param([string]$OutputDirectory, [string[]]$Only)
$ErrorActionPreference = 'Stop'
$gateRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
if (-not $OutputDirectory) { $OutputDirectory = Join-Path $gateRoot 'build/wireguard-release-gate-tests' }
$OutputDirectory = [IO.Path]::GetFullPath($OutputDirectory)
New-Item -ItemType Directory -Force -Path $OutputDirectory | Out-Null
$gateResults = [Collections.Generic.List[object]]::new()
$gateWrapper = Join-Path $gateRoot 'android/gradlew.bat'

function Invoke-GateCase {
    param([string]$Name, [string[]]$Tasks, [string]$Flag, [bool]$Reject,
        [string]$BuildType, [string]$ExpectedConfig, [string[]]$ExtraArguments = @())
    if ($Only -and $Name -notin $Only) { return }
    $caseLog = Join-Path $OutputDirectory ($Name + '.txt')
    $caseArguments = @($Tasks) + @('--offline', '--console=plain', '--max-workers=2', '-Ptarget-platform=android-arm64')
    if ($Flag) { $caseArguments += "-Pfuzevpn.usePatchedWireGuardAar=$Flag" }
    $caseArguments += $ExtraArguments
    $ErrorActionPreference = 'Continue'
    & $gateWrapper @caseArguments *> $caseLog
    $caseExit = $LASTEXITCODE
    $ErrorActionPreference = 'Stop'
    $caseOutput = Get-Content -LiteralPath $caseLog -Raw
    if ($Reject) {
        if ($caseExit -eq 0 -or $caseOutput -notmatch 'WG_PATCH_REQUIRED:') {
            throw "$Name did not fail at the WireGuard gate; see $caseLog"
        }
        if ($caseOutput -match '(?m)^> Task :app:(package|bundle)(Release|Profile)\s*$') {
            throw "$Name reached packaging despite rejection"
        }
    } else {
        if ($caseExit -ne 0) { throw "$Name failed; see $caseLog" }
        if ($BuildType) {
            $configPath = Join-Path $gateRoot "build/app/generated/source/buildConfig/$BuildType/com/fuzevpn/android/BuildConfig.java"
            $config = Get-Content -LiteralPath $configPath -Raw
            if ($config -notmatch "USE_PATCHED_WIREGUARD_AAR = $ExpectedConfig;") {
                throw "$Name produced an incorrect BuildConfig"
            }
        }
    }
    $gateResults.Add([pscustomobject]@{ name=$Name; passed=$true; expectedRejection=$Reject; exitCode=$caseExit })
    Write-Output "PASS $Name"
}

# A17-supply-chain-05: GoBackend loads only libwg-go. The AAR's wireguard-tools
# executables (libwg.so, libwg-quick.so: GPL-2.0, netlink LGPL-2.1) serve only
# WgQuickBackend and its root shell, which the app never uses, and must not ship.
function Invoke-NativeLibraryCase {
    param([string]$Name)
    if ($Only -and $Name -notin $Only) { return }
    $caseLog = Join-Path $OutputDirectory ($Name + '.txt')
    # The OpenVPN C++ build does not affect this inventory and is skipped.
    $caseArguments = @(':app:mergeDebugNativeLibs', '-x', ':app:buildCMakeDebug[arm64-v8a]', '--offline',
        '--console=plain', '--max-workers=2', '-Ptarget-platform=android-arm64', '-Pfuzevpn.usePatchedWireGuardAar=true')
    $ErrorActionPreference = 'Continue'
    & $gateWrapper @caseArguments *> $caseLog
    $caseExit = $LASTEXITCODE
    $ErrorActionPreference = 'Stop'
    if ($caseExit -ne 0) { throw "$Name failed; see $caseLog" }
    $merged = Join-Path $gateRoot 'build/app/intermediates/merged_native_libs/debug/mergeDebugNativeLibs/out/lib/arm64-v8a'
    $packaged = @(Get-ChildItem -LiteralPath $merged -Filter '*.so' | Select-Object -ExpandProperty Name)
    if ($packaged -notcontains 'libwg-go.so') { throw "$Name lost libwg-go.so; see $caseLog" }
    $unused = @($packaged | Where-Object { $_ -in @('libwg.so', 'libwg-quick.so') })
    if ($unused.Count) { throw "$Name packaged unused wireguard-tools executables: $($unused -join ', ')" }
    $gateResults.Add([pscustomobject]@{ name=$Name; passed=$true; expectedRejection=$false; exitCode=$caseExit; nativeLibraries=$packaged })
    Write-Output "PASS $Name ($($packaged -join ', '))"
}

