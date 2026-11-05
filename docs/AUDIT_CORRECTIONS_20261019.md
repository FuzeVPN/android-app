# Corrections de l’audit du 19 octobre 2026

Référence auditée : commit `a15bf81d3de3d3349d926380651d006ff24a4272`, version source `0.2.10+74016`.
Branche de travail : `audit/corrections-20261019`. La version de l’application n’est pas incrémentée par ce document.

Cette matrice suit les **49 constats consolidés** de l’audit. Les constats fusionnés gardent leur rattachement d’origine : A12-02 est compris dans AUTH-01. Les rapports et preuves de l’audit initial restent conservés.

Une correction de source et ses tests ciblés ne constituent pas une qualification du futur APK/AAB. Les preuves du 14/15 octobre restent datées ; les tests ARM natif, ARM32 dynamique, pages 16 Kio dynamiques, Google, achats et production ne sont pas réputés accomplis par les modifications de sources.

## Lecture des statuts

- **Corrigé dans les sources / tests ciblés passés** : le bilan indique la modification et les contrôles exécutés ; les limites d’intégration ou d’environnement restent applicables.
- **Limite historique documentée** : les limites de preuve sont explicites ; les données historiques manquantes ne sont pas reconstituées artificiellement.

## Matrice des constats

| Identifiant | Priorité auditée | Objet | État de correction et preuve |
| --- | --- | --- | --- |
| AUTH-01 | P1 | La déconnexion peut ne jamais commencer si une écriture du stockage échoue | Corrigé dans les sources, tests ciblés passés — Invalidation immédiate et purge sans rechiffrement ; tests Flutter axe02 et vrai magasin/JVM axe12 ; A12-02 inclus. |
| A04-01 | P1 | Un ticket Google authenticate peut être finalisé depuis le parcours claim | Corrigé dans les sources, tests ciblés passés — Finalité ticket/action comparée avant reprise et finalisation ; régressions de redémarrage bidirectionnelles, bilan 04. |
| API-01 | P2 | Une redirection interorigine transmet le contexte Google personnalisé | Corrigé dans les sources, tests ciblés passés — Redirections automatiques désactivées ; aucun rejeu automatique du contexte privé ; transport local HTTP/TLS testé, bilan 01. |
| API-02 | P2 | Des ouvertures TLS restent pendantes après le délai logique | Corrigé dans les sources, tests ciblés passés — TCP/TLS réellement annulés ; fermetures physiques et requête indépendante testées, bilan 01. |
| API-03 | P2 | Un délai JSON infini sort du contrat d’erreur API | Corrigé dans les sources, tests ciblés passés — Délais non finis refusés dans le contrat ApiException ; régressions parseur/API, bilan 01. |
| G03-01 | P2 | Le verrou d’authentification est perdu pendant un changement de compte | Corrigé dans les sources, tests ciblés passés — Propriétaire d’authentification conservé pendant changement de compte ; course de reprise tardive corrigée après revue ; 92 tests du lot invité, bilans 02/03. |
| G03-02 | P2 | Une ancienne reprise invitée reste autorisée après une connexion email | Corrigé dans les sources, tests ciblés passés — Auto-reprise désactivée durablement avant publication du compte inscrit ; 92 tests du lot invité après revue, bilan 03. |
| A04-02 | P2 | Les finalisations Google ignorent un Retry-After futur | Corrigé dans les sources, tests ciblés passés — Échéance serveur contrôlée par toutes les finalisations et minuterie UI ; tests contrôleur/widget, bilan 04. Google réel non qualifié. |
| A05-03 | P2 | Une ancienne lecture d’abonnement écrase un droit vérifié plus récent | Corrigé dans les sources, tests ciblés passés — Révision du droit empêchant une ancienne lecture d’écraser une vérification ; régressions, bilan 05. |
| A05-02 | P2 | La file d’événements d’un ancien compte retarde le nouveau | Corrigé dans les sources, tests ciblés passés — File d’événements isolée par session ; régressions dans les 48 tests contrôleur, bilan 05. |
| A05-01 | P2 | Une récupération de paiement peut laisser une attente permanente | Corrigé dans les sources, tests ciblés passés — Flow récupéré sans attente permanente sur reçu étranger ; régressions dans les 48 tests contrôleur, bilan 05. |
| A06-F01 | P2 | Les reçus suspendus sont exclus de la découverte des achats | Corrigé dans les sources, tests ciblés passés — Lecture native inclusive des reçus suspendus et booléen strict ; tests SDK/modèle/pont et accès serveur inactif, bilans 05/06. Aucun achat réel. |
| A07-01 | P2 | Annuler OpenVPN n’interrompt pas l’attente native de connexion | Corrigé dans les sources, tests ciblés passés — Signal d’annulation avant mutex et premier résultat rendu promptement ; 36 JUnit+6 harness axe09, 47 checks et contrôle négatif axe11. Réconciliation Dart axe02 additionnelle, pas une recette terrain. |
| A08-01 | P2 | Le premier handshake de reprise WireGuard est consommé comme référence | Corrigé dans les sources, tests ciblés passés — Timestamp réel de génération réseau et première preuve fraîche admise ; 40 tests JVM du lot, bilan 08. |
| A08-02 | P2 | Un handshake valide peut être rejeté après un retard du scheduler | Corrigé dans les sources, tests ciblés passés — Handshake lié à la nouvelle instance et au pair, indépendant de l’horloge murale ; retard réel du harness testé, bilan 08. |
| A09-01 | P2 | Une destruction JNI tardive laisse un handle périmé et bloque les reprises | Corrigé dans les sources, tests ciblés passés — Future de destruction possédé conservé et réconcilié après délai ; destruction tardive testée avec JNI simulé, bilan 09. |
| A09-02 | P2 | Une demande CSR refusée ou une révocation obsolète efface la preuve du tunnel | Corrigé dans les sources, tests ciblés passés — Preuve invalidée seulement après admission CSR/révocation ; cas refusés et obsolètes testés, bilan 09. |
| NAT-01 | P2 | Une demande d’arrêt très précoce peut être perdue dans OpenVPN Core | Corrigé dans les sources, tests ciblés passés — Signal Stop persistant avant disponibilité Core ; harness des sources natives, bilan 10. Pas de tunnel terrain. |
| NAT-02 | P2 | Des appels JNI suivent une exception d’allocation non traitée | Corrigé dans les sources, tests ciblés passés — Exceptions Java d’allocation arrêtent la suite JNI ; injections dans les entrées JNI originales, bilan 10. |
| NAT-03 | P2 | Des exceptions C++ peuvent franchir la frontière JNI | Corrigé dans les sources, tests ciblés passés — Barrières noexcept et nettoyage sur exceptions JNI/worker ; 67+32 cas hôte du lot natif, bilan 10. |
| NAT-04 | P2 | Une politique DNS avancée peut être acceptée sans être appliquée | Corrigé dans les sources, tests ciblés passés — Options DNS avancées non appliquées refusées explicitement ; tests natifs, bilan 10. Contrat serveur réel non exercé. |
| A11-01 | P2 | Une ancienne action de tuile peut remplacer une commande VPN récente | Corrigé dans les sources, tests ciblés passés — Epoch pris à réception et validations avant worker ; six échecs du contrôle négatif corrigés, 47 tests JVM du lot, bilan 11. |
| A11-02 | P2 | Les événements autonomes n’actualisent pas correctement la tuile | Corrigé dans les sources, tests ciblés passés — Tuile active, demande de rafraîchissement lors d’événements autonomes ; tests JVM, bilan 11. Instrumentation appareil non exécutée. |
| A12-01 | P2 | Une erreur Keystore transitoire supprime un enregistrement valide | Corrigé dans les sources, tests ciblés passés — Enregistrements conservés sur panne transitoire/clé absente ; vrai magasin et AES-GCM synthétique testés, 27 JVM/Gradle du lot, bilan 12. |
| A13-01 | P2 | Un refus de diagnostics non sauvegardé revient à true après redémarrage | Corrigé dans les sources, tests ciblés passés — Marqueur de refus indépendant du chiffrement ; régressions natives et Flutter, bilans 12/13. Échec de toute écriture durable reste signalé. |
| A13-03 | P2 | Des causes OpenVPN connues disparaissent des diagnostics | Corrigé dans les sources, tests ciblés passés — Catégories natives mappées au schéma diagnostics v1 ; tests, bilan 13. |
| A14-01 | P2 | Un identifiant de catalogue dupliqué peut changer la destination confirmée | Corrigé dans les sources, tests ciblés passés — Catalogue aux IDs dupliqués refusé par ApiClient ; confirmation/UI/contrôleur testés, 148 tests du lot, bilan 14. |
| A15-01 | P2 | Un changement de largeur efface les saisies de connexion | Corrigé dans les sources, tests ciblés passés — État des formulaires conservé aux deux franchissements responsive ; tests contrôleurs/saisies/largeur, bilan 15. |
| A15-02 | P2 | Des erreurs de formulaire deviennent illisibles à 200 % | Corrigé dans les sources, tests ciblés passés — Erreurs de validation affichées intégralement à 320dp/200% avec police embarquée ; tests RenderParagraph, bilan 15. |
| A16-01 | P2 | La date de prélèvement perd le format régional britannique | Corrigé dans les sources, tests ciblés passés — Format régional de date conservé, attentes de widgets actualisées ; 200 tests l10n/premium du lot, bilan 16. |
| A17-01 | P2 | L’exporteur valide un arbre sans les trois points d’entrée applicatifs | Corrigé dans les sources, tests ciblés passés — Entrées applicatives et références transitives exigées ; 26 tests exporteur et couverture réelle 3132/3132 au bilan 17. |
| D18-01 | P2 | Un correctif amont de concurrence WireGuard est absent | Sources et AAR reconstruits/contrôlés — WireGuard 2631ce99, ancien défaut reproduit puis réponse périmée refusée ; 5 suites Go et 27 tests policy, bilan18. Nouvelle bibliothèque non exécutée sur Android. |
| D18-02 | P2 | Le runtime Go embarqué 1.24.3 est hors support | Sources et AAR reconstruits/contrôlés — Go1.26.9, 4 ABI ELF/JNI, 2 AAR identiques, sources rapprochées et patches contrôlés, bilan18. Tests terrain/ARM de la nouvelle construction restent à faire. |
| D18-03 | P2 | Le SBOM de sources ne décrit pas le graphe runtime release | Graphe runtime et preuves distinctes livrés — 74 modules Maven runtime, 50 PURL exacts corrigés ; 35 tests et régénérations identiques, bilan 07. Q033 inventaire R8/Flutter demeure limité. |
| T19-01 | P2 | Aucun pipeline de validation n’est versionné dans le dépôt | Pipeline versionné, exécution CI distincte — Runner unique et workflow self-hosted livrés ; passage local canonique 03 réussi et addendum Python 115 cas après ajustement du helper isolé. Aucun run CI distant exécuté, bilan 19. |
| T19-02 | P2 | Six tests instrumentés exigent une préparation externe non livrée | Préparation reproductible livrée, APK isolés compilés — APK application/test x64 compilés ; IDs et signatures debug vérifiés statiquement ; six contrôles de garde finaux passés. Instrumentation appareil explicitement non exécutée, bilan 19. |
| API-04 | P3 | Le corps intermédiaire d’une redirection échappe au plafond de 1 Mio | Corrigé dans les sources, tests ciblés passés — Corps intermédiaires bornés dans le transport ; régressions locales, bilan 01. |
| AUTH-02 | P3 | Une réponse de reset obsolète modifie l’état busy d’un autre cycle | Corrigé dans les sources, tests ciblés passés — Propriété du cycle conservée pour le busy de reset ; régressions ciblées, bilan 02. |
| NAT-05 | P3 | Une copie temporaire tls-crypt-v2 n’est pas effacée explicitement | Corrigé dans les sources, tests ciblés passés — Copie tls-crypt-v2 supprimée et temporaires effacés par garde ; tests du validateur natif, bilan 10. |
| A11-03 | P3 | La tuile effectue des lectures Keystore sur le thread principal | Corrigé dans les sources, tests ciblés passés — Lectures Keystore déportées sur IO et résultats périmés ignorés ; tests du chargeur de production, bilan 11. |
| A12-03 | P3 | Les limites de longueur appareil et slot de stockage ne concordent pas | Corrigé dans les sources, tests ciblés passés — Capacité des slots alignée sans renommer les données ; bornes 158/159/160/161 vérifiées, bilan 12. |
| A13-02 | P3 | L’expiration du rapport local dépend de la propriété consultée | Corrigé dans les sources, tests ciblés passés — Expiration appliquée aux accès et export ; régressions dans les 116 tests Flutter ciblés, bilan 13. |
| A14-02 | P3 | La recherche GB ne trouve pas un pays fourni comme UK | Corrigé dans les sources, tests ciblés passés — Alias pays UK/GB commun à la recherche et présentation ; régressions, bilan 14. |
| A16-02 | P3 | Le titre après révocation affirme encore une limite de deux appareils | Corrigé dans les sources, tests ciblés passés — Titre de quota rendu générique après révocation ; régressions catalogues/widgets, bilan 16. |
| A16-03 | P3 | Le compteur Filipino affiche 1 pour plusieurs nombres d’événements | Corrigé dans les sources, tests ciblés passés — Compteur Filipino corrigé pour plusieurs valeurs ; comparaisons catalogues et tests de locale, bilan 16. |
| A16-04 | P3 | Certains chevrons RTL sont inversés deux fois | Corrigé dans les sources, tests ciblés passés — Miroir directionnel unique et chevrons d’emplacements vérifiés ; bilans 14/16. |
| A16-05 | P3 | Les noms contenant des accolades sont réinterprétés après traduction | Corrigé dans les sources, tests ciblés passés — Remplacement anonyme après interpolation retiré ; valeurs contenant des accolades testées, bilan 16. |
| A20-D1 | P3 | Deux originaux historiques pointent vers des documents serveur modifiés | Limite historique documentée — Originaux exacts non retrouvés ; outil de copie vérifiée et notice de réserve ; Q029 bloqué conservé. |
| A20-D2 | P3 | Les assertions d’un script AAB archivé disparaissent avec Python optimisé | Gardes corrigées, tests ciblés passés — Outil maintenu distinct, preuves liées au commit et aux binaires, inventaire complet ; 29 tests synthétiques normal et -O ; aucune action de livraison. |

