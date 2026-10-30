# Pont Android et tuile, hôte JVM

Cette suite JVM hors ligne compile, sans les modifier, `AndroidVpnBridge.kt`,
`VpnQuickTileService.kt` et leurs politiques (`run.ps1` en donne la liste). Les
API Android et Flutter, le stockage chiffré et les deux moteurs sont remplacés
par les doubles de `stubs/` et `fakes/`. Les types de résultat d'OpenVPN sont
extraits à chaque exécution de `OpenVpnController.kt`.

Elle ne démarre aucun TUN, ne lit aucun Keystore et n'ouvre aucun réseau. Elle
établit l'ordre des commandes, des publications et des appels Android, pas le
rendu ni le comportement d'un appareil.

Exécution (43 tests JUnit) avec les dépendances déjà en cache :

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
