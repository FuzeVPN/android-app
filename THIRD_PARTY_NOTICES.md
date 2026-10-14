# Notices des composants tiers — FuzeVPN Android

Audit de qualification du 14 octobre 2026 : [Q030](docs/VALIDATION.md#q030), [Q031](docs/VALIDATION.md#q031), [Q032](docs/VALIDATION.md#q032), [Q033](docs/VALIDATION.md#q033).


Inventaire de sources **0.2.10+74016**, audité le **14 octobre 2026** à
partir des fichiers conservés et des sources primaires indiquées.
[LICENSING.md](LICENSING.md) distingue le code propre MPL-2.0, ses exceptions,
les composants tiers et les marques. [docs/SBOM.spdx.json](docs/SBOM.spdx.json) contient les versions,
relations et empreintes disponibles. Il distingue les dépendances déclarées,
les outils de développement, les ressources et les paquets multiplateformes
résolus par Pub. Il ne constitue pas un relevé des composants d’un APK donné.

## Composants de l’application

| Composant | Version ou révision | Licence déclarée / retenue | Usage |
| --- | --- | --- | --- |
| Flutter SDK | 3.44.7 | BSD-3-Clause, avec notices de ses composants | Interface et runtime |
| flutter_localizations | SDK Flutter 3.44.7 | Voir les notices du SDK | Localisation Flutter |
| intl | 0.20.2 | BSD-3-Clause | Formats et localisation |
| crypto | 3.0.7 | BSD-3-Clause | Empreintes Dart |
| url_launcher | 6.3.2 | BSD-3-Clause | Liens publics |
| url_launcher_android | 6.3.32 | BSD-3-Clause | Implémentation Android |
| url_launcher_platform_interface | 2.3.2 | BSD-3-Clause | Interface du plugin |
| WireGuard Android Tunnel local | 1.0.20260102-fuzevpn-fgs | Apache-2.0 pour le tunnel Java ; notices natives distinctes | Service VPN partagé et démarrage protégé |
| wireguard-go | v0.0.0-20250521234502-f333402bd9cb | MIT | Moteur Go, via le pont natif modifié |
| wireguard-tools | e2ecaaa739144997ccff89d6ad6ec81698ea6ced | GPL-2.0-only ; nombreux fichiers GPL-2.0-only OR MIT, netlink LGPL-2.1-or-later | Outils libwg / libwg-quick conservés dans l’AAR |
| OpenVPN 3 Core | 28469efe3ae770268b2b5c6aa607ed1489e101f0 | MPL-2.0, option retenue | Moteur JNI et XKey amont |
| OpenSSL | 3.5.9 | Apache-2.0 | TLS et cryptographie OpenVPN |
| Asio | 1.36.0 | BSL-1.0 | E/S, avec les six patches maintenus par OpenVPN |
| fmt | 12.1.0 | MIT | Formatage du Core |
| lz4 | 1.10.0 | BSD-2-Clause | Dépendance du Core |
| AndroidX Core KTX | 1.16.0 | Apache-2.0 | API Android |
| AndroidX annotation / collection | 1.9.1 / 1.5.0 | Apache-2.0, déclaration des POM officiels | Dépendances explicites de l’AAR |
| Kotlin / Coroutines Android | 2.3.20 / 1.10.2 | Apache-2.0 | Code et exécution asynchrone |
| Google Play Billing Library | 9.1.0 | Android Software Development Kit License, déclaration du POM ; [conditions officielles](https://developer.android.com/studio/terms.html) | Prérequis de facturation Google Play |
| AndroidX Credential Manager / Credential Manager Play Services Auth | 1.6.0 / 1.6.0 | Apache-2.0, déclaration des POM et textes inclus dans les AAR | Sélection native du compte Google et pont Google Play services |
| Google ID Library (`com.google.android.libraries.identity.googleid:googleid`) | 1.2.1 | Android Software Development Kit License, déclaration du POM ; [conditions officielles](https://developer.android.com/studio/terms.html) | Requêtes de connexion Google et lecture de leur résultat |
| Google Play services base / basement / location / tasks / places-placereport | 18.5.0 / 18.9.0 / 19.0.0 / 18.2.0 / 17.0.0 | Android Software Development Kit License, déclaration des POM ; [conditions officielles](https://developer.android.com/studio/terms.html) | Dépendances transitives de Billing |
| Google Play services auth / auth-api-phone / auth-base / auth-blockstore / fido / identity-credentials | 21.1.1 / 18.0.2 / 18.0.10 / 16.4.0 / 21.0.0 / 16.0.0-alpha08 | Android Software Development Kit License, déclaration des six POM ; [conditions officielles](https://developer.android.com/studio/terms.html) | Dépendances transitives de la connexion Google |
| Google DataTransport API / CCT / Runtime | 3.0.0 / 3.1.8 / 3.1.8 | Apache-2.0, déclaration des POM | Dépendances transitives de Billing |
| Firebase encoders / JSON / Proto | 17.0.0 / 18.0.0 / 16.0.0 | Apache-2.0, déclaration des POM | Dépendances transitives de DataTransport |
| javax.inject | 1 | Apache-2.0, déclaration du POM officiel | Dépendance transitive de DataTransport |

Les licences Dart ajoutées ont été relevées dans les notices Flutter générées
présentes lors de cet inventaire. Les autres entrées proviennent des notices,
en-têtes et métadonnées conservés dans le projet. `NOASSERTION` dans le SBOM
signifie qu’aucune conclusion n’a été établie à partir des éléments inspectés.
Les dépendances Gradle transitives et tous les composants internes du moteur
Flutter doivent encore être rapprochés du livrable exact lors d’une diffusion.

Le graphe Billing et Google Auth est verrouillé dans
`android/gradle/dependency-locks/`. Les POM/AAR publics Billing ont été inspectés
le 3 octobre 2026 et ceux du parcours Google Auth le 5 octobre. Le SBOM conserve
les empreintes disponibles et leur contexte d’inspection. Une résolution
Gradle ne prouve pas la présence d’un composant dans l’application optimisée.

Les [POM Credential Manager](https://dl.google.com/dl/android/maven2/androidx/credentials/credentials/1.6.0/credentials-1.6.0.pom),
[Credential Manager Play Services Auth](https://dl.google.com/dl/android/maven2/androidx/credentials/credentials-play-services-auth/1.6.0/credentials-play-services-auth-1.6.0.pom)
et [Google ID](https://dl.google.com/dl/android/maven2/com/google/android/libraries/identity/googleid/googleid/1.2.1/googleid-1.2.1.pom)
du cache Gradle public ont été inspectés le 5 octobre 2026. Les deux AAR
AndroidX conservent leurs licences dans
`META-INF/androidx/credentials/credentials/LICENSE.txt` et
`META-INF/androidx/credentials/credentials-play-services-auth/LICENSE.txt`.
L’AAR Google ID contient `third_party_licenses.json` et
`third_party_licenses.txt` pour ses composants tiers ; ces textes ne changent
pas la licence SDK déclarée pour Google ID lui-même.

Le tableau recense également les six modules `com.google.android.gms`
supplémentaires de ce parcours, avec les versions résolues dans
`android/gradle/dependency-locks/app-patched.lockfile`. Les POM et AAR publics
de ces six versions ont été inspectés dans le cache Gradle le 5 octobre 2026.
Chaque POM déclare la licence SDK Android, et chaque AAR contient
`third_party_licenses.json` et `third_party_licenses.txt` pour ses composants
tiers. Les versions de base, basement, location, tasks et places-placereport
du tableau sont conservées. Cet inventaire des dépendances résolues doit
encore être rapproché du contenu du livrable optimisé, selon la portée du
SBOM décrite ci-dessous.

La licence déclarée par les POM Billing et Google Play services est une
licence SDK personnalisée. Les textes de licence et notices inclus dans
l’AAR Billing sont `third_party_licenses.json` et
`third_party_licenses.txt` ; ce dernier comprend notamment les conditions
« Android SDK Platforms » datées du 10 avril 2009 et des licences distinctes
pour les autres composants. Les [conditions SDK officielles](https://developer.android.com/studio/terms.html)
sont référencées par les POM. Les mentions Apache de composants tiers
conservent leur portée propre ; le SBOM laisse `licenseConcluded` à
`NOASSERTION` pour ces nouveaux paquets.

Les POM officiels [annotation 1.9.1](https://dl.google.com/dl/android/maven2/androidx/annotation/annotation/1.9.1/annotation-1.9.1.pom),
[collection 1.5.0](https://dl.google.com/dl/android/maven2/androidx/collection/collection/1.5.0/collection-1.5.0.pom)
et [javax.inject 1](https://repo.maven.apache.org/maven2/javax/inject/javax.inject/1/javax.inject-1.pom)
déclarent Apache-2.0 ; ils ont été contrôlés le 7 octobre 2026. Le SBOM corrige
l’ancienne absence déclarée de licence pour javax.inject. Les dépendances de
tests AndroidX et Coroutines Test déclarent Apache-2.0 ; JUnit 4.13.2 déclare
EPL-1.0. Le POM JSON-java 20240303 indique « Public Domain » : la conclusion
SPDX reste `NOASSERTION`, avec cette déclaration et son URL dans le SBOM.

## Ressources visuelles et noms de pays

| Ressource | Version locale | Licence et fichier conservé |
| --- | --- | --- |
| Archivo, police variable | 2.001, table de noms du TTF | OFL-1.1 ; `assets/fonts/Archivo-OFL.txt` |
| IBM Plex Mono, Regular et SemiBold | 2.3, tables de noms des TTF | OFL-1.1 ; `assets/fonts/IBMPlexMono-OFL.txt` |
| Noto Sans Arabic, police variable de repli | 2.012, table de noms du TTF | OFL-1.1 ; `assets/fonts/NotoSansArabic-OFL.txt` |
| Google Sans, police variable du bouton Google | 14.000, révision `08f2ac800`, table de noms du TTF | OFL-1.1 ; `assets/fonts/GoogleSans-OFL.txt` ; notice de marques `assets/fonts/GoogleSans-TRADEMARKS.md` |
| Logo Google « G » officiel | PNG public téléchargé le 5 octobre 2026 | Ressource de marque Google ; [règles Sign in with Google](https://developers.google.com/identity/branding-guidelines), sans licence open source attribuée au logo dans cet inventaire |
| Drapeaux Twemoji | v14.0.2 | CC-BY-4.0 ; `assets/licenses/TWEMOJI.txt` |
| Noms de pays Unicode CLDR | 47.0.0 | Unicode-3.0 ; `assets/licenses/UNICODE.txt` |

Archivo : Copyright 2020 The Archivo Project Authors
([projet amont](https://github.com/Omnibus-Type/Archivo)). IBM Plex Mono :
Copyright 2017 IBM Corp., nom réservé « Plex ». Les empreintes des trois TTF
figurent dans le SBOM ; leur révision de téléchargement amont n’est pas
consignée localement.

Noto Sans Arabic : Copyright 2022 The Noto Project Authors. Police variable
inchangée du [dépôt officiel Google Fonts](https://github.com/google/fonts/tree/8b0a1d0f5983c89bc2b93f1b5fb55f9e252744b5/ofl/notosansarabic),
révision `8b0a1d0f5983c89bc2b93f1b5fb55f9e252744b5`. Elle complète Archivo
et IBM Plex Mono pour les caractères arabes, persans et ourdous. Les sources
du [projet Noto Arabic](https://github.com/notofonts/arabic) sont référencées
par les métadonnées Google Fonts au commit
`6c8320740db19efbb3127c3697b0ee5d0fa62319`. Les URL de téléchargement et
empreintes du TTF et de sa licence sont conservées dans
`licenses/NotoSansArabic-source.json` et le SBOM.

Google Sans : Copyright 2025 The Google Sans Project Authors
([projet amont](https://github.com/googlefonts/googlesans)). Le TTF est copié
sans modification depuis le [dépôt officiel Google Fonts](https://github.com/google/fonts/tree/main/ofl/googlesans).
Sa licence OFL et sa notice de marques sont conservées avec la police dans
`assets/fonts/`. « Google » et « Google Sans » sont des marques de Google LLC ;
la licence de la police ne confère pas de droit général sur ces marques.
SHA-256 du TTF :
`d0a87d835a944b8b40d0e82a5651bb59ab97b936a2aeed5946eb57e7b2a3a90a`.

Le logo `assets/images/google-g.png` provient de la
[ressource officielle Google Identity](https://developers.google.com/static/identity/images/g-logo.png),
sans recoloration ni retouche. Il est utilisé uniquement pour le bouton de
connexion Google, selon les [règles de présentation Google](https://developers.google.com/identity/branding-guidelines).
Ces règles définissent notamment le logo en couleur, les proportions, le
texte et les thèmes du bouton ; elles ne sont pas assimilées à une licence
de logiciel libre. SHA-256 du PNG :
`d1ce9c2af0b10a7333abc99bc706f9a6a199e5b65bf3e3009624f076b8638e6a`.

Les illustrations de drapeaux proviennent de
[Twemoji](https://github.com/twitter/twemoji), arbre
`7a3dad4a4da30497093dab22eafba135f02308e1` du tag v14.0.2. Les PNG sont
copiés par `tools/prepare_country_assets.py`, sans retouche prévue par ce
script ; `assets/licenses/country-assets.json` en conserve les SHA-256.
Les noms CLDR proviennent de
[unicode-org/cldr-json](https://github.com/unicode-org/cldr-json) et alimentent
`lib/core/country_data.dart`. Les traductions additionnelles de l’application
ne sont pas présentées comme des copies intégrales de CLDR.

Le nom et l’emblème FuzeVPN relèvent des marques du projet ; ils ne sont pas
soumis au même droit de réutilisation que le code propre MPL. Les marques et
le logo Google restent distincts. Voir [LICENSING.md](LICENSING.md).

## Provenance native

L’AAR local WireGuard part du commit Android
`09b75c2bd37f749e2a8c85876394854113c74be7`. Il applique les patches de service
au premier plan et de démarrage protégé. **libwg-go est reconstruit** avec le
nouveau contrat JNI ; les autres bibliothèques restent celles de l’AAR officiel
vérifié. Les sources, patches et `.metadata.json` associés doivent rester avec
l’artefact. Le sous-module `wireguard-tools` possède ses propres notices ; la
licence Apache du tunnel Java ne décrit pas à elle seule tous les fichiers natifs.

L'AAR approuvé a pour SHA-256
`bf96422b21e086cf371154613f5250c8101568538ab40acb4ccbad09394e4811`.
Les quatre versions de `libwg-go.so` fixent leur socket UAPI local à
`/data/data/com.fuzevpn/cache/wireguard`. Cette adaptation de l'identifiant
installé conserve les sources Go, les patches et le contrat JNI. Les autres
bibliothèques natives et `classes.jar` sont identiques à ceux de l'AAR local
précédemment approuvé.

OpenVPN utilise l’option MPL-2.0 et le fournisseur XKey amont pour déléguer
ECDSA à Android Keystore. Les sources importées, archives et métadonnées sont
sous `android/app/src/main/cpp/third_party/`. Aucun patch cryptographique
FuzeVPN n’est appliqué au Core ou à OpenSSL. La licence OpenSSL complète est
également conservée dans `licenses/OPENSSL-APACHE-2.0.txt`.

Les commandes, contrôles de provenance, choix de licences et contenu du paquet
de sources sont décrits dans
[docs/NATIVE_DEPENDENCIES.md](docs/NATIVE_DEPENDENCIES.md).

## Développement et portée du SBOM

Les outils épinglés comprennent Android Gradle Plugin 9.3.0, Gradle 9.5.0,
Java 17, Android Platform 36, NDK 28.2.13676358, CMake 3.22.1 et Go 1.24.3.
`termux-elf-cleaner`, au commit
`7efc05090675ec6161b7def862728086a26c3b1f`, est un outil du build WireGuard
sous GPL-3.0-or-later ; il n’est pas une bibliothèque du runtime Android.
Les notices des outils restent avec l’environnement de construction.

Le SBOM reprend toutes les entrées de `pubspec.lock`, y compris
`flutter_test`, `flutter_lints`, leurs dépendances et les variantes iOS,
macOS, Linux, Windows et Web de `url_launcher`. Leur présence dans le lockfile
ne signifie pas qu’elles sont embarquées dans l’APK. Il recense aussi les
dépendances de tests Gradle explicites (JUnit, JSON, Coroutines Test,
AndroidX Test et UI Automator) et les modules du `go.mod` importé ; Wintun
est un support Windows, sans inclusion Android affirmée ici.

## Textes de licence des sources supplémentaires

Le contrôle du **7 octobre 2026** a ouvert les archives conservées, lu leurs
textes et comparé leurs empreintes au manifeste inchangé
`android/source-distribution/completeness.manifest.json`. Aucune archive ni
entrée native verrouillée n’a été modifiée.

| Source redistribuée | Licence principale et texte effectivement présent |
| --- | --- |
| Go 1.24.3, runtime et bibliothèque standard | BSD-3-Clause : `go/LICENSE` dans `go1.24.3.src.tar.gz` ; 18 autres licences de composants vendored conservées |
| `golang.org/x/crypto` v0.38.0 | BSD-3-Clause : `golang.org/x/crypto@v0.38.0/LICENSE` dans son ZIP |
| `golang.org/x/net` v0.40.0 | BSD-3-Clause : `golang.org/x/net@v0.40.0/LICENSE` dans son ZIP |
| `golang.org/x/sys` v0.33.0 | BSD-3-Clause : `golang.org/x/sys@v0.33.0/LICENSE` dans son ZIP |
| `golang.org/x/time` v0.7.0 | BSD-3-Clause : `golang.org/x/time@v0.7.0/LICENSE` dans son ZIP |
| WireGuard Go v0.0.0-20250521234502-f333402bd9cb | MIT : `golang.zx2c4.com/wireguard@v0.0.0-20250521234502-f333402bd9cb/LICENSE` dans son ZIP |
| Wintun v0.0.0-20230126152724-0fa3db229ce2 | MIT : `golang.zx2c4.com/wintun@v0.0.0-20230126152724-0fa3db229ce2/LICENSE` dans son ZIP ; source Windows, inclusion Android non affirmée |
| `github.com/google/btree` v1.1.2 | Apache-2.0 : `github.com/google/btree@v1.1.2/LICENSE` dans son ZIP |
| gVisor v0.0.0-20250503011706-39ed1f5ac29c | Apache-2.0 : `gvisor.dev/gvisor@v0.0.0-20250503011706-39ed1f5ac29c/LICENSE` dans son ZIP |
| `wireguard-tools` | GPL-2.0 : `android/third_party/wireguard-android/tunnel/tools/wireguard-tools/COPYING` ; alternatives MIT et netlink LGPL-2.1-or-later conservées dans les en-têtes |
| `termux-elf-cleaner` | GPL-3.0 : `android/third_party/wireguard-android/tunnel/tools/elf-cleaner/COPYING` ; option or-later conservée dans `elf-cleaner.cpp` |

Go et crypto/net/sys/time partagent le texte BSD-3-Clause SHA-256
`911f8f5782931320f5b8d1160a76365b83aea6447ee6c04fa6d5591467db9dad`.
WireGuard Go et Wintun ont le texte MIT SHA-256
`91276db973f25602d1aa43491f59cbc84cb88e6f151e1d0cc82a755563ce0195`.
Les chemins, origines et autres empreintes figurent dans le SBOM et le
manifeste conservé. btree, time, Wintun et gVisor accompagnent les sources
complètes de WireGuard ; leur présence ne constitue pas une inclusion Android.

**Complément extérieur au bundle natif** : `wireguard-tools/src/netlink.h`
déclare `LGPL-2.1+`, mais le dépôt amont importé ne fournit que le texte GPL-2.0.
Le texte LGPL 2.1 complet est donc joint dans
[licenses/WIREGUARD-NETLINK-LGPL-2.1.txt](licenses/WIREGUARD-NETLINK-LGPL-2.1.txt).
Il provient de la [distribution officielle SPDX v3.26.0 du texte FSF](https://raw.githubusercontent.com/spdx/license-list-data/v3.26.0/text/LGPL-2.1-or-later.txt),
consultée le 7 octobre 2026, sans modification ; SHA-256 :
`5749785c8bdefafcb5d798270ed0a967036fe2ca63dcedade1627565dfef81d2`.
L’URL GNU canonique était inaccessible lors du contrôle. Ce complément
s’applique au code netlink conservé et à son droit or-later ; il n’impose pas
une nouvelle licence au code propre de l’application et ne conclut pas le
régime d’un APK entier.

Les SDK Flutter/Android, NDK, JDK et CMake sont des prérequis externes à obtenir
séparément ; leurs distributions ne sont pas copiées dans ce dépôt. Le
`NOASSERTION` de leurs entrées décrit la limite de cet inventaire et la
provenance du poste, pas un texte manquant dans les sources redistribuées.

## Résultats de l’audit du 14 octobre

Les 106 composants ont un verdict et des preuves dans
[l’audit SPDX](docs/validation-evidence/licenses.json) et [Q030](docs/VALIDATION.md#q030).
Il reste une déclaration et 21 conclusions `NOASSERTION`, avec une raison
explicite par champ ; les copyright agrégés restent distincts des notices
fichier par fichier. Les accords SDK personnalisés sont identifiés par LicenseRef.

Archivo et les deux IBM Plex Mono sont byte-identiques aux fichiers du commit
Google Fonts `e9678a5385322c63730122ba464765baad83cfd8`. Le JDK installé est
Eclipse Adoptium **Temurin 17.0.20.1+1** : [Q031](docs/VALIDATION.md#q031).
Cette comparaison n’invente pas la provenance du téléchargement historique.
L’inventaire exhaustif des internes Flutter/transitifs réellement conservés
dans l’APK optimisé est **bloqué, Q033**, avec ses entrées requises
([détail](docs/VALIDATION.md#q033)).

## Diffusion

Conserver les textes de licence applicables, notices et attributions avec la
distribution, ainsi que les sources et modifications correspondantes pour
les composants concernés. Préparer les sources MPL exactes et les patches
avec leur ordre et leurs empreintes. La liaison statique ou l’inclusion dans
une AAR ne remplace pas ce travail de remise.

Pour chaque livraison, rapprocher cet inventaire des dépendances effectivement
résolues, du contenu de l’APK, de ses notices et de ses sources correspondantes.
Compléter les entrées `NOASSERTION` à partir des artefacts et licences effectifs,
puis enregistrer le SBOM et les empreintes propres à cette livraison.
