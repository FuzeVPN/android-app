# FuzeVPN for Android

[Français](README.fr.md)

The FuzeVPN app for Android: WireGuard and OpenVPN tunnels, thirty languages,
Google Play subscriptions and guest access. It runs on **Android 8.0 (API 26)
or later**; its package is `com.fuzevpn`.

This repository holds the app's source code and its reviewed native build
inputs. The FuzeVPN backend and VPN infrastructure are separate services and
are not included here.

## Download

Current version: **0.2.11** (build 74018).

Signed APKs are attached to each
[GitHub release](https://github.com/FuzeVPN/android-app/releases), with their
SHA-256 checksums and the matching source archive. App Bundles are not
published. The [APK guide](docs/APK.md) tells which file fits your phone and
how to check it before installing.

If you installed FuzeVPN from Google Play, keep updating it there: Google Play
and GitHub builds are signed with different keys, so one cannot update the other.

## What's new in 0.2.11

- The connection card says "Preparing" as soon as you tap Connect, and every
  OpenVPN location change shows its progress, step by step.
- From Android 11, always-on VPN comes back on its own after the app is
  stopped by a crash or by Android, even when the quick settings tile or
  another component restarts the app first (Android 10: without that
  fallback, untested).
- OpenVPN keeps transfers running when the phone switches back to Wi-Fi.
- Android 11: no more crash at startup; Android 8 to 11: no more crash when the
  VPN service is stopped right after it starts.
- With very large text (200 %), confirmation dialogs no longer cut words.
- Less work while connected and on the Account tab.

Details in the [release notes](docs/RELEASE_NOTES.md).

## Features

- WireGuard and OpenVPN tunnels integrated with Android VPN services.
- Dedicated VPN disclosure and explicit consent before Android permission,
  with an option to decline. See the [video walkthrough](docs/VPN_DISCLOSURE.md).
- Country/city locations, search, favourites and confirmed location changes.
- Thirty languages, light/dark themes and right-to-left layouts.
- Explicit diagnostic consent and encrypted local session/device storage.
- Google Play subscriptions with localized prices and purchase restoration.
- Guest access followed by optional account creation, and Google sign-in.
- A separate sign-in dialog in guest settings: signing into another account
  replaces the session after verification; it does not claim the guest or
  transfer its subscription. Account creation remains a separate action.

Release/profile builds use the production API origin; the API override is
debug-only. See the integration guides before running network-dependent tests.

## Build from source

The reviewed toolchain is Flutter **3.47.8** (Dart **3.13.7**), JDK **17**, Android Platform **36**,
NDK **28.2.13676358** and CMake **3.22.1**. Gradle **9.8.2**, Android Gradle
Plugin **9.3.0** and Kotlin **2.3.20** are pinned by the project.

Install the tools, set `JAVA_HOME` and `ANDROID_HOME`, and create your own
ignored `android/local.properties` with the SDK and Flutter paths.
Then, from the repository root:

```powershell
flutter pub get
python tools/generate_translations.py --check --require-all
flutter analyze --no-pub
flutter test --no-pub
flutter build apk --debug --no-pub --split-per-abi --target-platform android-arm64,android-arm,android-x64 --android-project-arg=fuzevpn.usePatchedWireGuardAar=true
```

Release and profile builds require the approved local WireGuard AAR through
`fuzevpn.usePatchedWireGuardAar=true`. Keep the AAR, static libraries,
source archives, patches and manifests: they are checked build inputs.
Signing credentials are neither included nor required to inspect the sources.

The native input checks establish integrity against reviewed manifests.
They do not, by themselves, establish byte-for-byte APK reproducibility.
The pinned SDKs and Maven/Pub dependencies must be installed separately.

## Documentation

Most detailed guides are maintained in French.

| Guide | Scope |
| --- | --- |
| [APK guide](docs/APK.md) | Which APK for which phone, installation, checks |
| [Release notes](docs/RELEASE_NOTES.md) | Changes by version and validation limits |
| [Full-audit corrections](docs/AUDIT_CORRECTIONS_20261029.md) | 81 findings, toolchain, two local validations and limits (in French) |
| [Re-audit corrections](docs/AUDIT_CORRECTIONS_20261028.md) | Eleven findings, local validation and control-build identities |
| [Latest release SPDX (28/10)](docs/SBOM.release.corrections-20261028.spdx.json) | Dependency resolution and the exact unsigned worktree AAB, produced before native components were listed ([release SBOM guide](docs/SBOM.release.md)) |
| [Development](docs/DEVELOPMENT.md) | Toolchain, build, tests and device qualification |
| [Architecture](docs/ARCHITECTURE.md) | Client behavior, storage, VPN lifecycle and expected API |
| [Native dependencies](docs/NATIVE_DEPENDENCIES.md) | Source revisions, patches, integrity and reconstruction |
| [Source distribution](docs/SOURCE_DISTRIBUTION.md) | Complete source export and binary correspondence limits |
| [Google Play](docs/PLAY_BILLING.md) | Purchases, restoration, ownership and server requirements |
| [Guest accounts](docs/GUEST_ACCOUNTS.md) | Guest sessions, account creation and separate sign-in |
| [Google authentication](docs/GOOGLE_AUTH.md) | Credential Manager and OAuth server contract |
| [Licensing](LICENSING.md) | MPL scope, existing exceptions and trademarks |
| [Third-party notices](THIRD_PARTY_NOTICES.md) | Component licenses and provenance |
| [Historical SPDX inventory (14/10)](docs/SBOM.spdx.json) | Source-level inventory of 14/10 with the former WireGuard engine; current versions in the [release SBOM guide](docs/SBOM.release.md) and [third-party notices](THIRD_PARTY_NOTICES.md) |

## Quality and audits

The [qualification registry](docs/VALIDATION.md) records what was tested, on
which version and environment, and its limits. Evidence keeps its original
version, signer and environment.

- Qualification audit of 14 October 2026: [Q001](docs/VALIDATION.md#q001), [Q002](docs/VALIDATION.md#q002), [Q003](docs/VALIDATION.md#q003), [Q004](docs/VALIDATION.md#q004), [Q006](docs/VALIDATION.md#q006), [Q009](docs/VALIDATION.md#q009), [Q018](docs/VALIDATION.md#q018), [Q019](docs/VALIDATION.md#q019), [Q020](docs/VALIDATION.md#q020), [Q021](docs/VALIDATION.md#q021), [Q023](docs/VALIDATION.md#q023), [Q030](docs/VALIDATION.md#q030), [Q031](docs/VALIDATION.md#q031), [Q032](docs/VALIDATION.md#q032), [Q033](docs/VALIDATION.md#q033).
  It records results by version: 74016 tunnels and recovery on Android 14–17
  VMs, historical 74008/API035 test purchases and RTDN, and documented blocks
  for native Google login, live freetest and native ARM.
- The [corrections of the full audit of 28 October 2026](docs/AUDIT_CORRECTIONS_20261029.md)
  (in French) address 81 findings (1 P1, 9 P2, 71 P3) and move the toolchain
  to Flutter 3.47.8 and Gradle 9.8.2.
- The [re-audit corrections of 28 October 2026](docs/AUDIT_CORRECTIONS_20261028.md)
  fix eleven source and tooling findings. The [19 October corrections](docs/AUDIT_CORRECTIONS_20261019.md)
  and earlier qualification evidence retain their original dates and limits.
- See the [evidence limits and maintained release tools](docs/RELEASE_EVIDENCE.md),
  including the two historical originals that could not be recovered.

## License and contributions

Original application code is published under **MPL-2.0**, except where an
existing file notice specifies otherwise. Third-party code, fonts, artwork,
SDKs and tools retain their own terms. The Google SDK dependencies mean this
repository does not claim that the complete APK is entirely free software.

FuzeVPN and Google names/logos have separate trademark rules; the software
license does not grant a right to present a fork as an official FuzeVPN app.
See [LICENSE](LICENSE), [LICENSING.md](LICENSING.md),
[CONTRIBUTING.md](CONTRIBUTING.md) and [SECURITY.md](SECURITY.md).
