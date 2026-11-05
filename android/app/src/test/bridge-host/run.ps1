[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)][string]$OutputDirectory,
    [string]$SourceRoot,
    [string]$JavaHome = $env:JAVA_HOME,
    [string]$ModuleCache,
    [switch]$ExpectFailure
)
$ErrorActionPreference = 'Stop'
$repository = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../../../../..'))
$OutputDirectory = [IO.Path]::GetFullPath($OutputDirectory)
$comparison = [StringComparison]::OrdinalIgnoreCase
$separator = [IO.Path]::DirectorySeparatorChar
$buildOutput = Join-Path $repository 'build'
$inRepository = $OutputDirectory.Equals($repository, $comparison) -or $OutputDirectory.StartsWith($repository + $separator, $comparison)
$inBuildOutput = $OutputDirectory.Equals($buildOutput, $comparison) -or $OutputDirectory.StartsWith($buildOutput + $separator, $comparison)
if ($inRepository -and -not $inBuildOutput) {
    throw 'Generated test outputs must use the root build directory or stay outside the source checkout.'
}
if ($JavaHome) {
    $Java = Join-Path $JavaHome 'bin/java.exe'
    if (-not (Test-Path -LiteralPath $Java -PathType Leaf)) { $Java = Join-Path $JavaHome 'bin/java' }
    if (-not (Test-Path -LiteralPath $Java -PathType Leaf)) { throw 'Java executable missing from JavaHome.' }
} else {
    $Java = (Get-Command java -ErrorAction Stop).Source
}
if (-not $ModuleCache) {
    $gradleUserDirectory = $env:GRADLE_USER_HOME
    if (-not $gradleUserDirectory) {
        $gradleUserDirectory = Join-Path ([Environment]::GetFolderPath('UserProfile')) '.gradle'
    }
    $ModuleCache = Join-Path $gradleUserDirectory 'caches/modules-2/files-2.1'
}
New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null
function Jar([string]$group,[string]$name,[string]$version) {
    $path = Get-ChildItem -LiteralPath "$ModuleCache/$group/$name/$version" -Recurse -Filter "$name-$version.jar" | Select-Object -First 1 -ExpandProperty FullName
    if (-not $path) { throw "Required cached dependency is missing: $group/$name/$version" }
    $path
}
$stdlib=Jar 'org.jetbrains.kotlin' 'kotlin-stdlib' '2.3.20'
$compiler=Jar 'org.jetbrains.kotlin' 'kotlin-compiler-embeddable' '2.3.20'
$script=Jar 'org.jetbrains.kotlin' 'kotlin-script-runtime' '2.3.20'
$reflect=Jar 'org.jetbrains.kotlin' 'kotlin-reflect' '1.6.10'
$daemon=Jar 'org.jetbrains.kotlin' 'kotlin-daemon-embeddable' '2.3.20'
$compilerCoroutines=Jar 'org.jetbrains.kotlinx' 'kotlinx-coroutines-core-jvm' '1.8.0'
$coroutines=Jar 'org.jetbrains.kotlinx' 'kotlinx-coroutines-core-jvm' '1.10.2'
$annotations=Jar 'org.jetbrains' 'annotations' '23.0.0'
$junit=Jar 'junit' 'junit' '4.13.2'
$hamcrest=Jar 'org.hamcrest' 'hamcrest-core' '1.3'
$json=Jar 'org.json' 'json' '20240303'
$compilerCp=@($compiler,$stdlib,$script,$reflect,$daemon,$compilerCoroutines,$annotations) -join ';'
$runtimeCp=@($stdlib,$coroutines,$annotations,$junit,$hamcrest,$json) -join ';'
if (-not $SourceRoot) { $SourceRoot = "$repository/android/app/src/main/kotlin/com/fuzevpn/android" }
$SourceRoot = [IO.Path]::GetFullPath($SourceRoot)
# Production sources compiled unchanged. Android, Flutter, storage and both
# engines are replaced by the doubles in stubs/ and fakes/.
$production = @('AndroidVpnBridge.kt', 'VpnQuickTileService.kt', 'QuickTileSnapshotLoader.kt', 'QuickTileAction.kt',
    'QuickTileProfile.kt', 'SystemVpnResume.kt', 'SystemVpnNetworkWait.kt', 'SessionLifecycle.kt', 'SessionEndAttempt.kt',
    'VpnState.kt', 'VpnDisclosurePolicy.kt', 'SecureStorageKeyPolicy.kt', 'WireGuardRecoveryPolicy.kt',
    'TunnelNetworkSpec.kt', 'NativeConnectionTiming.kt', 'GuestCredentialStorage.kt', 'GuestOnboardingStorage.kt',
    'ExpectedDeviceIdentity.kt', 'FavoriteLocations.kt', 'NativeLocalePolicy.kt', 'DiagnosticExport.kt',
    'DiagnosticSnapshot.kt', 'openvpn/OpenVpnRecoveryAttempt.kt', 'openvpn/OpenVpnRecoveryPolicy.kt',
    'openvpn/OpenVpnRevocation.kt', 'openvpn/OpenVpnSessionEvents.kt')
