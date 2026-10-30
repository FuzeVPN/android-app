# Corrections du réaudit du 28 octobre 2026

Cette note suit les **11 écarts distincts du réaudit : 10 P2 et 1 P3**.
Ils sont corrigés dans les sources et l'outillage, avec tests ciblés, relectures
et validation locale intégrée. La version reste **0.2.10+74016**.

Le registre de référence est le fichier local
`reaudit-20261028/VERIFICATION.json`. Les reçus actuels sont conservés dans
`corrections-20261028/`, hors du dépôt distribué : `agents/<lettre>-corrections`
et `agents/<lettre>-review` décrivent les changements, tests, limites et
contre-exemples. Les [corrections du 19 octobre](AUDIT_CORRECTIONS_20261019.md)
et les [preuves de qualification historiques](VALIDATION.md) gardent leurs
dates et leurs périmètres.

## Matrice des onze écarts

« Corrigé » décrit le comportement vérifié localement. Les frontières simulées
et les limites de qualification sont précisées après la matrice.

| Identifiant | Priorité | Correction et comportement vérifié | Test versionné ; auteur / revue |
| --- | --- | --- | --- |
| RA-A06-01 | P2 | Reset et reprise invitée s'excluent avant admission ; les écritures natives déjà soumises sont réconciliées après annulation ou erreur tardive, sans nettoyer une session plus récente. | [Admission invitée](../test/guest_controller_test.dart) ; A / K |
| RA-A08-01 | P2 | L'échéance du claim 429 est mémorisée avant la relecture `/me` et conservée si cette relecture échoue ou tarde ; les bornes 120 s − 1 µs et 120 s sont testées. | [Retry-After Google](../test/google_auth_controller_test.dart), [admission réelle du contrôleur](../test/support/google_controller_cases.dart) ; A / K |
| B-02-PROXY | P2 | Les proxys d'environnement HTTP et HTTPS fonctionnent de nouveau. Le CONNECT et le TLS possédés restent annulables physiquement ; confiance, hostname, SNI, pooling et client injecté sont préservés, sans repli direct implicite. | [Transport proxy](../test/core/io_api_http_proxy_test.dart) ; B / J |
| B-03-NUMERIC | P2 | Les nombres non finis ou hors bornes sont refusés avant conversion ; les réponses de succès malformées produisent `ApiProtocolException` avec leur statut HTTP initial. | [Frontières numériques API](../test/core/api_numeric_response_test.dart) ; B / J |
| B-10-WEBVIEW | P2 | Une navigation commencée attend le document embarqué courant malgré une URL nulle ou précédente, sans évaluer l'ancien document ni prolonger le délai global ; navigation principale et origines restent contrôlées. | [Bridge Turnstile hôte](../android/app/src/testHost/turnstile/NativeTurnstileBridgeHostTest.kt) ; D / N |
| R11-01 | P2 | Lectures d'abonnement et vérifications de reçus partagent une file par scope ; le droit est appliqué avant la fin de chaque opération. Les réponses d'un ancien scope ou antérieures à une récupération serveur ne remplacent plus le droit courant. | [Ordre des snapshots](../test/billing_snapshot_ordering_test.dart), [facturation](../test/billing_controller_test.dart) ; C / L |
| R13-01 | P2 | Un propriétaire SDK absent ou vide reste inconnu (`null`) et ne fait plus échouer une liste mixte de reçus. Aucun propriétaire courant n'est substitué et aucun droit n'est accordé localement. | [Parseur Dart](../test/play_billing_purchase_test.dart), [adaptateur SDK](../android/app/src/test/kotlin/com/fuzevpn/android/PlayBillingPurchasesTest.kt) ; C / L |
| R15-01 | P2 | La reprise conserve une preuve positive antérieure à la perte et suit la génération réseau ainsi que l'écart horloge murale/temps écoulé. Le handshake ancien 5000, perte 6000, retour 1000, lecture 6001 et RX inchangé reste `RECOVERING`. Le premier handshake réellement frais reste admis. | [Horloge et reprise WireGuard](../android/app/src/test/kotlin/com/fuzevpn/android/WireGuardClockRecoveryTest.kt), [policy](../android/app/src/test/kotlin/com/fuzevpn/android/WireGuardRecoveryPolicyTest.kt) ; I + intégration E / M |
| E22-N01 | P2 | Une génération de publication et des gardes atomiques empêchent les erreurs, succès et publications tardives d'anciennes commandes de tuile/système d'écraser une commande récente ; l'arrêt explicite conserve son autorité. | [Commandes système/tuile](../android/app/src/test/command-epoch/SystemVpnCommandEpoch.template.kt) ; E / M |
| F-RESIDUEL-A13-03 | P2 | `tun_plan_rejected` devient `openvpn_network_configuration_failed` et `tun_establish_failed` devient `tun_failed`. Les 206 catégories du schéma v1 restent inchangées ; les codes inconnus restent filtrés. | [Producteurs diagnostics](../test/core/diagnostics_native_producers_regression_test.dart) ; F / O |
| R35-01 | P3 | Chaque `testsuite.timestamp` est contrôlé dans une fenêtre UTC bornée, en complément du mtime. Les anciens XML recopiés sont refusés ; le fuseau du producteur doit être explicite ou déclaré, sans réécriture du XML. | [Validateur de preuves](../tools/tests/test_validation_support.py), [contrat instrumentation](DEVELOPMENT.md#préparation-reproductible-de-linstrumentation-isolée) ; G / O |

Les contre-exemples d'origine restent inchangés dans le réaudit. Les suites
versionnées expriment le comportement corrigé ; les contrôles négatifs sur
copies antérieures et toutes les tentatives intermédiaires sont conservés
avec les bilans locaux. Ils ne sont pas réattribués à la source finale.

## Sources et validation intégrée

Le gel `SOURCE-INPUTS-FROZEN.json` identifie **3 116 entrées de construction,
outillage et tests, hors documentation**, dans l'arbre de travail
`fix/reaudit-20261028`. SHA-256 de l'ensemble :

`be6d1ac165574696463cc6127173b4b452b5f53a4aa9682b08c945d045aefb10`.

Ces corrections sont non committées. Le commit de base
`a15bf81d3de3d3349d926380651d006ff24a4272` n'est pas présenté comme contenant
les corrections ni comme un commit de livraison. Le relevé de l'ensemble des
entrées est distinct du snapshot partiel de dépendances décrit dans le SBOM.
Pour la comparaison finale avant/après, comprenant la préparation isolée,
consulter le registre local `corrections-20261028/CORRECTIONS.json`.

Le passage **H / validation-01** est terminé avec succès. Sa synthèse a été
produite le 28 octobre à 01:43:57 UTC. Son `summary.json` porte le SHA-256
`bdd6c174290036828bc9325e8e459f4f0981b44e2f96797ab82ca70d6bc76943` ;
`steps.json` porte
`298ad2fc7fa3fc22262045d7e963e3e180f9ef094c743c37e86e70234c3296f4`.
Le reçu `checks/H/validation-01-link.json` lie ces sorties au gel des sources.
H a ensuite vérifié les 3 116 empreintes inchangées après les constructions
normales et isolées ; le relevé `SOURCE-INPUTS-AFTER.json` conserve le même
SHA-256 d'ensemble.

| Contrôle réellement exécuté | Résultat |
| --- | --- |
| Analyse Flutter | Sans problème |
| Flutter | 2 138 tests réussis, aucun échec ni ignoré |
| Polices embarquées | 7 répétitions de cas Flutter avec assertions supplémentaires |
| Python/outils | 136 tests réussis, aucun ignoré |
| JVM Android | 293 tests dans 37 classes, aucun échec, erreur ni ignoré |
| buildSrc | 76 assertions dans 3 suites |
| Bridge Turnstile hôte | 35 JUnit et 15 scénarios JavaScript réussis |
| Commandes système/tuile hôtes | 14 JUnit réussis |
| Garde WireGuard / intégrité des dépendances | 16 / 4 contrôles réussis |
| Lint Android | 0 Error/Fatal ; 3 avertissements : 1 StaticFieldLeak et 2 UseKtx |

Ces trois avertissements sont identiques à ceux du passage validation-02 du
réaudit ; le contrôle de comparaison est conservé par H.

Tous les pas requis du runner ont un code de retour nul, notamment les
contrôles natifs OpenVPN et leur compilation Android, la provenance, l'export
des sources, le registre de preuves et la configuration isolée. Les suites
`turnstile-bridge` et `command-epochs`, hors découverte JUnit Gradle, sont
désormais obligatoires et leurs reçus sont consommés par la synthèse.
Node.js v24.16.0 a été utilisé pour les scénarios JavaScript ; le runner
enregistre sa version et échoue s'il est absent, sans installation implicite.
Le [guide de développement](DEVELOPMENT.md#validation-locale-unique-et-ci)
décrit les paramètres et les prérequis.

Les tests ciblés des auteurs et les sondes des relecteurs recouvrent les mêmes
scénarios que certaines suites intégrées. Ils ne sont pas additionnés en un
total de tests indépendants ; les sept cas de polices restent des répétitions.
Le résultat intégré conserve explicitement `instrumentation: not executed`.

## Compilations de contrôle et inventaire du nouvel AAB

Après la validation intégrée, H a construit les deux archives ARM ci-dessous
depuis le même gel de 3 116 entrées. Elles sont conservées dans
`corrections-20261028/checks/H/normal-01/` avec
`debug-release-build.result.json` et `artifact-checks.json`.

| Artefact local | Taille (octets) | SHA-256 |
| --- | ---: | --- |
| `app-debug-74016-corrected.apk` | 142 018 380 | `d4fd41120d59cdf74a4e3adac836efc541488f81b2a55976d9658463b35c8b26` |
| `app-release-74016-corrected-unsigned.aab` | 65 908 939 | `7b19aff4443c689cf657b64659690b09552f7a3e8148106e0a1cd607919136c5` |

Le manifeste du bundle conserve `com.fuzevpn` et `0.2.10+74016` ; bundletool
valide sa structure et aucune signature JAR n'y figure. L'APK porte seulement
la signature debug Android standard vérifiée. Ces archives sont des contrôles
locaux, sans installation, signature d'envoi ni publication.

La préparation isolée x64 a également compilé l'application et son APK de
tests. Le reçu `checks/H/isolated-01/artifact-checks.json` vérifie les packages
`com.fuzevpn.recoverytest` et `com.fuzevpn.recoverytest.test`, le package cible
de l'instrumentation, leurs signatures debug et l'intégrité des archives.
Ces APK restent non installés et l'instrumentation non exécutée.

| Artefact isolé, sous `checks/H/isolated-01/` | Taille (octets) | SHA-256 |
| --- | ---: | --- |
| `app-debug.apk` | 86 964 599 | `3b8e4109aff26c9a53b1518cd0fddd315bda0fdb866bd882e63771a400d262d6` |
| `app-debug-androidTest.apk` | 515 775 | `68ab2b073297c8e620657f4148ed27e98f47256ba212ec908e6ac2ed376815a4` |

Le reçu final `runtime-inventory-v3/result.json` inventorie 14 ELF et reproduit
exactement six transformations de suppression de symboles NDK entre l'AAR
approuvé et l'AAB. Les douze bibliothèques de moteurs sont identiques à celles
du contrôle du 19 octobre ; les deux `libapp.so` ont changé. Les sept ELF
ARM64 ont des alignements d'au moins 16 Kio. Les alignements ARM32 à 4 Kio
observés sont consignés avec leur identité historique ; cette inspection
statique ne qualifie pas une exécution sur appareil 16 Kio ou ARM32.
L'échec initial de la garde H appliquée trop largement à ARM32 est conservé
dans `runtime-inventory-v2/failure.json`, sans modification de l'application.

Le [nouveau document SPDX](SBOM.release.corrections-20261028.spdx.json), créé le
28 octobre à **01:49:25 UTC**, porte le SHA-256 :

`e1c5e441729c203c6fe67d1aa468b89999ee4b18101d4b3748d40f84e013ea8c`.

Il observe cet AAB précis sous le label `workingtree-fix20261028` et le scope
`unsigned-worktree`. Il contient 137 paquets et 693 fichiers observés :
677 entrées de l'AAB et 16 entrées de l'AAR, décrites comme archives distinctes.

Les 17 entrées du snapshot partiel de dépendances sont identiques à celles
du snapshot final du 19 octobre. Elles décrivent notamment 74 coordonnées
Maven runtime sélectionnées, sans prouver leur conservation après R8.
Le runtime **Go 1.26.9** et WireGuard
**v0.0.0-20261006164505-2631ce99a06f** sont également lus directement dans
les deux `libwg-go.so` ARM de ce nouvel AAB. Ces dépendances n'ont pas été
mises à niveau par les corrections du 28 octobre.

Le générateur existant `tools/generate_release_sbom.py` est inchangé
(SHA-256 `289cbe314b2840e090d147e15315eaf8448b74106588c99b3ab6a99019fbce81`).
Les entrées exactes et le générateur sont figés dans
`checks/P/sbom-source-inputs/` du dossier local de correction. La régénération
`checks/P/sbom-reproduction-02.json` a réussi avec des octets identiques ;
les tentatives préparatoires antérieures restent conservées.

Le SBOM distingue le snapshot de dépendances et l'archive observée ; il
n'atteste pas leur équivalence source-vers-binaire, la totalité des internes
Flutter, les licences ni l'absence de vulnérabilités. Son snapshot partiel
n'identifie pas les corrections applicatives : celles-ci sont reliées au
gel complet et aux reçus H. Les quatre SPDX existants et le
[guide SBOM du 19 octobre](SBOM.release.md) restent inchangés.

## Conservation et limites

Les dossiers locaux `audit-20261019`, `corrections-20261019` et
`reaudit-20261028`, leurs reproductions, reçus et livrables gardent leurs
octets. Les anciennes preuves ne qualifient pas rétroactivement les
corrections du 28 octobre. Le [registre historique](VALIDATION.md), les trois
SPDX release antérieurs, le SBOM de sources limité et le guide SBOM daté du
19 octobre ne sont pas réécrits.

Le contrôle H final constate respectivement 453/453, 3 751/3 751 et
1 671/1 671 fichiers historiques conformes dans ces trois dossiers.

Les contrôles locaux utilisent, selon la suite, des API, stockages, moteurs,
statistiques, horloges et frontières Android simulés. Aucun appareil ni VM
n'a été démarré, aucune application installée, aucun tunnel réel, compte
Google, défi Cloudflare/WebView réel, achat Play, RTDN ou serveur de
production n'a été exercé par cette correction. Cette validation n'a effectué aucune publication, signature
d'envoi ou modification de données utilisateur.

La sérialisation de facturation peut retarder les opérations suivantes du
même scope jusqu'à la fin d'une requête lente ; un changement de scope
détache cette attente. Les cooldowns Google ne gagnent pas de persistance
après destruction du processus.

Pour WireGuard, les observations discrètes ne permettent pas de distinguer
un aller-retour complet de l'horloge et une mise à jour de handshake jamais
échantillonnée, tous deux entièrement intervenus entre deux observations.
Les égalités à la milliseconde, l'absence de preuve positive antérieure et
les inventaires réseau tardifs restent traités de manière conservatrice.

Le contrôle de XML d'instrumentation vérifie uniquement les fichiers fournis
et leur cohérence temporelle. Il ne lance pas les tests et n'authentifie pas
une campagne réelle. Les qualifications sur ARM natif, pages 16 Kio, réseau,
Always-On/Doze/OEM, stockage physique, Google/Cloudflare et achats réels
restent distinctes, ainsi que la reproductibilité binaire complète.