## Régressions corrigées après les revues

Ces compléments ne créent pas de nouveaux identifiants dans les 49 constats initiaux :

- Reprise invitée A retardée après une authentification B : génération d’authentification, admission sérialisée et contexte invité stable corrigés par les axes 02/03. Les neuf entrelacements supplémentaires portent le lot ciblé invité à 92 tests. La revue et ses journaux sont conservés avec le bilan 03.
- Consommateur des preuves de livraison : la revue 17 a renforcé le nouvel outil A20. Les pièces sont reliées au commit/arbre/version et aux hashes des fichiers actuels ; l’inventaire vide, partiel ou dupliqué et une fin d’export interrompue sont refusés. Le schéma réel conservé a été vérifié : deux artefacts AAB/APK universel et sept fichiers livrables. Les 29 tests synthétiques passent en mode normal et optimisé ; aucun cycle de livraison réel n’a été exécuté par cet outil.

## Q025 — Évolution du parcours Google

La résolution native Turnstile est implémentée pour les finalisations Google register/claim, après rapprochement du contrat serveur existant et de sa clé publique. Le widget est déclenché explicitement après refus du serveur, puis le formulaire reste à confirmer manuellement. Les gardes de contexte/finalité/identité et la durée de vie limitée du jeton sont conservées. Le périmètre ne comprend pas les formulaires classiques d’inscription ou de réinitialisation.

