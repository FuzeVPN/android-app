# SPDX-License-Identifier: Apache-2.0
#Requires -Version 7.2
[CmdletBinding()]
param(
    [string]$FlutterRoot = $env:FLUTTER_ROOT,
    [string]$JavaHome = $env:JAVA_HOME,
    [string]$AndroidSdk = $env:ANDROID_SDK_ROOT,
    [string]$PubCache = $env:PUB_CACHE,
    [string]$GradleUserHome = $env:GRADLE_USER_HOME,
    [string]$PythonExecutable = 'python',
    [string]$NodeExecutable = $env:NODE_BINARY,
    [string]$GoExecutable = $env:FUZEVPN_GO,
    [string]$OutputDirectory,
    [switch]$PrepareDependencies,
    [switch]$PlanOnly
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$projectRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$expectedFlutter = (Get-Content -LiteralPath (Join-Path $projectRoot '.flutter-version') -Raw).Trim()
if (-not $AndroidSdk) { $AndroidSdk = $env:ANDROID_HOME }
if (-not $OutputDirectory) {
    $OutputDirectory = Join-Path $projectRoot ('build/reports/validation/' + [DateTime]::UtcNow.ToString('yyyyMMdd-HHmmss-fff'))
}
$OutputDirectory = [IO.Path]::GetFullPath($OutputDirectory)
$stepNames = @('toolchain', 'pub-offline', 'translations', 'google-sdk-notices', 'flutter-analyze', 'flutter-test', 'flutter-fonts',
    'python-tests', 'buildsrc', 'android-test-lint', 'turnstile-bridge', 'command-epochs', 'bridge-host', 'wireguard-gate', 'dependency-integrity', 'build-provenance',
    'wireguard-protected-start', 'openvpn-state', 'openvpn-network', 'openvpn-boundaries', 'source-export', 'evidence-registry', 'isolated-configuration')
if ($PlanOnly) {
    [ordered]@{status='planned'; flutter=$expectedFlutter; javaMajor=17; androidPlatform=36; ndk='28.2.13676358'; cmake='3.22.1';
        offlineValidation=$true; onlinePreparation=[bool]$PrepareDependencies; steps=$stepNames; outputDirectory=$OutputDirectory;
        instrumentation='not executed'; buildsProductionApkOrBundle=$false; nodeRequired=$true; goRequired=$true} | ConvertTo-Json -Depth 4
    exit 0
}
if (-not $FlutterRoot -or -not $JavaHome -or -not $AndroidSdk) {
    throw 'Set FLUTTER_ROOT, JAVA_HOME and ANDROID_SDK_ROOT (or pass their parameters). No SDK is installed by this script.'
}
[void](Get-Command $PythonExecutable -ErrorAction Stop)
if ((Test-Path -LiteralPath $OutputDirectory) -and @(Get-ChildItem -LiteralPath $OutputDirectory -Force).Count) {
    throw 'Choose a new empty validation output directory; failed or completed receipts must not be overwritten.'
}
$flutter = Join-Path $FlutterRoot 'bin/flutter.bat'
$java = Join-Path $JavaHome 'bin/java.exe'
foreach ($tool in @($flutter, $java, (Join-Path $AndroidSdk 'platforms/android-36/android.jar'),
    (Join-Path $AndroidSdk 'build-tools/36.0.0/aapt2.exe'), (Join-Path $AndroidSdk 'ndk/28.2.13676358/source.properties'),
    (Join-Path $AndroidSdk 'cmake/3.22.1/bin/cmake.exe'))) {
    if (-not (Test-Path -LiteralPath $tool)) { throw "Required pinned toolchain input is missing: $tool" }
}
if (-not $PubCache) { $PubCache = Join-Path $projectRoot '.dart_tool/isolated-pub-cache' }
if (-not $GradleUserHome) { $GradleUserHome = Join-Path $projectRoot '.gradle' }
$env:JAVA_HOME = [IO.Path]::GetFullPath($JavaHome)
$env:ANDROID_SDK_ROOT = [IO.Path]::GetFullPath($AndroidSdk)
$env:ANDROID_HOME = $env:ANDROID_SDK_ROOT
$env:PUB_CACHE = [IO.Path]::GetFullPath($PubCache)
$env:GRADLE_USER_HOME = [IO.Path]::GetFullPath($GradleUserHome)
$env:Path = (Join-Path $JavaHome 'bin') + ';' + (Join-Path $FlutterRoot 'bin') + ';' + $env:Path
if (-not $NodeExecutable) { $NodeExecutable = (Get-Command node -CommandType Application -ErrorAction Stop | Select-Object -First 1).Source }
$NodeExecutable = (Get-Command $NodeExecutable -CommandType Application -ErrorAction Stop | Select-Object -First 1).Source
$moduleCache = Join-Path $env:GRADLE_USER_HOME 'caches/modules-2/files-2.1'
$shell = (Get-Process -Id $PID).Path
$wrapper = Join-Path $projectRoot 'android/gradlew.bat'
$supportScript = Join-Path $PSScriptRoot 'validation_support.py'
$generatedDirectory = Join-Path $projectRoot 'lib/l10n/generated'
$generatedLocalizations = Join-Path $OutputDirectory 'l10n-generated-before.json'
$steps = [Collections.Generic.List[object]]::new()
New-Item -ItemType Directory -Force -Path $OutputDirectory | Out-Null
$lockInputs = @('pubspec.lock', 'android/gradle/verification-metadata.xml') + @(Get-ChildItem (Join-Path $projectRoot 'android/gradle/dependency-locks') -File | ForEach-Object { 'android/gradle/dependency-locks/' + $_.Name })
$beforeHashes = @{}
foreach ($relative in $lockInputs) { $beforeHashes[$relative] = (Get-FileHash -LiteralPath (Join-Path $projectRoot $relative) -Algorithm SHA256).Hash }

function Save-Steps { ConvertTo-Json -InputObject @($steps.ToArray()) -Depth 5 | Set-Content -LiteralPath (Join-Path $OutputDirectory 'steps.json') -Encoding utf8 }
function Invoke-ValidationStep {
    param([string]$Name, [string]$Executable, [string[]]$Arguments, [string]$WorkingDirectory = $projectRoot)
    $log = Join-Path $OutputDirectory ($Name + '.log')
    $started = [DateTime]::UtcNow
    $clock = [Diagnostics.Stopwatch]::StartNew()
    Write-Output "START $Name"
    Push-Location $WorkingDirectory
    try {
        $ErrorActionPreference = 'Continue'
        & $Executable @Arguments *> $log
        $succeeded = $?
        $code = $LASTEXITCODE
        if (-not $succeeded -and ($null -eq $code -or $code -eq 0)) { $code = 1 }
    } finally {
        $ErrorActionPreference = 'Stop'
        Pop-Location
    }
    $clock.Stop()
    $steps.Add([pscustomobject]@{name=$Name; executable=$Executable; arguments=$Arguments; startedAt=$started.ToString('o');
        finishedAt=[DateTime]::UtcNow.ToString('o'); durationSeconds=$clock.Elapsed.TotalSeconds; exitCode=$code; log=$log})
    Save-Steps
    if ($code -ne 0) { throw "$Name failed ($code); see $log" }
    Write-Output "PASS $Name ($([Math]::Round($clock.Elapsed.TotalSeconds, 2)) s)"
}
function Invoke-ProjectScript {
    param([string]$Name, [string]$Script, [string[]]$Arguments = @())
    Invoke-ValidationStep $Name $shell (@('-NoProfile', '-File', (Join-Path $PSScriptRoot $Script)) + $Arguments)
}
function Copy-ValidationArtifact {
    param([string]$Source, [string]$Destination)
    $original = Get-Item -LiteralPath $Source
    Copy-Item -LiteralPath $Source -Destination $Destination
    $copy = if (Test-Path -LiteralPath $Destination -PathType Container) { Join-Path $Destination $original.Name } else { $Destination }
    # Never turn an old result into apparently fresh evidence while copying it.
    [IO.File]::SetLastWriteTimeUtc($copy, $original.LastWriteTimeUtc)
}

Push-Location $projectRoot
try {
    Invoke-ValidationStep 'toolchain' $flutter @('--version', '--machine')
    $version = Get-Content -LiteralPath (Join-Path $OutputDirectory 'toolchain.log') -Raw | ConvertFrom-Json
    if ($version.frameworkVersion -ne $expectedFlutter) { throw "Flutter must be exactly $expectedFlutter" }
    $pythonVersion = (& $PythonExecutable -c 'import sys; print(sys.version); raise SystemExit(0 if (3, 10) <= sys.version_info < (4, 0) else 1)' | Out-String)
    if ($LASTEXITCODE -ne 0) { throw 'Python 3.10+ (major 3) is required.' }
    $pythonVersion | Set-Content -LiteralPath (Join-Path $OutputDirectory 'python-version.txt') -Encoding utf8
    $javaVersion = (& $java -version 2>&1 | Out-String)
    if ($javaVersion -notmatch 'version "17\.') { throw 'JDK 17 is required.' }
    $javaVersion | Set-Content -LiteralPath (Join-Path $OutputDirectory 'java-version.txt') -Encoding utf8
    $nodeVersion = (& $NodeExecutable --version | Out-String)
    if ($LASTEXITCODE -ne 0 -or $nodeVersion -notmatch '^v\d+\.') { throw 'Node.js is required for the generated Turnstile document regressions.' }
    $nodeVersion | Set-Content -LiteralPath (Join-Path $OutputDirectory 'node-version.txt') -Encoding utf8
    # python-tests runs tools/tests/test_wireguard_ipv6_length.py, which builds the pinned wireguard-go:
    # same lookup (FUZEVPN_GO, else go on PATH), minimum from libwg-go/go.mod, then pinned for that test.
    if ($GoExecutable) { $env:FUZEVPN_GO = $GoExecutable }
    $goToolchain = (& $PythonExecutable $supportScript go-toolchain --output (Join-Path $OutputDirectory 'go-version.txt') 2>&1 | Out-String)
    if ($LASTEXITCODE -ne 0) { throw "Go is required for the offline wireguard-go test: $($goToolchain.Trim())" }
    $env:FUZEVPN_GO = ($goToolchain | ConvertFrom-Json).executable
    $appVersion = [regex]::Match((Get-Content -LiteralPath (Join-Path $projectRoot 'pubspec.yaml') -Raw), '(?m)^version:\s*([0-9A-Za-z.-]+)\+(\d+)\s*$')
    if (-not $appVersion.Success) { throw 'Expected an explicit application version and build number in pubspec.yaml.' }
    $properties = "sdk.dir=$($env:ANDROID_SDK_ROOT.Replace('\','\\'))`nflutter.sdk=$([IO.Path]::GetFullPath($FlutterRoot).Replace('\','\\'))`nflutter.versionName=$($appVersion.Groups[1].Value)`nflutter.versionCode=$($appVersion.Groups[2].Value)`n"
    $properties | Set-Content -LiteralPath (Join-Path $projectRoot 'android/local.properties') -Encoding ascii
    # pub get (generate: true) rewrites the versioned l10n.yaml output-dir in place: fingerprint it
    # before any pub get, so that pub-offline must reproduce it exactly instead of hiding a stale copy.
    $snapshot = (& $PythonExecutable $supportScript fingerprint --directory $generatedDirectory --output $generatedLocalizations 2>&1 | Out-String)
    if ($LASTEXITCODE -ne 0) { throw "Cannot fingerprint the versioned generated localizations: $($snapshot.Trim())" }
    if ($PrepareDependencies) {
        Invoke-ValidationStep 'prepare-pub-online' $flutter @('pub', 'get', '--enforce-lockfile')
        Invoke-ValidationStep 'prepare-gradle-online' $wrapper @(':app:compileDebugUnitTestKotlin', ':app:lintDebug', ':app:lintVitalRelease',
            '-Pfuzevpn.usePatchedWireGuardAar=true', '--console=plain', '--max-workers=2') (Join-Path $projectRoot 'android')
    }
    Invoke-ValidationStep 'pub-offline' $flutter @('pub', 'get', '--offline', '--enforce-lockfile')
    $drift = (& $PythonExecutable $supportScript compare-fingerprint --directory $generatedDirectory --fingerprint $generatedLocalizations 2>&1 | Out-String)
    if ($LASTEXITCODE -ne 0) { throw "pub get regenerated lib/l10n/generated differently from the versioned files: $($drift.Trim())" }
    Invoke-ValidationStep 'translations' $PythonExecutable @('tools/generate_translations.py', '--check', '--require-all')
    Invoke-ValidationStep 'google-sdk-notices' $PythonExecutable @('tools/generate_google_sdk_notices.py', '--check', '--module-cache', $moduleCache)
    Invoke-ValidationStep 'flutter-analyze' $flutter @('analyze', '--no-pub')
    Invoke-ValidationStep 'flutter-test' $flutter @('test', '--no-pub', '--concurrency=2', '--reporter=json')
    Invoke-ValidationStep 'flutter-fonts' $flutter @('test', '--no-pub', '--dart-define=FUZEVPN_REVIEW_FONTS=true', '--name',
        'APP10 recovery controls remain reachable|disconnected status keeps its word', 'test/widget/app_ui_test.dart', '--concurrency=2', '--reporter=json')
    Invoke-ValidationStep 'python-tests' $PythonExecutable @('-m', 'unittest', 'discover', '-s', 'tools/tests', '-v')
    Invoke-ValidationStep 'buildsrc' $wrapper @('-p', 'buildSrc', 'check', '--offline', '--console=plain', '--max-workers=2') (Join-Path $projectRoot 'android')
    $androidArguments = @(':app:testDebugUnitTest', '--rerun', ':app:lintAnalyzeDebug', '--rerun', ':app:lintAnalyzeDebugAndroidTest', '--rerun',
        ':app:lintAnalyzeDebugUnitTest', '--rerun', ':app:lintReportDebug', '--rerun', ':app:lintVitalAnalyzeRelease', '--rerun',
        ':app:lintVitalReportRelease', '--rerun', '--offline', '-Pfuzevpn.usePatchedWireGuardAar=true', '--console=plain', '--max-workers=2')
    Invoke-ValidationStep 'android-test-lint' $wrapper $androidArguments (Join-Path $projectRoot 'android')
    $junit = Join-Path $OutputDirectory 'junit'
    New-Item -ItemType Directory -Force -Path $junit | Out-Null
    Get-ChildItem -LiteralPath (Join-Path $projectRoot 'build/app/test-results/testDebugUnitTest') -Filter 'TEST-*.xml' | ForEach-Object { Copy-ValidationArtifact $_.FullName $junit }
    Copy-ValidationArtifact (Join-Path $projectRoot 'build/app/reports/lint-results-debug.xml') $OutputDirectory
    Copy-ValidationArtifact (Join-Path $projectRoot 'build/app/intermediates/lint_vital_intermediate_text_report/release/lintVitalReportRelease/lint-results-release.txt') (Join-Path $OutputDirectory 'lint-vital-release.txt')
    Invoke-ProjectScript 'turnstile-bridge' 'test_turnstile_bridge.ps1' @('-JavaHome', $JavaHome, '-ModuleCache', $moduleCache, '-Node', $NodeExecutable,
        '-OutputDirectory', (Join-Path $OutputDirectory 'turnstile-bridge'))
    Invoke-ValidationStep 'command-epochs' $shell @('-NoProfile', '-File', (Join-Path $projectRoot 'android/app/src/test/command-epoch/run.ps1'),
        '-JavaHome', $JavaHome, '-ModuleCache', $moduleCache, '-OutputDirectory', (Join-Path $OutputDirectory 'command-epochs'))
    Invoke-ValidationStep 'bridge-host' $shell @('-NoProfile', '-File', (Join-Path $projectRoot 'android/app/src/test/bridge-host/run.ps1'),
        '-JavaHome', $JavaHome, '-ModuleCache', $moduleCache, '-OutputDirectory', (Join-Path $OutputDirectory 'bridge-host'))
    Invoke-ProjectScript 'wireguard-gate' 'test_wireguard_release_gate.ps1' @('-OutputDirectory', (Join-Path $OutputDirectory 'wireguard-gate'))
    Invoke-ProjectScript 'dependency-integrity' 'test_dependency_integrity.ps1' @('-OutputDirectory', (Join-Path $OutputDirectory 'dependency-integrity'))
    Invoke-ProjectScript 'build-provenance' 'test_build_provenance.ps1' @('-JavaHome', $JavaHome, '-OutputDirectory', (Join-Path $OutputDirectory 'build-provenance'))
    Invoke-ProjectScript 'wireguard-protected-start' 'test_wireguard_protected_start.ps1' @('-JavaHome', $JavaHome, '-AndroidSdk', $AndroidSdk, '-GradleUserHome', $GradleUserHome, '-OutputDirectory', (Join-Path $OutputDirectory 'wireguard-protected-start'))
    Invoke-ProjectScript 'openvpn-state' 'test_openvpn_connection_state.ps1' @('-NdkPath', (Join-Path $AndroidSdk 'ndk/28.2.13676358'), '-OutputDirectory', (Join-Path $OutputDirectory 'openvpn-state'))
    Invoke-ProjectScript 'openvpn-network' 'test_openvpn_network.ps1' @('-NdkPath', (Join-Path $AndroidSdk 'ndk/28.2.13676358'), '-OutputDirectory', (Join-Path $OutputDirectory 'openvpn-network'))
    Invoke-ProjectScript 'openvpn-boundaries' 'test_openvpn_native_boundaries.ps1' @('-NdkPath', (Join-Path $AndroidSdk 'ndk/28.2.13676358'), '-OutputDirectory', (Join-Path $OutputDirectory 'openvpn-boundaries'))
    Invoke-ValidationStep 'source-export' $PythonExecutable @('tools/package_android_sources.py', '--check')
    Invoke-ValidationStep 'evidence-registry' $PythonExecutable @('tools/check_validation.py')
    Invoke-ProjectScript 'isolated-configuration' 'prepare_isolated_instrumentation.ps1' @('-ConfigurationOnly', '-OutputDirectory', (Join-Path $OutputDirectory 'isolated-configuration'))
    foreach ($relative in $lockInputs) {
        if ((Get-FileHash -LiteralPath (Join-Path $projectRoot $relative) -Algorithm SHA256).Hash -ne $beforeHashes[$relative]) {
            throw "Validation changed a lock or verification input: $relative"
        }
    }
    Invoke-ValidationStep 'summarize' $PythonExecutable @('tools/validation_support.py', 'summarize', '--directory', $OutputDirectory)
    Write-Output "PASS local automated validation; receipt: $(Join-Path $OutputDirectory 'summary.json'). Instrumentation was not executed."
} catch {
    [ordered]@{status='failed'; scope='local automated checks'; error=$_.Exception.Message; finishedAt=[DateTime]::UtcNow.ToString('o'); steps=@($steps.ToArray()); instrumentation='not executed'} |
        ConvertTo-Json -Depth 6 | Set-Content -LiteralPath (Join-Path $OutputDirectory 'summary.json') -Encoding utf8
    throw
} finally { Pop-Location }
