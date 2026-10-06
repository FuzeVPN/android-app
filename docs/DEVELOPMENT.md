# Développer et valider le client Android

Version source **0.2.4+74010**. Le dépôt public contient les sources et entrées
natives nécessaires, sans APK/AAB ni GitHub Releases.

Les commandes de ce guide partent de la racine du dépôt, sauf
indication contraire. Elles décrivent la procédure à exécuter ; leur présence
ne signifie pas que la version courante a passé ces contrôles. Les essais sur
téléphone et la signature de diffusion nécessitent une validation distincte.

Le comportement attendu est décrit dans [ARCHITECTURE.md](ARCHITECTURE.md).
Les imports, patches, empreintes et licences natives sont détaillés dans
[NATIVE_DEPENDENCIES.md](NATIVE_DEPENDENCIES.md).

## Poste de travail

| Prérequis | Version / cible |
| --- | --- |
| Flutter | 3.44.7, déclaré dans `.flutter-version` |
| JDK | 17 |
| Android Gradle Plugin / Kotlin | 9.3.0 / 2.3.20 |
| Gradle | 9.5.0 via le wrapper et son empreinte verrouillée |
| Android SDK | Platform 36, Build Tools 36 |
| NDK | 28.2.13676358 |
| CMake | 3.22.1 |
| Application | `minSdk=26`, `compileSdk=36`, `targetSdk=36` |
| ABI de diffusion | `arm64-v8a`, `armeabi-v7a` |
| ABI supplémentaire de test | `x86_64` pour émulateur debug |

Installer ces outils sur le poste ou l'image de CI, puis vérifier les versions
de Flutter et Java. Le projet ne télécharge pas lui-même le SDK Flutter.
Créer `android/local.properties`, ignoré, avec les chemins locaux :

```properties
sdk.dir=C:\\Android\\Sdk
flutter.sdk=C:\\outils\\flutter-3.44.7
```

Définir `JAVA_HOME` vers le JDK 17 et `ANDROID_SDK_ROOT` vers le SDK
(Android SDK `ANDROID_HOME` est aussi accepté par les outils PowerShell).
Ajouter Flutter et les outils Android au `PATH`. Préparer Platform/Build Tools
36, NDK 28.2.13676358, CMake 3.22.1 et `cmdline-tools/latest`.
`GRADLE_USER_HOME`, s’il est défini, choisit le cache Gradle.

Les options
`android.builtInKotlin=false` et `android.newDsl=false` de
`android/gradle.properties` assurent la compatibilité de cette matrice avec
l'intégration Flutter ; ne pas les retirer indépendamment d'une évolution
validée du toolchain.

Préparer les dépendances Flutter :

```powershell
flutter pub get
```

La première résolution des dépendances et la préparation des caches peuvent
nécessiter le réseau. `--no-pub` évite une nouvelle résolution Flutter et
`--offline` impose le cache Gradle ; ces options ne remplacent pas une
préparation complète du poste. Les imports natifs restent explicites : la
compilation native de l'application ne télécharge pas ses sources.

## Dépendances et intégrité natives

### Résolution Gradle verrouillée

Les configurations résolubles de l'application et du plugin Android de liens
utilisent le mode strict de verrouillage. Les versions transitives sont
conservées sous `android/gradle/dependency-locks/` ; `app-patched.lockfile`
couvre l'AAR local approuvé et `app-maven.lockfile` le fallback Maven de debug.
`url_launcher_android.lockfile` reste dans ce dépôt, même lorsque le plugin
est chargé depuis le cache Pub.

Les modules de moteur `io.flutter` dépendent des ABI demandées par Flutter et
sont exclus du verrou de versions pour permettre les splits ARM64/ARMv7 et
les essais x86_64. Leur révision exacte et leurs artefacts restent imposés
par les empreintes de vérification ; seules les entrées du SDK épinglé sont
approuvées dans ces métadonnées.

