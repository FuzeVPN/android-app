# Inventaires release : résolution et contenu observé

Génération du **19 octobre 2026** avec `tools/generate_release_sbom.py`, sans
réseau, compilation, extraction sur disque ni exécution d'un binaire.

Le [SBOM de sources limité](SBOM.spdx.json) conserve son périmètre et ses
constats historiques du 14 octobre. Quatre documents SPDX 2.3 séparent les
snapshots de préparation, les entrées finales et les octets d'AAB observés.
Ils ne constituent pas une attestation de reconstruction ou une qualification
complète des composants internes Flutter, des licences ou des vulnérabilités.

| Document | Sujet et preuve |
| --- | --- |
| [SBOM.release.sources.spdx.json](SBOM.release.sources.spdx.json) | **Snapshot préparatoire du 19/10 à 01:38:29 UTC, entrées exactes archivées** : classpaths release, résolution Pub, AAR WireGuard et informations Go lues dans ses ELF. Conservé inchangé ; la métadonnée AAR a été finalisée ensuite. Aucun AAB n'est déclaré produit par ce snapshot. |
| [SBOM.release.74016.spdx.json](SBOM.release.74016.spdx.json) | Même snapshot préparatoire archivé **et**, comme sujet indépendant, l'AAB local historique `0.2.10+74016`. Conservé inchangé et reproductible avec ses entrées et son générateur archivés. Aucune relation affirmant qu'il a été construit avec les entrées corrigées n'est ajoutée. |
| [SBOM.release.audit-corrected.spdx.json](SBOM.release.audit-corrected.spdx.json) | Entrées finales lues le 19/10 à 02:19:26 UTC **et** AAB local `workingtree-fix20261019`, scope `unsigned-worktree`, SHA-256 attendu vérifié. Le document observe un binaire construit dans l'arbre de travail ; il n'atteste ni commit propre, ni livraison, ni recette VPN. |
| [SBOM.release.corrections-20261028.spdx.json](SBOM.release.corrections-20261028.spdx.json) | Entrées lues le 28/10 à 01:49:25 UTC **et** AAB local `workingtree-fix20261028`, scope `unsigned-worktree`, SHA-256 `7b19aff4443c689cf657b64659690b09552f7a3e8148106e0a1cd607919136c5` ; 137 paquets, 693 fichiers ; SHA-256 du document `e1c5e441729c203c6fe67d1aa468b89999ee4b18101d4b3748d40f84e013ea8c`. Produit avant la correction A17-supply-chain-04 (voir ci-dessous). |

## Versions et périmètres

`android/gradle/dependency-locks/app-patched.lockfile` sélectionne **74
coordonnées Maven dans `releaseRuntimeClasspath`**. L'union avec
`releaseCompileClasspath` contient 83 coordonnées, chacune avec une identité
comprenant sa version et la liste exacte de ses configurations. Les
configurations de tests, debug, lint et outils ne sont pas assimilées au runtime
release. Le verrou utilisé et son empreinte figurent dans le snapshot.

La comparaison avec l'ancien inventaire distingue **48 modules absents** et
**deux modules présents à une autre version** : cela fait 50 PURL de version
exacte absents, et non 50 nouveaux modules. Les deux versions de compilation et
de runtime sont conservées séparément :

| Module | Compilation release | Runtime release |
| --- | --- | --- |
| `androidx.core:core-ktx` | `1.16.0` | `1.17.0` |
| `androidx.annotation:annotation` | `1.9.1` | `1.10.0` |

La relation SPDX `DEPENDS_ON` du snapshot vers une coordonnée runtime signifie
« sélectionné par ce verrou pour ce classpath ». Elle **ne prouve pas que R8 a
conservé le code de cette bibliothèque**. L'annotation
`binaryPresenceAfterR8: not-established` l'indique pour chaque coordonnée. Les
métadonnées de dépendances de l'AAB et son mapping R8 sont inventoriés comme
fichiers, sans être promus en preuve d'inclusion individuelle. Le verrou ne
permet pas de reconstruire toutes les arêtes transitives du graphe ; il donne
l'ensemble exact de ses coordonnées sélectionnées.

