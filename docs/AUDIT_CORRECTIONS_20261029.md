# Corrections de l'audit complet du 28 octobre 2026

Cette note suit les **81 écarts confirmés de l'audit complet : 1 P1, 9 P2 et
71 P3**. Ils ont été corrigés du 29 au 30 octobre 2026 dans les sources,
l'outillage et la chaîne d'outils. Chaque correction a des tests versionnés,
une relecture adversariale, un réaudit final indépendant et deux validations
locales intégrées. La version reste **0.2.10+74016**.

Le registre de référence est le fichier local
`audit-complet-20261028/VERIFICATION.json` (révision 2). Les reçus sont
conservés dans `corrections-20261029/`, hors du dépôt distribué. On y trouve :
- les rapports de correction par lot ;
- les journaux d'échec avant correctif et de succès après correctif ;
- les preuves sur la copie d'avant corrections, et les mutants ;
- le réaudit final ;
- les sorties des validations.

Les [corrections du 28 octobre](AUDIT_CORRECTIONS_20261028.md) et celles du
[19 octobre](AUDIT_CORRECTIONS_20261019.md) gardent leurs dates et leurs
périmètres.

## Méthode

Les écarts ont été répartis en trois lots aux fichiers disjoints :
- **S** : le contrôleur Dart (session, invité, authentification, fins de
  session) ;
- **N** : le natif Kotlin/C++ (pont, tuile, reprise système, OpenVPN,
  WireGuard, Turnstile et Billing natifs) ;
- **R** : le reste. On y trouve le transport, les modèles, Google, l'interface
  et les traductions, l'outillage, la chaîne d'approvisionnement, les
  diagnostics et la facturation Dart.

Pour chaque écart, le travail a suivi cette méthode :
1. écrire d'abord un test qui échoue sur l'état d'avant corrections ;
2. corriger, puis vérifier que le test passe ;
3. relancer les suites voisines ;
4. obtenir une relecture adversariale indépendante, avec mutants si
   nécessaire.

Le lot S a aussi reçu une relecture croisée. Le contrat de fin de session est
partagé entre Dart et le natif : la cause transmise est `voluntary`, `expired`
ou `abandoned`.

Un **réaudit final** a ensuite rejugé chaque écart sur l'état corrigé. Il a
mobilisé 17 réauditeurs, 7 confirmateurs indépendants et une critique de
complétude. Résultat :
- aucun problème bloquant ni majeur ;
- 6 écarts partiels, chacun confirmé indépendamment ;
- des mineurs.

Tous ont été repris dans une **passe finale**, elle-même vérifiée. Les limites
qui subsistent sont indiquées dans la matrice et en fin de note.

## Matrice des 81 écarts

« Corrigé » décrit le comportement vérifié localement sur l'état final.
« Corrigé (passe finale) » désigne un écart jugé partiel par le réaudit puis
repris. Une limite qui subsiste est indiquée dans le statut.

### Lot S — contrôleur Dart