Les tests locaux du contrôleur, du canal, de l’API et de l’interface passent selon les bilans 04/11 ; la revue indépendante 12 est conservée. Q025 reste bloqué dans le registre historique du 14 octobre. Son état courant est implémenté et testé dans les sources ; la recette Google/Cloudflare/WebView native réelle reste à faire. Le contrat serveur n’est plus un prérequis manquant. Voir [le contrat Google courant et ses limites](GOOGLE_AUTH.md).

## Preuves de livraison et documents historiques

Voir [les réserves EAPI043 et le remplacement du script AAB archivé](RELEASE_EVIDENCE.md). Les fichiers `docs/VALIDATION.md`, `docs/validation.json`, les extraits de `docs/validation-evidence/`, les livrables signés et le script ponctuel archivé conservent leurs octets historiques.

Les corrections documentaires décrivent la branche de travail. Elles ne remplacent pas un reçu de construction, une signature, une recette Play/Google ni une observation de production. Les bilans externes de correction et leurs journaux sont conservés dans le dossier `corrections-20261019` de la reprise locale ; ils ne sont pas intégrés aux preuves historiques.

## Vérifications finales

Le passage canonique **03** est terminé avec succès sur les sources figées après les corrections Q025 et la course d’authentification. Les passages 01/02 restent des étapes intermédiaires conservées ; leurs résultats ne sont pas attribués au dernier état.

