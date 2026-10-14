# Dépendances natives Android

Version source **0.2.10+74016**. Les commandes partent de la racine du dépôt. Les prérequis généraux
et les commandes de l’application sont dans [DEVELOPMENT.md](DEVELOPMENT.md).
L’inventaire est dans [SBOM.spdx.json](SBOM.spdx.json) et
[THIRD_PARTY_NOTICES.md](../THIRD_PARTY_NOTICES.md).

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

Le build natif utilise Go **1.24.3** Windows avec
`goruntime-boottime-over-monotonic.diff`, NDK **28.2.13676358**, API **21** et
le module `golang.zx2c4.com/wireguard v0.0.0-20250521234502-f333402bd9cb`.
Il produit `libwg-go.so` et ses preuves sous `build/wireguard-native/` pour
`arm64-v8a`, `armeabi-v7a`, `x86_64` et `x86`, vérifie les symboles JNI et
l’alignement ELF de 16 Ko. Le script prépare le Go Windows épinglé et patché sous
`build/toolchains/go1.24.3-wireguard` s’il manque ; `-GoToolchain` permet de
préciser ce répertoire. Le SDK est fourni via `ANDROID_SDK_ROOT` ou
`-AndroidSdk`. Les modules Go doivent aussi être disponibles dans
l’environnement de build.

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
`bf96422b21e086cf371154613f5250c8101568538ab40acb4ccbad09394e4811`.
Son manifeste conserve le minimum SDK 24 de l'artefact officiel ; le minimum
de l'application reste Android 26. La reconstruction pour le chemin IPC de
`com.fuzevpn` conserve `classes.jar` et toutes les bibliothèques autres que
`libwg-go.so` identiques à celles de l'AAR approuvé précédent.

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
| `x86_64` | `android-x86_64` | debug émulateur |

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
