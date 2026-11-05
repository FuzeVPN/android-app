# Which APK should I install?

[Français](APK.fr.md)

Each FuzeVPN [GitHub release](https://github.com/FuzeVPN/android-app/releases)
offers three signed APKs. They contain the same app; only the processor type
they target differs.

| File | For which devices |
| --- | --- |
| `FuzeVPN-<version>-arm64-v8a.apk` | **Almost all recent phones and tablets** (64-bit ARM processor). Start with this one. |
| `FuzeVPN-<version>-armeabi-v7a.apk` | Older or entry-level phones running 32-bit Android, including many "Android Go" devices. Use it if the first file does not install. |
| `FuzeVPN-<version>-x86_64.apk` | Android emulators on a PC, some Chromebooks and Intel/AMD tablets. |

All three require **Android 8.0 or later**. To see your version:
*Settings › About phone › Android version*. Android 7 and older are not
supported.

## Finding the processor type

In most cases there is nothing to look up: install `arm64-v8a`. If FuzeVPN is
not already installed from Google Play and Android answers "App not installed"
or "not compatible", install `armeabi-v7a`. If it is installed from Google
Play, see [Google Play or GitHub?](#google-play-or-github) below.

To check beforehand:

- an information app such as *CPU-Z* or *Device Info HW* lists the supported
  ABIs (`arm64-v8a`, `armeabi-v7a` or `x86_64`);
- with a computer and ADB: `adb shell getprop ro.product.cpu.abi`.

## Installing

1. Download the APK from the release, directly on the phone.
2. Open the file. Android asks you to allow installs from this source (browser
   or file manager): allow it for that source only.
3. Install, then open FuzeVPN and sign in.

To update, install the APK of the newer release over it: the app and your
session are kept.

## Google Play or GitHub?

Google Play and GitHub builds are signed with different keys, so Android
refuses to replace one with the other ("App not installed" or "conflicts with
an existing package").

- Installed from Google Play: keep updating through Google Play.
- To switch: uninstall FuzeVPN first, install the other build, then sign in to
  your account again. A guest without an account restores a Google Play
  subscription with "Already purchased?" on the welcome screen.

## Checking an APK (optional)

Each release includes a `SHA256SUMS.txt` file. Compare the checksum of the
downloaded file:

- Windows: `certutil -hashfile FuzeVPN-<version>-arm64-v8a.apk SHA256`
- macOS: `shasum -a 256 FuzeVPN-<version>-arm64-v8a.apk`
- Linux: `sha256sum FuzeVPN-<version>-arm64-v8a.apk`

The signing certificate of the GitHub APKs has this SHA-256 fingerprint:

```
F6:F8:56:A1:A5:CD:9E:10:41:EB:84:A8:75:7E:D6:E6:C3:B7:46:39:18:48:DA:E9:9C:FA:93:0F:C2:C9:93:E3
```

With the Android SDK tools, `apksigner verify --print-certs <file.apk>` must
show the same value, written in lowercase without colons:
`Signer #1 certificate SHA-256 digest: f6f856a1a5cd9e1041eb84a8757ed6e6c3b746391848dae99cfa930fc2c993e3`.

## Sources

Each release attaches the source archive matching its APKs, produced by
`tools/package_android_sources.py` (see [SOURCE_DISTRIBUTION.md](SOURCE_DISTRIBUTION.md),
in French). To build it yourself, follow the [README](../README.md#build-from-source).