Pub reste un inventaire de résolution comprenant les dépendances de
développement et les plugins d'autres plateformes. Le rôle déclaré et le hash
d'archive du lockfile sont conservés. Leur présence après compilation AOT
Android n'est pas inférée. La version Flutter sélectionnée ne devient pas une
preuve de la version de chacun des composants internes de `libflutter.so`.

## Composants natifs déclarés et moteur Flutter (générateur du 29 octobre 2026)

Depuis la correction A17-supply-chain-04, chaque document produit par le
générateur contient aussi :

- **Asio, fmt et lz4** (`DEPENDENCIES-METADATA.json` du préfixe natif) : un
  paquet par source, à sa référence et à son commit, PURL `pkg:github/…@<commit>`,
  licence déclarée relue dans les métadonnées (BSL-1.0, MIT, BSD-2-Clause), les
  six patches Asio maintenus par OpenVPN en annotation. Ils sont compilés dans
  `libfuzevpn_openvpn.so` avec OpenVPN 3 Core et OpenSSL ;
- **wireguard-tools** au commit du sous-module revu
  (`tools/import_wireguard_android.ps1`), licence déclarée `GPL-2.0-only`
  (alternatives MIT et netlink LGPL-2.1-or-later en annotation). Les
  `jni/*/libwg.so` et `libwg-quick.so` de l'AAR approuvé lui sont reliés par
  `GENERATED_FROM` ;
- **le moteur Flutter** : les artefacts `io.flutter:*_release` épinglés par
  `android/gradle/verification-metadata.xml` (ils sont exclus des verrous
  Gradle par `android/build.gradle.kts`), avec leur PURL Maven
  `pkg:maven/io.flutter/<artefact>@1.0.0-<révision>` et leurs empreintes.

Lorsqu'un AAB est inspecté, chaque `libflutter.so` est lu : la bannière de
version Dart devient un paquet `Dart SDK runtime` (PURL
`pkg:github/dart-lang/sdk@<version>`) relié par `STATIC_LINK`, et la révision
du moteur trouvée dans le binaire le relie par `GENERATED_FROM` à l'artefact
épinglé de même ABI. Un `libwg.so`/`libwg-quick.so` de l'AAB n'est relié à
wireguard-tools que s'il est identique à l'octet près à l'entrée de l'AAR
approuvé. Depuis leur exclusion (`packaging.jniLibs.excludes`,
A17-supply-chain-05), un AAB n'en contient plus : `wireguardToolsLibraries`
est vide et wireguard-tools reste seulement relié aux entrées de l'AAR. Le
générateur refuse tout AAB qui en contient encore, quel que soit son périmètre,
sauf les trois AAB inspectés avant l'exclusion (`PRE_EXCLUSION_AABS` :
`f39d06bb…`, `f6ca8698…` et `7b19aff4…`, ceux des documents versionnés), décrits
tels qu'ils sont. En amont, le contrôle `native-libraries-approved` de
`tools/test_wireguard_release_gate.ps1` refuse déjà une fusion qui les contient. Pour `libfuzevpn_openvpn.so`, les composants statiques sont listés
dans l'annotation `observedBinary.openVpnLibraries` comme déclarés par la
provenance native, sans relation : leurs versions internes ne sont pas lues
dans le binaire.

Contrôle du 29 octobre sur l'AAB du 28/10 (`7b19aff4…`, scope
`unsigned-worktree`) : 146 paquets au lieu de 137, Dart **3.12.2** et la
révision moteur `69c8c617…` relevés dans les deux `libflutter.so`, les quatre
bibliothèques wireguard-tools identiques à celles de l'AAR. Les documents SPDX
déjà versionnés ci-dessous ont été produits avant cette correction et ne
contiennent pas ces paquets ; le SBOM de la prochaine livraison doit être
régénéré avec le générateur courant.

## Go : outil de compilation et runtime statique