| Contrôle local exécuté | Résultat |
| --- | --- |
| Flutter | 1976 cas réussis, aucun échec/ignoré |
| Polices embarquées | 7 cas réussis, répétitions de cas Flutter existants avec assertions supplémentaires |
| Python/outils | 115 cas réussis, aucun ignoré |
| JVM | 275 cas dans 36 classes, aucun échec/erreur/ignoré |
| buildSrc | 76 assertions dans 3 suites |
| Gate WireGuard / intégrité | 16 / 4 réussites |
| Démarrage WireGuard protégé | 5 contrôles réussis |
| Natifs OpenVPN | 67 cas adaptateur et 32 cas JNI sur hôte ; compilation de 3 ABI Android |
| Lint | 0 Error/Fatal, 3 avertissements |

Les cas de polices ne sont pas ajoutés au total Flutter comme de nouveaux scénarios distincts. Les suites locales avec doubles ou exécutables hôte ne sont pas des essais de tunnel sur appareil.

## Compilations de contrôle et identité des sources

Le passage canonique 03 et les compilations normales utilisent 3093 entrées de construction/test figées, hors documentation. SHA-256 de cet ensemble : `f282afafe9124dc0c3486d5385fa59b494716d69a0600678170aad1f41dea093`. Ces fichiers n’appartiennent pas à un nouveau commit de livraison propre ; le commit de base ne leur est pas attribué comme s’il les contenait.