`android/gradle/verification-metadata.xml` impose aussi les SHA-256 des
artefacts et métadonnées Gradle, y compris les plugins. Un build ordinaire
refuse une empreinte inattendue ou un état de verrouillage manquant. Les
empreintes initiales ont été enregistrées depuis les dépôts HTTPS configurés ;
elles assurent la stabilité des téléchargements suivants et ne constituent
pas une certification indépendante de chacun de leurs éditeurs.

Une évolution de dépendance exige une mise à jour explicite et une revue des
différences. Depuis `android/`, résoudre les deux variantes puis exécuter les
tâches de compilation et de lint nécessaires pour couvrir leurs artefacts :

```powershell
.\gradlew.bat resolveLockedDependencyGraphs --write-locks --write-verification-metadata sha256 '-Pfuzevpn.usePatchedWireGuardAar=true'
.\gradlew.bat resolveLockedDependencyGraphs --write-locks --write-verification-metadata sha256 '-Pfuzevpn.usePatchedWireGuardAar=false'
```

Examiner les versions, dépôts et nouvelles empreintes avant de conserver ces
fichiers. Ne pas utiliser les options de génération pendant la validation
normale : relancer ensuite les builds sans `--write-locks` ni
`--write-verification-metadata`. Le test isolé
`tools/test_dependency_integrity.ps1` vérifie le succès avec une dépendance
approuvée et les refus pour empreinte altérée, version contradictoire et
verrou absent ; il ne modifie ni le cache ni les verrous de l'application.

### Entrées natives

L'application active déjà `FUZEVPN_ENABLE_OPENVPN3_CORE=ON` dans
`android/app/build.gradle.kts`. Le bundle importé sous
`android/app/src/main/cpp/third_party/`, son inventaire indépendant dans
`android/native-provenance/` et l'AAR WireGuard local sont des entrées de build
à conserver.

Les builds release et profile exigent
`fuzevpn.usePatchedWireGuardAar=true` et l'AAR local approuvé. Debug peut utiliser
le runtime Maven si cette option est absente ; pour les essais de l'application
complète et du VPN permanent, sélectionner aussi l'AAR local en debug.
Une modification d'empreinte ne constitue pas une approbation de provenance.
Suivre [NATIVE_DEPENDENCIES.md](NATIVE_DEPENDENCIES.md) pour un import ou une
reconstruction des moteurs.

## Contrôles locaux

Après préparation des dépendances :

```powershell
python tools/generate_translations.py --check --require-all
flutter analyze --no-pub
flutter test --no-pub

Push-Location android
try {
    .\gradlew.bat -p buildSrc check --offline
    .\gradlew.bat :app:testDebugUnitTest :app:lintDebug :app:lintVitalRelease --offline -Pfuzevpn.usePatchedWireGuardAar=true
} finally {
    Pop-Location
}

.\tools\test_wireguard_release_gate.ps1
.\tools\test_dependency_integrity.ps1
```

Examiner le code de sortie de chaque commande avant de poursuivre. Les tests
Flutter utilisent des modèles, transports simulés ou serveurs de test locaux ;
ils ne valident pas les services de production. Les tests JVM couvrent les
politiques et la coordination Android sans remplacer Android Keystore ni les
tunnels sur un appareil réel.

Le `check` de `buildSrc` exécute les politiques de provenance native, d'AAR
WireGuard et de permissions Android. Le script de gate WireGuard vérifie aussi
les refus release/profile sans option explicite et la séparation des
dépendances Maven/locales. Ses résultats sont produits sous `build/`.

La configuration lint documente des exclusions de compatibilité : les tâches
lint de `url_launcher_android`, deux contrôles de commentaires défaillants avec
le JDK 17, des alertes de disponibilité de versions et le contrôle des chemins
de `local.properties`. Le lint de l'application reste actif ; ces exclusions
font partie des limites à réévaluer lors d'une évolution du toolchain.

Selon la zone modifiée, compléter avec les contrôles ciblés suivants :

