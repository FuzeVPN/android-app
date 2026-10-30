# SPDX-License-Identifier: Apache-2.0
#Requires -Version 7.2
[CmdletBinding()]
param(
    [ValidateSet('android-x64', 'android-arm64', 'android-arm')]
    [string]$TargetPlatform = 'android-x64',
    [string]$OutputDirectory,
    [switch]$ConfigurationOnly,
    [switch]$PlanOnly
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$projectRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
if (-not $OutputDirectory) {
    $OutputDirectory = Join-Path $projectRoot ('build/reports/isolated-instrumentation/' + [DateTime]::UtcNow.ToString('yyyyMMdd-HHmmss-fff'))
}
$OutputDirectory = [IO.Path]::GetFullPath($OutputDirectory)
$initScript = Join-Path $PSScriptRoot 'isolated_instrumentation.gradle'
$tasks = @(':app:verifyIsolatedInstrumentationConfig')
if (-not $ConfigurationOnly) {
    # Fresh package receipts, without forcing CMake/Kotlin dependencies to rerun.
    $tasks += @(':app:assembleDebug', ':app:packageDebug', '--rerun', ':app:assembleDebugAndroidTest', ':app:packageDebugAndroidTest', '--rerun')
}
$arguments = $tasks + @('--offline', '--console=plain', '--max-workers=2', '-I', $initScript,
    '-Pfuzevpn.isolatedInstrumentation=true', '-Pfuzevpn.usePatchedWireGuardAar=true', "-Ptarget-platform=$TargetPlatform")
$plan = [ordered]@{ status='planned'; applicationId='com.fuzevpn.recoverytest'; testApplicationId='com.fuzevpn.recoverytest.test';
    targetPlatform=$TargetPlatform; configurationOnly=[bool]$ConfigurationOnly; executable=(Join-Path $projectRoot 'android/gradlew.bat'); arguments=$arguments;
    installsOrRunsOnDevice=$false; productionSignature=$false }
if ($PlanOnly) { $plan | ConvertTo-Json -Depth 4; exit 0 }
if ((Test-Path -LiteralPath $OutputDirectory) -and @(Get-ChildItem -LiteralPath $OutputDirectory -Force).Count) {
    throw 'Choose a new empty isolated output directory; failed or completed receipts must not be overwritten.'
}
New-Item -ItemType Directory -Force -Path $OutputDirectory | Out-Null
$started = [DateTime]::UtcNow
$clock = [Diagnostics.Stopwatch]::StartNew()
$log = Join-Path $OutputDirectory 'gradle.log'
Push-Location (Join-Path $projectRoot 'android')
try {
    $ErrorActionPreference = 'Continue'
    & $plan.executable @arguments *> $log
    $code = $LASTEXITCODE
    $ErrorActionPreference = 'Stop'
    if ($code -ne 0) { throw "Isolated debug preparation failed ($code); see $log" }
    if ((Get-Content -LiteralPath $log -Raw) -notmatch 'ISOLATED_CONFIG_OK applicationId=com.fuzevpn.recoverytest') {
        throw 'Isolated application IDs were not verified by Gradle.'
    }
    $artifacts = @()
    if (-not $ConfigurationOnly) {
        $apkPaths = @(
            (Join-Path $projectRoot 'build/app/outputs/apk/debug/app-debug.apk'),
            (Join-Path $projectRoot 'build/app/outputs/apk/androidTest/debug/app-debug-androidTest.apk')
        )
        foreach ($apk in $apkPaths) {
            if (-not (Test-Path -LiteralPath $apk) -or (Get-Item -LiteralPath $apk).LastWriteTimeUtc -lt $started.AddSeconds(-2)) {
                throw "Missing or stale isolated APK: $apk"
            }
            $destination = Join-Path $OutputDirectory ([IO.Path]::GetFileName($apk))
            Copy-Item -LiteralPath $apk -Destination $destination
            $artifacts += [pscustomobject]@{ path=$destination; sha256=(Get-FileHash -LiteralPath $destination -Algorithm SHA256).Hash.ToLowerInvariant() }
        }
    }
    $clock.Stop()
    $result = [ordered]@{status='passed'; scope=$(if ($ConfigurationOnly) {'isolated debug configuration only'} else {'isolated debug APK preparation only'});
        applicationId=$plan.applicationId; testApplicationId=$plan.testApplicationId; targetPlatform=$TargetPlatform;
        startedAt=$started.ToString('o'); finishedAt=[DateTime]::UtcNow.ToString('o'); durationSeconds=$clock.Elapsed.TotalSeconds;
        exitCode=$code; arguments=$arguments; artifacts=$artifacts; instrumentation='not executed'; signing='standard Android debug signing only'}
    $result | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $OutputDirectory 'result.json') -Encoding utf8
    $result | ConvertTo-Json -Depth 5
} finally { Pop-Location }
