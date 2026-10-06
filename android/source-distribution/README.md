# Sources supplémentaires de la distribution Android

Ce dossier complète les arbres OpenVPN 3 et WireGuard Android déjà présents
dans le dépôt. Il contient les archives amont complètes d’Asio, fmt, lz4,
WireGuard Go, des modules Go épinglés et de Go 1.24.3. Le compilateur et les
outils binaires du poste de préparation ne sont pas copiés.

`completeness.manifest.json` indique pour chaque archive la version, le
commit, l’origine, le SHA-256, les licences et l’inventaire de son contenu.
Les sommes `h1` des modules et de leurs `go.mod` ont été recalculées à partir
des archives et comparées au `go.sum` de `tunnel/tools/libwg-go`.
Les fichiers `.mod` et `.info` de `module-metadata/` contiennent uniquement
les métadonnées publiques nécessaires à un proxy de modules hors ligne.

| Source | Révision conservée | Licence principale |
| --- | --- | --- |
| Asio | `asio-1-36-0`, `231cb29bab30f82712fcd54faaea42424cc6e710` | BSL-1.0 |
| fmt | `12.1.0`, `407c905e45ad75fc29bf0f9bb7c5c2fd3475976f` | MIT |
| lz4 | `v1.10.0`, `ebb370ca83af193212df4dcbadcc5d87bc0de2f0` | BSD-2-Clause pour la bibliothèque |
| WireGuard Go | `v0.0.0-20250521234502-f333402bd9cb` | MIT |
| Go crypto / net / sys | `v0.38.0` / `v0.40.0` / `v0.33.0` | BSD-3-Clause |
| Wintun | `v0.0.0-20230126152724-0fa3db229ce2` | MIT |
| google/btree | `v1.1.2` | Apache-2.0 |
| Go time | `v0.7.0` | BSD-3-Clause |
| gVisor | `v0.0.0-20250503011706-39ed1f5ac29c` | Apache-2.0 |
| Go, runtime et bibliothèque standard | `1.24.3` | BSD-3-Clause |

Les notices individuelles et les éventuelles licences de fichiers auxiliaires
restent dans les archives. Les archives amont comprennent leurs données de
tests publiques. Wintun, btree, time et gVisor accompagnent le module WireGuard
complet ; la résolution du runtime Android utilise WireGuard, crypto, net et sys.

## Reconstruction des dépendances C++

Les options exactes sont dans
`android/app/src/main/cpp/tools/prepare_openvpn3_deps.ps1`. Les archives
supplémentaires ne contiennent pas l’historique Git ; ce script d’import
strict attend des checkouts aux commits indiqués. Pour reconstruire directement
depuis les archives, les décompresser dans de nouveaux répertoires et reprendre
ses commandes CMake, avec NDK `28.2.13676358`, API `26`, mode `Release`,
`BUILD_SHARED_LIBS=OFF`, pour `arm64-v8a`, `armeabi-v7a` et `x86_64` :

- lz4 : source `build/cmake`, option `LZ4_BUILD_CLI=OFF` ;
- fmt : source racine, options `FMT_TEST=OFF`, `FMT_DOC=OFF`, `FMT_INSTALL=OFF` ;
- Asio : appliquer dans l’ordre les six patches du Core sous
  `deps/vcpkg-ports/asio`, puis copier `asio/include`.

Les archives utilisent des fins de ligne LF ; les patches importés du Core
peuvent être en CRLF. Normaliser une copie de travail des patches en LF avant
`git apply --check` et `git apply`. Les patches conservés et leurs empreintes
restent intacts. Après ces six patches, les 629 fichiers de l’en-tête Asio
correspondent au préfixe importé ; les 14 en-têtes fmt et les 6 en-têtes lz4
correspondent également, après normalisation des fins de ligne.

Une reconstruction peut produire des octets différents selon les chemins et
outils. L’import du runtime exige toujours la revue coordonnée du nouveau
préfixe et du verrou indépendant décrit dans
`android/native-provenance/README.md`.

## Reconstruction WireGuard hors ligne

`prepare_go_proxy.py` contrôle les SHA-256 du manifeste puis copie uniquement
les huit archives de modules et leurs métadonnées dans un nouveau proxy local.
Il ne modifie aucun cache Go existant. Depuis la racine du projet :

```powershell
$env:GOPROXY = python android/source-distribution/prepare_go_proxy.py C:/review/go-proxy
$env:GOMODCACHE = 'C:/review/go-module-cache'
./tools/build_wireguard_native.ps1 -GoToolchain 'C:/toolchains/go1.24.3-wireguard'
```

Le fichier `go.sum` conservé contrôle les sommes des modules. Le compilateur
Go 1.24.3 et le NDK épinglé doivent être préparés dans l’environnement de
reconstruction ; l’archive `go1.24.3.src.tar.gz` fournit les sources du runtime
et de la bibliothèque standard Go, sans exécutable de compilateur. Son SHA-256 officiel est
`229c08b600b1446798109fae1f569228102c8473caba8104b6418cb5bc032878`, provenant
des métadonnées de `https://go.dev/dl/?mode=json&include=all`.

Le patch runtime `goruntime-boottime-over-monotonic.diff` accompagne déjà le
bridge JNI WireGuard. `tools/build_wireguard_native.ps1` applique ses substitutions
contrôlées adaptées au contexte Go 1.24.3. Les sources du compilateur utilisé
ont été rapprochées de l’archive officielle : 10 681 fichiers identiques et
uniquement les huit fichiers d’assembleur runtime prévus modifiés. Les options
de compilation, ABI, adaptation du patch, contrôles JNI et alignement de 16 Kio
sont conservés dans ce script.

La préparation d’un proxy neuf suivie d’une résolution Android avec
`go list -mod=readonly -deps -tags linux` a réussi sans module du cache du poste.
Les preuves sont sous `build/reports/audit-fixes-2026-09-30/native/`.

## Ensemble à remettre

L’exporteur `tools/package_android_sources.py` rassemble ce dossier avec les
sources de l’application, Core, WireGuard Android, patches, archive OpenSSL
signée, notices, SBOM, verrous et outils de reconstruction. Ce dossier seul
n’est pas le paquet complet de l’application. Le manifeste ne déclare aucune
source native manquante.