| Identifiant | Priorité | Correction et comportement vérifié | Statut | Tests versionnés |
| --- | --- | --- | --- | --- |
| A01-auth-01 | P2 | Le report d'une reprise invitée est lié à la session (ou à l'absence de session) pour laquelle il a été posé ; une connexion explicite (e-mail, inscription, Google, connexion séparée) l'annule et désactive la reprise automatique avant d'écrire sa propre session. Un ancien invité ne remplace donc plus un compte en restauration en attente, ni au retour au premier plan ni sur « Réessayer ». | Corrigé | [Fins de session](../test/session/session_end_modes_test.dart), [Report sans opt-out écrit](../test/session/review_variants_test.dart), [Report lié à l'identité](../test/guest_controller_test.dart) |
| A13-dart-vpn-02 | P2 | Un 401 invité pendant une connexion, un changement de lieu, une création de profil OpenVPN ou une révocation d'appareil renouvelle le jeton puis relance une seule fois l'action ; pendant un reset ou un délai `Retry-After`, ou après un échec temporaire du renouvellement, la session et le tunnel sont conservés avec un avis. Seul un refus définitif du renouvellement termine la session. | Corrigé, limite : 401 pendant le suivi de migration vérifié par lecture | [Renouvellement par le propriétaire](../test/session/guest_renewal_owner_test.dart), [Chemin OpenVPN](../test/session/followups_20261029_test.dart), [Révocation relancée](../test/session/reaudit_final_test.dart) |
| A14-storage-platform-01 | P2 | Au démarrage, une lecture Keystore `secure_storage_read_failed` ou `native_bridge_unavailable` ne purge plus rien : la session reste en restauration en attente avec un avis, « Réessayer » la relit, et aucune reprise invitée n'est lancée tant qu'elle est illisible. Seule une corruption avérée est effacée, sans révoquer la reprise invitée ni afficher « session expirée ». | Corrigé | [Fins de session](../test/session/session_end_modes_test.dart), [Causes de fin](../test/session/review_p1_end_cause_test.dart), [Stockage instable](../test/session/review_flaky_store_test.dart) |
| C4-Tri-des-pistes-de-perte-de-ses-01 | P2 | Une session invitée renouvelée et déjà écrite dont seule la restauration échoue (réseau, 5xx, Keystore) reste en restauration en attente, au démarrage comme après un 401, avec l'avis du code réel et sans fin de session ni avis « session expirée ». « Réessayer » restaure cette session sans en créer une seconde sur le serveur. | Corrigé | [Fins de session](../test/session/session_end_modes_test.dart) |
| A01-auth-03 | P3 | Pendant une action invitée en arrière-plan (reprise, renouvellement, délai `Retry-After`), la page de connexion et le dialogue de connexion d'un invité désactivent leurs actions et affichent le message invité ou « Réessayez dans quelques instants », le Retour restant possible. La feuille de réinitialisation ne présente plus l'ancien avis comme résultat d'un envoi refusé : pendant une action invitée, elle affiche « Le service est temporairement indisponible ». | Corrigé | [Page de connexion](../test/session/auth_page_session_test.dart) |
| A01-auth-04 | P3 | Dès qu'une restauration en attente apparaît et se stabilise, quelle qu'en soit la cause (connexion acceptée ou admission invitée automatique au retour au premier plan), l'application ferme les pages poussées : la page de restauration est visible et son bouton « Réessayer » restaure le compte. | Corrigé (passe finale) | [Page de connexion et restauration](../test/session/auth_page_session_test.dart) |
| A02-guest-01 | P3 | La purge qui suit une écriture native en échec ne révoque plus la reprise invitée automatique : le message invité (`guest.secureStorageError`) et le délai `Retry-After` sont conservés, aucun avis « session expirée » n'apparaît et l'invité revient au lancement suivant. Les assertions versionnées qui figeaient l'ancien comportement sont réalignées. | Corrigé | [Fins de session](../test/session/session_end_modes_test.dart), [Admission invitée](../test/guest_controller_test.dart) |
| A02-guest-04 | P3 | « Réessayer » est refusé et son bouton désactivé pendant toute action invitée (reprise, renouvellement, délai) : un second appui ne relance ni `/me` ni la fin de session, et le tunnel reste actif. | Corrigé, limite : bouton désactivé sans indicateur de progression pendant la reprise | [Réessayer pendant la reprise](../test/session/guest_renewal_owner_test.dart) |
| A02-guest-05 | P3 | Le délai `Retry-After` d'un 503 (comme de tout 429 ou 5xx) bloque « Réessayer » jusqu'à l'échéance (délai plafonné à 60 s), et la page de restauration affiche le compte à rebours. Aucune nouvelle session invitée ni aucun `/me` n'est demandé avant la fin du délai. | Corrigé | [Retry-After et Réessayer](../test/session/guest_renewal_owner_test.dart), [Compte à rebours](../test/session/followups_20261029_test.dart) |
| A13-dart-vpn-01 | P3 | Un invité proche de l'expiration est renouvelé avant l'arrêt du tunnel : un refus laisse le tunnel actuel intact avec un avis, sinon la destination confirmée est connectée. Un jeton inscrit qui expire pendant le changement termine la session avec l'avis « session expirée » au lieu d'un arrêt silencieux. | Corrigé | [Changement de lieu invité](../test/session/guest_renewal_owner_test.dart), [Jeton inscrit échu](../test/session/reaudit_final_test.dart) |
| A13-dart-vpn-03 | P3 | Annuler un changement de lieu libère immédiatement `isChangingLocation` et les contrôles de connexion ; la requête abandonnée s'arrête à son retour sans rien connecter. | Corrigé | [Annulation du changement](../test/session/guest_renewal_owner_test.dart) |
| A13-dart-vpn-04 | P3 | Chaque erreur native est montrée une fois : une notice fermée ne revient pas à la reprise, une nouvelle erreur s'affiche et une erreur présente au démarrage est signalée. Une erreur arrivée derrière un autre avis n'est pas marquée comme vue : elle est montrée à la reprise ou à l'état natif suivant, une fois cet avis fermé. | Corrigé (passe finale) | [Erreur native fermée](../test/session/guest_renewal_owner_test.dart), [Erreurs natives masquées](../test/session/review_variants_test.dart) |
| A16-ui-l10n-02 | P3 | La notice « changement toujours en cours » (`location_migration_slow`) reçoit la destination (libellé affiché, identifiant en repli) et la cite dans les 30 langues. | Corrigé | [Contrôleur de changement de lieu](../test/support/location_change_controller_cases.dart), [Intégration l10n](../test/l10n/l10n_integration_20261029_test.dart) |
| C1-Vivacit-de-bout-en-bout-de-la--02 | P3 | La fin de session Dart n'attend plus les écritures en cours que 10 s (les suivantes repartent d'une file neuve), puis l'effacement natif 30 s au plus ; passé ce second délai, la fin devient « non confirmée » et l'écran de nettoyage propose un réessai effectif, une réponse native tardive complétant encore la fin. Le renouvellement invité bloqué est libéré pour qu'une nouvelle connexion soit acceptée, et le texte affiché pendant la fin n'affirme plus que la session est invalidée. | Corrigé, limite : un réessai qui rejoint une fin en cours n'attend pas son résultat | [Fin bornée](../test/session/session_bounds_test.dart), [Après une fin bornée](../test/session/review_variants_test.dart), [Texte de fin de session](../test/l10n/session_ending_wording_test.dart) |
| C4-Tri-des-pistes-de-perte-de-ses-02 | P3 | Au démarrage sans session, un état natif `error` sans tunnel actif ne termine plus rien. Seul un tunnel orphelin réellement actif est arrêté, en conservant la reprise invitée et son message, sans avis « session expirée ». | Corrigé | [Fins de session](../test/session/session_end_modes_test.dart), [Causes de fin](../test/session/review_p1_end_cause_test.dart) |
| C4-Tri-des-pistes-de-perte-de-ses-03 | P3 | Toute connexion explicite désactive la reprise invitée automatique avant d'écrire sa session, et une session inscrite stockée, même expirée ou jamais restaurée, ne relance jamais l'ancien invité. Sa fin attend que cette désactivation soit écrite ; tant qu'elle échoue, rien n'est purgé et la reprise reste bloquée avec un avis. | Corrigé | [Connexion explicite](../test/session/session_end_modes_test.dart), [Session inscrite stockée](../test/session/followups_20261029_test.dart), [Liaison du stockage natif](../test/native_storage_contract_test.dart) |
| C4-Tri-des-pistes-de-perte-de-ses-04 | P3 | Une session que le serveur vient de délivrer n'est plus refusée sur l'horloge de l'appareil. Si l'appareil la juge déjà échue, l'avis « Heure de l’appareil en avance » s'affiche, elle n'est renouvelée que sur un 401 (jamais préventivement) et les diagnostics gardent son compte et son jeton. | Corrigé, limite : au relancement, copie stockée jugée sur l'horloge | [Horloge en avance](../test/session/session_bounds_test.dart), [Pas de renouvellement sur l'horloge](../test/session/review_c404_renewal_test.dart), [Diagnostics et avis](../test/session/reaudit_final_test.dart) |
| H-RA-A06-01-02 | P3 | Une reprise invitée annulée par un Retour sur la page Google est purgée sans révoquer la reprise automatique ni afficher d'avis, et l'invité revient au premier plan suivant. Le bouton Google est désactivé pendant une action invitée. | Corrigé, limite : un Retour depuis une page Google déjà ouverte annule encore la reprise en cours | [Retour Google](../test/session/session_end_modes_test.dart), [Page de connexion](../test/session/auth_page_session_test.dart) |

**Limites restantes du lot**
- C4-Tri-des-pistes-de-perte-de-ses-04 : au lancement suivant, la copie stockée est jugée sur l'horloge de l'appareil, sans appel au serveur. Une session inscrite se termine alors avec l'avis « session expirée » (sans l'avis horloge), et un invité reçoit une nouvelle session à chaque lancement. Limite documentée dans [les comptes invités](GUEST_ACCOUNTS.md) ; la lever demanderait un marqueur natif persistant.
- A13-dart-vpn-02 : aucun test Dart ne couvre un 401 pendant le suivi d'une migration de lieu, les doubles de test ne modélisant pas la migration ; la relance du suivi par le renouvellement est vérifiée par lecture du code.
- C1-Vivacit-de-bout-en-bout-de-la--02 : un « Réessayer » qui rejoint une fin encore en cours n'attend pas le résultat de la cause qu'il ajoute. Un échec n'y serait possible que sur une erreur de transport entre deux messages de la même fin, dont le natif fusionne les causes.
- Qualification commune (A14-storage-platform-01, A02-guest-01, C4-Tri-des-pistes-de-perte-de-ses-02, H-RA-A06-01-02) : la fusion des causes de fin est vérifiée par les tests hôtes du pont natif ; les tests Dart la modélisent, sans essai sur appareil. Les jonctions d'une fin expirée et d'une fin abandonnée, ou une jonction pendant l'attente des écritures, ne sont pas testées : aucun chemin public ne les produit.
- H-RA-A06-01-02 : un Retour depuis une page Google déjà ouverte au démarrage d'une reprise invitée annule encore cette admission ; la reprise automatique est conservée et l'invité revient au premier plan suivant.
- A02-guest-04 : pendant la reprise invitée, « Réessayer » est désactivé sans indicateur de progression.

### Lot N — natif Android

