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
