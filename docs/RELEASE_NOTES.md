# Android 0.2.10+74016 — 2026-10-14

## Français

- Le statut de connexion ajuste sa taille de base à la largeur des mots :
  Déconnecté reste entier sur les téléphones à texte 200 %, notamment avec
  les scaleurs linéaires Android 12/13. Les autres statuts suivent cette règle.
- L’agrandissement demandé et les libellés restent complets ; les statuts qui
  tiennent déjà gardent leur taille, y compris avec le scaleur non linéaire
  Android 14 et suivants. La région live et les boutons sont conservés.

## English

- Connection status labels fit whole words on narrow phones with 200% text,
  including Android 12/13 linear scaling. Labels keep the full accessibility
  scaler and their original size whenever they already fit. Live semantics
  and connection/stop actions are retained.

## Qualification / Validation

The client retest validates 74015 startup and real OpenVPN on Android 13 and
real WireGuard/OpenVPN recovery on Android 14–17. This update corrects the
reported status word split; its regression checks and images are generated
from the new source. Native engines and the Android 12/13 translation limitations
remain unchanged. One universal signed ARM APK; no AAB, publication or backend change.

---

# Android 0.2.9+74015 — 2026-10-14

## Français

- WireGuard charge son moteur natif au premier démarrage du tunnel, sur son
  worker. L’interface, les lectures d’état au repos et OpenVPN ne chargent
  plus ce moteur au démarrage. Cela isole ces parcours du SIGILL du runtime
  Go ARM64 traduit dans les VM Android 13.
- Les moteurs natifs et les corrections réseau/interface/favoris de 74014
  restent inchangés. La connexion WireGuard dans les VM Android 12/13 garde
  une limite de traduction ARM ; elle doit être qualifiée sur matériel ARM.

## English

- WireGuard loads its native engine on its worker when first starting a tunnel.
  Startup, idle state reads and OpenVPN no longer load that engine, isolating
  those paths from the translated ARM64 Go runtime SIGILL on Android 13 VMs.
- Native engines and the 74014 network/UI/favorites corrections are unchanged.
  WireGuard on the Android 12/13 VMs still requires native ARM qualification.

## Qualification / Validation

The user retest validates 74014 real WireGuard/OpenVPN tunnels and network recovery
on Android 14/17. This release fixes eager loading of the unused WireGuard engine;
isolated ARM tests cover initialization, idle operations and deferred worker use.
They do not establish real ARM hardware or live VPN compatibility on Android 12/13.
One universal signed ARM release APK; no AAB, Play publication or backend changes.

---

# Android 0.2.8+74014 — 2026-10-13

## Français

- L’observation des réseaux physiques WireGuard inclut les réseaux des autres
  UID sur Android 12 et suivants. Le cache des événements est recoupé chaque
  seconde avec l’inventaire local tant que le tunnel reste actif, y compris
  sans Flutter. Une entrée périmée ne peut plus maintenir « Connecté » après
  une coupure complète ; une commande de préparation ne suspend plus cette
  observation.
- Le retour du réseau exige toujours une nouvelle preuve du pair avant
  « Connecté ». Les moteurs natifs, les traductions et les corrections
  d’interface/favoris de 74013 sont conservés.

## English

- WireGuard physical network observation includes other UID networks on
  Android 12 and later. While a tunnel remains active, the event cache is
  reconciled with Android’s local inventory every second, including without
  Flutter. Stale entries cannot retain Connected after a complete outage;
  preparation commands no longer suspend observation.
- Network return still requires fresh peer evidence before Connected. Native
  engines, translations and the 74013 interface/favorites corrections are retained.

## Qualification / Validation

Le retest utilisateur de 74013 confirme les corrections du formulaire, des titres
et des favoris, ainsi que la coupure WireGuard sur Android 15/16 ; il constate
encore « Connecté » hors réseau sur Android 14/17. Les régressions 74014 portent
sur l’observation native. Les tests isolés injectent un tunnel synthétique sans
compte ni backend ; ils ne qualifient pas une connexion VPN réelle du nouvel APK.
Les crashes de traduction ARM Android 12/13 restent ouverts. Un APK universel
ARM32/ARM64 est construit et signé localement ; aucun AAB ni publication.

---

# Android 0.2.7+74013 — 2026-10-13

## Français

- WireGuard affiche l'attente de réseau après une coupure complète et confirme
  la reprise avec une nouvelle preuve du pair, en conservant le tunnel local.
  La notification et la tuile Android suivent l'état ; l'arrêt reste accessible.
- Les champs de connexion restent renseignés après une erreur et sa fermeture,
  y compris dans la fenêtre de connexion depuis les réglages invités.
- Les titres s'adaptent aux mots sur les écrans étroits avec du texte agrandi,
  sans limiter l'agrandissement d'accessibilité ni tronquer les libellés.
- Le chargement lent ou échoué des favoris possède un état distinct de la
  sauvegarde. Une lecture tardive peut aboutir et une erreur peut être retentée
  sans écraser les favoris enregistrés avant leur chargement.

## English

- WireGuard shows network waiting after complete network loss and requires
  fresh peer evidence before reporting recovery, retaining the local tunnel.
  Android notifications and the quick tile follow the state; stopping stays available.
- Login fields survive an error and its dismissal, including guest settings login.
- Headings fit whole words on narrow screens with enlarged text while retaining
  the user's accessibility scale and complete labels.
