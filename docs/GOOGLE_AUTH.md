# Connexion Google — Android et contrat API attendu

Version source **0.2.6+74012**, métadonnées documentaires du **11 octobre 2026**.
Le client Flutter, Android Credential Manager et le stockage des intentions
Google sont intégrés. **Aucune connexion Google native réelle n’est attestée
par cette publication**. Les tests avec fakes et les captures d’interface ne
qualifient pas le sélecteur Google, les associations Cloud ni le backend.

Ce document conserve le contrat client correspondant à l’évolution serveur
référencée **037**. Le backend n’est pas fourni ici ; vérifier séparément la
disponibilité des routes, l’audience et la liste des clients autorisés sur
l’environnement ciblé. Les identifiants publics ci-dessous décrivent la
configuration du service FuzeVPN, sans attestation indépendante de Cloud.

## Parcours proposés

Le bouton Google est une action volontaire. L’ouverture de l’application,
l’accueil, une actualisation du compte ou une restauration Google Play ne
déclenchent pas le sélecteur. Android utilise `GetSignInWithGoogleOption` dans
Credential Manager, avec le client Web serveur et le nonce exact fourni par
l’API. La sélection d’un compte Google ne crée pas à elle seule une session
FuzeVPN et n’accorde aucun droit VPN.

Après un appui volontaire sur le bouton, le SDK peut sélectionner automatiquement
une entrée Google éligible unique (`isAutoSelectAllowed=true` dans googleid
1.2.1). L’ouverture du SDK peut donc sélectionner un compte ; elle ne garantit pas
un essai limité à l’annulation. Utiliser un appareil et un compte adaptés à
la qualification.

### Connexion et inscription

Depuis l’écran de connexion, l’utilisateur peut continuer avec Google. Le
serveur peut retourner :

| Résultat | Suite Android |
|---|---|
| `authenticated` | Vérifier la session reçue avec `GET /v1/me`, puis l’admettre et restaurer le compte FuzeVPN. |
| `registration_required` | Choisir un pays et accepter séparément les conditions et la politique de confidentialité avant de créer le compte. |
| `link_required` | Proposer une preuve explicite de propriété du compte FuzeVPN existant. |

Les prénom et nom sont **facultatifs** dans le contrat. Le formulaire Android
demande le pays et les deux consentements, pas un nom obligatoire. Le contexte
peut contenir les noms issus de Google ; une connexion ultérieure ne remplace
pas le profil existant. Une éventuelle vérification email FuzeVPN reste décidée
par le serveur.

L’association requiert soit le **mot de passe actuel FuzeVPN**, soit un code
envoyé par email puis confirmé par l’utilisateur. Elle ne demande pas le mot de
passe Google. Un email identique n’associe jamais automatiquement deux comptes.
Il n’existe pas de fusion ni de transfert implicite d’abonnement. L’association
depuis le profil est un écran distinct, qui n’est pas livré par ce parcours.

### Création d’un compte pour l’invité actuel

La proposition de créer un compte après l’accueil ou l’achat invité utilise
une intention `claim`, distincte de la connexion ordinaire. Pendant la
préparation, l’invité conserve son bearer, son appareil et son VPN.

Après `guest_claim_required`, l’utilisateur complète le pays et les deux
consentements. Le succès de `POST /v1/auth/google/claim` ne fournit **aucun
nouveau bearer**. Android relit `GET /v1/me` avec le bearer initiateur et exige
le même `user_id`, une identité enregistrée, la permission de gestion du compte
et une méthode d’authentification `google` avant de mettre à jour le profil.
Le même utilisateur conserve ses achats, abonnements, références Play,
appareils, clés, profils VPN et droits. Le rattachement ne déconnecte pas le VPN.

Une identité Google ou un email appartenant à un autre utilisateur est refusé
avec `google_identity_conflict`. Le client ne crée pas un autre propriétaire et
ne transfère pas l’achat pour résoudre ce conflit. Choisir une connexion
ordinaire à un autre compte reste une action différente : elle remplace la
session après preuve, sans convertir l’invité ni transférer ses données.

## Échange avec l’API

Le client réutilise les routes Google en HTTPS. Les réponses privées exigent
`Cache-Control: no-store`. Les headers `X-Fuze-Browser-Context` et
`X-Fuze-Auth-Generation` ancrent l’intention dans le contexte serveur ; le nom
« browser » de ces headers s’applique aussi au client natif.