# Optional production units: compiled when the checked source defines them.
$optional = @('SystemStartAuthority.kt')
$sources = @()
foreach ($file in $production) {
    $path = Join-Path $SourceRoot $file
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { throw "Production source missing: $file" }
    $sources += $path
}
foreach ($file in $optional) {
    $path = Join-Path $SourceRoot $file
    if (Test-Path -LiteralPath $path -PathType Leaf) { $sources += $path }
}
# The engine double keeps the real OpenVPN result and state types.
$controller = [IO.File]::ReadAllText((Join-Path $SourceRoot 'openvpn/OpenVpnController.kt'))
$typesStart = $controller.IndexOf('internal data class OpenVpnCertificateStatus(')
if ($typesStart -lt 0) { throw 'OpenVPN data type boundary changed' }
# Keep the controller's JVM and project imports; Android APIs stay out of the double.
$imports = ([regex]::Matches($controller, '(?m)^import (?!android\.)[\w.]+\r?$') | ForEach-Object { $_.Value.TrimEnd("`r") }) -join "`n"
$types = "package com.fuzevpn.android.openvpn`n`n$imports`n`n" + $controller.Substring($typesStart)
[IO.File]::WriteAllText("$OutputDirectory/OpenVpnTypes.generated.kt", $types)
$sources += "$OutputDirectory/OpenVpnTypes.generated.kt"
$sources += Get-ChildItem -LiteralPath "$PSScriptRoot/stubs" -Filter '*.kt' | Sort-Object Name | Select-Object -ExpandProperty FullName
$sources += Get-ChildItem -LiteralPath "$PSScriptRoot/fakes" -Filter '*.kt' | Sort-Object Name | Select-Object -ExpandProperty FullName
$sources += Get-ChildItem -LiteralPath $PSScriptRoot -Filter '*Test.kt' | Sort-Object Name | Select-Object -ExpandProperty FullName
$classes = "$OutputDirectory/classes"
New-Item -ItemType Directory -Path $classes -Force | Out-Null
function Invoke-Native([string]$Executable, [string[]]$Arguments) {
    # Windows PowerShell 5.1 turns redirected native stderr (the JAVA_TOOL_OPTIONS
    # notice, compiler warnings) into terminating NativeCommandError records
    # under 'Stop'. Capture both streams as text; $LASTEXITCODE decides.
    $previousPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    try { $lines = @(& $Executable @Arguments 2>&1 | ForEach-Object { "$_" }) }
    finally { $ErrorActionPreference = $previousPreference }
    return ,$lines
}
$started = (Get-Date).ToUniversalTime().ToString('o')
$output = Invoke-Native $Java (@('-cp', $compilerCp, 'org.jetbrains.kotlin.cli.jvm.K2JVMCompiler', '-no-stdlib', '-no-reflect',
    '-jvm-target', '17', '-classpath', $runtimeCp, '-d', $classes) + $sources)
[IO.File]::WriteAllLines("$OutputDirectory/compile.log", [string[]]@($output | ForEach-Object { $_.ToString() }), [Text.UTF8Encoding]::new($false))
if ($LASTEXITCODE -ne 0) { $output; throw 'Kotlin compile failed' }
$output = Invoke-Native $Java @('-cp', "$classes;$runtimeCp", 'org.junit.runner.JUnitCore', 'com.fuzevpn.android.AndroidVpnBridgeHostTest')
$code = $LASTEXITCODE
[IO.File]::WriteAllLines("$OutputDirectory/result.log", [string[]]@($output | ForEach-Object { $_.ToString() }), [Text.UTF8Encoding]::new($false))
$hashes = [ordered]@{}
foreach ($path in $sources) { $hashes[[IO.Path]::GetFileName($path)] = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant() }
[ordered]@{started_utc=$started; ended_utc=(Get-Date).ToUniversalTime().ToString('o'); source_root=$SourceRoot;
    java=$Java; module_cache=$ModuleCache; runner_sha256=(Get-FileHash -LiteralPath $PSCommandPath -Algorithm SHA256).Hash.ToLowerInvariant();
    sources_sha256=$hashes; junit_exit_code=$code; expect_failure=[bool]$ExpectFailure} | ConvertTo-Json -Depth 4 |
    Set-Content -LiteralPath "$OutputDirectory/execution.json"
$output
if ($ExpectFailure) {
    if ($code -eq 0 -or ($output -join "`n") -notmatch 'Tests run: \d+,\s+Failures: [1-9]') { throw 'The uncorrected control must fail regression assertions.' }
    'Negative control: the uncorrected source fails the corrected-behaviour assertions.'
} elseif ($code -ne 0) { throw 'Bridge host regression tests failed' }