| Identifiant | Priorité | Correction et comportement vérifié | Statut | Tests versionnés |
| --- | --- | --- | --- | --- |
| C2-R-gles-d-ex-cution-Android-12--01 | P2 | L'instantané de tuile n'appelle plus `VpnService.prepare` : « Connecter » dérive de la divulgation mémorisée et du dernier résultat de `prepare` obtenu lors d'une action explicite (connexion, clic de tuile, démarrage Always-on). Un rafraîchissement de tuile ne peut donc plus révoquer le VPN d'une autre application, et la tuile active est rafraîchie quand ce résultat change. | Corrigé, limite : consentement retiré par « Oublier le VPN » vu seulement à la prochaine action explicite | [Pont natif hôte](../android/app/src/test/bridge-host/AndroidVpnBridgeHostTest.kt) |
| C2-R-gles-d-ex-cution-Android-12--02 | P2 | La demande d'écoute de la tuile capture la `RuntimeException` levée sous Android 13 avant QPR3 hors utilisateur courant ; la publication d'état ne lève plus, la fin de session se termine toujours et un gestionnaire de dernier recours protège les portées de coroutines du pont. Permission VPN, connexion, évènements d'état et déconnexion du compte aboutissent malgré cette levée. | Corrigé | [Pont natif hôte](../android/app/src/test/bridge-host/AndroidVpnBridgeHostTest.kt) |
| H-E22-N01-01 | P2 | La reprise système capture une autorité qui avance à chaque admission d'une commande explicite ; si elle a changé, la reprise cède sans publier, bloquer le registre ni arrêter de moteur, et elle n'arrête jamais qu'un moteur qu'elle a elle-même démarré. Une connexion de tuile ou Flutter en file n'est plus arrêtée ni remplacée par ERROR, et une erreur réelle de cette connexion reste la sienne. | Corrigé, limite : une reprise qui cède à une commande explicite n'est pas retentée | [Commandes système/tuile](../android/app/src/test/command-epoch/SystemVpnCommandEpoch.template.kt), [Pont natif hôte](../android/app/src/test/bridge-host/AndroidVpnBridgeHostTest.kt) |
| A01-auth-02 | P3 | `SessionLifecycle.beginEnd` ne reprend les causes que d'une fin inachevée, et la purge native suit `revokeGuestRecovery`, posé par toute cause volontaire. Une déconnexion volontaire qui suit une expiration terminée désactive donc la reprise invitée. | Corrigé | [Cycle de session natif](../android/app/src/test/kotlin/com/fuzevpn/android/SessionLifecycleTest.kt), [Pont natif hôte](../android/app/src/test/bridge-host/AndroidVpnBridgeHostTest.kt) |
| A06-turnstile-01 | P3 | Un échec de chargement du script Turnstile est détecté avant l'initialisation et rend `provider_error` en 250 ms au plus ; un script qui ne s'initialise jamais est borné à 30 s. L'application affiche l'échec de la vérification au lieu d'un dialogue vide pendant 240 s suivi de « Vérification annulée ». | Corrigé, limite : aucun WebView réel exécuté | [Bridge Turnstile hôte](../android/app/src/testHost/turnstile/NativeTurnstileBridgeHostTest.kt), [document Turnstile](../android/app/src/testHost/turnstile/turnstile-document-test.cjs), [politique Turnstile](../android/app/src/test/kotlin/com/fuzevpn/android/TurnstilePolicyTest.kt) |
| A07-billing-03 | P3 | Le pont Play Billing est découpé, sans changement de comportement, derrière des interfaces hôte et client. Une suite JVM de 20 tests couvre la récupération d'un achat avec le propriétaire du lancement, le contrôle des achats existants avant paiement, le listener par génération et l'invalidation pendant la préparation. | Corrigé, limite : adaptateur Android `ActivityBillingHost` sans test versionné | [Pont Play Billing](../android/app/src/test/kotlin/com/fuzevpn/android/PlayBillingBridgeTest.kt) |
| A08-vpn-bridge-02 | P3 | Une reprise système annulée par une commande qui ne publie rien republie IDLE, que l'annulation survienne pendant l'attente réseau, pendant l'attente du mutex ou dans la connexion WireGuard elle-même, avant ou après sa préparation. Une erreur de perte de l'hôte publiée pendant la tentative est conservée. | Corrigé (passe finale), limite : perte de l'hôte entre l'annulation et la republication suivie d'IDLE, pas d'ERROR | [Pont natif hôte](../android/app/src/test/bridge-host/AndroidVpnBridgeHostTest.kt), [Commandes système/tuile](../android/app/src/test/command-epoch/SystemVpnCommandEpoch.template.kt) |
| A08-vpn-bridge-03 | P3 | Un handshake WireGuard interrompu parce que la requête ou la session n'est plus courante est traité comme une annulation : moteur arrêté, IDLE publié et `session_operation_cancelled` rendu. `wireguard_handshake_timeout` reste réservé au vrai délai. | Corrigé | [Pont natif hôte](../android/app/src/test/bridge-host/AndroidVpnBridgeHostTest.kt) |
| A09-01 | P3 | Les gardes d'identité OpenVPN (CSR, effacement d'identité, révocation) consomment la preuve d'une destruction JNI tardive avant de juger une session vivante : la reconnexion obtient son CSR sans second Destroy, et une session réellement vivante reste refusée. Un OpenVPN retenu en erreur après un arrêt expiré est arrêté par l'application avant la demande de CSR. | Corrigé, limite : arrêt avant CSR vérifié côté Dart seulement, pont réel non rejoué | [Opérations natives possédées](../android/app/src/test/kotlin/com/fuzevpn/android/openvpn/OwnedNativeOperationsTest.kt), [câblage du contrôleur OpenVPN](../android/app/src/test/kotlin/com/fuzevpn/android/openvpn/OpenVpnControllerWiringTest.kt), [arrêt avant CSR](../test/session/reaudit_final_test.dart) |
| A09-services-01 | P3 | Écrire ou effacer le profil de tuile, et activer une session, rafraîchissent la tuile active ; elle ne garde plus « Prêt · protocole · lieu » après l'effacement du profil. Un changement du consentement Android constaté par `prepare` la rafraîchit aussi. | Corrigé | [Pont natif hôte](../android/app/src/test/bridge-host/AndroidVpnBridgeHostTest.kt) |
| A10-wireguard-02 | P3 | Aucun appel du contrôleur WireGuard n'attend plus sans borne derrière un arrêt natif bloqué : la clé publique est bornée à 10 s, les empreintes d'identité lisent le Keystore ou l'état en mémoire, et toute soumission est refusée aussitôt tant qu'un démarrage ou un arrêt expiré occupe le worker. Le mutex du pont est libéré et la déconnexion du compte purge la session. | Corrigé, limite : lecture Keystore de l'empreinte non bornée si le Keystore se fige | [Délais WireGuard](../android/app/src/test/kotlin/com/fuzevpn/android/WireGuardControllerTimeoutTest.kt), [bornes WireGuard](../android/app/src/test/kotlin/com/fuzevpn/android/WireGuardControllerBoundsTest.kt), [Pont natif hôte](../android/app/src/test/bridge-host/AndroidVpnBridgeHostTest.kt) |
| A10-wireguard-03 | P3 | Seuls un démarrage ou un arrêt expirés rendent l'instance incertaine : une lecture de statistiques lente laisse intactes la preuve d'identité et la référence de reprise, donc le renouvellement de la reprise invitée. Un `connect` sur un tunnel actif est refusé (`tunnel_already_active`) avant d'effacer cette preuve. | Corrigé | [Délais WireGuard](../android/app/src/test/kotlin/com/fuzevpn/android/WireGuardControllerTimeoutTest.kt), [bornes WireGuard](../android/app/src/test/kotlin/com/fuzevpn/android/WireGuardControllerBoundsTest.kt) |
| A11-03 | P3 | Hors session, tout appui sur la tuile autre que l'ouverture des réglages ouvre l'application, y compris avec un moteur encore retenu, sans rien annuler, publier ni notifier. Un refus local de la tuile n'est plus publié comme ERROR global ; un échec de moteur reste publié. | Corrigé (passe finale), limite : refus local publié en ERROR si une autre publication suit le clic | [Pont natif hôte](../android/app/src/test/bridge-host/AndroidVpnBridgeHostTest.kt), [Commandes système/tuile](../android/app/src/test/command-epoch/SystemVpnCommandEpoch.template.kt) |
| A11-openvpn-kotlin-01 | P3 | L'appel natif borné rend telle quelle une `VpnNativeException` levée dans le Callable : un démarrage OpenVPN annulé au dernier moment rend `session_operation_cancelled`, les autres échecs `openvpn_native_failed` et un délai `openvpn_operation_timeout`. L'application n'affiche plus d'erreur native pour cette annulation. | Corrigé, limite : l'annulation reste publiée en ERROR par le natif, sans avis affiché | [Appel natif borné](../android/app/src/test/kotlin/com/fuzevpn/android/openvpn/BoundedNativeCallTest.kt), [câblage du contrôleur OpenVPN](../android/app/src/test/kotlin/com/fuzevpn/android/openvpn/OpenVpnControllerWiringTest.kt), [annulation sans avis](../test/session/reaudit_final_test.dart) |
| A12-openvpn-native-01 | P3 | Le validateur natif n'accepte plus qu'une forme canonique que Core découpe comme lui : lignes comparées exactement, ASCII, CR seulement en CRLF, lignes de 511 octets au plus, directives sans guillemets ni commentaires, PEM strict dans `<ca>` et `<tls-crypt-v2>`, `pull-filter` unique. Confrontés à l'analyseur réel de Core, les profils de l'audit et 40 000 mutations ne font plus passer aucune directive hors liste blanche. | Corrigé | [Validateur de profil OpenVPN](../android/app/src/test/cpp/openvpn_profile_host_test.cpp) |
| C2-R-gles-d-ex-cution-Android-12--03 | P3 | Le pont ne lance plus d'activité pour l'action « réglages » de la tuile : il la renvoie au service de tuile, qui ouvre les réglages VPN par `startActivityAndCollapse(PendingIntent)` sur Android 14 et plus. Une `ActivityNotFoundException` à l'ouverture des réglages ou de l'application est capturée et la tuile est rafraîchie. | Corrigé, limite : blocage d'Android 14-16 non exécuté sur appareil | [Pont natif hôte](../android/app/src/test/bridge-host/AndroidVpnBridgeHostTest.kt) |
| C3-Contrat-des-canaux-Dart-Kotlin-01 | P3 | Dart envoie toujours `language_code`, `null` pour la langue du système, et le natif accepte une valeur nulle ou absente : la notification de premier plan et la tuile reviennent à la langue du système. Un type ou une langue invalide reste refusé (`invalid_arguments`). | Corrigé | [Pont natif hôte](../android/app/src/test/bridge-host/AndroidVpnBridgeHostTest.kt), [contrat du canal natif](../test/native_storage_contract_test.dart) |
| H-E22-N01-02 | P3 | Une reprise système admise qui échoue dans sa tenue du mutex, vérification de session comprise, ou qui se termine sans restauration libère les clics de tuile plus anciens : le clic en file est tenté, ou son échec signalé. Une reprise réussie ou encore en cours garde la priorité. | Corrigé (passe finale), limite : clic dont les lectures finissent pendant l'attente réseau d'une reprise admise abandonné, ni différé ni rejoué | [Commandes système/tuile](../android/app/src/test/command-epoch/SystemVpnCommandEpoch.template.kt), [Pont natif hôte](../android/app/src/test/bridge-host/AndroidVpnBridgeHostTest.kt) |
| H-R15-01-01 | P3 | La suite versionnée de reprise WireGuard passe de 38 à 76 tests, dont un pilote qui suit l'ordre d'appels du pont et les six variantes CONNECTED de l'audit. Elle échoue sur la politique d'avant (17 tests) et tue les mutants qui survivaient à l'ancienne suite. | Corrigé | [Séquence de reprise du pont](../android/app/src/test/kotlin/com/fuzevpn/android/WireGuardRecoveryBridgeSequenceTest.kt), [horloge et reprise WireGuard](../android/app/src/test/kotlin/com/fuzevpn/android/WireGuardClockRecoveryTest.kt), [policy](../android/app/src/test/kotlin/com/fuzevpn/android/WireGuardRecoveryPolicyTest.kt) |
| R15-01 | P3 | La confiance dans l'horloge s'accumule dans tous les états, CONNECTED compris, et n'est plus réinitialisée à la perte ; seule une lecture de statistiques encadrée par deux mises à jour d'horloge continues la ré-ancre. Un handshake antérieur à la perte ne confirme plus la reprise, que le recul d'horloge précède ou suive la perte. | Corrigé, limite : aller-retour d'horloge plus court qu'une lecture non détecté | [Horloge et reprise WireGuard](../android/app/src/test/kotlin/com/fuzevpn/android/WireGuardClockRecoveryTest.kt), [policy](../android/app/src/test/kotlin/com/fuzevpn/android/WireGuardRecoveryPolicyTest.kt), [séquence de reprise du pont](../android/app/src/test/kotlin/com/fuzevpn/android/WireGuardRecoveryBridgeSequenceTest.kt) |

