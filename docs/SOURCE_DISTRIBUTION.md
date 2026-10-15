# Publication et paquet de sources Android

Audit de qualification du 14 octobre 2026 : [Q002](VALIDATION.md#q002), [Q004](VALIDATION.md#q004), [Q006](VALIDATION.md#q006), [Q007](VALIDATION.md#q007), [Q030](VALIDATION.md#q030), [Q032](VALIDATION.md#q032), [Q033](VALIDATION.md#q033).


Le dépôt public **FuzeVPN/android-app**, version **0.2.10+74016**, publie les
sources avec leurs entrées natives revues. Il ne publie ni APK, ni AAB, ni
GitHub Releases. Les archives natives incluses sont des dépendances de
construction ; elles ne constituent pas une application installable.

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

La matrice actuelle utilise Flutter **3.44.7**, Java **17**, Gradle **9.5.0**,
Android Gradle Plugin **9.3.0**, Kotlin **2.3.20**, Android Platform **36**,
NDK **28.2.13676358**, CMake **3.22.1** et Go **1.24.3**. Les versions sont
relues depuis les fichiers de configuration ou les métadonnées de l’AAR,
puis inscrites dans chaque archive.

Les entrées natives actuellement revues sont :

| Composant | Entrée de reconstruction |
| --- | --- |
| OpenVPN 3 Core | Arbre complet `28469efe3ae770268b2b5c6aa607ed1489e101f0`, option MPL-2.0, XKey amont |
| OpenSSL | Archive officielle signée 3.5.9, commit `45e844fa2a14ec92d146bd8f5778ac130b6625fb`, SHA-256 `603f5602e2eef00d77fbd429d34dcd5822bb301757a1bc9cdb24c670f1eb859a` |
| Asio / fmt / lz4 | Sources complètes aux commits des métadonnées du préfixe, patches Asio amont, en-têtes et archives importés |
| WireGuard Android | Tag `1.0.20260102`, commit `09b75c2bd37f749e2a8c85876394854113c74be7`, deux patches FuzeVPN ordonnés |
| wireguard-tools / elf-cleaner | Sous-modules exportés aux commits revus, licences et fichiers de construction |
| wireguard-go | Module `v0.0.0-20250521234502-f333402bd9cb`, ZIP canonique vérifié contre `go.sum` |
| Modules Go | ZIPs exacts de toutes les entrées de `go.sum`, y compris les dépendances nécessaires aux fonctionnalités et tests amont |
| Runtime Go | Source officielle 1.24.3 et patch `goruntime-boottime-over-monotonic.diff`, sans binaire de compilateur |

`android/source-distribution/completeness.manifest.json` associe chaque
archive complémentaire à son origine, sa version, sa révision et ses
empreintes. Les licences et inventaires du contenu sont conservés avec ces
archives. L’export exige la présence de chaque composant attendu et une
liste `missing_sources` vide avant d’indiquer que toutes ses entrées requises
sont présentes.

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
