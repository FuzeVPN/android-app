# Security reporting

Qualification audit, 14 October 2026: [Q029](docs/VALIDATION.md#q029), [Q032](docs/VALIDATION.md#q032).


Report vulnerabilities through the repository's private reporting page:

[Report a vulnerability privately](https://github.com/FuzeVPN/android-app/security/advisories/new)

Use this channel for issues involving session isolation, account or purchase
ownership, credential storage, VPN routing, diagnostics or dependency
integrity. Do not disclose an exploit or user data in a public issue.

Include the affected commit/version, Android version and device, reproduction
steps, expected/observed behavior and security impact. Prefer a minimal
synthetic reproduction. Do not include passwords, access tokens, guest
credentials, purchase tokens, private keys or live VPN profiles.

Private vulnerability reporting must be enabled by the repository owner.
If the page is unavailable, do not post details publicly; wait for the private
channel to be available. No unverified security email address or response-time
commitment is listed here.

The current source baseline is **0.2.10+74016**, preserved by commit
`a5eff1ab577be708e0c0c89b5dc98e5fc96f013b`. The dated
[qualification registry](docs/VALIDATION.md) identifies tested versions and
open prerequisites. There is no public binary
release or formal support lifecycle declared by this repository. Older code
should not be assumed to receive security updates. Report issues against the
current source when possible, and identify older affected versions if known.

The FuzeVPN backend and VPN infrastructure are outside this repository.
Explain any server dependency in your report without testing other users'
accounts or unauthorized infrastructure. A local test result does not establish
server deployment, Google OAuth configuration or production security.