```powershell
.\tools\test_build_provenance.ps1 -JavaHome $env:JAVA_HOME
.\tools\test_wireguard_protected_start.ps1
.\tools\test_openvpn_connection_state.ps1 -NdkPath (Join-Path $env:ANDROID_SDK_ROOT 'ndk/28.2.13676358')
.\tools\test_openvpn_network.ps1 -NdkPath (Join-Path $env:ANDROID_SDK_ROOT 'ndk/28.2.13676358')
```

Le test de démarrage WireGuard lit `JAVA_HOME`, `ANDROID_SDK_ROOT` (ou
`ANDROID_HOME`) et le cache Gradle du poste. `-JavaHome`, `-AndroidSdk` et
`-GradleUserHome` permettent de préciser ces chemins. Il exige les dépendances
JAR/AAR déjà résolues ; préparer le cache avec les résolutions Gradle avant
les contrôles hors ligne. Les deux scripts OpenVPN évaluent des
`static_assert` C++ pendant la compilation pour les trois ABI de test. Ils
produisent des fichiers objets, sans exécuter de binaire Android ni créer de
connexion VPN. Un succès de compilation couvre ces assertions, pas le moteur
en fonctionnement sur téléphone.

## Construire les APK

```powershell
flutter build apk --debug --no-pub --split-per-abi --target-platform android-arm64,android-arm,android-x64 --android-project-arg=fuzevpn.usePatchedWireGuardAar=true
flutter build apk --release --no-pub --split-per-abi --target-platform android-arm64,android-arm --android-project-arg=fuzevpn.usePatchedWireGuardAar=true
```

Les APK sont écrits dans `build/app/outputs/flutter-apk/`. Pour une livraison,
choisir explicitement le nom et le numéro de version, avec `--build-name` et
`--build-number` si nécessaire. Les splits Flutter peuvent produire des
`versionCode` différents du numéro de base : vérifier les métadonnées de chaque
APK au lieu de déduire sa version de son nom de fichier.

Le build release ne possède actuellement aucune configuration de signature
dans Gradle. `key.properties` est ignoré, mais n'est pas lu par le projet :
le créer ne signe pas l'APK. La signature de diffusion doit être fournie par
l'environnement de livraison. Un APK release signé avec un certificat debug
reste un APK de test et ne doit pas être présenté comme une livraison signée
pour publication.

### Construire l'App Bundle

```powershell
flutter build appbundle --release --no-pub --target-platform android-arm64,android-arm --android-project-arg=fuzevpn.usePatchedWireGuardAar=true
```

Le bundle est écrit dans `build/app/outputs/bundle/release/app-release.aab`.
Son `versionCode` est le numéro de base de `pubspec.yaml`, sans l'incrément
des APK séparés par ABI. Les filtres natifs reprennent les cibles Flutter
pour inclure les moteurs complets de chaque architecture sélectionnée.
Les outils Android doivent être disponibles sous `cmdline-tools/latest/bin/`
pour permettre à Flutter de vérifier les symboles natifs du bundle.

Le bundle release est non signé avec la configuration actuelle. Pour Google
Play, signer une copie avec la clé d'envoi appropriée via `jarsigner` ou la
configuration de signature de l'environnement de livraison. `apksigner`
sert aux APK ; la clé debug ne convient pas à la publication du bundle.
Valider le bundle avec `bundletool validate`, puis contrôler les APK générés
avec `bundletool build-apks`, notamment les ABI et l'alignement de 16 Kio.

### Optimisation de la release

La release active R8 et la réduction des ressources avec les règles Android
optimisées par défaut et `android/app/proguard-rules.pro`. Les règles locales
conservent les interfaces appelées par JNI ou par réflexion dans les moteurs
OpenVPN et WireGuard. Les builds debug gardent leurs noms pour le débogage.