L'AAR courant porte le SHA-256
`bf563b779e670647e7d47751e7f4ff5d90299272640af7814c52f74bfe8c4b73`.
Le générateur vérifie son empreinte, celles des ABI et des entrées de sources Go
énumérées par sa provenance. Les informations de chaque `libwg-go.so` sont
décodées depuis l'enregistrement ELF Go build-info : une simple chaîne de
version trouvée dans un fichier n'est pas acceptée.

- Le compilateur courant est représenté comme dépendance de construction
  **Go 1.26.9**.
- Le runtime et la bibliothèque standard **Go 1.26.9** sont un paquet distinct,
  relié par `STATIC_LINK` aux bibliothèques de l'AAR qui l'incorporent.
- Les enregistrements de modules incorporés indiquent WireGuard
  `v0.0.0-20261024220952-b3bc704ef0ee`. Ils ne prouvent pas la présence de tous les
  paquets ou symboles d'un module, notamment d'un symbole visé par une CVE.
- L'AAB historique conserve son runtime **Go 1.24.3** et sa version WireGuard
  `v0.0.0-20250521234502-f333402bd9cb`, lus directement dans les deux ABI livrées.
  Ils ne sont pas remplacés dans l'inventaire par les versions nouvellement
  construites dans l'AAR.

La composition binaire des autres bibliothèques est attestée au niveau des
fichiers et empreintes observés. Les versions internes OpenSSL/OpenVPN et les
internes du moteur Flutter ne sont pas déduits du seul nom d'une bibliothèque.
Les pins de sources natifs figurent dans le snapshot de construction avec cette
limite explicite.

## AAB local de corrections, distinct de l'historique

Le troisième document observe la copie construite par l'axe 19 :

- Origine :
  `corrections-20261019/checks/a19/builds/normal-20261019-021212-231/app-release-74016-worktree.aab`.
- Label : `workingtree-fix20261019` ; scope explicite : `unsigned-worktree`.
- SHA-256 :
  `f6ca8698ad34420c03ea2923e9aaee4d7aef1f45efaa14303c15e6ca4c58953d` ;
  taille : 65 869 893 octets.
- 677 entrées AAB, dont les bibliothèques Go ARM64 et ARM32 ; les deux
  enregistrements ELF confirment Go **1.26.9** et WireGuard
  **v0.0.0-20261006164505-2631ce99a06f**. Aucun fichier de signature JAR n'est
  présent. La validation bundletool est passée sur l'axe 19.
- 137 paquets et 693 fichiers dans le document combiné : les 677 entrées AAB
  et les 16 entrées de l'AAR sont des observations d'archives séparées.

Les hashes des ELF après le traitement de packaging Android peuvent différer
de ceux de l'AAR. Les enregistrements Go ci-dessus sont lus directement dans
l'AAB ; la seule égalité d'une version n'est pas présentée comme preuve
d'identité de tous ses octets. Les preuves de transformation du packaging et
le relevé des fichiers de l'arbre de travail appartiennent à l'axe 19/racine.
Le SBOM ne crée pas de relation de provenance entre son snapshot partiel
d'entrées et ce binaire. Il ne qualifie pas une recette VPN, une distribution
Play ou une version livrée.

## Identité de l'AAB historique

- Origine locale observée : `build/app/outputs/bundle/release/app-release.aab`,
  étiqueté explicitement « historical-0.2.10+74016-local-aab ».
- SHA-256 :
  `f39d06bb0699f5f08f03726bbaf20e3bd6ec8185a5eae2f1e5cf9926322b1651`.
- 677 entrées de l'AAB observées ; 16 entrées de l'AAR courant observées
  séparément. Le document combiné inventorie donc 693 fichiers, sans assimiler
  ces deux archives à une seule livraison.
- Ce hash désigne l'AAB local, pas l'APK historique identifié par d'autres
  preuves, ni une signature/distribution Google Play, ni un futur binaire
  contenant les corrections du 19 octobre.

## Régénération déterministe

Python 3.10 ou plus récent et sa bibliothèque standard suffisent. Le dossier
racine est déduit du script ; `--root` permet de sélectionner explicitement un
autre arbre. La date est explicite, pour que les mêmes entrées, le même
générateur et les mêmes paramètres produisent exactement les mêmes octets.

