# Développer et valider le client Android

Audit de qualification du 14 octobre 2026 : [Q001](VALIDATION.md#q001), [Q003](VALIDATION.md#q003), [Q004](VALIDATION.md#q004), [Q006](VALIDATION.md#q006), [Q008](VALIDATION.md#q008), [Q009](VALIDATION.md#q009), [Q010](VALIDATION.md#q010), [Q011](VALIDATION.md#q011), [Q012](VALIDATION.md#q012), [Q013](VALIDATION.md#q013), [Q014](VALIDATION.md#q014), [Q015](VALIDATION.md#q015), [Q016](VALIDATION.md#q016), [Q017](VALIDATION.md#q017), [Q026](VALIDATION.md#q026), [Q027](VALIDATION.md#q027), [Q028](VALIDATION.md#q028), [Q032](VALIDATION.md#q032).


Version source **0.2.11+74018**. Le dépôt public contient les sources et entrées
natives nécessaires. Les APK signés sont joints aux GitHub Releases, sans AAB :
voir le [guide des APK](APK.fr.md).

Les commandes de ce guide partent de la racine du dépôt, sauf
indication contraire. La validation locale de 0.2.11+74018 passe ses 24 étapes :
2 894 tests Flutter, 464 JVM, 237 Python et 94 bridge-host, lint sans erreur.
Les contrôles historiques 74016 restent dans le [registre daté](VALIDATION.md). Les résultats d’instrumentation, de signature et de VM sont
détaillés dans le [registre daté](VALIDATION.md).

Le [bilan des corrections de l'audit complet du 28 octobre 2026](AUDIT_CORRECTIONS_20261029.md)
décrit les 81 écarts corrigés les 29 et 30 octobre, la montée vers Flutter 3.47.8
et Gradle 9.8.2 et les deux validations locales intégrées, avec leurs limites.
Le [bilan des corrections du 28 octobre 2026](AUDIT_CORRECTIONS_20261028.md)
décrit les onze écarts, la validation locale actuelle et les nouvelles
compilations de contrôle, avec leurs limites de qualification.

Le comportement attendu est décrit dans [ARCHITECTURE.md](ARCHITECTURE.md).
Les imports, patches, empreintes et licences natives sont détaillés dans
[NATIVE_DEPENDENCIES.md](NATIVE_DEPENDENCIES.md).

## Poste de travail

| Prérequis | Version / cible |
| --- | --- |
| Flutter | 3.47.8 (Dart 3.13.7), déclaré dans `.flutter-version` et exigé par `pubspec.yaml` |
| JDK | 17 |
| Node.js | Installé pour les tests JavaScript hôtes ; v24.16.0 testée |
| Go | Installé pour le test hors ligne de wireguard-go (`tools/tests/test_wireguard_ipv6_length.py`) : 1.23.1 minimum, 1.26.3 testée ; `FUZEVPN_GO` peut désigner `go.exe` |
| Android Gradle Plugin / Kotlin | 9.3.0 / 2.3.20 |
| Gradle | 9.8.2 via le wrapper et son empreinte verrouillée |
| Android SDK | Platform 36, Build Tools 36 |
| NDK | 28.2.13676358 |
| CMake | 3.22.1 |
| Application | `minSdk=26`, `compileSdk=36`, `targetSdk=36` |
| ABI de diffusion | `arm64-v8a`, `armeabi-v7a`, `x86_64` |

Installer ces outils sur le poste ou l'image de CI, puis vérifier les versions
de Flutter et Java. Le projet ne télécharge pas lui-même le SDK Flutter.
Créer `android/local.properties`, ignoré, avec les chemins locaux :

```properties
sdk.dir=C:\\Android\\Sdk
flutter.sdk=C:\\outils\\flutter-3.47.8
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
les refus release/profile sans option explicite, la séparation des
dépendances Maven/locales et, avec l'AAR approuvé, que les bibliothèques
natives fusionnées contiennent `libwg-go.so` mais ni `libwg.so` ni
`libwg-quick.so` (cas `native-libraries-approved`). Ses résultats sont
produits sous `build/` ; `-Only <cas>` ne sert qu'au diagnostic local.

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
JAR déjà résolues et l'AAR local approuvé, vérifié par la même politique que
le build applicatif avant son extraction ; le fallback Maven debug n'est pas
un prérequis. Préparer le cache avec les résolutions Gradle avant les contrôles
hors ligne. `-OutputDirectory` isole les résultats du test de démarrage.
Les deux scripts OpenVPN évaluent des
`static_assert` C++ pendant la compilation pour les trois ABI de test. Ils
produisent des fichiers objets, sans exécuter de binaire Android ni créer de
connexion VPN. Un succès de compilation couvre ces assertions, pas le moteur
en fonctionnement sur téléphone.

## Construire les APK

```powershell
flutter build apk --debug --no-pub --split-per-abi --target-platform android-arm64,android-arm,android-x64 --android-project-arg=fuzevpn.usePatchedWireGuardAar=true
flutter build apk --release --no-pub --split-per-abi --target-platform android-arm64,android-arm,android-x64 --android-project-arg=fuzevpn.usePatchedWireGuardAar=true
```

Les APK sont écrits dans `build/app/outputs/flutter-apk/`. Pour une livraison,
choisir explicitement le nom et le numéro de version, avec `--build-name` et
`--build-number` si nécessaire. Les splits Flutter peuvent produire des
`versionCode` différents du numéro de base : vérifier les métadonnées de chaque
APK au lieu de déduire sa version de son nom de fichier.

Les APK joints aux GitHub Releases sont compilés une ABI à la fois, sans
`--split-per-abi`, pour garder le `versionCode` de `pubspec.yaml` :

```powershell
flutter build apk --release --no-pub --target-platform android-arm64 --android-project-arg=fuzevpn.usePatchedWireGuardAar=true
```

Répéter avec `android-arm` et `android-x64`, en copiant
`build/app/outputs/flutter-apk/app-release.apk` après chaque compilation.
Cet APK n'est pas signé : signer chaque copie avec le magasin de clés de
diffusion, conservé hors du dépôt (`apksigner sign`, schémas v2 et v3 ;
v1 inutile avec minSdk 26), sous le nom `FuzeVPN-<version>-<abi>.apk`.
Vérifier ensuite `apksigner verify --print-certs` (empreinte du
[guide des APK](APK.fr.md)) et `aapt2 dump badging` (`versionCode` de
`pubspec.yaml`, `native-code` de l'ABI). Produire enfin l'archive de sources
avec `python tools/package_android_sources.py --apk <chaque APK>` et le
fichier `SHA256SUMS.txt` des fichiers joints à la release.

Les APK GitHub sont signés avec la clé d'envoi Google Play. Toutes leurs mises
à jour doivent garder cette clé : une réinitialisation de la clé d'envoi auprès
de Google Play obligerait les utilisateurs GitHub à désinstaller puis
réinstaller l'application.

Le build release ne possède actuellement aucune configuration de signature
dans Gradle. `key.properties` est ignoré, mais n'est pas lu par le projet :
le créer ne signe pas l'APK. La signature de diffusion doit être fournie par
l'environnement de livraison. Un APK release signé avec un certificat debug
reste un APK de test et ne doit pas être présenté comme une livraison signée
pour publication.

### Construire l'App Bundle

```powershell
flutter build appbundle --release --no-pub --target-platform android-arm64,android-arm,android-x64 --android-project-arg=fuzevpn.usePatchedWireGuardAar=true
```

`x86_64` est livré pour que les appareils x86 (Chromebooks, par exemple)
n'exécutent jamais le runtime Go ARM de WireGuard sous traduction : voir
`docs/NATIVE_DEPENDENCIES.md`, « Limites des ponts ARM ».

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

Le test APP10 de reprise après indisponibilité vérifie ses assertions
fonctionnelles avec `flutter test` normal. Ses comparaisons visuelles avec les
polices embarquées sont activées séparément par `FUZEVPN_REVIEW_FONTS=true`.
Vérifier les références existantes, sans les régénérer :

```powershell
flutter test --no-pub --dart-define=FUZEVPN_REVIEW_FONTS=true --plain-name "APP10 recovery controls remain reachable at 320dp and 200 percent" test/widget/app_ui_test.dart
```

Les trois références `helper-app10-*.png` restent dans
`test/widget/goldens/`, distinctes des captures de revue ci-dessous. Les autres
références utilisant la police Ahem restent vérifiées par `flutter test` normal.

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

- [ ] Version de `pubspec.yaml` (**0.2.11+74018**), matrice du poste, dépendances et provenance natives
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

## Régressions 74013

Les cas `WireGuardRecoveryPolicyTest` couvrent plusieurs réseaux physiques,
les coupures rapides/répétées, les preuves anciennes et les instances arrêtées.
Les cas Flutter couvrent les champs après erreur, les favoris après lecture
lente/échouée et la déconnexion pendant l'attente WireGuard.
`test/widget/header_accessibility_test.dart` charge les polices embarquées et
contrôle les titres à 320/360/800 dp, 100/200 %, français/anglais/arabe,
clair/sombre. Ses 36 captures sont écrites sous `build/reports/74013-ui/`,
hors des références golden maintenues ; les examiner avant livraison.

L'APK local 74013 est construit directement en release pour les deux ABI ARM,
sans splits et sans App Bundle. Son signataire est la clé d'envoi conservée hors
Git ; il ne reproduit pas la signature Play App Signing. Conserver son mapping
R8, les preuves de contrôle et le diff source avec cette livraison locale.
Les quatre crashes ndk_translation Android 12/13 sont reproduits en 74016
([Q010](VALIDATION.md#q010)). L’exécution sur ARM natif est bloquée par
l’environnement disponible ([Q011](VALIDATION.md#q011)) ; les moteurs
natifs verrouillés sont conservés.

## Régressions réseau 74014

`WireGuardRecoveryPolicyTest` ajoute le recoupement d’une entrée initiale
périmée, le conflit avec un callback plus récent, la coupure et le retour sans
callback, et la conservation de la mesure de référence sur un inventaire inchangé.

`WireGuardNetworkObservationInstrumentedTest` exerce le bridge natif sans
Flutter : entrée périmée, commande annulée, coupure Wi-Fi/mobile de plus de
trente secondes et retour sans nouvelle preuve du pair. Il requiert le package
`com.fuzevpn.recoverytest` et passe en skipped avec le package de production.
Il passe aussi en skipped dans un processus Android 11 touché par la course de
liaison du ConnectivityManager (callback physique refusé). La validation des
preuves refuse ce skip : répéter simplement l’exécution dans un nouveau
processus.
Le build isolé remplace applicationId et testApplicationId via un init script
Gradle externe ; aucun changement de package ne fait partie du build release.
Il utilise x86_64 pour éviter la traduction ARM, sans créer de vrai tunnel ni
appeler FuzeVPN. Exécuter une VM à la fois et restaurer les réglages réseau.
La qualification réelle de l’APK ARM reste distincte de ce test synthétique.

## Régressions chargement natif 74015

WireGuardDeferredLoadingInstrumentedTest requiert le paquet isolé
com.fuzevpn.recoverytest. Il vérifie les opérations au repos et d’identité sans
construction du backend, la création unique sur le worker au premier UP avec
un backend refusant le démarrage sans tunnel réel, puis l’initialisation du
bridge et du Core OpenVPN sans libwg-go dans /proc/self/maps. Les profils
ARM traduits et ARM natifs restent des qualifications distinctes.

Sur les VM, une instance à la fois : **1536 Mo pour tous les profils**,
avec -qemu -m 1536 en dernier. Vérifier /proc/meminfo et la mémoire du
processus hôte ; le collecteur interrompt la VM au seuil conservateur de
4 000 000 000 octets. Les essais 16 Kio interrompus à ce seuil sont documentés
en [Q012](VALIDATION.md#q012), sans verdict applicatif extrapolé.
Conserver les VM en échec et les preuves existantes.

## Régressions de statut 74016

status_accessibility_test.dart charge les polices embarquées et teste les neuf
statuts dans trente langues, à 320/360 dp, à 100 %, avec un scaleur linéaire
200 % et avec la courbe Android 14 à 200 % (180 cas). Les sélections des mots
partagent une bande verticale, sans confondre les métriques des fallbacks avec
une véritable coupure. Les fixtures grecque et cyrilliques utilisent Google Sans en fallback
de test ; le fallback système Android dépend du matériel.
Les captures sont sous build/reports/74016-ui/, hors des références golden.

Les six cas app_ui_test "disconnected status keeps its word" vérifient région
live, taille d’accessibilité et bouton utilisable, à 320/360/800 dp et clair/sombre.
Leur exécution obligatoire avec FUZEVPN_REVIEW_FONTS=true vérifie également le
mot complet avec Archivo et écrit les captures de l’application :

```powershell
flutter test --no-pub --dart-define=FUZEVPN_REVIEW_FONTS=true --plain-name 'disconnected status keeps its word' test/widget/app_ui_test.dart
```

L’exécution standard de cette suite garde sa police synthétique pour les goldens
existants ; cette police ne valide pas la géométrie des mots dans ces six cas.
Examiner les nouvelles captures avant livraison ou changement d’une référence.
Aucune traduction ni moteur natif supplémentaire n’est introduit.

## Validation locale unique et CI

`tools/validate_project.ps1` regroupe les contrôles locaux avec leurs preuves.
Il exige PowerShell 7.2+, Python 3.10+, Flutter à la version exacte de
`.flutter-version`, JDK 17, SDK/Build Tools 36, NDK 28.2.13676358 et CMake
3.22.1. Node.js est requis pour les tests JavaScript du document Turnstile ;
la version testée sur le poste est v24.16.0. Aucune version antérieure minimale
n'est qualifiée ici. Go (1.23.1 minimum, 1.26.3 testée) est requis pour le test
hors ligne de wireguard-go ; `FUZEVPN_GO` peut désigner `go.exe`, sinon le premier
`go` du `PATH` est utilisé. Les tests natifs hôtes exigent aussi Visual Studio C++ Build Tools,
repéré par `vswhere`. Le wrapper et les versions AGP/Kotlin restent ceux verrouillés dans
le dépôt. Le script n'installe ni ne modifie ces SDK, ni Node.js, ni Go.

Python 3.10 suffit aussi pour relire les reçus : les horodatages écrits par
PowerShell (format `o`, sept chiffres de fraction, suffixe `Z` ou `+00:00`) sont
analysés sans `datetime.fromisoformat`, dont la grammaire 3.10 ne les accepte
pas (`tools/tests/test_receipt_instants.py`). Le runner seul exige PowerShell
7.2+ ; `tools/test_turnstile_bridge.ps1` fonctionne aussi sous Windows
PowerShell 5.1 (`powershell.exe`), comme indiqué dans son README.

Les validations de `tools/generate_translations.py`, `tools/release_aab_safe.py`
et des autres outils Python sont des contrôles explicites, jamais des `assert` :
elles restent actives sous `python -O`, `-OO` ou `PYTHONOPTIMIZE`
(`tools/tests/test_generate_translations.py` le vérifie, ainsi que l'absence
d'instruction `assert` dans `tools/*.py`).

Le test des liens de `tools/tests/test_package_android_sources.py` crée un lien
symbolique (privilège `SeCreateSymbolicLinkPrivilege` ou mode développeur sous
Windows) et une jonction de répertoire, qui ne demande aucun privilège : un
compte sans privilège exerce donc toujours un vrai point d'analyse. Si aucun
des deux ne peut être créé, le test est ignoré avec le motif « Creating
filesystem links and junctions is unavailable ». C'est le seul saut accepté
par l'agrégateur, avec ceux de `test_turnstile_runner.py` hors Windows : chaque
saut doit être nommé par la sortie `-v`, correspondre à
`ACCEPTED_PYTHON_SKIPS` de `tools/validation_support.py` et figure dans
`summary.json` (`python.acceptedSkips`). Tout autre test ignoré fait échouer
la validation.

`-NodeExecutable` sélectionne explicitement Node.js. À défaut, le runner utilise
`NODE_BINARY`, puis le premier `node` du `PATH`. Il vérifie sa version et la
conserve dans `node-version.txt` ; un exécutable absent provoque un échec,
sans téléchargement ni test ignoré.

`-GoExecutable` sélectionne explicitement Go. À défaut, le runner le cherche
comme le test wireguard-go : `FUZEVPN_GO`, puis le premier `go` du `PATH`.
L'étape `toolchain` exige la directive `go` de `libwg-go/go.mod` (1.23.1
minimum) et lit `go version` sans les variables `GO*` de l'appelant, avec
`GOTOOLCHAIN=local` : aucune autre chaîne n'est sélectionnée ni téléchargée.
Elle conserve cette sortie et le chemin retenu dans `go-version.txt`, puis fixe
`FUZEVPN_GO` à ce chemin pour `python-tests`. Un Go absent, illisible ou trop
ancien provoque un échec, sans test ignoré.

Configurer `FLUTTER_ROOT`, `JAVA_HOME` et `ANDROID_SDK_ROOT` (ou utiliser les
paramètres correspondants). `PUB_CACHE` et `GRADLE_USER_HOME` permettent de
réutiliser des caches préparés ; à défaut, le script emploie
`.dart_tool/isolated-pub-cache` et `.gradle` dans le checkout. Il écrit les
chemins du poste et la version de `pubspec.yaml` dans le fichier ignoré
`android/local.properties` ; les appels Gradle directs gardent ainsi la version source.

```powershell
# Afficher le périmètre sans exécuter les contrôles ni construire de binaire.
./tools/validate_project.ps1 -PlanOnly

# Caches déjà préparés : aucune résolution Pub/Gradle en ligne.
./tools/validate_project.ps1

# Premier poste : autoriser explicitement une préparation réseau, puis
# exécuter les mêmes contrôles hors ligne. Les verrous doivent rester identiques.
./tools/validate_project.ps1 -PrepareDependencies
```

Le mode normal effectue une résolution Pub hors ligne avec verrou imposé,
l'analyse et la suite Flutter complète, les sept cas APP10/statut avec polices,
la découverte de tous les tests Python sous `tools/tests`, les traductions,
la fraîcheur des notices des SDK Google (`tools/generate_google_sdk_notices.py
--check`, cache Gradle hors ligne), buildSrc, les tests JVM et lints Android, les trois suites hôtes obligatoires
`turnstile-bridge`, `command-epochs` et `bridge-host`, les gardes WireGuard et dépendances,
la provenance native, les assertions C++, les tests hôtes JNI/adaptateur/NAT
et leur compilation contre le Core épinglé pour trois ABI, le contrôle d'export, le registre
de preuves et la configuration de l'instrumentation isolée. Les tâches JVM
et d'analyse/rapport lint sont explicitement réexécutées sans forcer toute la
chaîne de compilation. Chaque sortie a son code de retour, ses heures et sa
durée dans un nouveau dossier `build/reports/validation/<date>/`.

`lib/l10n/generated` est versionné, mais `pub get` le régénère sur place
(`generate: true`, `output-dir` de `l10n.yaml`). Le runner relève donc
l'empreinte SHA-256 de chacun de ses fichiers avant toute résolution Pub
(`l10n-generated-before.json`) et échoue après `pub-offline` si un fichier a
été ajouté, retiré ou modifié : la copie versionnée doit être exactement celle
que produit la version Flutter épinglée. La référence est l'état du checkout au
lancement du runner, pas le dernier commit.

`turnstile-bridge` compile le vrai bridge avec des doubles Android/Flutter et
teste le JavaScript généré avec les modules intégrés de Node.js.
`command-epochs` compile les blocs de commande extraits des sources actuelles
avec des frontières Android simulées. `bridge-host`
(`android/app/src/test/bridge-host/run.ps1`) compile sans modification
`AndroidVpnBridge.kt` et les sources de production qu'il appelle, avec des
doublures Android, Flutter, stockage et moteurs (`stubs/`, `fakes/`), puis
exécute `AndroidVpnBridgeHostTest` ; ses reçus `execution.json` et
`result.log` ont le format de command-epoch. Ces suites ne sont pas
découvertes par les tests JVM Gradle ; leurs reçus restent séparés et
obligatoires. L'agrégateur exige au moins les cas exécutés le 30 octobre 2026
(`HOST_JUNIT_MINIMUMS` de `tools/validation_support.py`) : 44 tests JUnit et
20 scénarios JavaScript pour `turnstile-bridge`, 27 tests pour
`command-epochs` et 94 pour `bridge-host` (2 novembre 2026). Chaque plancher
JUnit est égal au
nombre de `@Test` des sources de sa suite (contrôlé par `tools/tests`) : un
cas ajouté doit relever le plancher dans le même changement. Aucun de ces
contrôles hôtes n'exécute de WebView ou de tunnel Android réel. Pour
`wireguard-gate`, l'agrégateur exige une fois chacun des 17 cas nommés de
`tools/test_wireguard_release_gate.ps1` (`WIREGUARD_GATE_CASES`), lancé sans
`-Only`, dont `native-libraries-approved` avec son inventaire : `libwg-go.so`
présent, `libwg.so` et `libwg-quick.so` absents.

`summary.json` rapporte les nombres réellement exécutés. L'agrégateur refuse
une suite vide, un résultat JUnit ancien, un test ignoré, une erreur lint et
un sous-ensemble de polices incomplet. Les sept cas de polices répètent des
scénarios déjà présents dans la suite standard ; ils ne s'ajoutent pas au
nombre de scénarios indépendants. Le résultat conserve explicitement
`instrumentation: not executed`. Il ne qualifie aucun appareil, achat,
compte Google ou service de production. Une exécution interrompue produit
un reçu d'échec et les journaux déjà disponibles.

Le workflow `.github/workflows/validate.yml` utilise un runner Windows
préparé portant le label `fuzevpn-android-36`. Configurer les variables de
dépôt `FUZEVPN_FLUTTER_ROOT`, `FUZEVPN_JAVA_HOME`,
`FUZEVPN_ANDROID_SDK_ROOT` et `FUZEVPN_CACHE_ROOT`. Ce dernier doit désigner
un dossier extérieur au checkout nettoyé par l'action de récupération.
`FUZEVPN_GO` désigne le `go.exe` du runner ; vide, c'est le premier `go` de
son `PATH`, avec le même minimum.
Les actions sont épinglées par commit. La préparation en ligne est désactivée
par défaut et nécessite l'entrée explicite de `workflow_dispatch` ; un cache
incomplet fait échouer le mode hors ligne. Les journaux et comptes restent
attachés à l'exécution, y compris lorsqu'elle échoue.

Le workflow s'applique aux pushes main/master, aux PR internes et aux
lancements manuels. Les PR issues d'un fork ne sont pas exécutées
automatiquement sur ce runner autonome ; un mainteneur peut déclencher la
validation d'une révision préalablement revue. La présence du workflow ne
prouve pas qu'un runner a été configuré ou qu'une exécution distante a eu lieu.

## Préparation reproductible de l'instrumentation isolée

Le script versionné `tools/prepare_isolated_instrumentation.ps1` et son init
script `tools/isolated_instrumentation.gradle` remplacent la préparation
externe décrite dans les régressions réseau/chargement ci-dessus. Ils fixent
exactement `applicationId=com.fuzevpn.recoverytest` et
`testApplicationId=com.fuzevpn.recoverytest.test`, sélectionnent une seule ABI
et imposent l'AAR WireGuard patché. Ils ne modifient pas les sources ni les
identifiants du build ordinaire. Seul debug est activé ; les tâches release,
profile, bundle et publication sont refusées par cet init script. La
signature debug Android standard reste en place, sans signature de diffusion.

```powershell
./tools/prepare_isolated_instrumentation.ps1 -PlanOnly
./tools/prepare_isolated_instrumentation.ps1 -ConfigurationOnly

# Préparer les deux APK de qualification, sans installation ni exécution.
./tools/prepare_isolated_instrumentation.ps1 -TargetPlatform android-x64
# Autres cibles explicites : android-arm64 et android-arm.
```

Le dossier daté sous `build/reports/isolated-instrumentation/` contient le
journal, les identifiants vérifiés et, pour une préparation complète, les deux
APK et leurs SHA-256. Les contrôles de provenance, d'AAR et de permissions
fusionnées restent actifs. La garde de manifeste lie l'identifiant exact au
nom de sa permission AndroidX : production ne peut pas employer la permission
du package isolé, ni l'inverse.

Les APK préparés restent à installer et exécuter dans un environnement de
qualification autorisé. Ces commandes ne démarrent aucune VM, aucun tunnel
ni aucune activité de production. Les quatre tests de chargement différé,
le smoke test de bibliothèque et le test d'observation réseau nécessitent
ce package isolé ; leur résultat ignoré dans le package standard ne vaut pas
réussite.

Pour contrôler des XML JUnit d'une exécution sur appareil, conserver leurs
octets et leurs dates de modification, puis indiquer l'heure réelle de début
avec secondes et zone explicite (`Z` ou `±HH:MM`). La date ci-dessous est un
exemple à remplacer par le début de la campagne contrôlée.

Le producteur Android `XmlTestRunListener` de ddmlib 32.3.0 écrit les
horodatages de suite sans suffixe de zone, mais emploie UTC. Pour ces XML,
déclarer ce contrat du producteur avec `--suite-utc-offset UTC`.

ddmlib formate ces horodatages avec la locale par défaut de la JVM qui
produit les XML (`SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss", Locale.getDefault())`).
Le contrôle les lit indépendamment de cette locale, sans réécrire les XML :
chiffres décimaux d'une seule écriture (arabes-indiens, persans, bengalis,
devanagari, birmans, thaïs…), année bouddhiste thaïe (`th-TH`, année
grégorienne + 543) et année d'ère japonaise non complétée (`ja-JP-JP`, première
année écrite `元`). Chaque lecture possible est convertie en instant et doit
tomber dans la fenêtre ci-dessous ; un mélange d'écritures, un autre caractère
ou une date hors de l'ère lue sont refusés. Le reçu indique la lecture retenue
(`counts.suiteTimestampReadings`, par exemple `buddhist/latin` ou
`gregorian/U+0660`). Une même année d'ère japonaise désigne plusieurs ères : un
XML écrit il y a exactement une ère, au même jour et à la même seconde, ne se
distinguerait pas d'un XML frais ; la date de modification reste contrôlée.

```powershell
python tools/validation_support.py check-instrumentation `
  --xml-directory chemin/vers/xml-de-cette-execution `
  --started-at 2026-10-28T12:00:00Z `
  --suite-utc-offset UTC
```

Pour un autre producteur dont les horodatages de suite n'ont pas de zone,
`--suite-utc-offset` doit déclarer son décalage réel, `UTC` ou `±HH:MM`,
compris entre −14:00 et +14:00 ; écrire par exemple
`--suite-utc-offset=-07:00` pour une valeur négative. Ne pas déduire ce
décalage de la zone du poste de collecte. Une suite portant déjà `Z` ou un
décalage explicite conserve sa
propre zone ; l'option ne la remplace pas. Aucun XML n'est réécrit pour lui
ajouter une zone ou rajeunir son horodatage.

Le contrôle compare en UTC le `timestamp` de chaque `testsuite` à la fenêtre
allant du début déclaré moins deux secondes à l'heure du contrôle plus deux
secondes. Le début déclaré ne peut pas dépasser cette dernière borne. Les
horodatages doivent contenir les secondes ; une fraction de seconde de un à
neuf chiffres est acceptée, y compris les sept chiffres du format `o` de
PowerShell pour `--started-at`. Un horodatage absent, invalide, sans zone et sans
déclaration du producteur,
hors fenêtre ou avec le décalage inconnu `-00:00` est refusé. La date de
modification de chaque fichier reste un contrôle supplémentaire : recopier
un ancien XML avec une date de fichier récente ne rend pas sa suite actuelle.

Cette vérification exige les six méthodes isolées actuelles, refuse les
échecs, ignorés et doublons, et rapproche les comptes déclarés et effectifs.
Son résultat décrit les XML fournis et la politique de fraîcheur appliquée ;
il ne lance aucune instrumentation et n'authentifie pas des résultats locaux.
Les contrôles JUnit hôtes du runner gardent leur contrat distinct. La
conservation des anciennes preuves et les outils de livraison sans publication
sont décrits dans [RELEASE_EVIDENCE.md](RELEASE_EVIDENCE.md).
