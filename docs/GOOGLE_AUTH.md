# Connexion Google — Android et contrat API attendu

Audit de qualification du 14 octobre 2026 : [Q018](VALIDATION.md#q018), [Q019](VALIDATION.md#q019), [Q025](VALIDATION.md#q025), [Q029](VALIDATION.md#q029).


Version source **0.2.10+74016**, métadonnées documentaires du **11 octobre 2026**.
Le client Flutter, Android Credential Manager et le stockage des intentions
Google sont intégrés. L’audit des archives du 14 octobre confirme l’absence
de recette native exécutée : **Q018 bloqué**, compte/parcours Google de
recette requis. Les associations Cloud sont un blocage distinct **Q019**.
Les résultats et prérequis sont dans le [registre](VALIDATION.md#q018).

Ce document conserve le contrat client correspondant à l’évolution serveur
référencée **037**. Le backend n’est pas fourni ici ; vérifier séparément la
disponibilité des routes, l’audience et la liste des clients autorisés sur
l’environnement ciblé. Les identifiants publics ci-dessous décrivent la
configuration déclarée du service FuzeVPN. Les couples package/certificat
Cloud n’ont pas été inspectés ; voir [Q019](VALIDATION.md#q019).

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
demande le pays et les deux consentements, pas un nom obligatoire. La liste des
pays suit l’alphabet de la langue affichée, comme les Emplacements : casse et
accents ne déplacent aucun pays après « Z », et les lettres distinctes d’une
langue gardent leur rang (`Ö` après `Z` en suédois, `Ch` après `H` en tchèque,
`І` après `И` en ukrainien, voyelles initiales thaïes rangées à leur consonne),
tandis qu’une simple variante reste avec sa lettre (`أ` et `إ` avec `ا` en
arabe, où `آ` précède ce bloc comme dans CLDR). Ce tri est embarqué : il ne
dépend ni du réseau ni de la version d’Android. Le contexte peut contenir les
noms issus de Google ; une connexion ultérieure ne remplace pas le profil
existant. Une éventuelle vérification email FuzeVPN reste décidée par le
serveur.

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

Un délai `Retry-After` ou une vérification Turnstile exigés pour une intention
restent appliqués même si la réponse arrive pendant un Retour dont l’annulation
échoue, ou si la relecture `/v1/me` d’un claim refusé échoue. Tant que le délai
court, le formulaire rouvert par la reprise, ou le bouton de vérification, reste
désactivé, explique la limitation et affiche le temps restant. À l’échéance, ce
message devenu caduc disparaît (l’écran rappelle alors la vérification si elle
est exigée) ; un nouveau refus sans délai, ou avec un délai nul, reste expliqué
sans bloquer. Quand l’échec d’annulation a fait perdre le contexte du
formulaire, le bouton « Résoudre la vérification » ou la reprise le recharge
avant d’ouvrir le défi ; si le ticket a expiré entre-temps, l’écran l’indique
sans appel serveur. Ces gardes appartiennent à l’intention : une annulation
confirmée, une conversion reconnue ou une nouvelle intention les efface, et
elles ne survivent pas à l’arrêt du processus.

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
choix Google. Les refus `google_context_expired` et `google_context_consumed`
(contexte déjà consommé par une finalisation dont la réponse a été perdue)
confirment en revanche qu’il ne reste rien à annuler : le ticket est effacé,
après la relecture `/v1/me` décrite ci-dessous pour un claim. Ce traitement de
`google_context_consumed` est une hypothèse du client, à confirmer dans le
contrat serveur. Une fois l’annulation confirmée par l’API (succès ou l’un de
ces deux refus), l’écran se ferme même si l’effacement local du ticket échoue,
comme après une connexion admise. Le contrôleur Google, qui vit autant que le
processus de l’application, retient alors ce ticket : s’il relit la copie
périmée restée sur le disque (ouverture de l’écran, reprise, Retour ou
Annuler), il ne la présente plus à l’API, ni pour la décrire ni pour
l’annuler (ni pour la relecture `/v1/me` d’un claim : une conversion déjà
commise est reconnue par la session), et retente seulement son effacement.
Il retient le ticket lui-même : si l’enregistrement d’un ticket renouvelé
avait échoué plus tôt, la copie du disque est l’ancien ticket de la même
tentative, qu’il présente encore à l’API, avec la même limite que ci-dessous. Retour et Annuler quittent
l’écran ; l’ouverture lance un nouveau choix Google, dont l’enregistrement
remplace cette copie. Cette mémoire disparaît avec le processus. Après un
redémarrage, la réouverture d’une copie périmée affiche l’état incertain, qui
propose la reprise (« Vérifier cette tentative ») ou Annuler, puisque l’API ne
la décrit plus ; la reprise l’interroge de nouveau sans l’annuler, et seuls
Annuler ou Retour la réannulent côté API, puis retentent son effacement. Le
client attend alors du serveur un succès ou l’un de ces deux refus ; toute
autre réponse à cette deuxième annulation (par exemple 401 ou 404) reste une
annulation non confirmée : l’écran reste ouvert et indique que l’annulation
n’a pas pu être confirmée. C’est la limite qui reste, entre deux processus
seulement : la réponse du serveur à une deuxième annulation d’un même ticket
est à fixer dans le contrat serveur. La
destruction du processus conserve les tickets pour une reprise explicite, sans
conserver le JWT.

Un ticket conservé par un processus précédent peut ne pas avoir été relu : par
exemple quand l’écran Google est ouvert pendant une connexion VPN ou une autre
opération de compte, ce que l’écran indique sans lire ni remplacer le ticket.
Annuler, ou « Continuer avec Google », relit alors ce ticket. Pour un claim du
même invité, la relecture de `/v1/me` reconnaît d’abord une conversion déjà
commise ; sinon l’intention est annulée côté API avant d’être effacée. Si
l’annulation n’est pas confirmée, le ticket est conservé et chargé : l’écran
reste incertain et propose la reprise. Si le stockage chiffré est
temporairement indisponible (`secure_storage_failed`), rien n’est chargé ni
effacé : l’écran peut être quitté, le ticket reste pour une relecture
ultérieure et, tant qu’il reste illisible, l’écran Google indique que Google
est indisponible sans lancer de nouveau choix. Dès que la lecture réussit,
rouvrir l’écran reprend la même intention, tandis que « Continuer avec
Google » l’annule d’abord côté API (ou la garde chargée si l’annulation
échoue) avant un nouveau choix. Seul un ticket invalide, qu’aucune annulation
API ne peut viser, est supprimé sans appel serveur : charge non conforme, ou
entrée que le stockage natif signale `secure_storage_corrupt` parce qu’elle ne
pourra plus jamais être déchiffrée (authentification AES-GCM en échec, format
invalide, clé Keystore disparue).
L’ouverture de l’écran Google, la vérification d’une tentative ou Annuler
l’effacent alors. À l’ouverture ou à la vérification, l’écran indique que la
connexion Google a échoué et propose « Continuer avec Google », qui lance un
nouveau choix ; Annuler quitte l’écran. Si cet effacement échoue, le message
est le même et la prochaine annulation le retente : l’écran n’est jamais
bloqué.

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

## État des sources du 19 octobre 2026 — défi Turnstile Google

Le contrat API existant et sa clé publique ont été retrouvés dans les sources
locales du projet serveur. La résolution native est maintenant implémentée
pour les finalisations Google **`register` et `claim` uniquement** ; cette
évolution ne décrit pas les formulaires classiques d’inscription ou de
réinitialisation. Aucune modification de politique ni déploiement serveur
n’a été effectué pour la correction.

Après un refus serveur `turnstile_required`, `turnstile_invalid` ou
`turnstile_unavailable`, le client conserve le contexte et l’invité et propose
une action explicite de vérification. Il ne lance pas le widget avant ce
refus. Une résolution réussie permet de confirmer manuellement le formulaire ;
elle ne rejoue pas automatiquement la finalisation.

La fenêtre native charge un document HTML local avec l’origine fixe
`https://app.fuzevpn.com/`, une clé de site publique fixe et l’action `signup`.
Aucun bearer, JWT Google, ticket de continuation ou donnée de compte n’est
injecté dans ce document. Les navigations du cadre principal sont refusées ;
les ressources externes sont limitées à HTTPS sur `challenges.cloudflare.com`.
Une erreur TLS interrompt la résolution ; les nouvelles fenêtres, fichiers
locaux et permissions de géolocalisation sont refusés. La réponse est lue
depuis le seul cadre principal et validée comme un jeton ASCII imprimable
sans espace, non vide, de 2 048 caractères maximum. Les paramètres du canal ne choisissent ni URL ni clé de
site. Voir la [politique native](../android/app/src/main/kotlin/com/fuzevpn/android/TurnstilePolicy.kt)
et le [résolveur WebView](../android/app/src/main/kotlin/com/fuzevpn/android/NativeTurnstileBridge.kt).

Le jeton reste en mémoire, avec une durée conservatrice de quatre minutes
comptée depuis le début de la résolution. Il est consommé et oublié avant
l’appel de finalisation, et effacé après chaque erreur. Le corps JSON de
`register` ou `claim` l’ajoute comme champ facultatif `turnstile_token` ; il
ne devient ni un droit d’accès ni une identité. Les gardes de finalité, cycle,
identité et contexte restent applicables. Annulation, fin, destruction et
changement d’identité empêchent un résultat tardif d’être admis ; le passage
en arrière-plan de l’Activity interrompt la résolution native.

Délais (corrections du 29 octobre 2026). La fenêtre native a une échéance de
240 s (`TurnstilePolicy.TIMEOUT_MS`), au terme de laquelle la résolution se
termine par `unavailable`. Un échec de démarrage du fournisseur est détecté
plus tôt : dès que le document embarqué est observé, le script Turnstile doit
signaler qu’il est prêt dans les 30 s de `TurnstilePolicy.STARTUP_TIMEOUT_MS`,
sinon la résolution se termine par `provider_error`. Une erreur de chargement
du script `challenges.cloudflare.com` donne aussitôt le même code. Côté Dart,
la garde `NativeSecurityChallengeGateway.defaultSolveTimeout` (4 min 20 s,
injectable par `solveTimeout`) couvre seulement un côté natif qui ne
répondrait jamais : elle dépasse volontairement l’échéance native de 240 s.
À son expiration, elle demande l’annulation native et remonte
`provider_error`, et non `interrupted`, puisque l’utilisateur n’a rien annulé.

## Limites de qualification

Q025 conserve son verdict historique **bloqué au 14 octobre** dans le
[registre daté](VALIDATION.md#q025), qui n’est pas réécrit. Au 19 octobre, le
statut courant est **implémenté dans les sources et couvert par des tests
locaux ; recette native réelle à effectuer**. Le contrat serveur n’est plus
un prérequis manquant. Une résolution effective Cloudflare/WebView, les
associations OAuth et les parcours Google réels n’ont pas été exécutés ou
qualifiés par cette modification.

La recette doit confirmer la configuration OAuth de chaque signature ciblée,
le serveur compatible 037, puis la connexion, l’inscription, les deux preuves
d’association, la conversion de l’invité sans changement de bearer/appareil/VPN,
l’annulation, la réponse perdue et la reprise après arrêt du processus. Les tests
avec fakes ne valident ni une sélection Credential Manager réelle, ni les
associations Cloud, ni une résolution Turnstile réelle. La présence du code ou la disponibilité des routes ne remplace pas la
vérification de la configuration Cloud ni la recette Google réelle.

[Implémentation officielle Credential Manager](https://developer.android.com/identity/sign-in/credential-manager-siwg-implementation).
