[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)][string]$OutputDirectory,
    [string]$BridgeSource,
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
$testCoroutines=Jar 'org.jetbrains.kotlinx' 'kotlinx-coroutines-test-jvm' '1.10.2'
$annotations=Jar 'org.jetbrains' 'annotations' '23.0.0'
$junit=Jar 'junit' 'junit' '4.13.2'
$hamcrest=Jar 'org.hamcrest' 'hamcrest-core' '1.3'
$compilerCp=@($compiler,$stdlib,$script,$reflect,$daemon,$compilerCoroutines,$annotations) -join ';'
$runtimeCp=@($stdlib,$coroutines,$testCoroutines,$annotations,$junit,$hamcrest) -join ';'
$native="$repository/android/app/src/main/kotlin/com/fuzevpn/android"
if (-not $BridgeSource) { $BridgeSource="$native/AndroidVpnBridge.kt" }
$bridge=[IO.File]::ReadAllText($BridgeSource)
$blocks=@{
    CANCEL=@('    private fun cancelSystemStart()', '    private fun invalidateSystemResume()');
    SYSTEM=@('    internal fun onSystemVpnStart()', '    internal fun captureHostLoss()');
    TILE=@('    internal fun toggleFromQuickTile(', '    internal fun quickTileState()')
}
$generated=[IO.File]::ReadAllText("$PSScriptRoot/SystemVpnCommandEpoch.template.kt")
# The negative control must run every test of the template, not just some (final reaudit C7).
$expectedTests=([regex]::Matches($generated, '@Test\b')).Count
foreach ($key in $blocks.Keys) {
    $start=$bridge.IndexOf($blocks[$key][0]); $end=$bridge.IndexOf($blocks[$key][1],$start)
    if ($start -lt 0 -or $end -lt 0) { throw "Cannot locate production block $key" }
    $block=$bridge.Substring($start,$end-$start)
    # A negative control on a bridge older than the explicit-authority hold
    # (H-E22-N01-01) keeps that bridge's behaviour: both hooks do nothing.
    if ($key -eq 'CANCEL' -and -not $block.Contains('fun closeTunnelHold(')) {
        $block += "    private fun admitExplicitCommand() {}`n    private fun closeTunnelHold() {}`n`n"
    }
    $generated=$generated.Replace("/* PRODUCTION_$key */",$block)
}
$wgStart=$bridge.IndexOf('    private suspend fun connectWireGuard(')
$wgBody=$bridge.IndexOf('        val connectionSession = NativeConnectionTiming.span(timing, "session_validation") {',$wgStart)
$wgEnd=$bridge.IndexOf('        activeSessionEpoch = ticket',$wgBody)
if ($wgStart -lt 0 -or $wgBody -lt 0 -or $wgEnd -lt 0 -or $bridge.Substring($wgStart,$wgBody-$wgStart) -notmatch '= withTunnelOperation\(timing\) \{') { throw 'WireGuard admission boundary changed' }
$generated=$generated.Replace('/* PRODUCTION_WG_ADMISSION */',$bridge.Substring($wgBody,$wgEnd-$wgBody))
$ovpnStart=$bridge.IndexOf('    private suspend fun reconnectOpenVpn(')
$ovpnBody=$bridge.IndexOf('        checkRequest(requestEpoch)',$ovpnStart)
$ovpnEnd=$bridge.IndexOf('        val connectionSession = localSession(profile)',$ovpnBody)
if ($ovpnStart -lt 0 -or $ovpnBody -lt 0 -or $ovpnEnd -lt 0 -or $bridge.Substring($ovpnStart,$ovpnBody-$ovpnStart) -notmatch '= withTunnelOperation \{') { throw 'OpenVPN admission boundary changed' }
$generated=$generated.Replace('/* PRODUCTION_OVPN_ADMISSION */',$bridge.Substring($ovpnBody,$ovpnEnd-$ovpnBody))
[IO.File]::WriteAllText("$OutputDirectory/SystemVpnCommandEpoch.generated.kt",$generated)
$state=[IO.File]::ReadAllText("$native/VpnState.kt")
[IO.File]::WriteAllText("$OutputDirectory/VpnPrimitives.generated.kt",$state.Substring(0,$state.IndexOf('internal data class VpnState')))
$classes="$OutputDirectory/classes"
New-Item -ItemType Directory -Path $classes -Force | Out-Null
$sources=@("$OutputDirectory/SystemVpnCommandEpoch.generated.kt","$OutputDirectory/VpnPrimitives.generated.kt","$native/QuickTileAction.kt","$native/SystemVpnNetworkWait.kt")
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
$started=(Get-Date).ToUniversalTime().ToString('o')
$output=Invoke-Native $Java (@('-cp',$compilerCp,'org.jetbrains.kotlin.cli.jvm.K2JVMCompiler','-no-stdlib','-no-reflect','-jvm-target','17','-classpath',$runtimeCp,'-d',$classes)+$sources)
[IO.File]::WriteAllLines("$OutputDirectory/compile.log", [string[]]@($output | ForEach-Object { $_.ToString() }), [Text.UTF8Encoding]::new($false))
if ($LASTEXITCODE -ne 0) { $output; throw 'Kotlin compile failed' }
$output=Invoke-Native $Java @('-cp',"$classes;$runtimeCp",'org.junit.runner.JUnitCore','com.fuzevpn.android.SystemVpnCommandEpochTest')
$code=$LASTEXITCODE
[IO.File]::WriteAllLines("$OutputDirectory/result.log", [string[]]@($output | ForEach-Object { $_.ToString() }), [Text.UTF8Encoding]::new($false))
[ordered]@{started_utc=$started;ended_utc=(Get-Date).ToUniversalTime().ToString('o');bridge_source=$BridgeSource;bridge_sha256=(Get-FileHash -LiteralPath $BridgeSource -Algorithm SHA256).Hash.ToLowerInvariant();java=$Java;module_cache=$ModuleCache;runner_sha256=(Get-FileHash -LiteralPath $PSCommandPath -Algorithm SHA256).Hash.ToLowerInvariant();template_sha256=(Get-FileHash -LiteralPath "$PSScriptRoot/SystemVpnCommandEpoch.template.kt" -Algorithm SHA256).Hash.ToLowerInvariant();junit_exit_code=$code;expect_failure=[bool]$ExpectFailure} | ConvertTo-Json | Set-Content -LiteralPath "$OutputDirectory/execution.json"
$output
if ($ExpectFailure) {
    if ($code -eq 0 -or ($output -join "`n") -notmatch "Tests run: $expectedTests,\s+Failures: [1-9]") { throw 'The uncorrected control must fail regression assertions.' }
    'Negative control: the uncorrected source fails the corrected-behaviour assertions.'
} elseif ($code -ne 0) { throw 'Command epoch regression tests failed' }
