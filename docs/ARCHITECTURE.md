# Architecture et comportement Android

Version source **0.2.6+74012**. Ce guide décrit le comportement implémenté
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

| Opération | Réponse attendue / traitement |
| --- | --- |
| Connexion et inscription | `POST /v1/auth/login` et `/v1/auth/register` : `201` |
| Déconnexion et renvoi de vérification | `POST /v1/auth/logout` et `/v1/auth/email/resend` : `204` |
| Confirmation d'e-mail | `POST /v1/auth/email/verify` : `200` avec `email_verified: true` |
| Réinitialisation de mot de passe | `/v1/auth/password/reset/request` : `202` ; `/confirm` : `204` |
| Profil du compte | `GET` et `PUT /v1/me` : `200`. L'absence de `email_verified` signifie inconnu, pas faux. |
| Catalogue | `GET /v1/locations` : `200`. `supported_protocols` détermine les protocoles proposés. |
| Activation WireGuard | `POST /v1/devices` : `201`. Envoie nom, clé publique locale et `location_id`, puis importe l'activation dans le composant natif. |
| Liste et suppression d'appareils | `GET /v1/devices` : `200` ; `DELETE /v1/devices/{id}` : `204` |
| Métadonnées des profils | `GET /v1/devices/{id}/profiles` : `200`, sans activation ni secrets |
| Création / renouvellement OpenVPN | `POST /v1/devices/{id}/profiles/openvpn` et `/renew` : `201`, avec `csr_pem` |
| Révocation OpenVPN ciblée | `DELETE /v1/devices/{id}/profiles/openvpn` : `204` |
| Migration OpenVPN | `POST /v1/devices/{id}/location-migrations` : `200` ou `202` ; suivi `GET .../{migration_id}` : `200` |

Une demande double pile ajoute `ip_families: ["ipv4", "ipv6"]` aux activations
qui le permettent. Le modèle valide la cohérence des adresses et familles
retournées ; aucune route IPv6 n'est déduite d'une donnée manquante.

Un appareil logique peut porter les profils WireGuard et OpenVPN au même
emplacement. La liste accepte aussi un appareil navigateur avec `location: null`
et un profil `browser_proxy` : il reste gérable, mais n'est pas un protocole VPN
sélectionnable. Un refus `device_limit` doit conduire à la gestion des appareils,
pas à une création supplémentaire.

### Déplacement et révocation

WireGuard tente directement `POST /v1/devices` avec la destination. Si le
serveur renvoie `device_location_locked`, le client révoque uniquement le profil
OpenVPN. Après le `204`, il efface atomiquement l'identité OpenVPN locale et
retente WireGuard une seule fois. La session, le `device_id` et la clé WireGuard
restent préservés. Ce chemin ne lance pas de migration d'appareil.

OpenVPN utilise les états `draining`, `activating`, `ready` et `blocked` de la
migration asynchrone. L'identifiant opaque, l'appareil, la destination et l'état
sont chiffrés avec une portée compte/appareil. `Retry-After` prime sur
`retry_after_seconds` ; sans valeur, l'attente est de deux secondes. Les délais
sont validés et le nombre de vérifications est borné. Après `ready`, une lecture
des appareils doit confirmer la destination avant de préparer le tunnel.

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