**Limites restantes du lot**
- C2-R-gles-d-ex-cution-Android-12--01 : un consentement Android retiré par « Oublier le VPN » n'est constaté qu'à la prochaine action explicite ; d'ici là la tuile affiche « Prêt », et le clic ouvre l'application (`vpn_permission_required`).
- H-E22-N01-01 : une reprise système qui cède à une commande explicite n'est pas retentée ; si cette commande échoue, l'utilisateur voit son erreur à elle. Les variantes avec une connexion Flutter en file ne sont rejouées que dans la suite des commandes système/tuile.
- H-E22-N01-02 : un clic de tuile dont les lectures finissent pendant l'attente réseau (jusqu'à 30 s) d'une reprise admise est abandonné au profit de celle-ci, ni différé ni rejoué si elle échoue ensuite. L'ERROR de la reprise et sa notification « action requise » restent visibles, et un nouveau clic suffit (décision produit). La variante OpenVPN n'est rejouée que dans la suite des commandes système/tuile.
- A08-vpn-bridge-02 : `captureHostLoss` est inchangé ; une perte de l'hôte VPN survenue entre l'annulation de la reprise et sa republication est suivie d'IDLE, pas d'ERROR.
- A11-03 : si une autre publication survient entre le clic de tuile et le refus local, l'ERROR est publié comme avant.
- A07-billing-03 : l'adaptateur Android `ActivityBillingHost` (construction de `BillingFlowParams`, propriétaire transmis à Play, normalisation du catalogue) n'est couvert par aucun test versionné ; il faudrait le vrai SDK Billing avec des doubles Looper/TextUtils, ou Robolectric.
- A09-01 : l'arrêt d'un OpenVPN retenu en erreur avant le CSR est prouvé par le harnais Dart seulement ; le pont réel n'est pas rejoué, sa doublure OpenVPN ne sachant ni connecter ni produire de CSR. Le câblage des gardes du contrôleur est épinglé dans le source, sans exécution du vrai contrôleur, et ces gardes peuvent tenir le mutex de tunnel jusqu'à 10 s pendant un Destroy encore en cours.
- A11-openvpn-kotlin-01 : une annulation OpenVPN reste publiée par le natif comme ERROR `session_operation_cancelled` (WireGuard publie IDLE) ; seule l'application l'ignore. Le chemin réel du contrôleur est épinglé dans le source, pas exécuté.
- A10-wireguard-02 : un démarrage ou un arrêt natif qui ne revient jamais laisse l'instance incertaine jusqu'au redémarrage du processus, le pont signalant l'échec au lieu de se figer ; `existingIdentityFingerprint` lit le Keystore sur le thread appelant, sans borne si le Keystore se fige.
- A10-wireguard-03 : une lecture `wgGetConfig` bloquée à vie rend chaque arrêt (10 s au plus) et chaque lecture (2 s au plus) lents, mais bornés.
- A06-turnstile-01 : aucun WebView réel exécuté ; la borne de démarrage de 30 s n'est pas qualifiée sur réseau lent ; après `ready`, un widget qui ne termine jamais reste borné par 240 s.
- A12-openvpn-native-01 : un PEM non standard renvoyé par l'API est désormais refusé à la connexion (échec fermé) ; le test hôte Windows (MSVC) porte sur `OptionList` de Core, pas sur `ClientOptions` ni sur une connexion réelle.
- C2-R-gles-d-ex-cution-Android-12--03 : le blocage des lancements en arrière-plan d'Android 14-16 n'est pas exécuté sur appareil ; le chemin API inférieure à 34 n'est vérifié que par lecture.
- C3-Contrat-des-canaux-Dart-Kotlin-01 : les tests vérifient que la langue nulle atteint le natif ; le retour de la notification et de la tuile à la langue du système (`VpnForegroundService.setLocale(null)`) est établi par lecture du code.
- R15-01 : après un recul d'horloge vu en CONNECTED sans lecture ultérieure, un handshake frais attend une preuve différentielle (RECOVERING, puis CONNECTED dès du trafic reçu) ; un aller-retour d'horloge plus court que l'incertitude d'une lecture reste invisible.
- H-R15-01-01 : deux mutants de la politique corrigée survivent ; ils sont équivalents, ce que confirme un fuzz différentiel sans violation.
- Qualification commune (C2-R-gles-d-ex-cution-Android-12--01, -02 et -03, C3-Contrat-des-canaux-Dart-Kotlin-01, H-E22-N01-01, H-E22-N01-02, A08-vpn-bridge-02, A08-vpn-bridge-03, A09-services-01, A11-03) : le pont réel est exécuté sur JVM avec des doubles Android, Flutter, Keystore et moteurs, sans appareil, SystemUI, TUN ni Always-on réel ; la levée d'Android 13 multi-utilisateur est modélisée d'après l'AOSP. Aucun JNI ni moteur natif réel n'est exécuté pour A09-01, A11-openvpn-kotlin-01, A10-wireguard-02 et A10-wireguard-03.

### Lot R — transport, Google, interface, outillage et chaîne d'approvisionnement

