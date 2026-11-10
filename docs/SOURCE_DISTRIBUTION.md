# Publication et paquet de sources Android

Audit de qualification du 14 octobre 2026 : [Q002](VALIDATION.md#q002), [Q004](VALIDATION.md#q004), [Q006](VALIDATION.md#q006), [Q007](VALIDATION.md#q007), [Q030](VALIDATION.md#q030), [Q032](VALIDATION.md#q032), [Q033](VALIDATION.md#q033).


Le dépôt public **FuzeVPN/android-app**, version **0.2.11+74018**, publie les
sources avec leurs entrées natives revues. Les APK signés sont joints aux
GitHub Releases avec l’archive de sources produite pour eux par ce guide
(option `--apk`) ; aucun AAB n’est publié. Les archives natives incluses sont
des dépendances de construction ; elles ne constituent pas une application
installable.

`tools/package_android_sources.py` prépare une archive `.tar.gz` des sources
de l’application et des entrées natives revues. Python **3.10 ou supérieur**
suffit ; le script utilise uniquement la bibliothèque standard. Il ne
télécharge rien et ne recherche pas les caches du poste.

Pour une distribution binaire séparée, préparer les sources correspondantes
et les notices applicables. Une association d’empreintes indique les fichiers
désignés lors de l’export ; elle ne démontre pas à elle seule qu’un APK a été
compilé avec ces sources. Cette publication de sources n’atteste aucun binaire.

## Vérifier sans produire d’archive

À la racine du projet :

```powershell
python tools/package_android_sources.py --check
python -m unittest discover -s tools/tests -p 'test_package_android_sources.py'
```

Le premier contrôle parcourt les seuls chemins autorisés, vérifie le bundle
natif contre `android/native-provenance/bundle.sha256`, l’archive officielle
OpenSSL 3.5.9, l’AAR WireGuard et les archives sources complémentaires. Les
modules Go sont comparés aux empreintes `h1:` du `go.sum` importé, en
recalculant l’empreinte de leur contenu. Il ne lance aucune compilation.

Il vérifie aussi, de façon statique, les entrées qu’exigent la compilation et
le runner de validation :

- scripts et fichiers lus par `tools/validate_project.ps1` et par chaque script
  du dépôt qu’il lance, PowerShell comme Python : chemins `Join-Path` et
  `"$base/..."`, fichiers inclus par `.`, jointures littérales des scripts
  Python (`Path(__file__)`, `/ 'littéral'`, boucles sur des listes littérales,
  comme les 70 packs de `lib/l10n/translations` lus par l’étape
  `translations`) et des modules de test que `unittest discover -s tools/tests`
  charge ;
- tout fichier des répertoires utilisés en bloc : sources Dart de `lib` et
  `test`, jeux de sources Gradle, ressources Android, `buildSrc`, répertoires
  d’assets déclarés, répertoire exporté qu’un script du runner nomme (racine
  d’inclusion ou de sources ; un répertoire qui contient des racines exportées,
  comme le projet Gradle `android`, compte seulement par ses entrées
  explicites), fichiers listés par `Get-ChildItem` avec leur filtre et modules
  de test Python découverts ;
- fichiers lus par les tests Flutter au moyen de `File('…')` ou
  `Directory('…')` littéraux ;
- fermeture Kotlin des jeux `main`, `test` et `androidTest`, et celle du runner
  Turnstile hôte (noms référencés sans import dans le même paquet, imports
  `com.fuzevpn.*`, doublures Android/Flutter de `testHost/turnstile/stubs`) ;
- sources et scripts nommés par les `CMakeLists.txt`/`.cmake` de l’application,
  puis leurs `#include "..."` locaux ;
- tout fichier source qu’une règle d’exclusion (`build`, `cache`, `tmp`…)
  écarterait d’un répertoire compilé.

Ce sont des contrôles statiques, pas une compilation de l’archive. Les chemins
calculés à partir de données, de paramètres ou de l’environnement ne sont pas
suivis, ni ceux qui ne sont lus qu’après un test d’existence. Dans le corps
d’une classe qui hérite d’un type externe, un nom nu peut désigner un type
imbriqué hérité (`Builder` d’un `VpnService`) : il n’y est pas vérifié, mais
le fichier qui le déclarerait reste exigé comme tout fichier du jeu de sources.

Une entrée manquante, une révision incompatible, une empreinte différente ou
un lien dans les sources arrête l’export normal. `--allow-incomplete` permet
un diagnostic explicitement marqué `partial`, avec les lacunes dans le
manifeste et le README. Une telle archive ne doit pas être présentée comme
un paquet complet. Les archives sources imbriquées sont inspectées sans
extraction et les chemins sortants, doublons et liens sont refusés.

## Produire une archive de sources locale

À la racine du dépôt :

```powershell
python tools/package_android_sources.py --output build/FuzeVPN-Android-sources-v74016.tar.gz
```

Sans `--apk`, le README généré indique que l’archive n’est rattachée à aucun
APK. Le nom par défaut reprend la version de `pubspec.yaml`. L’outil refuse
d’écraser une archive et une sortie dans les répertoires sources autorisés ;
il affiche le SHA-256 final. Garder cette sortie locale hors du dépôt Git.

Pour une distribution binaire distincte, l’option `--apk <chemin>` peut être
répétée pour chaque APK effectivement remis. Les noms, tailles et empreintes
sont inscrits au manifeste ; leurs octets ne sont jamais inclus dans l’archive
de sources. Conserver aussi les preuves de construction et les licences du
livrable distribué. Les guides de ce dépôt ne remplacent pas cette qualification.

Le script ne modifie ni sources, préfixes, verrous ni AAR. Une mutation entre
inventaire et empaquetage fait échouer l’export ; ses temporaires sont retirés.

## Contenu et format

L’allowlist comprend les sources Dart et leurs tests, les ressources et
licences, les documents, outils et patches, les sources Android/Kotlin/C++,
`buildSrc`, le wrapper et la configuration Gradle, les verrous et métadonnées
de vérification, les bundles natifs et `android/source-distribution/`.
L’AAR local et les archives statiques approuvées restent inclus : les contrôles
de provenance exigent leurs octets exacts lors de la compilation.

L’archive contient, dans une racine nommée selon la version :

- Les fichiers source dans leurs chemins relatifs d’origine.
- `SOURCE_MANIFEST.json` : version de l’application, outils et composants
  exacts, empreintes et tailles des entrées, APK associés, politique d’export
  et liste explicite des entrées sources manquantes.
- `README-SOURCE.md` : matrice de versions, ABI, ordre des patches et étapes
  pour retrouver l’environnement de construction.
- `SHA256SUMS` : empreintes de tous les fichiers exportés et des deux documents
  générés, vérifiables après extraction avec `sha256sum -c SHA256SUMS`.

Les fichiers sont ordonnés par chemin ; les dates TAR et GZIP, propriétaires
et groupes sont normalisés. Les scripts shell et `gradlew` reçoivent le mode
755, les autres fichiers le mode 644. À entrées identiques, avec la même
version de Python/zlib, deux exports donnent les mêmes octets, quel que soit
leur nom de sortie. Le manifeste ne contient ni chemin absolu du poste ni
horodatage de la commande. Les anciennes métadonnées de provenance importées
restent toutefois conservées à l’identique et peuvent indiquer l’environnement
historique de leur reconstruction.

Des chemins de l'ancien poste de compilation sont aussi intégrés à certaines
archives statiques `.a` et aux métadonnées de l'AAR approuvé. Ils sont conservés
avec les octets et empreintes d'origine ; les retirer modifierait les entrées
natives verrouillées. Ces traces de provenance ne sont pas des credentials.
Le fichier `.gitattributes` conserve les octets des fichiers lors d'un clone,
y compris sous Windows ; Git ne normalise pas leurs fins de ligne.
Les sources officielles Go et OpenSSL contiennent des clés publiques de test
et des identités PKI de test publiées en amont. Certaines archives imbriquées
dans les `testdata` de Go sont volontairement malformées ou contiennent des
liens, chemins de test et fichiers sparse : ce sont des fixtures de parseurs,
identifiées par leurs empreintes, à examiner sans extraction ni exécution.
L'exporteur contrôle les archives de distribution externes ; il n'exécute
pas les archives de test qu'elles contiennent.

Sont exclus les rapports et livrables, sorties `build`, caches `.gradle` et
`.cxx`, données `.git`, dossiers de l’éditeur, temporaires, secrets identifiés,
`local.properties`, `key.properties`, certificats personnels et magasins de
clés. Les clés des tests amont OpenVPN sont des fixtures publiques ; elles
restent incluses uniquement dans les chemins de tests du Core et leurs octets
doivent correspondre au verrou natif indépendant. Aucun secret de diffusion
ne doit être placé dans les fichiers sources autorisés. L’outil applique des
exclusions de chemins et formats ; il ne certifie pas une détection universelle
de secrets arbitrairement cachés dans du code.

## Sources et outils exacts

La matrice actuelle utilise Flutter **3.47.8**, Java **17**, Gradle **9.8.2**,
Android Gradle Plugin **9.3.0**, Kotlin **2.3.20**, Android Platform **36**,
NDK **28.2.13676358**, CMake **3.22.1** et Go **1.26.9**. Les versions sont
relues depuis les fichiers de configuration ou les métadonnées de l’AAR,
puis inscrites dans chaque archive ; `README-SOURCE.md` reprend la série de
patches WireGuard depuis `android/third_party/wireguard-android/patches/fuzevpn/series`.

Les entrées natives actuellement revues sont :

| Composant | Entrée de reconstruction |
| --- | --- |
| OpenVPN 3 Core | Arbre complet `28469efe3ae770268b2b5c6aa607ed1489e101f0`, option MPL-2.0, XKey amont |
| OpenSSL | Archive officielle signée 3.5.9, commit `45e844fa2a14ec92d146bd8f5778ac130b6625fb`, SHA-256 `603f5602e2eef00d77fbd429d34dcd5822bb301757a1bc9cdb24c670f1eb859a` |
| Asio / fmt / lz4 | Sources complètes aux commits des métadonnées du préfixe, patches Asio amont, en-têtes et archives importés |
| WireGuard Android | Tag `1.0.20260102`, commit `09b75c2bd37f749e2a8c85876394854113c74be7`, trois patches FuzeVPN appliqués dans l’ordre du fichier `series` : `0001-go-backend-real-foreground-service.patch`, `0002-go-backend-protected-start.patch`, `0003-go-runtime-and-handshake-update.patch` |
| wireguard-tools / elf-cleaner | Sous-modules exportés aux commits revus, licences et fichiers de construction |
| wireguard-go | Module `v0.0.0-20261024220952-b3bc704ef0ee` (commit `b3bc704ef0ee21a36298601a9e1e5ff90377ac52`), ZIP canonique vérifié contre `go.sum` |
| Modules Go | ZIPs exacts de toutes les entrées de `go.sum`, y compris les dépendances nécessaires aux fonctionnalités et tests amont |
| Runtime Go | Source officielle 1.26.9 (`go1.26.9.src.tar.gz`) et patch `goruntime-go1.26.9-boottime.diff` avec son manifeste `goruntime-go1.26.9-boottime.json`, ajoutés par le patch 0003, sans binaire de compilateur |
| AAR WireGuard approuvé | `tunnel-1.0.20260102-fuzevpn-fgs.aar`, SHA-256 `bf563b779e670647e7d47751e7f4ff5d90299272640af7814c52f74bfe8c4b73` (`WireGuardAarPolicy.APPROVED_SHA256`) |

`tools/import_wireguard_android.ps1` exporte l’étiquette amont avec
`core.autocrlf=false` puis applique la série par
`tools/wireguard_patch_series.ps1`, indépendamment des fins de ligne : les
patches revus mélangent des préimages CRLF (0001, 0003) et LF (0002). Les
octets et empreintes des patches ne changent pas. Une réimportation n’est pas
identique à l’octet : elle écrit les octets commités et des fichiers en LF là
où l’arbre versionné, exporté en `core.autocrlf=true`, est en CRLF ; les
sous-modules `wireguard-tools` et `elf-cleaner` sont copiés depuis la copie de
travail et suivent son `core.autocrlf`. `jni.c` ne correspond alors plus à
`nativeBuild.sourceHashes` de l’AAR approuvé et
`tools/generate_release_sbom.py` refuse l’AAR tant que
`build_wireguard_native.ps1` puis `build_wireguard_patched_aar.ps1` n’ont pas
régénéré l’AAR et ses métadonnées (empreinte à réapprouver dans
`WireGuardAarPolicy`). Sans cette reconstruction, l’arbre versionné reste la
référence de l’archive de sources ; voir docs/NATIVE_DEPENDENCIES.md.

`android/source-distribution/completeness.manifest.json` associe chaque
archive complémentaire à son origine, sa version, sa révision et ses
empreintes. Les licences et inventaires du contenu sont conservés avec ces
archives. L’export exige la présence de chaque composant attendu et une
liste `missing_sources` vide avant d’indiquer qu’aucune entrée manquante n’a
été détectée par ses contrôles.

La signature détachée OpenSSL et les certificats de publication officiels
accompagnent l’archive. Leur vérification d’origine est décrite dans
[NATIVE_DEPENDENCIES.md](NATIVE_DEPENDENCIES.md). L’export vérifie leurs octets
contre le verrou revu ; il n’exécute pas lui-même GPG ni une nouvelle décision
de confiance sur une clé.

## Reconstruction et portée

Suivre [DEVELOPMENT.md](DEVELOPMENT.md) pour les SDK, dépendances Pub/Gradle et
commandes de l’application, puis [NATIVE_DEPENDENCIES.md](NATIVE_DEPENDENCIES.md)
pour la reconstruction des préfixes et de l’AAR. Le README des sources
complémentaires donne leurs méthodes de récupération et d’authentification.
Le dépôt fournit les entrées OpenSSL et leurs options exactes, mais conserve
la préparation du compilateur, MSYS2/Perl/make et du préfixe à l’environnement
de reconstruction. Les SDK et caches du poste ne sont jamais empaquetés.

La présence des sources, licences et notices facilite la remise des composants
concernés. Elle ne constitue pas une certification juridique, une vérification
de toutes les obligations de redistribution ni une preuve de reproductibilité
bit à bit de l’APK. Rapprocher le paquet, les notices consultables, le SBOM,
les preuves de compilation et les fichiers réellement diffusés avant toute
publication. Les fichiers publics de fixture amont ne doivent jamais servir
de clés de production.

## Taille et hébergement

Les sources et entrées natives représentent environ **215 Mio non compressés**.
L’archive OpenSSL conservée représente environ **51 Mio** ; une archive complète
de sources peut dépasser **100 Mio**. GitHub avertit pour les fichiers Git
supérieurs à 50 Mio et refuse les fichiers supérieurs à 100 Mio. Ne pas ajouter
l’archive générée, les APK/AAB ou les caches à l’historique Git. Git LFS peut
servir à un futur besoin de gros fichiers, avec sa configuration et sa méthode
de récupération documentées ; il ne remplace pas la mise à disposition des
sources et licences requises.
[Limites GitHub](https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-large-files-on-github).
