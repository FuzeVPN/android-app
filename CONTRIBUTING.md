# Contributing

Use issues for reproducible bugs and scoped feature proposals. Report security
issues privately as described in [SECURITY.md](SECURITY.md).

Before opening a pull request:

1. Describe the observable problem, the resulting behavior and the affected
   Android/API configuration.
2. Keep changes focused. Do not include caches, generated build outputs,
   credentials, signing material, live VPN profiles or user diagnostics.
3. Follow the existing architecture and update the relevant maintained guide.
4. Run the checks appropriate to the change in
   [docs/DEVELOPMENT.md](docs/DEVELOPMENT.md). State exactly what ran and what
   still needs a real device, Google account or compatible test backend.
5. For translated text, edit the thirty source packs in
   `lib/l10n/translations/` and regenerate their outputs. Inspect intentional
   golden-image changes before accepting them.
6. Preserve upstream licenses and file notices. Record native modifications
   as ordered patches and follow the provenance procedure; changing a hash
   does not approve a new binary.

The root MPL-2.0 declaration applies to new original source files unless a
different scope is agreed and documented. Contributions to an already
licensed file use that file's license. Submit only material you have the
right to contribute; identify copied third-party material and its origin.

Do not call production APIs or make paid purchases as part of an ordinary
local test. Network/device qualification requires a suitable test account,
Google license tester and explicitly authorized environment. Local fakes and
compilation are not a qualification of real Google sign-in or VPN behavior.

Maintainers may request changes for correctness, license provenance,
privacy, compatibility or missing validation. No response-time guarantee is
made. This repository publishes sources only.
