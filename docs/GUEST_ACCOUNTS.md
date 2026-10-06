# Accueil et abonnements avec compte invité

Version source **0.2.4+74010**. Les contrats ci-dessous sont ceux attendus
par le client ; le backend et son état en production ne sont pas inclus ni
vérifiés par cette publication.

L’application permet de consulter les formules et de souscrire avec Google Play
sans saisir d’adresse e-mail ni de mot de passe FuzeVPN. Une identité invitée
existe néanmoins côté API : elle porte les droits, les appareils et la référence
opaque associée aux achats. Le serveur reste la seule autorité pour l’accès VPN.

Après activation, créer un compte est facultatif. Cette création demande
uniquement une adresse e-mail et un mot de passe. Elle transforme l’identité
invitée existante ; elle ne crée pas un second propriétaire de l’abonnement.

## Parcours de l’application

- Sans session récupérable : accueil FuzeVPN avec **Démarrer**, **Se connecter**
  et **Déjà acheté ?**.
- **Démarrer** ouvre une page présentant les forfaits `monthly` et `yearly` du
  produit `premium`. Les prix affichés viennent exactement du SDK Google Play.
  Aucun forfait n’est sélectionné d’avance. La session invitée est préparée
  après le choix, avant le lancement du paiement.
- Le client recherche les achats existants ou en attente avant un nouveau
  paiement. Un reçu permet de retrouver son propriétaire invité via l’API ;
  il ne permet pas d’attribuer arbitrairement le même achat à un autre compte.
- **Se connecter** ouvre l’identification FuzeVPN classique. Une connexion
  séparée depuis un invité valide le compte cible avant de quitter la session
  invitée ; elle ne fusionne aucun abonnement.
- **Déjà acheté ?** recherche les reçus détenus par le compte Google Play du
  téléphone et demande leur restauration vérifiée au serveur.
- Après un achat vérifié et un accès serveur actif : proposer **Créer mon
  compte** et **Plus tard / Utiliser mon VPN**. Le paiement en attente et une
  fenêtre de paiement simplement fermée ne constituent pas une activation.
- Une session invitée existante ouvre l’espace VPN. Dans Réglages, son profil
  indique **Compte non rattaché**, explique la restauration avec le même compte
  Google Play et propose **Créer mon compte**. Le bloc **Fuze Premium** reste
  disponible, notamment après expiration. La suppression d’un compte inscrit
  n’est pas proposée aux invités.
- Depuis **0.2.4+74010**, **Se connecter** dans les Réglages de l’invité ouvre
  une fenêtre dédiée avec email/mot de passe et Google. Elle permet de choisir
  un compte existant après vérification de sa session. Fermer la fenêtre ou
  échouer conserve l’invité ; une connexion réussie change de compte et ne
  transforme pas l’invité, ne fusionne pas les droits et ne transfère pas son
  abonnement. **Créer mon compte** conserve son parcours de conversion distinct.

## Contrat HTTP

Les réponses sensibles utilisent `Cache-Control: no-store`. Les trois méthodes
Android refusent un autre code de succès que celui documenté. Les jetons,
credentials, mots de passe et reçus ne doivent pas être journalisés.

| Route | Authentification et corps | Succès attendu |
| --- | --- | --- |
| `POST /v1/auth/guest` | Sans Bearer ; `guest_credential`, `terms_accepted`, `privacy_accepted` | **201** : `access_token`, `expires_at`, `user_id`, `identity_kind: guest` |
| `POST /v1/auth/guest/google-play/restore` | Sans Bearer ; `purchase_token`, `guest_credential` | **201** : même session et identité, `purchase_status` et `subscription` |
| `POST /v1/auth/guest/claim` | Bearer invité ; `email`, `password` uniquement | **200** : `identity_kind: registered`, `email_verified`, `verification_email_sent` ; aucun jeton de remplacement |

La credential doit être persistée avant la première requête. La création est
idempotente pour cette credential. Lors d’une première création, les accords
doivent avoir été acceptés ; le client les envoie explicitement après l’action
de continuation accompagnée des liens vers les textes. Le renouvellement d’une
identité déjà créée réutilise la même credential sans fabriquer une nouvelle
acceptation utilisateur.

La session invitée a une durée de 30 jours. La credential permet de la renouveler
tant que le compte invité demeure actif. Après inscription, cette credential
ne permet plus de délivrer une nouvelle session invitée.

La restauration vérifie le reçu auprès de Google et récupère l’ancien
propriétaire invité. La credential proposée est associée à ce propriétaire de
façon atomique et idempotente : une réponse perdue ne doit pas transformer une
nouvelle tentative en création d’un autre invité. Android garde une credential
de restauration dans un slot en attente distinct du slot actif, jusqu’à la
confirmation et la promotion locales. La même credential peut occuper les deux
slots lors d’une restauration explicite du même appareil.

`purchase_status` accepte uniquement `verified` ou `pending` sur cette route.
`subscription` reprend le DTO de droit commun de
[PLAY_BILLING.md](PLAY_BILLING.md) : `status`, `has_access`, `provider`,
`expires_at`. Le client conserve ces valeurs serveur et n’accorde aucun accès
à partir de l’état local du reçu. La récupération d’un achat expiré dépend de
sa vérifiabilité par Google ; elle ne promet pas la restauration de tout achat
historique absent des reçus accessibles.

Un achat appartenant à un compte inscrit retourne **409**
`account_login_required`, sans informations personnelles. L’utilisateur doit
se connecter à ce compte. Un fournisseur temporairement indisponible retourne
**503** avec `Retry-After` ; le client affiche une erreur récupérable et borne
le délai de nouvelle tentative.

