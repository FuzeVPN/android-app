# Turnstile bridge host tests

`tools/test_turnstile_bridge.ps1` compiles the actual `NativeTurnstileBridge`,
`TurnstilePolicy` and `TurnstileDocument` sources with the deterministic Android
and Flutter doubles in `stubs/`. It runs the versioned bridge and policy JUnit
tests, then exercises the generated document JavaScript with Node.js.

This directory is deliberately outside the Android source sets. These doubles
must never be included in the application or replace the Android SDK in a build.
The tests open no WebView, network connection, challenge provider or real token.
They establish control flow and callback ownership, not Android rendering or
provider availability on a device.

The fake WebView can deliver `onPageStarted` while `getUrl` still returns its
previous value, then independently advance the current URL and commit callbacks.
The clock is monotonic and manually advanced; no wall-clock delay is required.
An alternate `-BridgeSource` supports a negative control on an isolated copy of
the old source without modifying the repository.

Example:

```powershell
./tools/test_turnstile_bridge.ps1 -JavaHome /path/to/jdk-17 -ModuleCache /path/to/gradle/caches/modules-2/files-2.1 -Node /path/to/node -OutputDirectory /path/to/turnstile-host-tests
```

The runner declares `#Requires -Version 5.1`: it runs unchanged under Windows
PowerShell 5.1 (`powershell.exe`, the Windows default) and PowerShell 7.2+
(`pwsh`). Native standard error (`java -version`, compiler and Node warnings) is
captured as text and recorded in the logs; only exit codes decide success.
`tools/tests/test_turnstile_runner.py` replays this boundary in both shells.

Tests require Java 17 or newer, the pinned Kotlin/JUnit/JSON jars already present
in the Gradle module cache, and an installed Node.js runtime. Node runs only the
built-in `node:fs`, `node:path`, `node:vm` and `node:assert/strict` modules; the
runtime tested during this correction was Node v24.16.0. No lower Node version
has been qualified by these tests.

`-JavaHome`, `-ModuleCache` and `-Node` are explicit CI parameters. Without them,
the runner resolves Java from `JAVA_HOME` or `Get-Command java`, the module cache
from `GRADLE_USER_HOME` or the user's `.gradle` directory, and Node from
`NODE_BINARY` or `Get-Command node`. `-Java` accepts a direct Java executable and
`-Cache` remains an alias for `-ModuleCache`. A missing runtime or pinned jar is
an error, never a skipped test. The runner never downloads dependencies or
invokes Gradle. The default output is the ignored directory
`build/reports/turnstile-bridge-host-tests`; CI may supply an external directory.
