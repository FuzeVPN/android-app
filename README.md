# FuzeVPN for Android

Qualification audit, 14 October 2026: [Q001](docs/VALIDATION.md#q001), [Q002](docs/VALIDATION.md#q002), [Q003](docs/VALIDATION.md#q003), [Q004](docs/VALIDATION.md#q004), [Q006](docs/VALIDATION.md#q006), [Q009](docs/VALIDATION.md#q009), [Q018](docs/VALIDATION.md#q018), [Q019](docs/VALIDATION.md#q019), [Q020](docs/VALIDATION.md#q020), [Q021](docs/VALIDATION.md#q021), [Q023](docs/VALIDATION.md#q023), [Q030](docs/VALIDATION.md#q030), [Q031](docs/VALIDATION.md#q031), [Q032](docs/VALIDATION.md#q032), [Q033](docs/VALIDATION.md#q033).


[Français](README.fr.md)

Source code for the FuzeVPN Android client, version **0.2.10+74016**.
The app uses Flutter, Kotlin, WireGuard and OpenVPN. Its Android package is
`com.fuzevpn`; Android 8.0 (API 26) or later is required.

This repository publishes sources and reviewed native build inputs. It does
not publish APKs, App Bundles or GitHub Releases. The FuzeVPN backend and VPN
infrastructure are separate services and are not included here.

This version redesigns the Premium screen and supports the Google Play
`freetest` offer for eligible new subscribers, with exact recurring prices,
renewal terms and an estimated first charge date. See the
[release notes](docs/RELEASE_NOTES.md) and [trial guide](docs/FREE_TRIAL.md).

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

The 14 October audit records results by version: 74016 tunnels and recovery
on Android 14–17 VMs, historical 74008/API035 test purchases and RTDN,
and documented blocks for native Google login, live freetest and native ARM.
See the [qualification registry](docs/VALIDATION.md). Evidence keeps its
original version, signer and environment.
Release/profile builds use the production API origin; the API override is
debug-only. See the integration guides before running network-dependent tests.

## Build

The reviewed toolchain is Flutter **3.44.7**, JDK **17**, Android Platform **36**,
NDK **28.2.13676358** and CMake **3.22.1**. Gradle **9.5.0**, Android Gradle
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
| [Release notes](docs/RELEASE_NOTES.md) | Changes in 0.2.10+74016 and validation limits |
| [Development](docs/DEVELOPMENT.md) | Toolchain, build, tests and device qualification |
| [Architecture](docs/ARCHITECTURE.md) | Client behavior, storage, VPN lifecycle and expected API |
| [Native dependencies](docs/NATIVE_DEPENDENCIES.md) | Source revisions, patches, integrity and reconstruction |
| [Source distribution](docs/SOURCE_DISTRIBUTION.md) | Complete source export and binary correspondence limits |
| [Google Play](docs/PLAY_BILLING.md) | Purchases, restoration, ownership and server requirements |
| [Guest accounts](docs/GUEST_ACCOUNTS.md) | Guest sessions, account creation and separate sign-in |
| [Google authentication](docs/GOOGLE_AUTH.md) | Credential Manager and OAuth server contract |
| [Licensing](LICENSING.md) | MPL scope, existing exceptions and trademarks |
| [Third-party notices](THIRD_PARTY_NOTICES.md) | Component licenses and provenance |
| [SPDX inventory](docs/SBOM.spdx.json) | Source-level inventory and its limitations |

## License and contributions

Original application code is published under **MPL-2.0**, except where an
existing file notice specifies otherwise. Third-party code, fonts, artwork,
SDKs and tools retain their own terms. The Google SDK dependencies mean this
repository does not claim that the complete APK is entirely free software.

FuzeVPN and Google names/logos have separate trademark rules; the software
license does not grant a right to present a fork as an official FuzeVPN app.
See [LICENSE](LICENSE), [LICENSING.md](LICENSING.md),
[CONTRIBUTING.md](CONTRIBUTING.md) and [SECURITY.md](SECURITY.md).