| Étape | Route et preuve |
|---|---|
| Réserver le contexte | `POST /v1/auth/browser/context`, corps `{}` ; avec le bearer initiateur pour un claim. |
| Créer le challenge | `POST /v1/auth/google/challenge`, corps `{"purpose":"authenticate"}` ou `{"purpose":"claim"}` ; le claim conserve le bearer initiateur. |
| Échanger le JWT Google | `POST /v1/auth/google/verify`, bearer du challenge, corps `challenge_id` et `credential` ; même contexte serveur. |
| Lire la continuation | `GET /v1/auth/google/context`, bearer du ticket provisoire ; les tickets ne sont pas des sessions FuzeVPN. |
| Créer le compte | `POST /v1/auth/google/register`, ticket provisoire, pays et consentements. |
| Convertir l’invité | `POST /v1/auth/google/claim`, ticket provisoire, pays et consentements ; pas de `user_id` ni de bearer invité supplémentaire dans le corps. |
| Associer explicitement | `POST /v1/auth/google/link` avec `current_password`, ou `link/email/request` puis `link/email/confirm` avec le code. |
| Annuler l’intention | `POST /v1/auth/google/cancel`, ticket courant et, pour un challenge encore en attente, `challenge_id`. |

Le succès d’authentification ordinaire retourne HTTP **201** et une session
FuzeVPN. Les continuations retournent HTTP **200** avec un ticket limité ; le
claim final retourne HTTP **200** sans nouveau token de session. Android ne
confond pas ces réponses et n’utilise jamais un ticket pour accéder au VPN.
L’envoi du code d’association retourne **202 sans corps** ; les délais de
renvoi et les réponses `Retry-After` sont respectés.

Ces réponses sont exigées par le client Android. Le contrat et la
configuration du serveur doivent être contrôlés dans son propre projet ;
aucun fichier backend externe n’est requis pour lire ce guide. La route
`/v1/auth/session` n’est pas utilisée.

## Stockage, annulation et réponse perdue

Le JWT d’identité Google existe seulement en mémoire pendant son échange avec
l’API. **Il n’est jamais persisté**. Les intentions provisoires stockent leur
ticket, le contexte serveur, la génération, l’échéance et les identifiants
nécessaires à la reprise. Ces données sont chiffrées en AES-GCM avec une clé
Android Keystore, dans un emplacement privé distinct des données de session
VPN. La liste des champs est contrôlée ; elle n’admet ni JWT Google, ni mot de
passe, ni code email, ni profil. Les représentations et erreurs exposées par le
client masquent les valeurs privées.

Le bouton Retour ou Annuler interrompt la sélection native et annule l’intention
exacte côté API. Une réponse tardive ne s’applique pas à une autre session. Si
l’annulation serveur ne peut pas être confirmée, Android garde l’intention et
affiche un état incertain ; il ne la remplace pas silencieusement par un nouveau
choix Google. La destruction du processus conserve les tickets pour une
reprise explicite, sans conserver le JWT.

Après une réponse de claim perdue, la lecture de `/v1/me` avec le **même bearer**
permet de reconnaître la conversion déjà commise. Le client ne rejoue pas
aveuglément la finalisation et ne change pas de credential invitée. Une
annulation n’invalide jamais le bearer initiateur ni une conversion déjà
commise. Pour une vérification ordinaire dont la réponse est perdue, la preuve
de challenge peut encore servir à l’annulation de cette intention pendant sa
validité ; le contrat fixe cette durée à cinq minutes, sans prolongation par
le ticket de continuation. Une session déjà admise n’est pas révoquée par un
simple Retour.

JWT, bearer, tickets, code email, mot de passe et contexte privé ne doivent pas
apparaître dans les journaux, diagnostics, captures ou rapports de recette.

## Configuration publique Google

Le package Android est **`com.fuzevpn`**. Le projet Cloud annoncé est
`deep-burner-510522-h7`. Credential Manager demande un ID token pour le client
**Web serveur**, défini par `GoogleAuthController.serverClientId` :

```text
77017033563-bs6rpo2dro8mi19guaoq4ppdb9khqj6q.apps.googleusercontent.com
```

Les clients Android identifient le couple package/certificat ; ils ne remplacent
pas ce `serverClientId`. Les identifiants publics fournis sont :