Après une modification des interfaces natives, adapter ces règles, inspecter
les classes et signatures du DEX optimisé, puis tester les connexions et le
cycle de vie sur Android. La réussite de la compilation seule ne garantit pas
la conservation des appels indirects.

Conserver les fichiers de `build/app/outputs/mapping/release/` avec chaque
livraison, notamment `mapping.txt`, pour comprendre les rapports de plantage.
Le bundle inclut les métadonnées R8 et le mapping destinés à Google Play.
L'export des sources inclut les règles R8 ; elles doivent aussi être publiées
dans le dépôt open source avec les instructions de compilation. Les clés de
signature et leurs mots de passe restent en dehors du dépôt.

### Signature et qualification des builds locaux

Le dépôt ne fournit ni clé privée ni mot de passe de signature. Un build
release non signé ou signé avec une clé de test ne constitue pas une
publication Play. Pour une distribution binaire distincte, fournir la
signature adaptée, contrôler le certificat avec `apksigner`, puis les ABI,
versions, alignement de 16 Kio et empreintes. Garder ces sorties hors du dépôt.
Les archives de sources correspondantes et notices doivent être préparées
selon [SOURCE_DISTRIBUTION.md](SOURCE_DISTRIBUTION.md).

## Tests visuels

Les références de comparaison sont dans `test/widget/goldens/` et font partie
des tests. Les images sous `test/widget/failures/` sont des sorties de comparaison.
Lors d'une modification visuelle voulue, examiner les différences avant de
régénérer les références :

```powershell
flutter test --no-pub --update-goldens --tags golden test/widget/app_ui_test.dart test/widget/account_restoration_test.dart
```

Les captures de revue avec les polices embarquées utilisent un emplacement
séparé, `build/reports/ui-previews/` :

```powershell
flutter test --no-pub --update-goldens --dart-define=FUZEVPN_REVIEW_FONTS=true --tags golden test/widget/app_ui_test.dart test/widget/account_restoration_test.dart
```

Ces captures chargent Archivo, IBM Plex Mono et Noto Sans Arabic. Elles
couvrent connexion, authentification, inscription, réinitialisation, catalogue,
compte, diagnostics, fermeture de session, restauration, tablette et arabe à
200 %. Les vues utilisent des données synthétiques. Examiner les thèmes clair et
sombre, les petits écrans, les textes longs, le texte à 200 %, les états de
transition et les interfaces de droite à gauche. La génération d'une image
ne vaut pas une revue visuelle ni une approbation automatique d'une nouvelle
référence.

## Localisation

Les trente fichiers `lib/l10n/translations/<code>.json` sont la source des
messages Flutter, des textes Android et des noms de pays. Modifier les packs,
puis régénérer leurs sorties ; ne pas entretenir une traduction parallèle dans
les ARB, XML ou classes Dart générés. Les codes sont :

```text
en es pt de fr ar tr ja id ru it ko pl nl hi vi uk th
zh-Hans zh-Hant fa ur fil ms ro cs sv da nb el
```

Le générateur écrit les ARB de toutes les langues, les `strings.xml` Android,
le français dans `android/app/src/main/res/values/strings.xml` et
`lib/l10n/translated_countries.dart`. Flutter produit ensuite les classes de
`lib/l10n/generated/` selon `l10n.yaml`, dont le catalogue modèle est
`app_fr.arb`.

```powershell
python tools/generate_translations.py --require-all
python tools/generate_translations.py --check --require-all
flutter gen-l10n
flutter analyze --no-pub
flutter test --no-pub
```

`--check --require-all` contrôle tous les packs et la fraîcheur des sorties sans
écrire de fichiers. Les trente packs sont toujours requis ; `--require-all`
reste accepté pour la compatibilité des commandes. Les contrôles portent
notamment sur les clés, textes vides, doublons, variables ICU, branches `select`
et arguments Android. Une validation structurelle ne garantit pas la qualité
linguistique : relire les traductions en contexte.