- Slow or failed favorites loading is separate from saving. Late reads can
  complete, and retry never overwrites saved favorites before they are loaded.

## Qualification / Validation

Local source corrections and regression checks; one signed ARM32/ARM64 release
APK is prepared separately. No App Bundle, Play publication, backend change or
new real VPN campaign is part of this update. Test counts and binary fingerprints
belong to the local delivery report. Android 12/13 ARM translation failures in
x86_64 emulators remain a qualification limitation for physical ARM devices.

---

# Android 0.2.6+74012 — 2026-10-11

## Français

- L’écran Fuze Premium présente les avantages, les formules et les conditions
  de renouvellement dans une nouvelle composition adaptée aux différentes tailles
  d’écran, aux thèmes et au texte agrandi.
- L’offre Google Play `freetest` est prise en charge sur `monthly` et `yearly`.
  L’essai de deux semaines apparaît seulement lorsque Google le propose au compte
  Play éligible. Le forfait normal reste disponible sinon.
- Le tarif récurrent exact reste affiché avec sa périodicité ; il n’est pas remplacé
  par le prix nul de l’essai. La date du premier débit est une prévision si l’essai
  commence aujourd’hui, avec confirmation finale dans Google Play.
- Une offre modifiée avant validation bloque le lancement avec les anciennes
  conditions et demande une nouvelle sélection. Aucun forfait n’est présélectionné.
- Les nouveaux textes sont disponibles dans les trente langues. Les reçus et
  droits restent vérifiés par le serveur, y compris pendant l’essai.

## English

- The Fuze Premium screen presents benefits, plans and renewal terms in a new
  layout that adapts to screen size, themes and large text.
- The Google Play `freetest` offer is supported on `monthly` and `yearly`.
  The two-week trial is shown only when Google returns it for the eligible
  Play account. Otherwise the regular base plan remains available.
- The exact recurring price and period remain visible alongside the free trial.
  The first charge date is estimated for a trial starting today and the final
  terms are confirmed by Google Play.
- Changed offer terms invalidate the old selection instead of silently replacing
  it. No plan is preselected.
- New copy is available in all thirty languages. Receipt and access verification
  remain server-controlled, including during the trial.

## Qualification / Validation

See [free trial integration](FREE_TRIAL.md) for Google configuration, client
behavior and backend requirements. The source changes and automated regression
checks do not establish that the live backend grants trial access correctly,
that Play Console offers are active in every region, or that a new real purchase
has been completed. No live backend inspection or change was performed for this
integration. APKs, bundles and signing credentials remain outside this repository.

---

# Android 0.2.5+74011 — 2026-10-11

## Français

- Une mention VPN dédiée explique le tunnel et les données nécessaires à la
  connexion, avec un accord explicite avant la permission Android et une
  possibilité de refuser. Elle est disponible dans les trente langues.
- Un paiement Google Play annulé puis un retour ramènent l’invité non activé à
  l’accueil. **Démarrer** conserve son libellé après l’ouverture de la connexion
  ou des formules. La session invitée reste disponible pour reprendre l’achat.
- L’affichage de bord à bord gère les barres système, le clavier et les fenêtres
  d’identification, notamment sous Android 15 et versions ultérieures.
- Une indisponibilité `node_unavailable` affiche le message traduit de serveur
  indisponible (`target_unavailable`) et propose d’actualiser les emplacements ou
  d’en choisir un autre. La reprise reste manuelle, sans recréer l’appareil.
- La référence de diagnostic d’une erreur peut être sélectionnée ou copiée.
- La navigation s’adapte mieux au texte agrandi ; les traductions de la limite
  d’appareils sont corrigées.

## English

- A dedicated VPN disclosure explains the tunnel and the data needed for the
  connection, with explicit consent before Android permission and an option
  to decline. It is available in all thirty languages.
- Cancelling Google Play checkout and going back returns a guest without a
  confirmed activation to the welcome screen. **Get started** keeps its label
  after opening sign-in or plans. The guest session is retained for a retry.
- Edge-to-edge layouts handle system bars, the keyboard and sign-in dialogs,
  including on Android 15 and later.
- A `node_unavailable` error shows the translated server-unavailable message
  (`target_unavailable`) and offers location refresh or selection of another
  location. Recovery remains manual and does not recreate the device.
- Error diagnostic references can be selected or copied.
- Navigation better accommodates large text; device-limit translations are
  corrected.

## Qualification / Validation

This is a source update and a new local Android delivery. It does not establish
which version is distributed by Google Play. APKs, App Bundles and signing
credentials are kept outside the public repository.

Regression coverage is maintained in the repository, including
[onboarding returns](../test/widget/onboarding_return_test.dart),
[edge-to-edge layouts](../test/widget/edge_to_edge_layout_test.dart),
[UI errors and diagnostics](../test/widget/app_ui_test.dart), and
[account-scoped onboarding storage](../test/native_guest_onboarding_storage_test.dart).
No current test counts or live service qualification are asserted here.

The real Google Play test purchases and VPN checks recorded for **74008** on
2026-10-04 are historical evidence for that version. They do not qualify this
new delivery. Real native Google sign-in, a real pending payment, guest purchase
restoration on another device, account creation while OpenVPN is already
connected, and complete revocation remain unconfirmed for **74011**.
