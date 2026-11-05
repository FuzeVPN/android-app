# Architecture et comportement Android

Audit de qualification du 14 octobre 2026 : [Q008](VALIDATION.md#q008), [Q009](VALIDATION.md#q009), [Q010](VALIDATION.md#q010), [Q011](VALIDATION.md#q011), [Q014](VALIDATION.md#q014), [Q017](VALIDATION.md#q017), [Q018](VALIDATION.md#q018), [Q025](VALIDATION.md#q025), [Q026](VALIDATION.md#q026), [Q027](VALIDATION.md#q027), [Q028](VALIDATION.md#q028), [Q029](VALIDATION.md#q029), [Q032](VALIDATION.md#q032).


Version source **0.2.11+74018**. Ce guide décrit le comportement implémenté
dans ce client. Les réponses API
attendues ci-dessous sont les contraintes du client ; ce document ne remplace
pas le contrat serveur et ne constate pas l'état de la production. Les
propriétés décrites à partir du code ne constituent pas un résultat d'essai
sur téléphone.

La préparation du poste et les contrôles sont dans
[DEVELOPMENT.md](DEVELOPMENT.md). Les versions, patches, imports et verrous
des moteurs VPN sont dans [NATIVE_DEPENDENCIES.md](NATIVE_DEPENDENCIES.md).

## Répartition du code

| Partie | Responsabilité | Sources |
| --- | --- | --- |
| Flutter | Interface, compte, appels API et coordination des opérations | `lib/app.dart`, `lib/app_controller*.dart`, `lib/features/` |
| Contrat réseau | Requêtes, validation des réponses, erreurs structurées et diagnostics | `lib/core/` |
| Localisation | Registre des langues, packs de traduction et catalogues générés | `lib/l10n/` |
| Bridge Android | Opérations typées, stockage chiffré, autorisation VPN et cycle des tunnels | `lib/native_vpn_bridge.dart`, `android/app/src/main/kotlin/com/fuzevpn/android/` |
| Moteurs natifs | WireGuard Android et OpenVPN 3 Core/OpenSSL via JNI | `android/third_party/wireguard-android/`, `android/app/src/main/cpp/` |

L'application porte l'identifiant `com.fuzevpn` et requiert Android 8
ou ultérieur. Le namespace Kotlin `com.fuzevpn.android` reste celui des classes
et des symboles JNI ; les composants du manifeste sont entièrement qualifiés.
Elle utilise l'origine `https://api.fuzevpn.com/`. La variable
de compilation `FUZEVPN_API_BASE_URL` n'est lue qu'en debug ; release et profile
utilisent toujours l'origine de production.

## Interface et choix d'emplacement

La charte reprend celle du site officiel : ivoire `#F3EFE6`, surfaces
`#FAF8F3`, encre `#101820`, panneau réseau `#17242C` et signal doré `#F4C95D`.
Archivo compose les titres et le texte ; IBM Plex Mono les valeurs et petits
libellés. Noto Sans Arabic est embarquée en police de repli pour les textes
arabes, persans et ourdous. Les ressources sont embarquées. `lib/app_theme.dart` définit les
thèmes clair et sombre et `lib/widgets/fuze_design.dart` leurs panneaux,
entêtes et états vides. Les boutons dorés portent un texte encre ; les liens,
contrôles de sélection et champs actifs utilisent une couleur contrastée.

La connexion associe l'état réel du tunnel, un motif réseau décoratif, l'action
VPN et la destination. Sur un écran court, les espacements et le motif se
réduisent pour garder l'action visible ; avec des caractères agrandis, les
textes restent complets et le contenu défile. La navigation passe d'une barre
inférieure à une barre latérale à partir de 720 points. Authentification,
inscription, restauration, fin de session et diagnostics suivent cette même
charte. Les compositions et flèches tiennent compte du sens de lecture ; le
logotype latin conserve son sens d'origine.

Les trois onglets présentent la connexion, les emplacements et le compte.
L'écran de connexion affiche l'état natif, l'emplacement actif, la durée et
les compteurs reçus/envoyés ; WireGuard ajoute l'âge du dernier handshake.
Ces mesures proviennent du moteur local et ne créent pas d'historique serveur
de navigation ou de trafic.

Les emplacements suivent la hiérarchie pays → villes → serveurs. La zone
principale d'une carte de pays ou de ville propose une sélection automatique ;
la zone avec chevron ouvre le niveau suivant sans lancer de connexion. Le choix
automatique prend le serveur actif compatible du groupe, sinon le serveur
sélectionné compatible, sinon le premier nom dans l'ordre naturel. Il ne
prétend pas mesurer le serveur le plus rapide.

Choisir un autre emplacement ouvre une confirmation indiquant le serveur exact.
Confirmer revient sur Connexion, attend l'arrêt du tunnel existant, conserve le
protocole actif, sélectionne la destination et lance la connexion. Annuler ne
change rien. Une opération concurrente, un arrêt non confirmé ou un changement
de session empêche la suite du démarrage. Le contrôle correspondant est
`changeLocationAndConnect()` dans `lib/app_controller_location_change.dart`.

La recherche locale ignore la casse, les accents latins et les séparateurs.
Elle compare ville, nom de serveur, code pays et noms de pays des trente langues
embarquées. Les villes et serveurs restent ceux du catalogue reçu. Recherche
et favoris affichent directement les serveurs ; quitter ces modes retrouve la
navigation hiérarchique. Les serveurs incompatibles avec le protocole effectif
ne sont pas sélectionnables.

Les favoris sont des identifiants d'emplacement stockés dans une préférence
Android chiffrée, locale au téléphone et indépendante du compte, avec une limite
de 500. Ils survivent à la déconnexion et à l'absence temporaire d'un serveur
du catalogue. Les écritures sont ordonnées ; un échec rétablit les étoiles dans
leur dernier état sauvegardé. Les autres préférences d'interface prennent effet
dans la session même si leur enregistrement échoue, avec un message explicite.

Le catalogue utilise `GET /v1/locations`, sans requête de disponibilité par
serveur. Un refus `409 server_full` ou `503 capacity_unavailable` retire
localement la destination et provoque une seule actualisation du catalogue.
L'erreur initiale reste visible si cette actualisation échoue. Une actualisation
ultérieure réussie peut réadmettre la destination. Le client ne choisit pas
automatiquement un autre serveur pour relancer la connexion.

Les drapeaux, polices et noms de pays sont embarqués. Un pays inconnu utilise un
globe ; son libellé reste accessible. Le compte donne accès aux appareils, à
l'apparence, à la langue, à la protection Android, aux diagnostics et aux
informations. Le panneau des appareils conserve son état ouvert pendant le
défilement grâce au stockage de page. L'application et les surfaces Android suivent la même préférence
de langue ; voir [la procédure de localisation](DEVELOPMENT.md#localisation).

## Compte invité et connexion depuis Réglages

L’identité invitée porte les droits et appareils sans email ni mot de passe.
**Créer mon compte** transforme cette même identité ; le client conserve la
session initiatrice, les clés et le tunnel lors d’un claim confirmé.
La fenêtre **Se connecter** des Réglages, ajoutée dans **0.2.4+74010**, propose
email/mot de passe et Google pour un compte existant. Elle vérifie la session
cible avant son adoption. Fermeture, annulation et échec préservent l’invité ;
une connexion réussie remplace le compte sans fusion ni transfert d’abonnement.
Voir [GUEST_ACCOUNTS.md](GUEST_ACCOUNTS.md) et
[GOOGLE_AUTH.md](GOOGLE_AUTH.md) pour les contrats et limites de qualification.

## Contrats API appliqués

Le client valide les types, identifiants, états et statuts HTTP attendus. Les
routes d'appareil, d'activation et de migration exigent une réponse
`Cache-Control: no-store`. Une réponse incompatible produit
`invalid_api_response` ; le client n'invente aucun endpoint, port ou profil de
secours. Les identifiants incorporés aux chemins sont encodés.

Un corps `2xx` doit être de l'UTF-8 valide et tenir dans 1 Mio. Le corps
d'une autre réponse n'est qu'une enveloppe d'erreur : s'il est mal encodé
(octets non UTF-8, `Content-Encoding` invalide) ou dépasse 1 Mio, une fois
décompressé compris (la lecture s'arrête alors au plafond et le corps est
ignoré), le statut HTTP et `Retry-After` sont conservés, de sorte qu'un `5xx`
reste une indisponibilité temporaire. Il en va de même, dès lors que les
en-têtes sont arrivés avant l'échéance, pour un corps tronqué, un découpage
`chunked` invalide, une connexion fermée ou un corps encore incomplet à
l'échéance : la réponse garde son statut avec un corps vide, sans prolonger
l'échéance, et aucune enveloppe partielle n'est interprétée. Un corps `2xx`
dans ces cas reste une erreur réseau. Derrière un proxy
d'environnement, la réponse `CONNECT` est lue comme par le SDK (fins de ligne
CRLF ou LF seul, obs-fold, réponse fragmentée en plusieurs lectures), dans la
limite de 16 Kio d'en-têtes au total, réponses intermédiaires comprises, et de
quatre réponses intermédiaires.

| Opération | Réponse attendue / traitement |
| --- | --- |
| Connexion et inscription | `POST /v1/auth/login` et `/v1/auth/register` : `201` |
| Déconnexion et renvoi de vérification | `POST /v1/auth/logout` et `/v1/auth/email/resend` : `204` |
| Confirmation d'e-mail | `POST /v1/auth/email/verify` : `200` avec `email_verified: true` |
| Réinitialisation de mot de passe | `/v1/auth/password/reset/request` : `202` ; `/confirm` : `204` |
| Profil du compte | `GET` et `PUT /v1/me` : `200`. L'absence de `email_verified` signifie inconnu, pas faux. |
| Catalogue | `GET /v1/locations` : `200`. `supported_protocols` détermine les protocoles proposés. `supported_ip_families` n'est qu'un indice : IPv6 n'est proposé que si la valeur est une liste qui contient à la fois `ipv4` et `ipv6` (comparaison exacte, casse comprise), quel que soit l'ordre ; ses autres éléments (doublons, familles inconnues ou futures, autre casse, valeurs non textuelles) sont ignorés. Une liste à laquelle manque l'une de ces deux valeurs, ou une forme inattendue (champ absent, texte, objet), laisse l'emplacement en IPv4. Aucune de ces formes n'invalide le catalogue ni la liste des appareils. Une ligne dont `display_name` est un texte que le natif refuserait (vide ou blanc, plus de 96 unités UTF-16, caractère de contrôle ISO) n'est pas proposée ; les autres lignes restent disponibles. Un `display_name` absent ou non textuel et des identifiants dupliqués refusent toujours tout le catalogue. |
| Activation WireGuard | `POST /v1/devices` : `201`. Envoie nom, clé publique locale et `location_id`, puis importe l'activation dans le composant natif. |
| Liste et suppression d'appareils | `GET /v1/devices` : `200` ; `DELETE /v1/devices/{id}` : `204` |
| Métadonnées des profils | `GET /v1/devices/{id}/profiles` : `200`, sans activation ni secrets |
| Création / renouvellement OpenVPN | `POST /v1/devices/{id}/profiles/openvpn` et `/renew` : `201`, avec `csr_pem` |
| Révocation OpenVPN ciblée | `DELETE /v1/devices/{id}/profiles/openvpn` : `204` |
| Migration OpenVPN | `POST /v1/devices/{id}/location-migrations` : `200` ou `202` ; suivi `GET .../{migration_id}` : `200` |

Une demande double pile ajoute `ip_families: ["ipv4", "ipv6"]` aux activations
qui le permettent. Le modèle valide la cohérence des adresses et familles
retournées ; aucune route IPv6 n'est déduite d'une donnée manquante. Familles,
adresses et routes d'une activation sont lues comme des ensembles, dans
l'ordre choisi par le serveur : IPv4 obligatoire, IPv6 facultatif, aucun
doublon ni valeur inconnue, chaque adresse rattachée à sa famille. Le natif
reçoit toujours la forme canonique (IPv4 puis IPv6). Les
adresses IPv4 reçues (DNS, endpoint OpenVPN, adresses de tunnel) suivent la
forme décimale stricte du natif : quatre octets de 0 à 255 en chiffres ASCII,
sans signe, espace ni zéro initial.

Un appareil logique peut porter les profils WireGuard et OpenVPN au même
emplacement. La liste accepte aussi un appareil navigateur avec `location: null`
et un profil `browser_proxy` : il reste gérable, mais n'est pas un protocole VPN
sélectionnable. Un refus `device_limit` doit conduire à la gestion des appareils,
pas à une création supplémentaire. Le libellé textuel d'emplacement d'un
appareil existant, quelle que soit sa longueur, est ramené à une forme acceptée
par le natif (contrôles remplacés, 96 unités au plus, identifiant de
l'emplacement s'il est vide ou blanc) sans écarter l'appareil. Un nom d'appareil
absent ou vide reste vide dans le modèle ; l'interface affiche alors un libellé
traduit.

### Déplacement et révocation

WireGuard tente directement `POST /v1/devices` avec la destination. Si le
serveur renvoie `device_location_locked`, le client révoque uniquement le profil
OpenVPN. Après le `204`, il efface atomiquement l'identité OpenVPN locale et
retente WireGuard une seule fois. La session, le `device_id` et la clé WireGuard
restent préservés. Ce chemin ne lance pas de migration d'appareil.

OpenVPN utilise les états `draining`, `activating`, `ready` et `blocked` de la
migration asynchrone. L'identifiant opaque, l'appareil, la destination et l'état
sont chiffrés avec une portée compte/appareil. `Retry-After` (secondes ou
HTTP-date, mesurée depuis l'en-tête `Date` de la réponse) prime sur
`retry_after_seconds` ; sans valeur lisible, l'attente est de 0,5 s, puis 1 s,
puis deux secondes, et l'écran n'affiche pas de délai. Un
délai supérieur à 300 s est ramené à 300 s et un délai illisible est ignoré : il
ne fait jamais perdre une migration acceptée. Le nombre de vérifications est
borné. Après `ready`, une lecture des appareils doit confirmer la destination
avant de préparer le tunnel.

La migration normale conserve l'identité OpenVPN. Après une révocation ciblée,
la prochaine création OpenVPN produit une nouvelle clé P-256 et un nouveau CSR.
Une révocation distante échouée ne vaut pas autorisation d'effacer les secrets
locaux nécessaires à sa reprise.

### Profil et renouvellement OpenVPN

L'activation fournit un endpoint IPv4 sans port ; l'adaptateur natif impose
UDP/1194. Le client refuse ici DNS, URI, port explicite et endpoint de transport
IPv6. Le tunnel peut transporter IPv6 indépendamment de cet endpoint.
L'adresse IPv4 d'activation reste le CIDR `/32` reçu. La validation TLS impose
`remote-cert-tls server` et `verify-x509-name` avec le `server_name` fourni.

Avant de créer un profil, une action de connexion consulte le `NotAfter` X.509
et sa métadonnée chiffrée. Un certificat expiré ou arrivant à échéance dans les
sept jours passe directement par `/renew`. Le renouvellement utilise deux
générations Keystore : l'identité active reste disponible pendant l'appel, le
nouveau CSR est réutilisé après interruption et la nouvelle génération n'est
publiée qu'avec une activation validée. L'ancienne génération est libérée après
une preuve native de connexion. Une divergence entre `not_after` API et le
certificat produit `openvpn_certificate_expiry_mismatch`.

### Erreurs et reprises

| Code ou situation | Réaction du client |
| --- | --- |
| `401 unauthorized` sur le contrôle du compte | Termine la session et le tunnel concerné, puis demande une reconnexion. |
| `403 email_verification_required` | Propose la vérification avec le délai de renvoi applicable. |
| `device_identity_revoked`, `openvpn_profile_revoked` | Invalide l'identité concernée et exige une action explicite. |
| `openvpn_profile_exists` | Réutilise l'état local idempotent ; ne régénère pas une clé par défaut. |
| `openvpn_operation_pending`, `location_migration_pending` | Garde une attente contrôlée et l'opération en cours, sans multiplier les activations. |
| `location_migration_blocked`, `target_ca_mismatch` | Conserve l'état et indique l'intervention nécessaire. |
| `location_migration_conflict` | Actualise les appareils avant un nouvel essai contrôlé. |
| `target_unavailable`, `node_unavailable`, `openvpn_signer_unavailable` | Affiche l'indisponibilité et respecte les délais applicables sans recréer l'appareil. |

Le `Retry-After` d'une erreur accepte des secondes ou une HTTP-date (mesurée
depuis l'en-tête `Date`, sinon l'horloge locale) ; une valeur supérieure à
24 h est ramenée à 24 h au lieu d'être perdue, et des en-têtes répétés gardent
le délai lisible le plus long. Une valeur illisible est ignorée. Un délai
exact sous forme d'HTTP-date suppose l'en-tête `Date` : sans lui, une horloge
d'appareil en avance sur le serveur raccourcit le délai, et une date passée
vaut 0 (réessai immédiat), comme `Retry-After: 0`.

Les messages sont des identifiants traduits au moment de l'affichage, avec des
paramètres sûrs. Un changement de langue actualise les notices déjà visibles.
Un code inconnu utilise un repli traduit ; les corps API et les textes libres
du moteur ne sont pas affichés.

## Tunnels et protection Android

Les commandes de tunnel sont sérialisées : arrêt confirmé, préparation,
autorisation Android, démarrage, puis preuve native. WireGuard requiert un
handshake après démarrage ; OpenVPN requiert l'événement Core `CONNECTED`.
Un arrêt expiré interdit le lancement d'un deuxième tunnel.

Avec l'AAR local approuvé, `GoBackend$VpnService` est l'unique `VpnService`
partagé entre les deux protocoles. Le contrôleur décide de la restauration
locale et de la libération du service. Le démarrage WireGuard protège les
sockets avant d'ajouter les pairs ; le détail des patches est dans
[NATIVE_DEPENDENCIES.md](NATIVE_DEPENDENCIES.md).

`SharedVpnHost` démarre et arrête ce service sur le fil principal, où ses
`onCreate()` et `onDestroy()` s'exécutent d'un bloc : publié juste avant
`startForeground()`, un hôte arrêté entre les deux fait tuer l'application par
Android 8 à 11, et un démarrage tombé au milieu de `onDestroy()` ne démarre rien.
Un arrêt attend la fin de `onDestroy()` ; un passage au fil principal expiré est
annulé, il ne démarre ni n'arrête plus rien ensuite.

Le tunnel peut rester actif en arrière-plan. Le VPN permanent et le blocage
des connexions sans VPN sont deux réglages Android distincts que l'utilisateur
active dans les paramètres système. Une notification persistante ne prouve pas
que le blocage est activé. Si le VPN permanent empêche un arrêt applicatif,
l'interface et la tuile orientent vers les réglages Android.

La reprise système utilise seulement un profil local ayant déjà obtenu une
preuve native de connexion, avec vérification de sa session et de son identité.
Elle ne prépare pas une nouvelle identité par l'API. L'accès au stockage
Keystore peut nécessiter le premier déverrouillage après redémarrage. Un échec
de reprise reste bloqué jusqu'à une nouvelle connexion explicite. La reprise
OpenVPN après perte de transport possède un budget borné, conservé avec l'état
de reprise ; elle ne contourne pas révocation, expiration ou renouvellement.
Quand elle reconnecte avec le même plan réseau, elle réutilise l'interface TUN
conservée au lieu d'en établir une nouvelle : sur Android 11 à 16, chaque
nouvelle interface fait couper par le système les connexions TCP en cours.
L'interface conservée est identifiée par `ioctl(TUNGETIFF)` sur son descripteur :
une app release n'est pas « dumpable » et, sur Android 11, son propre
`/proc/self/fdinfo` lui est illisible.

Sur Android 11 seulement, le `ConnectivityManager` est unique par processus. Une
mise à jour de proxy que le système envoie à tous les processus (à chaque fin de
réseau VPN, par exemple) et qui arrive pendant le démarrage du processus le lie
au paquet « android » jusqu'à la mort du processus : l'abonnement réseau et la
lecture des capacités lèvent alors `SecurityException`. Le démarrage ne doit pas
en mourir. Le pont journalise une fois « Physical network callback refused by
Android » et continue sans abonnement : WireGuard ne suit plus les pertes de
réseau ; tant qu'OpenVPN est actif, les réseaux physiques sont relus chaque
seconde et un réseau disparu déclenche la reprise comme l'abonnement l'aurait
fait ; toute autre interruption garde la reprise unique. Le réseau par défaut, le
type VPN et les interfaces se lisent par les appels sans contrôle de paquet
(`getAllNetworks`, `getActiveNetworkInfo`, `getNetworkInfo`, `getLinkProperties`).
Android 12 a corrigé la cause.

Après la mort du processus, Android ne relance pas le service VPN qu'il a déjà
délié. Un service sans liaison ni premier plan, `SystemVpnResumeSentinel`
(START_STICKY), est donc démarré tant qu'une mort serait suivie d'une reprise :
Android 10 ou plus, état de reprise prêt, VPN permanent constaté pendant que le
tunnel est connecté, et aucune commande d'arrêt ni perte du service en cours.
Une commande d'arrêt le désarme dès sa réception. Relancé par Android, il
vérifie d'abord sans rien écrire ni afficher l'état, la session, l'identité,
le consentement, l'absence d'un autre VPN et un réseau physique (30 s au plus).
Il réserve ensuite l'état, démarre le service VPN puis suit la reprise système.
Rien n'est restauré sans VPN permanent, sur Android 8 et 9, ni dans le runtime
de debug ; une reprise interrompue par une nouvelle mort n'est pas retentée.

Android 10 à 13 abandonnent parfois ce redémarrage quand un autre composant (la
tuile, une tâche d'une bibliothèque) relance d'abord le processus (observé sur
Android 11 à 13). Tant que la sentinelle est armée, une tâche JobScheduler en
attente (`SystemVpnRestartMark`, jamais exécutée avant 30 jours) la marque.
Chaque démarrage du processus consomme cette marque et lance la même reprise,
sur Android 11 ou plus, si le processus principal vient de mourir (2 min au
plus) d'une mort qu'Android fait suivre d'un redémarrage : plantage, signal,
mémoire, ANR, ressources, permission retirée ou fournisseur mort. Un arrêt forcé
annule la marque, même processus déjà mort ; un démarrage d'appareil l'efface.
Android 10 n'enregistre pas la raison d'une mort : seule la sentinelle y reprend.

La tuile Réglages rapides reconnecte ce dernier profil validé sans accès API.
Elle ouvre l'application lorsqu'une préparation, un consentement VPN ou un
renouvellement est requis. La déconnexion du compte et la suppression de
l'identité invalident ce raccourci. Le runtime Maven de debug ne propose pas
le mode VPN permanent.

## Stockage et confidentialité

Les jetons, identités et préférences persistantes passent par des opérations
Android typées. Le canal Flutter/Kotlin n'accepte pas un nom arbitraire de clé
de stockage. Les données sensibles sont chiffrées avec AES-GCM et une clé
protégée par Android Keystore. Les portées compte/appareil empêchent la reprise
d'une opération dans une autre session.

La clé privée WireGuard est produite et conservée localement ; l'API reçoit sa
clé publique. La clé P-256 OpenVPN est non exportable. Le fournisseur XKey amont
délègue les signatures à Keystore. Activation, CSR, certificat, profil et clé
`tls-crypt-v2` ne doivent pas entrer dans des journaux, captures ou rapports.
Le raccourci de reprise référence l'identité chiffrée sans dupliquer ces secrets.

La déconnexion du compte retire le jeton et conserve l'identité chiffrée du
compte pour retrouver le même appareil ; une révocation réussie efface les
secrets concernés. Le manifeste désactive la sauvegarde de l'application et le
trafic en clair. Une politique de build vérifie les permissions du manifeste
fusionné avant l'empaquetage.

## Diagnostics

La référence affichée suit la forme `<étape> · <code stable>`, par exemple
`WG-STOP · wireguard_stop_timeout`. Le mapping est défini par
`_diagnosticStage()` dans `lib/app_controller.dart` et les erreurs API par
`lib/core/api_exception.dart`.

| Étape | Origine |
| --- | --- |
| `WG-START`, `WG-SERVICE`, `WG-CONFIG`, `WG-IDENTITY`, `WG-HANDSHAKE`, `WG-STOP` | Démarrage, service, configuration, identité, handshake ou arrêt WireGuard |
| `OVPN-SERVICE`, `OVPN-PROFILE`, `OVPN-TLS`, `OVPN-TUN`, `OVPN-CORE`, `OVPN-STOP` | Service, profil, TLS, interface TUN, Core ou arrêt OpenVPN |
| `VPN-AUTH`, `VPN-STORAGE`, `VPN-BRIDGE`, `VPN-STATE`, `VPN-STOP` | Autorisation, stockage, canal natif, état ou arrêt partagé |
| `API-HTTP-<statut>`, `API-NETWORK` | Réponse HTTP ou absence de réponse exploitable |
| `APP-*` | Erreur de coordination applicative |

`wireguard_stop_timeout` et `openvpn_stop_timeout` restent distincts.
`openvpn_core_status_error`, `openvpn_stopped_before_connected` et
`openvpn_connection_timeout` distinguent aussi les échecs avant connexion.
Le code original reste disponible même si plusieurs codes partagent une
traduction. Pour reproduire un défaut, relever ce code, le protocole, la version
et les étapes ; aucun secret n'est nécessaire.

Dans Compte > Diagnostics, l'envoi automatique des erreurs importantes est
désactivé par défaut. Son consentement persiste dans le stockage chiffré.
Le diagnostic manuel et sa case d'envoi sont indépendants. Un utilisateur
déconnecté peut préparer et exporter un rapport, mais ne peut pas l'envoyer.
L'export utilise le sélecteur de fichiers Android et un JSON lisible.

Le rapport contient des champs et codes autorisés, des observations et des
contrôles explicitement réussis, échoués, inconnus ou non exécutés. Il exclut
logcat, traces d'exception brutes, paquets, adresses IP, noms de serveurs,
historique de navigation, identités, profils, certificats, clés et jetons.
Une information absente ne devient pas un succès ou une valeur zéro.
Les lectures de diagnostic ne reprennent pas le VPN et ne nettoient pas le
stockage.

| Livraison | Limite appliquée |
| --- | --- |
| Route et schéma | `POST /v1/diagnostics`, schéma 1, origine API du client et jeton de session courant |
| Rapport simple / complet | 8 Kio / 512 Kio maximum |
| Rapport complet | 1 000 événements sur dix minutes, 64 contrôles maximum |
| File en mémoire | 32 rapports, 2 Mio, durée maximale de 24 heures |
| Réessais | Trois tentatives par rapport, `Retry-After`, attente croissante avec aléa, plafond de 30 tentatives par heure |
| Erreurs automatiques | Au plus un nouveau rapport par minute |
| Accusé de réception | `201` ou `200` validé, identifiant client inchangé et expiration annoncée à 30 jours |

L'UUID et le contenu sont figés avant l'envoi et réutilisés à l'identique lors
des reprises. Un changement de compte retire les rapports de la session.
Désactiver le consentement automatique retire ses envois en attente ; annuler
un envoi manuel arrête ses reprises, sans retirer une requête déjà reçue par
le serveur. Une erreur du collecteur ne crée pas elle-même un rapport, ne
révoque pas la session VPN et ne réduit pas la protection Android.

Les rapports et événements restent en mémoire jusqu'à un export explicite.
La collecte ne récupère pas les événements antérieurs au processus ni les
crashes système. Elle ne lance aucun test réseau actif ni réparation : les
sondes Internet, DNS, routage et certificat restent non exécutées. L'état
« connecté » ne prouve donc ni l'efficacité du blocage hors VPN, ni l'accès
Internet, ni la fraîcheur du handshake. Ces propriétés nécessitent les essais
sur appareil décrits dans [DEVELOPMENT.md](DEVELOPMENT.md).

## Corrections de reprise 0.2.7+74013

Un tunnel WireGuard déjà établi reste créé quand tous les réseaux physiques
INTERNET/NOT_VPN disparaissent. Son état public devient `connecting` avec
`wireguard_waiting_network`. Le retour du réseau produit `wireguard_recovering` :
une première mesure fixe le compteur reçu et le handshake de référence ; seul un
handshake plus récent ou une augmentation des octets reçus confirme la reprise.
L'envoi de paquets et un ancien handshake ne constituent pas cette preuve.
Une lecture échouée conserve l'attente. Aucun endpoint de contrôle ni appel API
n'est ajouté ; cette preuve du pair ne certifie pas toutes les destinations Internet.
La surveillance native continue sans interface Flutter, avec une mesure par seconde
pendant la reprise. Les événements d'une ancienne session ou instance sont rejetés.
Application, notification et tuile suivent ces états ; l'arrêt reste accessible.

Le chargement des favoris est indépendant de leur sauvegarde. Le démarrage attend
au plus quatre secondes, mais accepte une lecture tardive ; la nouvelle tentative
réutilise une lecture encore en cours. Avant une lecture réussie, les modifications
sont bloquées pour ne pas écraser des identifiants enregistrés mais inconnus.
Une erreur de lecture possède son propre message et une action de nouvelle tentative.
Les erreurs d'écriture conservent le retour au dernier ensemble durable.

Les formulaires conservent e-mail et mot de passe en mémoire après une erreur et
la fermeture de sa notice. Les titres adaptent leur taille de base à la largeur
des mots avec les polices et la langue actives, jusqu'à 20 points minimum, sans
limiter le TextScaler d'accessibilité ni tronquer le texte.

## Observation réseau WireGuard 0.2.8+74014

À partir d’Android 12, la requête INTERNET/NOT_VPN inclut les réseaux des autres
UID (`setIncludeOtherUidNetworks(true)`). Android filtre autrement les callbacks
aux réseaux applicables à l’UID appelant, ce qui peut masquer le réseau physique
pendant un VPN. L’observation utilise les capacités reçues par callback, sans
lecture synchrone dans le callback. Le filtre conserve INTERNET, NOT_VPN,
TRUSTED et NOT_RESTRICTED.

Un observateur natif continue chaque seconde pendant toute la durée du tunnel
WireGuard établi. Il recoupe le cache des événements avec l’inventaire local
Android sur un worker IO ; une génération empêche ce recoupement d’écraser un
callback plus récent. Une lecture d’inventaire échouée conserve le cache. Cette
mesure couvre aussi les événements manqués et Android 8–11, où l’inclusion des
autres UID n’est pas disponible. Les statistiques du pair sont lues pendant la
reprise ; aucun trafic de sondage ni appel API n’est ajouté.

La durée de cet observateur dépend de la session et de l’instance du tunnel,
pas du compteur des commandes de préparation. Une commande annulée ne retire
pas la surveillance d’un tunnel encore actif. Un arrêt ou un remplacement
annule l’observateur et empêche une publication tardive. Les conditions de
preuve de reprise et les trois affichages introduits en 74013 restent identiques.

Références Android : [état réseau](https://developer.android.com/develop/connectivity/network-ops/reading-network-state),
[portée des UID](https://developer.android.com/reference/android/net/NetworkRequest.Builder#setIncludeOtherUidNetworks(boolean)).

## Chargement WireGuard différé 0.2.9+74015

Le contrôleur conserve un backend lazy synchronisé. La construction de GoBackend
charge libwg-go et initialise le runtime Go ; elle se produit désormais sur le
worker WireGuard lors du premier démarrage natif. La construction du bridge, les
lectures d’état au repos, les statistiques sans tunnel, l’arrêt sans tunnel et
les opérations de clé publique n’initialisent pas ce moteur. OpenVPN et
l’interface ne dépendent donc pas de sa compatibilité avec un pont ARM de VM.

Le runtime Go ARM64 1.24.3 lit MIDR_EL1 lorsque HWCAP_CPUID est annoncé. Le pont
ndk_translation 0.2.3 des VM Android 13 rejette cette instruction ; les VM
Android 12 atteignent une assertion de l’optimiseur lors de WireGuard. Cette
correction isole les parcours inutilisant WireGuard ; elle ne modifie pas Go,
les moteurs précompilés, les verrous ou les paramètres cryptographiques.
Le vrai moteur reste initialisé à la connexion WireGuard et les blocages de
traduction sont reproduits dans les VM : [Q010](VALIDATION.md#q010).
La recette ARM native est bloquée par l’absence d’environnement :
[Q011](VALIDATION.md#q011).

## Statuts lisibles avec texte agrandi 0.2.10+74016

FuzeAdaptiveText partage la mesure des mots entre les titres et le statut de
connexion. Le statut conserve sa taille de base lorsqu’il tient, y compris
avec le scaleur non linéaire Android 14 et suivants. Si un mot dépasse la
largeur intérieure de la carte, sa taille de base est réduite, au minimum
14 points pour les statuts ; les titres gardent leur minimum de 20 points.
La police, les fallbacks, la langue et le TextScaler actifs sont utilisés.
Le TextScaler n’est pas plafonné ou remplacé ; les espaces et retours à la
ligne restent naturels, sans ellipse ajoutée. La ponctuation accolée, notamment
l’ellipse déjà traduite de Reconnexion, participe à la largeur du mot.
Le libellé, la région sémantique live et les actions de connexion/arrêt restent
identiques. Les neuf statuts utilisent cette même présentation.
