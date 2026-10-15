# Licensing scope

Qualification audit, 14 October 2026: [Q030](docs/VALIDATION.md#q030), [Q032](docs/VALIDATION.md#q032), [Q033](docs/VALIDATION.md#q033).


The original FuzeVPN application source in this repository is licensed under
the **Mozilla Public License 2.0** in [LICENSE](LICENSE), except where an
existing file or directory notice states different terms. This declaration
attaches the MPL notice to original files without a separate header.

Existing notices are preserved. In particular, some build/export scripts are
Apache-2.0, the OpenVPN bridge files are MPL-2.0, and vendored dependencies
retain their upstream licenses. This publication does not relicense any
third-party code or imply ownership of its copyrights.

## Component boundaries

| Material | Applicable terms |
| --- | --- |
| Original app source and original documentation without another notice | MPL-2.0 |
| Original files already carrying Apache-2.0 or another notice | The existing file notice |
| OpenVPN 3 Core | Upstream AGPL-3.0 / MPL-2.0 options; this project uses MPL-2.0 |
| WireGuard Java tunnel / wireguard-go | Apache-2.0 / MIT |
| wireguard-tools executables and source | GPL-2.0-only, per-file MIT alternatives and netlink LGPL-2.1-or-later; retain the complete upstream notices |
| OpenSSL / Asio / fmt / lz4 | Apache-2.0 / BSL-1.0 / MIT / BSD-2-Clause |
| Go sources and modules | Their individual upstream licenses |
| Archivo, IBM Plex Mono, Noto Sans Arabic, Google Sans | OFL-1.1; retain their notices and applicable reserved-name rules |
| Twemoji flag artwork / CLDR data | CC-BY-4.0 / Unicode-3.0 |
| Google Billing, Google ID and Google Play services | Their SDK-specific terms and bundled third-party notices |
| SPDX document | CC0-1.0 as declared by its dataLicense field |

See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) and
[docs/SBOM.spdx.json](docs/SBOM.spdx.json) for versions and evidence. The source
inventory is not a complete license conclusion for an optimized APK.

The native WireGuard AAR contains components with different licenses.
Its Java license does not cover all native executables. MPL is a file-level
license: supplying an executable containing MPL-covered code requires making
the applicable source available and informing recipients where to obtain it.
Preserve the corresponding source, patches, build instructions and notices
when distributing your own binaries.

## Trademarks and artwork

FuzeVPN names, logos and the FuzeVPN emblem identify the official service.
They are excluded from the general MPL grant for original software. No
trademark permission or right to imply official status, affiliation or
endorsement is granted. A fork should use its own branding; permitted
attribution and descriptive references remain subject to applicable law.

Google names and the official G logo are Google brand assets governed by
[Google's Sign in with Google branding rules](https://developers.google.com/identity/branding-guidelines).
The logo is not designated open-source artwork. Google Sans is licensed under
OFL-1.1, with its separate trademark notice preserved beside the font.

## Dependency and distribution limits

This is an open-source application-code publication with separately licensed
dependencies and brand assets. It does not claim that every downloaded SDK
or the entire resulting APK is free software. Do not redistribute SDK caches
under MPL or remove their license notices.

No APK, App Bundle, signing key or GitHub Release is published by this
repository. If you distribute binaries, assess their exact included components
and follow their individual terms. The presence of a source archive or hash
alone does not establish that a binary was built from those sources.

Primary references: [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/),
[Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0),
[OFL-1.1](https://openfontlicense.org/open-font-license-official-text/),
[CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/),
[Android SDK terms](https://developer.android.com/studio/terms).