Le claim est atomique et conserve le `user_id`, la référence opaque Play,
l’abonnement, les appareils et la session initiatrice. Une adresse déjà utilisée
retourne **409** `email_exists` et laisse l’invité intact. **Aucune fusion** ni
attribution de son achat au compte existant n’est effectuée. La confirmation
d’e-mail peut être proposée ensuite ; elle ne retire pas le droit VPN déjà
acquis par l’invité abonné.

## Identité et permissions de session

`GET /v1/me` distingue `identity_kind: guest | registered` du statut administratif
du compte et expose quatre booléens explicites :

| Champ | Usage Android |
| --- | --- |
| `profile_redacted` | Le profil personnel est absent de cette projection. |
| `can_manage_account` | La session peut afficher et gérer le compte inscrit. |
| `can_claim_account` | La session peut transformer l’invité en compte inscrit. |
| `can_use_vpn` | La session est autorisée à utiliser le VPN selon les droits serveur. |

Les invités utilisent une projection expurgée : nom, prénom, e-mail, coordonnées
et `email_verified` sont omis. Android représente les textes personnels absents
par des chaînes vides et la vérification absente par `null`, jamais par une
fausse adresse ou une valeur `false` inventée.

Une session issue de la récupération d’un achat est limitée. Si le compte est
ensuite inscrit ailleurs, elle ne devient pas automatiquement une session
personnelle de ce compte. L’API évalue les permissions selon la credential et
l’initiateur de la conversion ; Android emploie les booléens reçus, pas une
permission déduite du seul mot `registered`. Un profil inscrit expurgé demande
une connexion pour afficher et gérer ses informations.

Le parseur exige tous les booléens lorsque `identity_kind` est présent et refuse
une projection expurgée contenant des champs personnels. Pour les réponses
legacy dépourvues de l’ensemble de ces nouveaux champs, il conserve le profil
inscrit historique : gestion autorisée, claim absent et contrôle VPN final
toujours assuré par l’API. Les noms absents ou vides sont acceptés pour permettre
l’inscription par e-mail et mot de passe seulement.

## Persistance et continuité

La credential est générée avec un générateur cryptographique : **32 octets
aléatoires**, encodés en base64url canonique sans padding, soit 43 caractères.
Elle reste dans le stockage natif chiffré adossé au Keystore Android. Les
opérations de stockage sont typées ; aucune clé arbitraire de préférences ni
credential visible dans les diagnostics n’est utilisée.

Le stockage distingue credential active, credential de restauration en attente
et autorisation de reprise automatique. Promouvoir la credential active
supprime la credential en attente dans le même commit. La credential ne doit
jamais être interprétée comme un identifiant Google ou un reçu d’achat.

Une restauration explicite sur le même appareil propose la credential active
conservée, dans le slot de restauration en attente, avant la première requête.
Le serveur doit vérifier le reçu et confirmer le même propriétaire : cette
reprise conserve le binding de l’appareil, ses clés et ses certificats. Sans
credential locale, le client en génère une nouvelle. Une paire déjà en attente
est toujours réutilisée après une réponse perdue ou une panne fournisseur.
Seul **409 `guest_credential_conflict`**, qui confirme un autre propriétaire,
autorise un essai avec une nouvelle credential en attente. Une erreur **503**
ou **409 `account_login_required`** ne remplace aucune credential.

- **Expiration du jeton** : garder la credential pour tenter le renouvellement
  du même invité. Une indisponibilité réseau reste récupérable.
- **Déconnexion volontaire** : désactiver la reprise automatique avant de
  terminer la session. Ne pas reconnecter l’utilisateur silencieusement au
  lancement suivant.
- **Claim confirmé** : nettoyer les credentials invitées sans modifier le
  jeton courant. Un échec du nettoyage ne peut annuler la conversion serveur.
- **Réponse de claim perdue** : relire le profil avec la session initiatrice
  inchangée. Une identité inscrite cohérente permet de constater la réussite
  sans mémoriser le mot de passe ni effectuer une nouvelle souscription.
- **Renouvellement de session** : remplacer le jeton dans le scope du même
  compte. La procédure native vérifie le tunnel, l’appareil et les empreintes
  avant de conserver une reprise système valide ; elle ne migre pas les clés.

Chaque adoption de session vérifie le `user_id` retourné avec le profil serveur
avant de publier un compte utilisable. Les barrières d’opération de session
empêchent une réponse ancienne ou un HTTP 401 tardif de modifier une autre
autorisation. Les opérations de connexion, migration et révocation conservent
leurs protections existantes.

Le claim ne réécrit pas la session native : il préserve le tunnel courant,
la clé WireGuard, le CSR et le certificat OpenVPN, le `device_id` et les
informations de reprise. Ces éléments restent attachés au même `user_id`.

## Qualification

Les tests de contrat et de contrôleur doivent couvrir les statuts HTTP stricts,
le refus d’une rotation dans le résultat de claim, les projections expurgées,
les permissions explicites, la compatibilité legacy, les réponses perdues,
callbacks tardifs et 401 concurrents. Vérifier également redémarrage après
expiration, déconnexion volontaire, credential de restauration et paiement pending.

La recette de bout en bout reste propre à l’environnement ciblé. Utiliser un
compte Google testeur de licence et un moyen de paiement explicitement de test.
Confirmer l’accès via l’API, la restauration du même propriétaire sur un nouvel
appareil et le claim sans perte des identités/appareils/clés. Vérifier la
continuité des tunnels WireGuard et OpenVPN pendant la conversion.

La fenêtre de connexion des Réglages doit conserver l’invité à la fermeture,
l’annulation Google et l’échec. Une connexion à un autre compte doit remplacer
le scope après vérification du profil cible et refuser tout transfert implicite.
Les tests simulés ne prouvent ni un achat Play réel ni l’état du backend.
