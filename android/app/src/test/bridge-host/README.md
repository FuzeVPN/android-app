# Pont Android et tuile, hôte JVM

Cette suite JVM hors ligne compile, sans les modifier, `AndroidVpnBridge.kt`,
`VpnQuickTileService.kt` et leurs politiques (`run.ps1` en donne la liste). Les
API Android et Flutter, le stockage chiffré et les deux moteurs sont remplacés
par les doubles de `stubs/` et `fakes/`. Les types de résultat d'OpenVPN sont
extraits à chaque exécution de `OpenVpnController.kt`.

Elle ne démarre aucun TUN, ne lit aucun Keystore et n'ouvre aucun réseau. Elle
établit l'ordre des commandes, des publications et des appels Android, pas le
rendu ni le comportement d'un appareil.

Les tests de la tuile active peuvent activer un modèle de SystemUI
(`TileService.systemUi`, désactivé par défaut) : un START reçu pendant l'écoute
est ignoré, un STOP suit chaque `updateTile` (retenu sur demande, ou jamais
envoyé), un clic sur une tuile `STATE_UNAVAILABLE` est ignoré. Ces tests
prouvent la cohérence avec ce modèle, pas le comportement de SystemUI.

Exécution (94 tests JUnit) avec les dépendances déjà en cache :

```powershell
& android/app/src/test/bridge-host/run.ps1 -OutputDirectory C:/temp/bridge-host -JavaHome <jdk-17> -ModuleCache <gradle>/caches/modules-2/files-2.1
```

Le dossier de sortie doit être hors du dépôt, ou sous son dossier racine
`build/`. Comme `command-epoch`, la suite ne fait pas partie de
`testDebugUnitTest`. Le runner conserve le journal de compilation, `result.log`
et un reçu `execution.json` (empreinte de chaque source compilée).

Pour vérifier que les assertions rejettent un ancien pont, passer
`-SourceRoot <copie de com/fuzevpn/android avant correction> -ExpectFailure`.
Le script réussit alors seulement si JUnit a rejeté l'ancien code.

Cas couverts, par constat d'audit :