| Artefact de contrôle | Taille (octets) | SHA-256 |
| --- | ---: | --- |
| APK debug ARM de contrôle | 141987088 | `e53addd46b37e0dfedd8848ebcd5258cb0e8a5dfeddd76af0af1489c6dec2c64` |
| AAB release ARM non signé | 65869893 | `f6ca8698ad34420c03ea2923e9aaee4d7aef1f45efaa14303c15e6ca4c58953d` |
| APK application isolée x64 | 86933367 | `0d3411b6e6ea3c397d614cc03b3acaa011995ba05ea53ce25946ae276e44db4d` |
| APK instrumentation isolée | 515807 | `a31f54535c8687231c0cf1cdb153816c7c51119e329e77afff5df1283a7a33f7` |

Après ce gel, le seul changement de construction/test est le helper `tools/isolated_instrumentation.gradle` : sa garde accepte maintenant `--rerun` à la position des deux tâches de packaging debug autorisées. SHA-256 avant : `668e5b86b8ffef7d1a389d70a148a48df40187033fb134c767939404ed641847` ; après : `2427a168df726b225fdeaaf541340ce66fca750f4102a496ead9ec7817e4e25d`. Il n’est pas consommé par les compilations normales. Les 115 tests Python ont été rejoués avec succès après ce changement et les deux APK isolés ont compilé.

L’ensemble final conserve 3093 entrées et porte le SHA-256 `236de66b2e7445da6c6423b3a8ccc2aadb6c637fcfea1117aaa23e14777ea8ef`. Les 2956 entrées applicatives restent strictement identiques pendant les validations et les compilations (SHA-256 `280e781f2fc7209e5a79480147483ed3ab9f3841e9c03dac3c8eba6ae5d9b771`). Le reçu canonique 03 reste daté et inchangé ; son succès n’est pas réécrit comme s’il avait exécuté le helper modifié.

Le helper final a aussi passé six contrôles Gradle : une configuration admise et cinq refus attendus, comprenant une tâche release, un `--rerun` mal placé ou dupliqué et une publication. Les métadonnées et signatures debug des deux APK isolés sont vérifiées statiquement ; l’instrumentation n’est pas exécutée.

Le bundle est validé structurellement par bundletool ; son manifeste conserve `com.fuzevpn`, version `0.2.10+74016`, sans signature d’envoi. L’inventaire natif v2 reproduit la suppression des symboles par le NDK sur des copies des six bibliothèques WireGuard, puis constate leur identité avec le paquet et les intermédiaires Gradle. Le contrôle v1 comparait directement des fichiers avant/après cette transformation : son échec reste conservé et n’est pas effacé par le résultat corrigé. Cette vérification ne démontre pas la reproductibilité complète source-vers-binaire.

Les APK debug et le bundle release non signé sont des compilations de contrôle conservées avec leurs reçus. La préparation isolée utilise les identifiants `com.fuzevpn.recoverytest` et `com.fuzevpn.recoverytest.test`. Aucun de ces fichiers n’a été installé ou exécuté sur appareil par cette validation ; aucun nouvel APK/AAB n’a été signé avec la clé d’envoi ou publié.

Le [SBOM de livraison](SBOM.release.md) distingue le binaire historique, les sources corrigées et le bundle non signé issu de l’arbre de travail. Les nouvelles preuves ne sont pas reportées rétroactivement sur l’ancienne livraison.

L’audit initial conserve ses 453 fichiers inchangés. Les 29 tests synthétiques des nouveaux outils de preuve/livraison passent en mode normal et optimisé ; le cycle réel de ce nouvel outil AAB n’a pas été exécuté.

## Limites de qualification restantes

Le workflow CI est versionné ; aucun passage distant n’est déclaré exécuté. L’instrumentation native sur appareil, les tunnels réels avec les nouveaux moteurs, ARM natif/ARM32 et pages 16 Kio dynamiques, Google/Cloudflare/WebView et achats réels restent à qualifier séparément. Une compilation réussie et les contrôles statiques du bundle ne remplacent pas ces recettes.

Les deux originaux EAPI043 restent indisponibles dans la recherche documentée ; le reçu public conservé et les limites historiques restent inchangés. Aucun service de production ni politique serveur n’a été modifié par cette correction.
