# Commandes système et tuile

Cette suite JVM hors ligne vérifie l'ordre entre une reprise VPN Android et les
commandes explicites. Elle extrait à chaque exécution les vrais blocs
`onSystemVpnStart`, `toggleFromQuickTile`, `cancelSystemStart` et les préfixes
d'admission WireGuard/OpenVPN depuis `AndroidVpnBridge.kt`.

Le template fournit seulement des frontières synthétiques pour Android, le
registre durable, la session et les moteurs. Il ne démarre pas de TUN et ne lit
aucun Keystore réel. Les deux connexions conservent leur vrai préfixe de garde
dans le mutex de transition du harness.

Exécution (26 tests JUnit) avec les dépendances déjà en cache :

```powershell
& android/app/src/test/command-epoch/run.ps1 -OutputDirectory C:/temp/vpn-command-epoch
```

Le dossier de sortie doit être extérieur au dépôt ou dans son dossier racine
`build/`. Les dossiers de sources sont refusés. La suite ne fait pas partie de
la découverte automatique de `testDebugUnitTest` : ce runner direct est son
point d'entrée. Il conserve les sources extraites, les journaux et le reçu JSON.
`-JavaHome` et `-ModuleCache` permettent de passer explicitement le JDK et le
dossier `caches/modules-2/files-2.1` de Gradle. Par défaut, le runner utilise
`JAVA_HOME` (ou Java dans PATH), puis `GRADLE_USER_HOME` (ou le dossier `.gradle`
standard du profil). Aucune dépendance manquante n'est ignorée ou téléchargée.

Pour vérifier que les assertions rejettent un ancien bridge, utiliser
`-BridgeSource <copie-source-avant-correction> -ExpectFailure` avec un autre dossier
de sortie. Un succès du script signifie alors que JUnit a effectivement rejeté
l'ancien code ; son code de retour brut reste dans `execution.json`.

Cas couverts : anciennes lectures et callbacks d'erreur, connexions anciennes
réussies, deux protocoles, refus de reprise, duplicats avant déverrouillage et
pendant attente réseau, réservation interrompue par une commande plus récente,
priorité d'un arrêt déjà en file et linéarisation des publications avec admission
et annulation système. Une préemption après libération du mutex de réservation
vérifie aussi qu'un ancien système ne peut réécrire CONNECTING après le CONNECTED
d'une nouvelle commande explicite.

Le registre de la fixture distingue READY, RESERVED, BLOCKED et la tombe. Les
cas du 29/10 font partager le même epoch de requête à la reprise système et à
une commande explicite :
- reprise refusée qui tient le mutex devant une tuile ou une connexion Flutter
  (H-E22-N01-01) ;
- reprise admise puis dépassée par une connexion Flutter antérieure, et rappel
  système pendant une connexion explicite qui échoue (A08-vpn-bridge-01) ;
- ancien clic de tuile après l'échec d'une reprise admise, y compris en file
  derrière cet échec (H-E22-N01-02) ;
- reprise annulée par une commande qui ne publie rien (A08-vpn-bridge-02) ;
- refus local de la tuile sans erreur globale (A11-03).

Sur un pont antérieur à la garde d'autorité explicite, le runner ajoute deux
fonctions vides (`admitExplicitCommand`, `closeTunnelHold`) pour que le contrôle
négatif compile.