| Constat | Ce que la suite vérifie |
| --- | --- |
| C2-01 | un rafraîchissement de tuile n'appelle jamais `VpnService.prepare`. Un clic explicite vérifie toujours le consentement Android. |
| C2-02 | un `requestListeningState` qui lève (Android 13 avant QPR3, hors utilisateur courant) ne casse ni l'autorisation VPN, ni la connexion, ni la déconnexion du compte. Aucune exception n'atteint le gestionnaire du processus. |
| C2-03 | la branche « réglages » de la tuile passe par le lanceur de la tuile et tolère l'absence de l'activité. |
| C3-01 | `{}`, ou seulement des identifiants de trace, signifie « langue du système ». |
| A08-vpn-bridge-02 | une reprise système annulée sans publication ne reste pas CONNECTING. |
| A08-vpn-bridge-03 | une annulation pendant le handshake WireGuard n'est pas un délai dépassé. |
| A09-services-01 | effacer le profil de la tuile demande son rafraîchissement. |
| A11-03 | hors session, la tuile ouvre l'application. Un refus local n'est pas publié comme une erreur globale. |
| H-E22-N01-01 | une reprise système refusée n'arrête, ne bloque et ne remplace pas une connexion de tuile en file derrière elle. |
| H-E22-N01-02 | un ancien clic de tuile se connecte quand la reprise système admise plus récente a échoué. |
| C4-03 (lot S) | `storageReadSessionBinding` indique `account`, `pending` ou rien, sans effacer après une lecture en échec. |
| A05-models-01, C5-05 | le pont refuse, avant tout moteur, les libellés que le catalogue Dart écarte (97 unités UTF-16, contrôle ISO, vide). Le profil de tuile garde tel quel un libellé accepté. |
| P1 (revue du lot S) | `storageClearSession` lit `reason` (`voluntary`, `expired`, `abandoned`). Seul `expired` est publié comme expiration ; seul `voluntary` révoque la reprise invitée. Les demandes d'une même fin fusionnent, un `voluntary` arrivé après l'effacement révoque encore, une cause inconnue est refusée, l'absence de `reason` garde l'ancien drapeau. |
| P6 (revue du lot S) | une clé Keystore disparue remonte `secure_storage_corrupt` pour les lectures de session ; un Keystore indisponible reste `secure_storage_read_failed`. |
| Réaudit final A2/B11 | une reprise annulée sans publication dans `connectWireGuard`, avant ou après PREPARING, finit IDLE. L'ERROR d'une perte de l'hôte publiée entre-temps est gardée. |
| Réaudit final A3/B16 | hors session, avec un moteur retenu après un arrêt expiré, un clic sur la tuile ouvre l'application sans changer l'état. |
| Réaudit final A4/B20 | une reprise qui échoue dans sa propre vérification de session libère l'ancien clic de tuile en file derrière elle, qui se connecte ou dont l'échec est signalé. |
| Réaudit final B15 | un changement du consentement VPN vu par `VpnService.prepare` rafraîchit la tuile active. |
| Réaudit final B19 | un moteur incertain refuse sa clé (`wireguard_operation_pending`) ; la déconnexion du compte purge quand même la session. |
| Réaudit final B31 | une demande `storageClearSession` refusée (cause inconnue) n'annule pas une reprise système en cours. |
| Réaudit final B33 | une clé Keystore disparue remonte `secure_storage_corrupt` aussi pour les lectures invitées (credential, reprise automatique). |
| QT-REVOKE-OVPN-01 (campagne VM de bc30a13) | la tuile active finit sur l'état du pont après une rafale de publications (perte de l'hôte, déconnexion depuis la tuile), que SystemUI ignore les START pendant l'écoute, l'arrête après chaque rendu ou ne l'arrête jamais. Un STOP qui annule sa lecture, ou la destruction sans STOP d'une instance qui a manqué une publication, est rattrapé. Un clic refusé ne laisse pas le rendu « occupé ». La lecture lancée par le START du clic ne remplace pas ce rendu, et un second clic avant la première publication est ignoré. Les demandes d'écoute restent bornées, même sans objet `Tile`. |
| QT-REVOKE-OVPN-01, précondition | un clic de tuile refusé localement (sans profil, sans identité) n'appelle jamais `VpnService.prepare`. |
| Perte réseau OpenVPN (VM Android 16 : bascule Wi-Fi → cellulaire, coupures répétées) | `onLost` décide seul, même si `getAllNetworks` liste encore le réseau perdu ou si un autre réseau reste ; une perte pendant le démarrage est traitée à la preuve CONNECTED. Chaque reconnexion prouvée permet le changement de réseau suivant sans consommer la reprise sur échec, qui reste unique par connexion explicite. Sans réseau, la session finit en `network_unavailable` avec la notification, et le TUN retenu n'est relâché (`OpenVpnService.stop`) qu'à ce moment. Une session WireGuard ne déclenche jamais cette perte. |
| P2 VPN permanent (campagne 74018 : SIGKILL ou `am crash` sans reprise) | le VPN permanent constaté pendant la connexion, même activé après elle, arme la relance ; une commande d'arrêt (app, tuile) ou une perte de l'hôte la désarme dès sa réception, sans qu'une écriture en cours la réarme. Après la mort, la relance restaure WireGuard ou OpenVPN par la reprise système ; elle ne montre ni n'écrit rien avant ses vérifications (état prêt, compte, consentement, aucun autre VPN de cette app, réseau), ne prend jamais le VPN d'une autre app, ne retente pas une reprise interrompue, laisse l'état prêt si l'hôte est refusé ou le réseau absent, et bloque comme au démarrage système après l'échec d'une connexion. Le démarrage système d'Android l'emporte sur une relance non réservée, en une seule restauration. |
| Android 11, `ConnectivityManager` du paquet `android` (campagne vm31i : 10 démarrages à froid plantés sur 40) | un processus dont le gestionnaire refuse le callback et les capacités (`SecurityException`, `SystemPackageConnectivityManager`) construit quand même le pont ; la tuile et `getState` répondent, WireGuard reste CONNECTED sans attente de réseau, la déconnexion revient à IDLE. La relance après une mort restaure le VPN permanent. Le type hérité du réseau par défaut refuse encore le VPN d'une autre app, pas celui d'un autre profil. Pendant OpenVPN, le réseau physique par défaut lu sans contrôle de paquet (type hérité et information supplémentaire, l'APN d'un cellulaire, de `activeNetworkInfo` ; réseaux listés, connectés ou suspendus, qui leur correspondent ; `LegacyDefaultNetworkTracker`) remplace le callback (campagne vm31j : téléchargements expirés à la perte puis au retour du Wi-Fi). Le double nomme ce réseau par défaut : le retirer n'en promeut aucun autre. Comme Android 11 (`filterNetworkStateForUid`, `mixInInfo`), il efface l'APN d'un réseau `BLOCKED` pour l'app dans les deux lectures et le garde pour un réseau `SUSPENDED`, qui n'est pas connecté. Quand ses réseaux disparaissent (le Wi-Fi, puis le cellulaire remplacé par un Wi-Fi ; le cellulaire de données remplacé par un nouveau du même APN pendant qu'un réseau IMS reste listé ; le seul Wi-Fi perdu, un instant sans réseau par défaut, puis remplacé), la perte est suivie une fois, en moins de 3 s comme `onLost`, par une reconnexion qui ne consomme pas la reprise sur échec. Le Wi-Fi qui revient comme réseau par défaut pendant que le cellulaire reste listé (campagne vm31k), ou les données mobiles passées à l'autre SIM (autre APN) pendant que la première reste listée, sont aussi une perte ; le retrait ultérieur du réseau délaissé n'en est pas une. Un nouveau réseau du même APN monté connecté derrière le réseau par défaut, qui le devient pendant que l'ancien reste listé, n'est pas une perte : seul le départ de l'ancien en est une. Le réseau de données par défaut `SUSPENDED` (hors service de données, appel sans voix et données simultanées) pendant que l'IMS de l'autre SIM reste connecté n'est pas une perte ; sa suppression, un instant sans réseau par défaut, en est une seule, la reconnexion attendant le nouveau réseau de données. Le réseau par défaut lu `BLOCKED` (APN effacé) puis de nouveau connecté n'est pas une perte. Un réseau listé derrière le réseau par défaut (IMS ou MMS de son type avec son propre APN, Wi-Fi sans adresse) apparaît et disparaît sans perte ni reconnexion ; un Wi-Fi encore sans adresse ne masque pas le départ du réseau par défaut dont il prend la place. Une interruption de Core n'est un changement de réseau que si le réseau par défaut a été perdu depuis le relevé précédent, compté une fois ; sinon, même après le départ d'un réseau listé derrière lui, elle consomme l'unique reprise, puis finit en `openvpn_recovery_exhausted`, comme avec le callback. |