| Usage | Client OAuth Android |
|---|---|
| APK local | `77017033563-gcmhn8mgrehq18f7i7i6sbd8lj8bggo5.apps.googleusercontent.com` |
| Développement et VM | `77017033563-pskmjn5f5ffd8otegbtha1vc7l0d6pi0.apps.googleusercontent.com` |
| Play — certificat de déploiement | `77017033563-j25i2ldmajr8b6g1m36nlcqadqjheki4.apps.googleusercontent.com` |
| Play — certificat hybride classique | `77017033563-7km9q0r6q6oi09bumgi5lslnfvknkdg5.apps.googleusercontent.com` |
| Play — certificat hybride PQC | `77017033563-rokq7omkl0tio403hl61mhchlcpun746.apps.googleusercontent.com` |

Ces identifiants ne prouvent pas les associations package/certificat enregistrées
dans Google Cloud. L’audience attendue côté API reste le client Web ; les clients
Android doivent figurer dans la liste autorisée du champ `azp`. La liste locale
préparée pour 037 contient les cinq clients ci-dessus. La confirmation de son
activation serveur doit accompagner le rapport de recette.
Android n’embarque aucun secret client OAuth ni credential de service Google.

### Clients OAuth pour la signature Google Play

Les affectations des trois clients Play ci-dessus sont documentées, sans
vérification indépendante dans Google Cloud. Pour chaque certificat effectivement utilisé, vérifier un client
OAuth de type **Android** dans le **même projet Cloud que le client Web**, avec
le package `com.fuzevpn` et sa propre empreinte SHA-1. Les trois certificats
publics Play concernés sont :

| Certificat | SHA-1 |
|---|---|
| `deployment_cert.der` | `06:0A:D1:C1:62:FC:30:44:96:EB:A2:B7:5B:B1:6F:FA:87:70:6F:03` |
| `hybrid_classical_cert.der` | `99:BE:0D:C5:A3:E1:74:5C:DB:E2:77:7A:6B:57:B0:70:AE:F6:7B:BD` |
| `hybrid_pqc_cert.der` | `AA:8C:E9:8D:B9:DD:3F:6F:D9:0D:98:77:B3:D2:33:94:E5:96:66:E1` |

Les certificats et la configuration Cloud ne sont pas distribués dans ce
dépôt. Contrôler le certificat de chaque APK cible avec `apksigner verify
--print-certs <apk>` et les certificats publics de signature dans Play Console.
Comparer leurs empreintes à la configuration OAuth et à la liste `azp` du
serveur ciblé. Les forks doivent configurer leur propre projet OAuth et un
backend acceptant leur package et leurs signatures.
Une empreinte n’est pas un identifiant OAuth. La clé
d’envoi locale ne remplace pas les certificats de signature des APK distribués
par Google Play. Google demande l’enregistrement des trois empreintes pour une
signature hybride. [Guide Play des fournisseurs API](https://support.google.com/googleplay/android-developer/answer/9842756?hl=en-GB#register-with-api-providers).

Pour les APK locaux et la VM, contrôler séparément les associations existantes
avec le certificat qui signe réellement chaque APK. Cette vérification ne
nécessite aucun secret dans l’application.

## Limites de qualification

Si la politique serveur exige Turnstile pour `register` ou `claim`, un défi
natif réel reste **à qualifier**. Le formulaire actuel ne fournit pas de token
Turnstile. Sur `turnstile_required`, `turnstile_invalid` ou
`turnstile_unavailable`, le client conserve le contexte et l’invité et affiche
le problème ; aucun champ Android ne contourne la protection. Un serveur qui
exige ce défi bloque donc la finalisation tant que ce parcours n’est pas prêt.

La recette doit confirmer la configuration OAuth de chaque signature ciblée,
le serveur compatible 037, puis la connexion, l’inscription, les deux preuves
d’association, la conversion de l’invité sans changement de bearer/appareil/VPN,
l’annulation, la réponse perdue et la reprise après arrêt du processus. Les tests
avec fakes ne valident ni une sélection Credential Manager réelle, ni les
associations Cloud, ni Turnstile. La présence du code ou la disponibilité des routes ne remplace pas la
vérification de la configuration Cloud ni la recette Google réelle.

[Implémentation officielle Credential Manager](https://developer.android.com/identity/sign-in/credential-manager-siwg-implementation).