| Identifiant | Priorité | Correction et comportement vérifié | Statut | Tests versionnés |
| --- | --- | --- | --- | --- |
| A17-supply-chain-01 | P1 | Flutter 3.47.8 / Dart 3.13.7 (moteur `cf636b1d…`) est épinglé par `.flutter-version`, le plancher `flutter: '>=3.47.8'` qui fait refuser un SDK antérieur à `pub get`, le verrou Pub et `verification-metadata.xml`, d'où les artefacts de l'ancien moteur sont retirés ; les goldens sont régénérés pour ce moteur. Aucun épinglage de clé TLS n'est ajouté côté API. | Corrigé (validation-02) | [Goldens de l'interface](../test/widget/app_ui_test.dart), [intégrité des dépendances](../tools/test_dependency_integrity.ps1) |
| A13-03 | P2 | Les causes natives stables (profil trop grand ou chiffrement invalide, identité OpenVPN occupée, perte du tunnel, échec de reprise, reprise système indisponible ou bloquée, permission VPN, opération WireGuard en attente) ont un alias fermé vers une catégorie v1 existante, appliqué à l'erreur, aux événements et au contrôle. Un inventaire versionné de tous les producteurs Kotlin, C++ et Dart refuse tout code non classé ou en collision avec un code API. | Corrigé, limite : acceptation serveur des catégories non requalifiée | [Producteurs natifs](../test/core/diagnostics_native_producers_regression_test.dart), [collisions d'alias](../test/core/diagnostics_alias_collision_test.dart) |
| A16-ui-l10n-01 | P2 | Le contenu de `HomeShell` porte une `GlobalKey` stable dans les deux dispositions : au franchissement de 720 dp, dans un sens comme dans l'autre, la recherche, le pays ouvert, l'état d'Emplacements et la confirmation de changement de lieu en cours sont conservés, et la connexion confirmée part. | Corrigé | [Seuil 720 dp](../test/widget/corrections_20261029_home_shell_test.dart) |
| A03-google-01 | P3 | Le Retry-After d'une finalisation reçue pendant un Retour (claim, register, link, demande d'e-mail) est mémorisé avant la garde d'époque ; une annulation non confirmée conserve l'intention et ses blocages, et la reprise rouvre le formulaire avec `google.rateLimited`, finalisation bloquée jusqu'à l'échéance dans le contrôleur comme sur la page. | Corrigé, limite : blocages perdus à l'arrêt du processus | [Contrôleur Google](../test/google_corrections_20261029_controller_test.dart), [page Google](../test/google_corrections_20261029_page_test.dart) |
| A03-google-02 | P3 | Le blocage Turnstile et le Retry-After d'un claim refusé sont posés avant la relecture `/me` ; l'échec de cette relecture ne remplace plus que le message, et aucun second claim ne part sans jeton de vérification. | Corrigé | [Contrôleur Google](../test/google_corrections_20261029_controller_test.dart), [admission réelle du contrôleur](../test/support/google_controller_cases.dart) |
| A03-google-03 | P3 | `google.cancelFailed` n'est affiché que tant que le contrôleur n'a pas publié de nouvel état : une reprise, une finalisation ou une erreur ultérieure (par exemple un mot de passe faux) redevient visible. | Corrigé | [Page Google](../test/google_corrections_20261029_page_test.dart) |
| A03-google-04 | P3 | Le sélecteur de pays Google trie avec la fonction d'Emplacements : minuscules, repli latin, marques combinantes retirées et règles propres à chaque langue (dont une table ourdoue) ; les initiales accentuées sont rangées à leur lettre en fr, de, tr et cs, et la liste française se termine par Zimbabwe. | Corrigé, limite : ja et zh en ordre Unicode | [Ordre des pays](../test/google_corrections_20261029_country_order_test.dart), [tri localisé](../test/core/location_grouping_test.dart), [page Google](../test/google_corrections_20261029_page_test.dart) |
| A04-transport-01 | P3 | Un corps non-2xx illisible, trop gros, tronqué ou encore en cours à l'échéance garde le statut et le Retry-After ; un 503 reste transitoire et la reprise invitée est différée sans effacer la session. Un corps 2xx reste décodé strictement et porte son statut. | Corrigé | [Transport](../test/core/corrections_20261029_transport_test.dart), [reprise invitée](../test/guest_controller_test.dart) |
| A04-transport-02 | P3 | La confiance au certificat de test est installée dans un `setUpAll` valable pour tout le fichier, quels que soient l'ordre et le filtre ; la preuve « certificat non approuvé » est isolée dans un fichier qui n'installe jamais cette confiance. | Corrigé | [Transport proxy](../test/core/io_api_http_proxy_test.dart), [certificat non approuvé](../test/core/io_api_http_proxy_untrusted_test.dart) |
| A05-models-01 | P3 | `Location.fromJson` applique la borne native (libellé non blanc, au plus 96 unités UTF-16, sans caractère de contrôle ISO) ; `locations()` écarte seulement la ligne fautive avant toute sélection, donc avant tout effet serveur, et le libellé d'un appareil existant est ramené à une forme native. | Corrigé, limite : ligne écartée sans message | [Modèles](../test/core/corrections_20261029_models_test.dart), [contrat natif](../android/app/src/test/kotlin/com/fuzevpn/android/NativeInputContractTest.kt) |
| A05-models-02 | P3 | Un nom d'appareil absent ou blanc reste vide dans le modèle ; la ligne d'appareil et la confirmation de retrait affichent la clé localisée `devices.unnamed`, présente dans les 31 ARB. | Corrigé, limite : traductions sans relecture native | [Modèles](../test/core/corrections_20261029_models_test.dart), [libellés localisés](../test/widget/corrections_20261029_l10n_widgets_test.dart) |
| A06-turnstile-02 | P3 | Le runner déclare `#Requires -Version 5.1`, dérive `-Repository` dans son corps et capture le stderr natif en texte, seul le code de sortie décidant ; il tourne sous Windows PowerShell 5.1 et pwsh 7. Son test ne dépend plus de l'ordre de fusion stdout/stderr : seule la ligne stderr connue est retirée avant le contrôle strict du reçu JUnit. | Corrigé (passe finale) | [Runner Turnstile](../tools/tests/test_turnstile_runner.py) |
| A07-billing-02 | P3 | Un reçu Play suspendu rattaché, ou un droit serveur `past_due` fourni par Google Play, bloque l'achat avec la raison traduite `billing.playOnHold` ; la carte, la page Premium et la feuille des offres remplacent l'achat voué à `already_owned` par « Gérer l'abonnement ». | Corrigé, limite : réponse serveur réelle en suspension non observée | [Blocage du paiement Play](../test/billing_play_checkout_block_test.dart), [page Premium](../test/widget/subscription_paywall_play_block_test.dart), [carte d'abonnement](../test/widget/subscription_card_test.dart) |
| A10-wireguard-04 | P3 | Le patch runtime Go couvre aussi `time.now` sur linux/amd64 (9 fichiers, 14 sites) et l'AAR approuvé est reconstruit ; sur x86_64, `time.now` lit `CLOCK_REALTIME` pour l'heure murale et `CLOCK_BOOTTIME` pour sa partie monotone, et `nanotime1`, dont les trois autres ABI tirent cette partie, lit `CLOCK_BOOTTIME` sur les quatre ABI. | Corrigé | [Horloge native WireGuard](../tools/tests/test_wireguard_native_clock.py) |
| A10-wireguard-05 | P3 | L'import exporte l'amont en LF quel que soit `core.autocrlf` et applique chaque patch sur des copies LF par `git apply --check` puis `git apply`, sans fuzz ; la série s'applique en export LF comme CRLF, les octets des patches sont inchangés et un vrai conflit reste refusé. | Corrigé, limite : réimportation en LF, différente à l'octet | [Série de patches WireGuard](../tools/tests/test_wireguard_patch_series.py) |
| A15-diagnostics-01 | P3 | L'export du rapport est à vol unique : un second appui est ignoré avant tout appel natif et le bouton est désactivé pendant l'export ; le refus natif « export en cours » n'est plus présenté comme un échec, et un échec tardif est ignoré si un nouveau diagnostic ou un effacement a eu lieu. | Corrigé | [Export de diagnostic](../test/widget/corrections_20261029_diagnostics_export_test.dart) |
| A16-01 | P3 | La date « Accès jusqu'au » passe par `AppFormats.longDate`, qui suit la région système et écrit le mois en lettres : « 2 November 2026 » en en-GB, « November 2, 2026 » en en-US, « 2 novembre 2026 » en fr-FR. | Corrigé | [Carte d'abonnement](../test/widget/subscription_card_test.dart) |
| A16-ui-l10n-03 | P3 | `openvpn_recovery_exhausted`, `openvpn_recovery_failed` et `openvpn_renewal_required` ont un titre propre dans les 30 langues ; l'avis d'erreur du tunnel affiche titre et message spécifiques, et le générateur refuse tout message natif sans titre. | Corrigé, limite : traductions sans relecture native | [Localisation](../test/l10n/corrections_20261029_l10n_test.dart), [avis du tunnel](../test/widget/corrections_20261029_home_shell_test.dart), [générateur](../tools/tests/test_generate_translations.py) |
| A16-ui-l10n-04 | P3 | `notice_retryAfter` est un pluriel ICU à argument entier dans les 30 langues, avec les catégories CLDR de chaque langue (one, few, many en ru, uk et pl ; zero à other en ar) ; un Retry-After de 1 s donne « Try again in 1 second. », et les variantes en minutes et en heures restent plurielles. | Corrigé, limite : traductions sans relecture native | [Localisation](../test/l10n/corrections_20261029_l10n_test.dart), [pluriels intégrés](../test/l10n/l10n_integration_20261029_test.dart) |
| A16-ui-l10n-05 | P3 | `AppFormats.date` et `AppFormats.longDate` convertissent l'instant en heure locale avant formatage : ajout d'appareil, reçu de diagnostic et dates d'abonnement suivent le jour local. Le test comporte des gardes indépendantes du fuseau de l'hôte. | Corrigé | [Dates locales](../test/widget/corrections_20261029_l10n_widgets_test.dart), [ligne d'appareil](../test/widget/device_row_test.dart) |
| A16-ui-l10n-07 | P3 | En néerlandais, MF devient « Saint-Martin » et SX « Sint-Maarten » ; en ourdou, les deux noms sont distincts. Le test des 30 langues et le générateur, y compris sous `-O`, refusent tout nom de pays dupliqué. | Corrigé, limite : libellés ourdous non relus par un locuteur natif | [Localisation](../test/l10n/corrections_20261029_l10n_test.dart), [générateur](../tools/tests/test_generate_translations.py) |
| A16-ui-l10n-08 | P3 | Les `assert` des générateurs de traductions sont remplacés par des contrôles explicites : toute violation sort en code 1 en mode normal, sous `-O` et sous `PYTHONOPTIMIZE`, rien n'est écrit avant la validation des 30 packs, et une garde AST interdit `assert` dans `tools/*.py`. | Corrigé | [Générateur de traductions](../tools/tests/test_generate_translations.py) |
| A17-supply-chain-02 | P3 | wireguard-go est épinglé au commit `b3bc704`, qui contient le correctif de longueur IPv6, avec l'AAR approuvé, ses métadonnées et la distribution des sources réalignés ; un test Go hors ligne échoue sur l'ancien commit et passe sur `b3bc704`, et le runner vérifie et enregistre la chaîne Go. | Corrigé | [Longueur IPv6](../tools/tests/test_wireguard_ipv6_length.py), [cas Go](../tools/tests/wireguard_ipv6_length/ipv6_length_test.go), [AAR approuvé](../tools/tests/test_wireguard_native_clock.py) |
| A17-supply-chain-03 | P3 | Les notices, le guide de distribution des sources et le README-SOURCE généré nomment le moteur épinglé (wireguard-go `b3bc704`, AAR `bf563b77…`, Go 1.26.9, trois patches dans l'ordre de `series`) ; `LICENSING.md` renvoie aux notices et qualifie l'ancien SPDX d'historique, et un test lit les épingles du dépôt pour refuser toute version divergente. | Corrigé | [Documents de la chaîne](../tools/tests/test_supply_chain_docs.py) |
| A17-supply-chain-04 | P3 | Le générateur SBOM émet Asio, fmt, lz4, wireguard-tools (GPL-2.0-only) et les artefacts du moteur Flutter, et lit la version de Dart et la révision du moteur dans chaque `libflutter.so` de l'AAB inspecté ; hors les trois AAB versionnés antérieurs à l'exclusion, tout AAB qui livre encore `libwg.so` ou `libwg-quick.so` est refusé, quel que soit le périmètre déclaré. | Corrigé, limite : SPDX release versionné non régénéré | [SBOM release](../tools/tests/test_generate_release_sbom.py) |
| A17-supply-chain-05 | P3 | Les notices des AAR Google sont reproduites à l'octet près dans le registre de licences, avec contrôle de fraîcheur dans le runner ; `libwg.so` et `libwg-quick.so` (wireguard-tools GPL-2.0, netlink LGPL) sont exclus de toutes les variantes. L'écran de licences affiche la version installée et renvoie aux sources MPL-2.0 du tag `v<version>` (au dépôt si la version est inconnue), dans les 30 langues. | Corrigé, limite : rétention R8 non établie, AAB release final non reconstruit | [Notices des SDK Google](../test/widget/corrections_20261029_google_notices_test.dart), [version et sources](../test/widget/licenses_version_test.dart), [générateur des notices](../tools/tests/test_generate_google_sdk_notices.py) |
| A17-supply-chain-06 | P3 | Gradle passe à 9.8.2, au-delà de 9.8.1 qui corrige les trois avis ; la version 9.5.2 annoncée par l'audit n'existe pas. `gradle-wrapper.properties` et les amorces `gradlew` vérifient l'empreinte SHA-256 officielle de la distribution 9.8.2. | Corrigé (validation-02) | [Intégrité des dépendances](../tools/test_dependency_integrity.ps1), [wrapper officiel 9.8.2](../tools/tests/test_gradle_wrapper.py) |
| A17-supply-chain-07 | P3 | `gradle-wrapper.jar` est le JAR officiel 9.8.2 (empreinte égale à la somme publiée, `Main-Class` présent) ; `gradlew` et `gradlew.bat` restent des amorces autonomes qui vérifient la distribution et n'exécutent pas ce JAR. | Corrigé (validation-02) | [Amorce du wrapper](../tools/test_dependency_integrity.ps1), [wrapper officiel 9.8.2](../tools/tests/test_gradle_wrapper.py) |
| A18-tooling-evidence-02 | P3 | La complétude de l'export dérive ses entrées du runner : scripts PowerShell et Python lancés, suivis récursivement, modules découverts, fichiers lus par les tests Dart, fermetures Kotlin et CMake/C++ ; une entrée exigée omise est détectée, et le README ne promet plus que ce qui est contrôlé. | Corrigé, limite : contrôles statiques, sans compilation de l'archive | [Export des sources](../tools/tests/test_package_android_sources.py) |
| A18-tooling-evidence-03 | P3 | Les reçus du runner sont lus sans `datetime.fromisoformat` : l'horodatage PowerShell au format `o` (7 chiffres de fraction, `Z` ou décalage) est analysé par une expression ASCII compatible Python 3.10, et une garde AST empêche le retour de `fromisoformat`. | Corrigé, limite : Python 3.10 émulé, non exécuté | [Instants des reçus](../tools/tests/test_receipt_instants.py) |
| A18-tooling-evidence-07 | P3 | Sans privilège de lien symbolique, la jonction reste créée et refusée par l'export, et le seul saut du lien symbolique, nommé et listé, est accepté par la synthèse ; tout autre saut fait échouer la validation. | Corrigé, limite : absence de privilège modélisée | [Liens et jonctions](../tools/tests/test_package_android_sources.py), [sauts acceptés](../tools/tests/test_validation_support.py) |
| C5-Analyseurs-stricts-face-au-con-01 | P3 | `advertisedIpv6` ne lève plus : IPv6 n'est proposé que si la liste contient `ipv4` et `ipv6`, dans n'importe quel ordre, les autres éléments étant ignorés ; une liste sans l'une des deux familles ou une autre forme laisse la ligne en IPv4 sans invalider le catalogue ni la liste d'appareils, et l'activation est lue en ensembles. | Corrigé | [Modèles](../test/core/corrections_20261029_models_test.dart), [IPv6](../test/core/ipv6_test.dart) |
| C5-Analyseurs-stricts-face-au-con-02 | P3 | Pour une migration acceptée, le Retry-After est converti (HTTP-date relative à `Date`), borné à 300 s, réduit au plus long en cas d'en-têtes joints ou ignoré s'il est illisible ; l'identifiant de migration est conservé et le suivi attend 2 s par défaut, avec un nombre de vérifications borné. | Corrigé | [Retry-After](../test/core/corrections_20261029_retry_after_test.dart), [modèles](../test/core/models_test.dart) |
| C5-Analyseurs-stricts-face-au-con-03 | P3 | Un début refusé publie `google.busy` sans lire ni remplacer le ticket ; sans intention chargée, Annuler relit le ticket persisté, réconcilie un claim par `/me` et l'annule côté API avant de l'effacer. Si la lecture ou l'annulation échoue, rien n'est effacé et aucun nouveau choix Google n'est ouvert ; seul un ticket corrompu ou à charge invalide est supprimé sans appel API. | Corrigé, limite : annulation déjà confirmée rejouée après redémarrage | [Contrôleur Google](../test/google_corrections_20261029_controller_test.dart), [page Google](../test/google_corrections_20261029_page_test.dart) |
| C5-Analyseurs-stricts-face-au-con-04 | P3 | `ApiRetryAfter` lit secondes et HTTP-date (mesurée depuis l'en-tête `Date`, sinon l'horloge locale), borne à 86 400 s au lieu de rejeter et garde le plus long délai d'en-têtes joints ; la garde de finalisation Google s'applique à claim, register et link, et un long délai s'affiche en heures. | Corrigé | [Retry-After Google](../test/core/corrections_20261029_google_retry_after_test.dart), [Retry-After](../test/core/corrections_20261029_retry_after_test.dart) |
| C5-Analyseurs-stricts-face-au-con-05 | P3 | `_isIpv4Address` exige la forme IPv4 canonique du natif (chiffres ASCII, octets au plus 255, sans signe, espace ni zéro initial) pour les DNS, l'endpoint OpenVPN et les CIDR ; les formes non canoniques sont refusées dès l'analyse de la réponse, et le natif les refuse aussi au lieu de les normaliser. | Corrigé | [Modèles](../test/core/corrections_20261029_models_test.dart), [contrat natif](../android/app/src/test/kotlin/com/fuzevpn/android/NativeInputContractTest.kt) |
| H-B-02-PROXY-01 | P3 | La lecture du tunnel CONNECT s'arrête quand aucun octet n'est disponible : `read()` n'est plus appelé à vide, et une réponse fragmentée ou livrée octet par octet garde le tunnel, assertions actives comprises. | Corrigé | [Transport proxy](../test/core/io_api_http_proxy_test.dart) |
| H-B-02-PROXY-02 | P3 | Le parseur CONNECT termine une ligne sur LF, avec ou sans CR, et accepte l'obs-fold après le premier champ, comme le SDK ; un CR nu, un repli initial et les réponses hors bornes (plus de 16 Kio d'en-têtes cumulés, plus de 4 réponses intermédiaires, statut 101) sont refusés immédiatement, sans attendre l'échéance. | Corrigé | [Transport proxy](../test/core/io_api_http_proxy_test.dart) |
| H-R11-01-01 | P3 | Chaque opération de facturation capture la révision du message qu'elle efface ; un résultat tardif n'est publié que si aucun message plus récent ne l'a été entre-temps, si bien qu'une vérification réussie n'est plus écrasée par `billing.comingSoon`. | Corrigé, limite : échec propre masqué par une vérification plus récente | [Ordre des messages](../test/billing_message_order_test.dart) |
| H-R13-01-01 | P3 | La restauration classe un reçu premium sans propriétaire ou d'un autre compte comme non rattaché et publie `billing.playReceiptUnlinked` (ou `billing.playOnHold`) au lieu de « Aucun achat à restaurer » ; l'achat est masqué et « Gérer l'abonnement » proposé, y compris pour un invité connecté, sans jamais vérifier ce reçu pour le compte. | Corrigé, limite : reçu disparu de Play bloquant jusqu'à la lecture suivante | [Reçus Play](../test/billing_play_receipts_test.dart), [page Premium](../test/widget/subscription_paywall_play_block_test.dart), [invité connecté](../test/guest_controller_test.dart) |
| H-R35-01-01 | P3 | Les horodatages produits sous une locale JVM à chiffres non latins ou à calendrier bouddhiste ou japonais sont lus sans réécrire le XML (chiffres ramenés en ASCII, année grégorienne, bouddhiste ou d'ère japonaise) ; chaque lecture doit tomber dans la fenêtre de la campagne, et les anciennes campagnes restent refusées. | Corrigé, limite : année d'ère japonaise ambiguë entre ères | [Validateur de preuves](../tools/tests/test_validation_support.py) |
| H-RA-A08-01-03 | P3 | La règle « l'échéance la plus longue gagne » est épinglée par trois tests (120/10, 10/120 et 120/120 s) qui vérifient l'échéance après soumission et reprise, le blocage juste avant et le déblocage à l'échéance. | Corrigé | [Retry-After Google](../test/google_auth_controller_test.dart) |
| H-RA-A08-01-04 | P3 | Le formulaire rouvert après un claim limité porte `google.rateLimited` ; la page affiche le message et un compte à rebours rafraîchi chaque seconde, puis réactive le bouton et masque le message caduc à l'échéance. | Corrigé | [Contrôleur Google](../test/google_corrections_20261029_controller_test.dart), [page Google](../test/google_corrections_20261029_page_test.dart) |

**Limites restantes du lot**
- A17-supply-chain-01 : hors dépôt, le SDK Flutter du runner CI et la configuration externe de `tools/release_aab_safe.py` doivent désigner Flutter 3.47.8.
- A17-supply-chain-06 et A17-supply-chain-07 : les empreintes officielles de la distribution Gradle 9.8.2 et du JAR du wrapper ont été relevées une seule fois, sans seconde source indépendante.
- A13-03 : l'acceptation des catégories par le serveur n'est pas requalifiée, seules des catégories déjà au registre v1 étant utilisées ; les producteurs Kotlin et C++ sont inventoriés par lecture des sources, sans exécution, et l'inventaire des codes API se limite à ceux que le client connaît.
- A03-google-01 : les blocages Retry-After appartiennent à l'intention et ne survivent pas à l'arrêt du processus, comme le documente `docs/GOOGLE_AUTH.md`.
- A03-google-04 : sans données de lecture embarquées, ja et zh restent triés en ordre Unicode ; les règles par langue couvrent les lettres des 30 langues livrées, pas toutes les règles CLDR.
- A07-billing-02 : la réponse serveur réelle d'un abonnement suspendu (account hold) n'a pas été observée ; l'hypothèse `past_due` est documentée.
- A10-wireguard-05 : l'import complet n'est pas exécutable hors ligne ; une réimportation produit des fins de ligne LF, différentes à l'octet de l'arbre versionné, et impose de reconstruire l'AAR ; le câblage du script d'import n'est vérifié que textuellement.
- A05-models-01 : une ligne d'emplacement non conforme est écartée du catalogue sans message à l'utilisateur.
- A16-ui-l10n-07 : les libellés ourdous de MF et SX n'ont pas été relus par un locuteur natif.
- A05-models-02, A16-ui-l10n-03, A16-ui-l10n-04 et A17-supply-chain-05 : les nouvelles chaînes des 30 langues ont été rédigées sans relecture native.
- A17-supply-chain-04 : aucun SPDX release versionné ne contient encore les composants ajoutés ; il est à régénérer après la construction de l'AAB Flutter 3.47.8. Les versions internes d'Asio, fmt, lz4 et OpenSSL ne sont pas lues dans le binaire, et le moteur Flutter reste sans licence déclarée (`NOASSERTION`).
- A17-supply-chain-05 : la rétention R8 de chaque composant Google n'est pas établie (notices affichées par excès) ; l'exclusion de `libwg.so` et `libwg-quick.so` est contrôlée sur la fusion debug arm64, l'AAB release final n'étant pas reconstruit.
- A18-tooling-evidence-02 : les contrôles de complétude sont statiques, sans compilation de l'archive ; les chemins calculés à partir de données, de paramètres ou de l'environnement ne sont pas suivis.
- A18-tooling-evidence-03 : aucun Python 3.10 réel sur le poste ; la grammaire 3.10 est émulée et la syntaxe contrôlée statiquement.
- A18-tooling-evidence-07 : l'absence de privilège de lien symbolique est modélisée, le poste de validation disposant de ce privilège.
- C5-Analyseurs-stricts-face-au-con-03 : après un redémarrage, une copie dont l'annulation était confirmée mais l'effacement local en échec est de nouveau présentée à l'API ; une réponse autre que succès, `expired` ou `consumed` garde l'écran, en attendant que le contrat serveur fixe ce cas. De même, l'ancien ticket d'une tentative, resté sur le disque après l'échec d'enregistrement du ticket renouvelé, est encore présenté à l'API avec la même limite, documentée dans `docs/GOOGLE_AUTH.md`. Un ticket corrompu, supprimé sans appel faute de pouvoir être lu, n'est pas annulé côté serveur, où l'intention expire d'elle-même.
- C5-Analyseurs-stricts-face-au-con-05 : hors périmètre de l'écart, l'endpoint WireGuard n'est validé que comme texte côté Dart.
- H-R11-01-01 : un échec propre (par exemple `price_changed`) est lui aussi masqué si une vérification plus récente a publié son message pendant le lancement.
- H-R13-01-01 : un reçu d'un autre propriétaire qui disparaît de Play en cours de session reste bloquant jusqu'à la lecture suivante (restauration, retour au premier plan ou refus `already_owned`).
- H-R35-01-01 : une même année d'ère japonaise désigne plusieurs ères ; un XML écrit exactement une ère plus tôt, au même jour et à la même seconde, ne se distinguerait pas d'un XML frais, la date de modification du fichier restant contrôlée.

## Chaîne d'outils

- **Flutter 3.47.8 / Dart 3.13.7** (A17-supply-chain-01) corrige l'avis TLS
  GHSA-frr6-h895-5pxp.
  - Moteur : `cf636b1dfb818dd6a3ff16e390e93b1a036969c8`.
  - SDK vérifié contre `releases_windows.json` :
    `11e19ea3409808fe3b3765ea8149640c299e58cce6eda7c9f38fc1b4a193eb6e`.
  - `pubspec.yaml` exige `flutter: '>=3.47.8'` : un SDK vulnérable est
    refusé dès `pub get`.
  - Le verrou ne change que les cinq paquets imposés par le SDK : `intl`
    0.20.3, `matcher` 0.12.20, `test_api` 0.7.12, `meta` 1.18.3,
    `vector_math` 2.4.0.
  - Les 31 goldens ne diffèrent que par l'anticrénelage des coins arrondis
    (0,02 % à 1,17 % des pixels).
- **Gradle 9.8.2** (A17-supply-chain-06) corrige les trois avis
  GHSA-j5m7-59rp-24f5, GHSA-xwqc-3h47-hg64 et GHSA-mvvg-497x-hmj8.
  - Versions affectées : avant 8.14.6, et de 9.0.0 à 9.8.0. Versions
    corrigées : 8.14.6 et 9.8.1.
  - Distribution : `21bd5da2de49b642904077f38c0efdc7778e92b3ed0889392dca61b97e389607`.
  - `verification-metadata.xml` passe de 704 à 750 composants. Chaque
    empreinte ajoutée a été recalculée sur un téléchargement direct depuis le
    dépôt officiel.
  - `verify-metadata` reste actif, et rien n'est relâché.
- **Wrapper Gradle** (A17-supply-chain-07) : le JAR officiel 9.8.2
  `3b8a25775a69158b5ad2b1d17a80a88dc7b40a352a73eb27d06c612a7ce68e98` est
  produit par `gradle wrapper`. Les scripts autonomes du dépôt (contrôle
  SHA-256 de la distribution) sont conservés.
- **wireguard-go `b3bc704ef0ee`** (A17-supply-chain-02) lit la longueur IPv6
  sur 32 bits. Le runtime Go 1.26.9 est patché pour que `time.now` utilise
  `CLOCK_BOOTTIME` sur linux/amd64 (A10-wireguard-04).
  - Empreinte de l'AAR approuvé :
    `bf563b779e670647e7d47751e7f4ff5d90299272640af7814c52f74bfe8c4b73`.
  - Les binaires `libwg.so` et `libwg-quick.so` de wireguard-tools sont
    exclus de l'APK et de l'AAB. Leur licence GPL-2.0 ne figure donc plus sur
    l'écran des licences.

## Validation locale intégrée

Les deux passages de `tools/validate_project.ps1` ont réussi, avec 24 étapes
sur 24 et aucun saut accepté.

| Passage | État des sources | Flutter / Gradle | Flutter | JVM | Python | Hôtes JUnit (Turnstile / command-epoch / bridge-host) | Release gate WireGuard |
| --- | --- | --- | --- | --- | --- | --- | --- |
| validation-01, 30/10 11:04 UTC | lots figés, avant la passe finale | 3.44.7 / 9.5.0 | 2778 | 389 (44 classes) | 206 | 44 + 20 JS / 26 / 33 | 17/17 |
| validation-02, 30/10 12:57 UTC | état final | 3.47.8 / 9.8.2 | 2824 | 391 (45 classes) | 223 | 44 + 20 JS / 27 / 43 | 17/17 |

Les deux passages relèvent 0 erreur de lint et 2 avertissements `UseKtx`.

Le `summary.json` de validation-02 porte le SHA-256
`27cae0baba95f072c8e92b17f925de164c59902eeac582d5d38b49621b4a91f4`, et son
`steps.json` porte
`6c7e77338ef89d5bd89a0d8b2986ac7f3a52b031f5f99ee3ab8067230310b32d`.
Pendant ce passage, seuls les 30 fichiers `lib/l10n/generated/` ont été
réécrits par `pub get`, à l'identique octet pour octet.

Après validation-02, un seul fichier a été ajouté : `tools/tests/test_gradle_wrapper.py`. Il épingle le JAR officiel et la distribution 9.8.2 (A17-supply-chain-06 et 07). La suite Python, relancée ensuite, passe à 226 sur 226.

Le runner contrôle maintenant deux points de plus :
- la chaîne Go (1.23.1 minimum, reçu `go-version.txt`) ;
- la stabilité des fichiers de traduction générés après `pub get`.

Ses minimums de tests hôtes valent le nombre de cas versionnés.

Un premier essai de validation-01 avait échoué sur 2 tests Python sur 206.
Lancé depuis pwsh 7 par l'intermédiaire de Python, Windows PowerShell 5.1
héritait de `PSModulePath` et perdait `Get-FileHash`. Le test lance
maintenant 5.1 avec ses propres chemins de modules.

## Limites et suites hors dépôt

Ces suites sont à faire hors du dépôt ou relèvent d'un contrat externe :

- **Runner CI auto-hébergé** : `FUZEVPN_FLUTTER_ROOT` doit désigner un SDK
  Flutter 3.47.8, et `FUZEVPN_GO` une chaîne Go 1.23.1 ou plus récente
  (déclarée dans `.github/workflows/validate.yml`). Il faut préparer le cache
  une fois par `workflow_dispatch` avec `prepare_dependencies=true` : nouveaux
  artefacts `io.flutter`, Kotlin 2.4.x et distribution `fuzevpn-gradle-9.8.2`.
- **Construction de release** : la configuration externe de
  `tools/release_aab_safe.py` doit pointer `flutter_root` sur 3.47.8. Après la
  prochaine construction de l'AAB, il faut régénérer le SPDX release avec
  `tools/generate_release_sbom.py`, puis le référencer dans
  [le SBOM](SBOM.release.md) et dans les README (A17-supply-chain-04).
- **Publication** : chaque version distribuée doit être publiée sous le tag
  `v<version>` vers lequel pointe désormais l'écran des licences (voir
  [LICENSING.md](../LICENSING.md)).
- **Contrat serveur** : trois hypothèses restent à confirmer côté serveur.
  - la réponse à une deuxième annulation Google d'un même ticket, et le
    traitement de `google_context_consumed` ([Google](GOOGLE_AUTH.md)) ;
  - l'état `past_due` d'un abonnement suspendu (A07-billing-02) ;
  - l'acceptation des catégories de diagnostic alias (A13-03).
- **Gradle 10** : Gradle 9.8.2 signale des fonctions dépréciées du plugin
  Flutter 3.47.8 (`AbstractAppExtension`). `android.builtInKotlin=false` et
  `android.newDsl=false` restent donc nécessaires.
- **Appareil** : aucune instrumentation ni aucun essai sur appareil n'a été
  exécuté. La tuile, la reprise système, Always-on, les restrictions de
  lancement d'Android 14 à 16, les vrais WebView, TUN et moteurs natifs sont
  qualifiés sur JVM et sur hôte, avec des doubles de test, comme le précisent
  les limites de chaque lot.
- **Traductions** : les nouvelles chaînes des 30 langues n'ont pas été relues
  par des locuteurs natifs.

## Conservation

Ces corrections forment un seul commit sur la branche
`fix/reaudit-20261028`, au-dessus du commit de base
`a15bf81d3de3d3349d926380651d006ff24a4272`.

Ce commit compte 252 fichiers modifiés, 170 fichiers ajoutés et 1 suppression
(`assets/licenses/WIREGUARD-TOOLS.txt`). Les fichiers ajoutés portent du code
et des preuves indispensables, par exemple `lib/core/api_socket_open.dart` et
`test/session/**`. Il reprend aussi les fichiers des corrections du 19 et du
28 octobre qui n'étaient pas encore suivis.