Le registre `lib/l10n/app_languages.dart` et
`NativeLocalePolicy.kt` doivent rester cohérents. Les préférences utilisent
les tags BCP-47 complets, avec `zh-Hans` et `zh-Hant` distincts. Les alias
`in` → `id`, `tl` → `fil` et `no` → `nb` sont normalisés. Les variantes
régionales rejoignent la langue disponible. Le choix explicite de l'utilisateur
prime ; en mode système, la première langue du téléphone reconnue est utilisée.
Si aucune préférence explicite valide ni langue système prise en charge n'est
disponible, la politique applicative se replie sur le français. Les ressources
Android par défaut sont également françaises.

Le sélecteur place la langue du téléphone en premier, puis les noms de langue
dans leur propre écriture. Le tri ignore les accents latins et utilise un
ordre Unicode déterministe pour les autres écritures. Arabe, persan et ourdou
utilisent une interface de droite à gauche. `app_zh.arb` est la base chinoise
requise par Flutter, générée depuis le chinois simplifié ; elle n'ajoute pas
un trente-et-unième choix. Android conserve le répertoire historique
`values-in` pour l'indonésien, tout en stockant la préférence `id`.

Les notifications et la tuile suivent la langue de l'application. Les paquets
de langues Android séparés sont désactivés pour conserver ces ressources dans
l'installation de base. Les écritures non latines utilisent les polices de
secours du système. Les liens juridiques externes restent limités aux langues
prises en charge par leur site.

## Essais sur téléphone

Les tests locaux ne prouvent pas le fonctionnement d'un VPN réel, du stockage
Keystore ou du VPN permanent. Utiliser un téléphone de test Android 8+, un
compte prévu pour les essais et les emplacements effectivement proposés à ce
compte. Les essais de connexion sollicitent l'API et les serveurs VPN ; ils
doivent être lancés dans le cadre d'une validation sur appareil autorisée.

Pour une première installation, activer le débogage USB, autoriser ADB,
déverrouiller le téléphone et installer l'APK choisi avec `adb install -r`.
Une mise à jour exige le même identifiant d'application et un signataire
compatible avec l'installation présente. Depuis la version 0.2.1,
`com.fuzevpn` est distinct de l'ancienne installation `com.fuzevpn.android` :
les données privées, clés Keystore et autorisations VPN ne sont pas reprises.
Le namespace des classes Kotlin reste `com.fuzevpn.android` ; les tests sont
installés sous `com.fuzevpn.test`.
Accepter explicitement l'autorisation VPN et, si demandée, celle des
notifications. L'autorisation de notification ne remplace pas le consentement
VPN.

Le script `tools/test_redmi_vpn_lifecycle.ps1` pilote l'interface publique et
contrôle le transport VPN Android, le service et l'interface réseau. Par défaut,
il vise le Redmi Note 13 Pro ; les autres modèles requièrent `-AllowAnyModel`.
Avant son lancement, connecter le compte dans l'application, charger le
catalogue et vérifier les deux protocoles et les emplacements choisis.

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\test_redmi_vpn_lifecycle.ps1 `
  -ApkPath .\build\app\outputs\flutter-apk\app-arm64-v8a-debug.apk `
  -JavaHome $env:JAVA_HOME `
  -SourceLocation 'Frankfurt-01' `
  -TargetLocation 'Frankfurt-02'