Depuis la racine du dépôt :

```powershell
python tools/generate_release_sbom.py --created 2026-10-19T02:19:26Z --output new-sources.spdx.json
```

Cette commande crée un **nouveau** snapshot des entrées présentes. Les deux
documents préparatoires restent inchangés. Leurs 17 entrées exactes, leur
générateur initial et les documents sont figés dans le dossier local
`corrections-20261019/checks/a07/historical/` : manifest de 20 fichiers vérifiés,
aucune entrée manquante. L'ancien AAB y a été copié exclusivement avant
écrasement du chemin de build, puis passé en lecture seule. Les deux documents
initiaux ont été reproduits à l'octet près avec ce jeu figé.

La reproduction historique exige ce jeu archivé et le générateur correspondant.
L'empreinte attendue empêche qu'un nouveau binaire au même chemin reçoive
l'ancien label :

```powershell
python ../corrections-20261019/checks/a07/historical/source-inputs/tools/generate_release_sbom.py --root ../corrections-20261019/checks/a07/historical/source-inputs --created 2026-10-19T01:38:29Z --aab ../corrections-20261019/checks/a07/historical/app-release-74016-f39d06bb.aab --binary-label historical-0.2.10+74016-local-aab --binary-sha256 f39d06bb0699f5f08f03726bbaf20e3bd6ec8185a5eae2f1e5cf9926322b1651 --binary-origin "build/app/outputs/bundle/release/app-release.aab (historical local 74016)" --output verify-historical.spdx.json
```

Le troisième document ne se reproduit à l'octet près qu'avec le générateur et
les entrées archivés de l'axe 19, sur le modèle de la commande historique
ci-dessus : l'empreinte du générateur entre dans le namespace. Le générateur
courant accepte encore la commande suivante, puisque cet AAB est antérieur à
l'exclusion de wireguard-tools, mais il produit un autre document (contrôle du
30 octobre : autre namespace, 147 paquets au lieu de 137) :

```powershell
python tools/generate_release_sbom.py --created 2026-10-19T02:19:26Z --aab ../corrections-20261019/checks/a19/builds/normal-20261019-021212-231/app-release-74016-worktree.aab --binary-label workingtree-fix20261019 --binary-scope unsigned-worktree --binary-sha256 f6ca8698ad34420c03ea2923e9aaee4d7aef1f45efaa14303c15e6ca4c58953d --binary-origin "corrections-20261019/checks/a19/builds/normal-20261019-021212-231/app-release-74016-worktree.aab (unsigned local worktree build)" --output verify-corrected.spdx.json
```

Les identités SPDX et le namespace dérivent des empreintes des entrées, du
générateur, du binaire éventuel et de la date explicite. Une modification
d'entrée pendant la génération fait échouer le contrôle. Les versions
incompatibles entre AAR, métadonnées et ELF Go sont rejetées. Aucun chemin de
poste ni flag de linker arbitraire n'est exporté depuis Go build-info.

## Vérification et reste à qualifier

```powershell
python -m unittest discover -s tools/tests -p test_generate_release_sbom.py -v
```

Les **44 tests** couvrent notamment les 48 omissions de modules et deux écarts
de version, les deux versions de chaque configuration, le runtime Go statique,
la coexistence des anciens/nouveaux runtimes, les composants natifs
Asio/fmt/lz4, wireguard-tools et le moteur Flutter/Dart (y compris sur les
entrées réelles du dépôt), les empreintes des livrables, l'absence de
provenance inventée, la distinction historique/unsigned-worktree, la stabilité
de génération et le rejet des entrées corrompues ou remplacées.

L'inventaire corrige la lacune de résolution et de représentation du runtime Go
du constat D18-03. La qualification complète du contenu Java conservé par R8,
des internes Flutter et de la correspondance d'un AAB destiné à une livraison
avec les sources corrigées demande des preuves propres au build concerné. Ce
document ne clôt pas ces limites par déclaration.