# Examine the real application's dependency declarations without altering them.
$dependencyProbe = Join-Path $OutputDirectory 'dependency-probe.gradle'
@'
gradle.projectsEvaluated {
    def app = gradle.rootProject.findProject(':app')
    if (app == null) return // Flutter's included Gradle build has no app module.
    app.tasks.register('verifyWireGuardDependencyIsolation') {
        doLast {
            def selected = app.providers.gradleProperty('fuzevpn.usePatchedWireGuardAar').orElse('false').get().equalsIgnoreCase('true')
            ['debug', 'profile', 'release'].each { type ->
                def dependencies = app.configurations.getByName(type + 'RuntimeClasspath').allDependencies
                def maven = dependencies.findAll { it.group == 'com.wireguard.android' && it.name == 'tunnel' }
                def local = dependencies.findAll { it instanceof org.gradle.api.artifacts.FileCollectionDependency }
                    .collectMany { it.files.files }.findAll { it.name == 'tunnel-1.0.20260102-fuzevpn-fgs.aar' }
                def patched = type != 'debug' || selected
                assert maven.size() == (patched ? 0 : 1) : "$type Maven isolation failed"
                assert local.size() == (patched ? 1 : 0) : "$type local AAR selection failed"
                println "PASS dependency $type: " + (patched ? 'approved local AAR only' : 'official debug Maven runtime')
            }
        }
    }
}
'@ | Set-Content -LiteralPath $dependencyProbe -Encoding UTF8

Push-Location (Join-Path $gateRoot 'android')
try {
    Invoke-GateCase 'release-config-no-flag' @(':app:generateReleaseBuildConfig') '' $true
    Invoke-GateCase 'release-config-false' @(':app:generateReleaseBuildConfig') 'false' $true
    Invoke-GateCase 'profile-config-no-flag' @(':app:generateProfileBuildConfig') '' $true
    Invoke-GateCase 'profile-config-false' @(':app:generateProfileBuildConfig') 'false' $true
    Invoke-GateCase 'release-apk-no-flag' @(':app:assembleRelease') '' $true
    Invoke-GateCase 'release-bundle-false' @(':app:bundleRelease') 'false' $true
    Invoke-GateCase 'profile-apk-false' @(':app:assembleProfile') 'false' $true
    Invoke-GateCase 'profile-bundle-no-flag' @(':app:bundleProfile') '' $true
    Invoke-GateCase 'debug-config-maven' @(':app:generateDebugBuildConfig') 'false' $false 'debug' 'false'
    Invoke-GateCase 'release-config-approved' @(':app:generateReleaseBuildConfig') 'true' $false 'release' 'true'
    Invoke-GateCase 'profile-config-approved' @(':app:generateProfileBuildConfig') 'true' $false 'profile' 'true'
    Invoke-GateCase 'debug-config-approved' @(':app:generateDebugBuildConfig') 'true' $false 'debug' 'true'
    Invoke-GateCase 'warm-release-false' @(':app:generateReleaseBuildConfig') 'false' $true
    Invoke-GateCase 'combined-debug-release-no-flag' @(':app:generateDebugBuildConfig', ':app:generateReleaseBuildConfig') '' $true
    Invoke-GateCase 'dependencies-no-flag' @(':app:verifyWireGuardDependencyIsolation') '' $false -ExtraArguments @('-I', $dependencyProbe)
    Invoke-GateCase 'dependencies-approved' @(':app:verifyWireGuardDependencyIsolation') 'true' $false -ExtraArguments @('-I', $dependencyProbe)
    Invoke-NativeLibraryCase 'native-libraries-approved'
    $gateResults | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath (Join-Path $OutputDirectory 'results.json') -Encoding UTF8
    Write-Output "WireGuard Gradle integration: $($gateResults.Count) cases passed"
} finally {
    Pop-Location
}