```

Adapter les emplacements au catalogue du compte. Omettre `-ApkPath` teste
l'application déjà installée. `-Serial` choisit l'appareil ; `-AdbPath` peut
désigner ADB. `-Cycles 1` fournit un contrôle réduit, tandis que la matrice
normale utilise trois cycles par protocole. `-SkipBuild` réutilise l'APK
d'instrumentation existant : ne l'utiliser que s'il correspond aux sources à
valider. Les délais sont réglables avec `-ConnectionTimeoutSeconds` et
`-MigrationTimeoutSeconds`.

La matrice couvre les connexions et arrêts répétés, la bascule
WireGuard → OpenVPN → WireGuard, le déplacement OpenVPN et le passage
OpenVPN → WireGuard vers un autre emplacement sans migration d'appareil.
Chaque connexion doit avoir une preuve native ; chaque arrêt doit faire
disparaître le transport, le service et l'interface VPN attendus.

Le script choisit le français pour stabiliser les libellés, termine déconnecté
et laisse la destination cible sélectionnée. Il maintient l'écran allumé sur
USB et restaure ce réglage à la fin. Après un échec dont le nettoyage laisse
un VPN actif, il peut arrêter le processus de l'application. Il n'efface pas
l'application ni ses données. Les résultats vont dans `build/reports/device/`
avec étapes, états, version, modèle et suffixe du numéro ADB, sans collecte de
logcat, profils, clés, certificats, CSR ou réponses API.

Compléter cette matrice avec les scénarios suivants :

| Scénario | Contrôle attendu |
| --- | --- |
| Keystore / XKey | Exécuter les tests Android ciblés de stockage, CSR et signatures avec une vraie clé non exportable. |
| Réseau réel | Vérifier l'IP publique, DNS, routage IPv4/IPv6 et la réaction aux changements Wi-Fi/mobile. |
| Arrière-plan | Vérifier le tunnel et sa notification après verrouillage et fermeture de l'interface. |
| Réglages rapides | Reconnecter et arrêter le dernier profil validé pour chaque protocole, sans appel API de préparation. |
| VPN permanent / blocage sans VPN | Vérifier les options système, l'absence de fuite hors tunnel et la reprise après redémarrage et déverrouillage. |
| Révocation et session | Vérifier arrêt, effacement limité à l'identité concernée, perte de session et changement de compte. |
| Renouvellement OpenVPN | Utiliser un certificat à J-7 ou expiré ; vérifier `/renew`, reprise du même CSR et conservation de l'identité active en cas d'échec API. |
| Consentement et interruptions | Refuser la permission VPN, interrompre une préparation et confirmer l'absence de boucle ou de second tunnel. |
| Interface | Vérifier hiérarchie, recherche, favoris, confirmation, capacité refusée, trente langues, RTL et notifications. |
| Diagnostics | Vérifier consentements séparés, export, absence de secrets et exactitude des contrôles inconnus/non exécutés. |

Les tests Android ciblés sont sous `android/app/src/androidTest/` ; leur
compilation seule ne vaut pas leur exécution. Sélectionner les classes
adaptées au changement et réserver les tests de cycle VPN au compte de test.
Ne pas envoyer un diagnostic d'essai en production sans le consentement prévu
pour cet envoi.

## Revue de publication des sources

- [ ] Version **0.2.4+74010**, matrice du poste, dépendances et provenance natives
      décrites ; entrées verrouillées et fixtures amont conservées.
- [ ] Sources, patches, assets, licences, notices et instructions présentes,
      liens du dépôt utilisables sans historique de rapports locaux.
- [ ] [LICENSE](../LICENSE), [LICENSING.md](../LICENSING.md),
      [notices](../THIRD_PARTY_NOTICES.md) et [SBOM](SBOM.spdx.json) cohérents,
      exceptions et composants Google sous conditions SDK explicites.
- [ ] Aucun cache, sortie de compilation, APK/AAB, clé de diffusion, profil
      privé ni rapport contenant une identité personnelle dans les sources.
- [ ] Limites Google natif, API/achats/RTDN réels et reproductibilité binaire
      explicitement distinguées des contrôles de sources.

Les commandes précédentes permettent aux contributeurs de construire et
valider localement. Les résultats vont sous `build/` et ne sont pas publiés
avec ce dépôt. Pour une diffusion binaire ultérieure, ajouter une recette
sur les appareils/signatures ciblés, l’inventaire du livrable exact et les
sources correspondantes ; voir [SOURCE_DISTRIBUTION.md](SOURCE_DISTRIBUTION.md).
