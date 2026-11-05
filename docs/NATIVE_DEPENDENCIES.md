# Dépendances natives Android

Audit de qualification du 14 octobre 2026 : [Q001](VALIDATION.md#q001), [Q004](VALIDATION.md#q004), [Q005](VALIDATION.md#q005), [Q006](VALIDATION.md#q006), [Q007](VALIDATION.md#q007), [Q010](VALIDATION.md#q010), [Q011](VALIDATION.md#q011), [Q012](VALIDATION.md#q012), [Q013](VALIDATION.md#q013), [Q014](VALIDATION.md#q014), [Q015](VALIDATION.md#q015), [Q016](VALIDATION.md#q016), [Q031](VALIDATION.md#q031).


Version source **0.2.11+74018**. Les commandes partent de la racine du dépôt. Les prérequis généraux
et les commandes de l’application sont dans [DEVELOPMENT.md](DEVELOPMENT.md).
Les versions épinglées actuelles sont dans
[THIRD_PARTY_NOTICES.md](../THIRD_PARTY_NOTICES.md) et dans le SBOM release
décrit par [SBOM.release.md](SBOM.release.md) ; [SBOM.spdx.json](SBOM.spdx.json)
est l’inventaire historique du 14 octobre (ancien moteur WireGuard).

## Entrées à conserver

| Ensemble | Rôle |
| --- | --- |
| `android/third_party/wireguard-android/` | Sources, sous-modules exportés, patches et AAR local approuvé |
| `patches/wireguard-android/` | Patches de référence, comparés aux copies de l’arbre importé |
| `android/app/src/main/cpp/third_party/` | Core OpenVPN, en-têtes, archives statiques, source OpenSSL et notices |
| `android/native-provenance/` | Inventaire indépendant et modèles d’import |
| `android/buildSrc/src/` | Politiques de provenance, permissions et sélection de l’AAR |

`dist/` dans WireGuard contient une dépendance directe du build release.
Le bundle OpenVPN doit rester complet : les contrôles refusent les fichiers
absents, modifiés ou supplémentaires. Les sorties sous `build/` se régénèrent.

## WireGuard

Le tag Android est `1.0.20260102`, au commit
`09b75c2bd37f749e2a8c85876394854113c74be7`, avec l’objet de tag annoté
`3831cab2da844319291459308a6e535d36dde4b3`. L’importateur vérifie aussi
`wireguard-tools` (`e2ecaaa739144997ccff89d6ad6ec81698ea6ced`) et
`elf-cleaner` (`7efc05090675ec6161b7def862728086a26c3b1f`). Vérifier la
signature OpenPGP du tag dans l’environnement de préparation des sources :
l’importateur contrôle son identité, sans vérifier cette signature.

Les patches s’appliquent dans cet ordre :

1. `0001-go-backend-real-foreground-service.patch` expose le service partagé.
2. `0002-go-backend-protected-start.patch` protège les sockets avant les pairs.
3. `0003-go-runtime-and-handshake-update.patch` épingle Go 1.26.9 et
   wireguard-go b3bc704, qui ajoute au correctif amont de concurrence du
   handshake du 6 octobre 2026 celui de la longueur des paquets IPv6.

`GoBackend$VpnService` héberge successivement WireGuard et OpenVPN. Le contrôleur
Android décide de sa libération après l’arrêt confirmé du moteur. Les événements
système lui sont transmis ; le service ne crée pas de tunnel de lui-même.
Le support Always-On du manifeste est activé lorsque l’AAR patché est sélectionné.

Le démarrage sépare trois étapes : `wgTurnOn` ouvre les sockets avec la seule
configuration d’interface ; Android protège IPv4 puis IPv6 lorsqu’il existe ;
`wgSetConfig` installe les pairs avec `replace_peers=true`. Cette dernière
étape exclut `private_key`, `listen_port` et `fwmark`, qui pourraient recréer
un socket non protégé. Un échec de protection ferme le handle ; si sa fermeture
reste incertaine, un `DOWN` explicite peut la reprendre.

Le socket UAPI local de `libwg-go.so` utilise
`/data/data/com.fuzevpn/cache/wireguard`, correspondant à l'identifiant Android
installé. Le namespace Kotlin/JNI de l'application reste `com.fuzevpn.android`. Le build natif
fixe ce chemin à l'édition des liens et la politique de l'AAR en vérifie la
présence dans les quatre ABI, en plus du contrat JNI et de l'empreinte approuvée.

### Import et reconstruction

Préparer un checkout propre au tag exact avec ses sous-modules initialisés.
L’import refuse de remplacer l’arbre déjà présent : le rejouer dans une copie
de travail destinée à la revue où cette destination n’existe pas.

```powershell
.\tools\import_wireguard_android.ps1 -WireGuardAndroidSource 'C:\src\wireguard-android'
.\tools\build_wireguard_native.ps1 -AndroidSdk $env:ANDROID_SDK_ROOT
.\tools\build_wireguard_patched_aar.ps1 -JavaHome $env:JAVA_HOME -AndroidSdk $env:ANDROID_SDK_ROOT
```

Le build natif utilise Go **1.26.9** Windows avec
`goruntime-go1.26.9-boottime.diff`, NDK **28.2.13676358**, API **21** et
le module `golang.zx2c4.com/wireguard v0.0.0-20261024220952-b3bc704ef0ee`.
Il produit `libwg-go.so` et ses preuves sous `build/wireguard-native/` pour
`arm64-v8a`, `armeabi-v7a`, `x86_64` et `x86`, vérifie les symboles JNI et
l’alignement ELF de 16 Ko. Le script prépare le Go Windows épinglé et patché sous
`build/toolchains/go1.26.9-wireguard` s’il manque ; `-GoToolchain` permet de
préciser ce répertoire. Le SDK est fourni via `ANDROID_SDK_ROOT` ou
`-AndroidSdk`. Les modules Go doivent aussi être disponibles dans
l’environnement de build. `tools/tests/test_wireguard_ipv6_length.py` fait
passer dans deux équipements de ce module, hors ligne et avec les seules
sources de `android/source-distribution/`, des paquets IPv6 dont la longueur
déborde sur 16 bits : ils doivent être rejetés (A17-supply-chain-02). Ce test
demande une chaîne Go, désignée par `FUZEVPN_GO` ou présente dans le `PATH`.

L’adaptation du patch CLOCK_BOOTTIME reprend les huit fichiers et douze sites
du patch amont historique, et ajoute les deux sites de `time_linux_amd64.s` :
sur linux/amd64, `time.now` est écrit en assembleur et lisait encore
CLOCK_MONOTONIC, alors que les autres ABI le dérivent du `nanotime1` corrigé
(neuf fichiers, quatorze substitutions). `tools/tests/test_wireguard_native_clock.py`
vérifie dans les quatre `libwg-go.so` de l’AAR approuvé que `nanotime1` et
`time.now` lisent CLOCK_BOOTTIME (A10-wireguard-04). Le manifeste de
l’adaptation épingle chaque empreinte originale et après patch ; les sources sont revérifiées lors de chaque invocation, même si
le marqueur existe. `-PrepareOnly` prépare et contrôle ces sources sans compiler.
L’import exporte l’étiquette avec `core.autocrlf=false`, puis applique la série
`patches/fuzevpn/series` par `tools/wireguard_patch_series.ps1` : chaque patch
revu est appliqué depuis une copie LF aux copies LF des fichiers qu’il nomme,
car les préimages des patches mélangent CRLF (0001, 0003) et LF (0002). Les
octets et empreintes des patches ne changent pas ; les fichiers du runtime Go
ajoutés par 0003 gardent leurs fins de ligne LF et leurs empreintes épinglées.
`tools/tests/test_wireguard_patch_series.py` vérifie l’application sur un amont
reconstruit, exporté en LF et en CRLF.

Une réimportation n’est pas identique à l’octet à l’arbre versionné. Celui-ci
vient d’un export en `core.autocrlf=true` : la plupart de ses fichiers texte
sont en CRLF. L’import actuel écrit les octets commités, et les fichiers
touchés par la série finissent en LF : le contenu est le même à CR près.
Conséquence : `jni.c` (CRLF dans l’arbre versionné) n’a plus l’empreinte
inscrite dans `nativeBuild.sourceHashes` des métadonnées de l’AAR approuvé
(`dist/tunnel-1.0.20260102-fuzevpn-fgs.metadata.json`), de même que tout autre
fichier de ces empreintes exporté en LF. `tools/generate_release_sbom.py`
refuse alors l’AAR (« Current Go source input differs from AAR provenance »)
tant que `build_wireguard_native.ps1` puis `build_wireguard_patched_aar.ps1`
n’ont pas régénéré l’AAR et ses métadonnées ; la nouvelle empreinte doit
ensuite être revue et approuvée dans `WireGuardAarPolicy`. Sans cette
reconstruction, l’arbre versionné reste la référence : une réimportation sert
à contrôler son contenu, pas à le remplacer. Les sous-modules
`wireguard-tools` et `elf-cleaner` ne passent pas par `git archive` : ils sont
copiés depuis la copie de travail du checkout et leurs fins de ligne suivent
son `core.autocrlf` (CRLF dans l’arbre versionné). Ils n’entrent pas dans
`libwg-go.so` ; `libwg.so` et `libwg-quick.so` restent ceux de l’AAR officiel ;
ils sont exclus de l’APK et de l’AAB (`packaging.jniLibs.excludes`).
Les sources officielles, métadonnées du proxy, preuves de correspondance et
recette de proxy hors ligne sont conservées dans `android/source-distribution/`.

L’assembleur nécessite Java 17, Android Platform 36, l’AAR officiel
`1.0.20260102` et les JAR AndroidX annotation `1.9.1` / collection `1.5.0`
déjà présents dans le cache Gradle. `-JavaHome`, `-AndroidSdk`, `-OfficialAar`
et `-NativeDirectory` permettent de préciser ces entrées. Il recompile le Java,
reconstruit le manifeste et remplace **libwg-go** par le natif reconstruit ; les
autres bibliothèques restent celles de l’AAR officiel vérifié. Il retire
uniquement `R.txt` vide, incompatible avec la transformation d’AAR locale d’AGP 9.3.

Le résultat est
`android/third_party/wireguard-android/dist/tunnel-1.0.20260102-fuzevpn-fgs.aar`,
accompagné de `.metadata.json`. Ce JSON donne les empreintes des patches,
sources et bibliothèques ; `WireGuardAarPolicy.java` fixe indépendamment
l’empreinte de l’AAR approuvé. Produire un nouvel AAR ne l’approuve pas.

L'AAR actuellement approuvé porte le SHA-256
`bf563b779e670647e7d47751e7f4ff5d90299272640af7814c52f74bfe8c4b73`.
Son manifeste conserve le minimum SDK 24 de l'artefact officiel ; le minimum
de l'application reste Android 26. La mise à jour du 29 octobre 2026
(wireguard-go b3bc704, `time.now` amd64 sur CLOCK_BOOTTIME) ne change que les
quatre `libwg-go.so` : le chemin IPC de `com.fuzevpn`, `classes.jar`, le
manifeste et les autres entrées sont identiques à ceux de l'AAR approuvé
précédent.

Les quatre ABI ont été reconstruites et contrôlées (ELF, JNI, alignement 16 Kio),
et deux assemblages de l’AAR ont produit les mêmes octets. Cela ne remplace pas
les essais réseau et de reprise sur Android ARM physique. Les essais 74014/74015
ci-dessous concernent les moteurs historiques, pas cette nouvelle construction.

### Sélection et contrôles

Release et profile exigent `-Pfuzevpn.usePatchedWireGuardAar=true`.
Debug autorise l’AAR Maven officiel lorsque cet indicateur est absent ou faux.
La politique refuse une AAR locale absente, différente de l’empreinte approuvée
ou dépourvue des API Java/JNI attendues sur une ABI. Elle est rejouée même
lorsque les sorties de compilation sont à jour.

```powershell
.\tools\test_wireguard_protected_start.ps1
.\tools\test_wireguard_release_gate.ps1
```

Le premier teste le contrat de démarrage ; le second exécute les cas Gradle
debug/profile/release avec `--offline`. Ils utilisent les outils et caches déjà
préparés, écrivent sous `build/` et ne remplacent pas les essais sur appareil.

## OpenVPN, OpenSSL et dépendances

L’application active le Core dans `android/app/build.gradle.kts`. Elle utilise
le backend OpenSSL et le fournisseur XKey amont ; aucun patch cryptographique
FuzeVPN n’est appliqué au Core ni à OpenSSL.

| Composant | Révision | Licence retenue |
| --- | --- | --- |
| OpenVPN 3 Core | `28469efe3ae770268b2b5c6aa607ed1489e101f0` | MPL-2.0 |
| OpenSSL 3.5.9 | `45e844fa2a14ec92d146bd8f5778ac130b6625fb` | Apache-2.0 |
| Asio 1.36.0 | `231cb29bab30f82712fcd54faaea42424cc6e710` | BSL-1.0 |
| fmt 12.1.0 | `407c905e45ad75fc29bf0f9bb7c5c2fd3475976f` | MIT |
| lz4 1.10.0 | `ebb370ca83af193212df4dcbadcc5d87bc0de2f0` | BSD-2-Clause |

Ces dépendances suivent le snapshot vcpkg
`d7b75fa8a30478ae5b5eb86ac730f851ef036875`. Les six patches Asio maintenus
par OpenVPN sont répertoriés dans `third_party/deps/DEPENDENCIES-METADATA.json`.
L’archive officielle `openssl-3.5.9.tar.gz` est conservée sous
`android/app/src/main/cpp/third_party/openssl/source/` ; son SHA-256 est
`603f5602e2eef00d77fbd429d34dcd5822bb301757a1bc9cdb24c670f1eb859a`.
Le tag signé `openssl-3.5.9` est l’objet Git
`d0ca66a1abe52545f14eca635c648932fcde5615`. La signature de ce tag et celle
de l’archive ont été vérifiées avec le certificat de publication officiel,
empreinte primaire `B146647E45A7B33947AB226B2A2C87D161692D40`, publié sur
[la page officielle des téléchargements OpenSSL](https://openssl-library.org/source/).
La signature détachée et le fichier officiel `pubkeys.asc` sont conservés
avec l’archive source et couverts par le verrou indépendant.
La mise à jour corrige les avis de la
[livraison du 29 septembre 2026](https://openssl-library.org/news/secadv/20260929.txt).

### Préparation des préfixes

Ce script utilise exclusivement des checkouts propres déjà disponibles :

```powershell
.\android\app\src\main\cpp\tools\prepare_openvpn3_deps.ps1 `
  -OpenVpn3Source 'C:\sources\openvpn3' `
  -AsioSource 'C:\sources\asio' `
  -FmtSource 'C:\sources\fmt' `
  -Lz4Source 'C:\sources\lz4' `
  -NdkPath 'C:\toolchains\android-sdk\ndk\28.2.13676358' `
  -OutputDirectory 'C:\build\openvpn-deps'
```

OpenSSL se construit séparément avec NDK **28.2.13676358**, API **26**,
`Configure`, `make` et `make install_sw`, avec les outils NDK dans `PATH` :

| ABI | Cible Configure | Usage prévu |
| --- | --- | --- |
| `arm64-v8a` | `android-arm64` | release et debug |
| `armeabi-v7a` | `android-arm`, avec `-D__ARM_MAX_ARCH__=8` | release et debug |
| `x86_64` | `android-x86_64` | release et debug |

Options communes : `no-shared no-tests no-apps no-docs no-legacy no-module
no-engine no-dso no-zlib no-quic`. Le préfixe fournit `include/<ABI>/openssl/`
et `lib/<ABI>/{libcrypto.a,libssl.a}`, avec `IMPORT-METADATA.json`,
`MANIFEST.sha256`, licence et source. Les empreintes par ABI et options
exactes figurent dans les métadonnées importées. Le dépôt ne fournit pas
de script complet de reconstruction du préfixe OpenSSL.
Les métadonnées conservées décrivent une reconstruction avec MSYS2/Perl et
les outils Windows du NDK. Les rapports historiques de poste ne sont pas
inclus. Pour reproduire cette préparation, installer ces outils, relever
les options/versions des métadonnées, puis vérifier version OpenSSL, format
ELF, ABI et empreintes de chaque archive produite. Une intégrité conforme
au verrou ne prouve pas une reconstruction aux mêmes octets.

### Import vérifié hors ligne

```powershell
.\tools\import_openvpn3_openssl.ps1 `
  -OpenVpn3Source 'C:\sources\openvpn3' `
  -DependenciesSource 'C:\build\openvpn-deps' `
  -OpenSslPrefixSource 'C:\build\openssl-android' `
  -OpenSslSourceArchive 'C:\sources\openssl-3.5.9.tar.gz' `
  -DependenciesManifestSha256 '<empreinte du manifeste deps revu>' `
  -DestinationRoot 'C:\review\native-import\third_party'
```

La destination doit être inexistante. Sans `-DestinationRoot`, l’import vise
`android/app/src/main/cpp/third_party`. Java 17 est nécessaire ; `-JavaHome`
permet de préciser son installation. L’import vérifie Core, archive source,
ABI, manifestes et chaque fichier contre le verrou indépendant avant de
publier le répertoire temporaire complet. Il refuse les liens et chemins
sortants. Un échec laisse le staging isolé pour inspection.

Gradle et CMake contrôlent le même bundle sans télécharger les dépendances
natives ; les préfixes CMake non revus sont refusés. La résolution générale
Gradle nécessite toutefois `--offline` pour interdire les téléchargements.
Les tests isolés se lancent avec `tools/test_build_provenance.ps1` et sont
également raccordés au `check` de `android/buildSrc`.

Le verrou garantit l’intégrité du bundle approuvé, pas à lui seul l’origine
d’un binaire. Une reconstruction aux octets différents exige une revue et
une mise à jour coordonnée décrite dans
[le guide du verrou natif](../android/native-provenance/README.md).

### XKey et livraison

XKey délègue ECDSA à une clé P-256 non exportable d’Android Keystore.
`Sign` transmet un digest avec nom de hash vide (`NONEwithECDSA`) ;
`DigestSign` transmet le message et SHA256/SHA384/SHA512
(`SHAxxxwithECDSA`). `OpenSslXKeyExternalPkiInstrumentedTest` couvre les
deux formes, vérifie la signature et rejette une signature altérée.

Avant diffusion, vérifier provenance et permissions, builds ARM64/ARMv7,
essais WireGuard/OpenVPN sur téléphone et contrat Keystore. Consigner les
résultats et empreintes des livrables de cette diffusion.

Préparer le paquet de sources correspondant : Core exact, fichiers FuzeVPN
marqués MPL-2.0, sources/patches WireGuard, archive OpenSSL, dépendances,
métadonnées, manifestes, notices et textes de licence. Un `README-SOURCE.md`
décrit outils, ABI et commandes ; un `SHA256SUMS` couvre sources et archives
statiques. Fournir tout nouveau correctif comme diff ordonné et haché.
Le SBOM et les notices doivent décrire le livrable distribué ; faire vérifier
le paquet et la mise à disposition des sources avant publication.

## Limites des ponts ARM x86_64 Android 12/13 (retests 74014)

Le retest utilisateur confirme les tunnels réels WireGuard/OpenVPN et la reprise
réseau de 74014 sur Android 14/17. Les quatre VM Android 12/13 conservées
exécutent les bibliothèques ARM64 via ndk_translation, sans CPU ARM natif.
Android 12 échoue dans HeavyOptimizerFrontend::StoreRegMappings ; Android 13
rejette MRS MIDR_EL1 (0xd5380000), présent dans libwg-go à l’adresse ELF 0xa0e50.
Go 1.24.3 exécute cette lecture sous HWCAP_CPUID lors de l’initialisation CPU.
Le runtime possède ce contrôle ; supprimer des capacités CPU ou modifier le
moteur sans preuve sur ARM physique ne constitue pas une correction établie.

74015 reporte uniquement le chargement WireGuard au premier démarrage du tunnel.
Les empreintes de l’AAR approuvé, du bundle natif et des dépendances restent
identiques. Un test ARM traduit prouve seulement les parcours qu’il exécute.
La qualification exige un appareil ARM64 Android 12 et un Android 13 (ou un
émulateur ARM64 natif sur hôte ARM), avec l’APK universel signé, les deux
protocoles, trafic, coupures/reprise, arrière-plan et arrêt. Un APK x86_64
contourne ce pont et ne qualifie pas les bibliothèques ARM.

Go 1.26.9 ajoute une seconde limite (campagne VM du 31/10/2026) : le
`runtime.procyieldAsm` ARM64 lit `CNTFRQ_EL0` dès que le runtime attend un
verrou. ndk_translation 0.2.3 (Android 12 à 14) rejette cette instruction :
la release ARM64 plante dans WireGuard à chaque connexion, alors que Berberis
16.0.0 (Android 16 à 17.2) l'exécute. Sur un CPU ARM, cette lecture est
autorisée en espace utilisateur. Depuis 0.2.11, la release livre aussi
`x86_64` : un appareil x86 charge alors la bibliothèque native et n'exécute
plus jamais `libwg-go` ARM sous traduction. Le runtime ARM n'est pas modifié.
