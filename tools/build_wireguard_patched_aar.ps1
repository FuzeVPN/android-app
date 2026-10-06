# SPDX-License-Identifier: Apache-2.0
<#
Builds the reviewed local WireGuard AAR used by release builds.

Recompiles the reviewed Java/manifest patches and packages libwg-go rebuilt by
build_wireguard_native.ps1. The protected-start JNI contract must be available
on every ABI. Other native libraries remain identical to the official AAR.

AGP 9.3 throws while transforming a file-dependency AAR containing an empty
R.txt. WireGuard's tunnel library deliberately has no Android resources, so
the script removes only that zero-byte marker; it changes neither resources,
Java APIs nor native libraries.

Use a Linux/WSL/CI source build as an additional release check when available.
#>
[CmdletBinding()]
param(
    [string]$JavaHome = $env:JAVA_HOME,
    [string]$AndroidSdk = $(if ($env:ANDROID_SDK_ROOT) { $env:ANDROID_SDK_ROOT } else { $env:ANDROID_HOME }),
    [string]$OfficialAar,
    [string]$NativeDirectory
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'wireguard_manifest.ps1')

$expectedAarSha256 = '2b9c16db026496123e4db695d26d03d1958a201096c7c4c89b21077dc70f3119'
$expectedCommit = '09b75c2bd37f749e2a8c85876394854113c74be7'
$expectedPatchSha256 = '777a8563e37ca11c4bf084820c3fd69e12280c5dd48af99274cf407dcfacd92c'
$version = '1.0.20260102'
$root = Split-Path -Parent $PSScriptRoot
$sourceRoot = Join-Path $root 'android\third_party\wireguard-android'
$sourceFile = Join-Path $sourceRoot 'tunnel\src\main\java\com\wireguard\android\backend\GoBackend.java'
$sourceManifest = Join-Path $sourceRoot 'tunnel\src\main\AndroidManifest.xml'
$importMetadataPath = Join-Path $sourceRoot 'FUZEVPN-IMPORT-METADATA.json'
$projectPatch = Join-Path $root 'patches\wireguard-android\0001-go-backend-real-foreground-service.patch'
$copiedPatch = Join-Path $sourceRoot 'patches\fuzevpn\0001-go-backend-real-foreground-service.patch'
$startupPatch = Join-Path $root 'patches\wireguard-android\0002-go-backend-protected-start.patch'
$copiedStartupPatch = Join-Path $sourceRoot 'patches\fuzevpn\0002-go-backend-protected-start.patch'
$outputDirectory = Join-Path $sourceRoot 'dist'
$outputAar = Join-Path $outputDirectory "tunnel-$version-fuzevpn-fgs.aar"
$outputMetadata = Join-Path $outputDirectory "tunnel-$version-fuzevpn-fgs.metadata.json"
$archiveTimestamp = '2026-01-02T00:00:00Z'

function Require-Path([string]$Path, [string]$Label) {
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        throw "$Label is missing: $Path"
    }
}

function Resolve-SingleCachedJar([string]$RelativePath, [string]$Label) {
    $gradleHome = if ($env:GRADLE_USER_HOME) { $env:GRADLE_USER_HOME } else { Join-Path $env:USERPROFILE '.gradle' }
    $candidates = @(Get-ChildItem (Join-Path $gradleHome $RelativePath) -Recurse -Filter '*.jar' -File -ErrorAction SilentlyContinue)
    if ($candidates.Count -ne 1) {
        throw "Expected one $Label JAR in Gradle cache; found $($candidates.Count)."
    }
    return $candidates[0].FullName
}

Require-Path $sourceFile 'Patched WireGuard source'
Require-Path $sourceManifest 'Patched WireGuard manifest'
Require-Path $importMetadataPath 'WireGuard import metadata'
Require-Path $projectPatch 'WireGuard patch'
Require-Path $copiedPatch 'Copied WireGuard patch'
Require-Path $startupPatch 'Protected-start WireGuard patch'
Require-Path $copiedStartupPatch 'Copied protected-start patch'

$importMetadata = Get-Content -LiteralPath $importMetadataPath -Raw | ConvertFrom-Json
if ($importMetadata.source.commit -ne $expectedCommit) {
    throw "Unexpected WireGuard source commit: $($importMetadata.source.commit)"
}

$startupPatchHash = (Get-FileHash -LiteralPath $startupPatch -Algorithm SHA256).Hash.ToLowerInvariant()
if ($startupPatchHash -ne $importMetadata.protectedStartPatch.sha256 -or
    $startupPatchHash -ne (Get-FileHash -LiteralPath $copiedStartupPatch -Algorithm SHA256).Hash.ToLowerInvariant()) {
    throw 'Protected-start patch does not match its reviewed metadata.'
}
if (-not $NativeDirectory) { $NativeDirectory = Join-Path $root 'build\wireguard-native' }
$nativeMetadataPath = Join-Path $NativeDirectory 'metadata.json'
Require-Path $nativeMetadataPath 'Rebuilt WireGuard native metadata'
$nativeMetadata = Get-Content -LiteralPath $nativeMetadataPath -Raw | ConvertFrom-Json
foreach ($inputFile in $nativeMetadata.sourceHashes.PSObject.Properties) {
    $inputPath = Join-Path $sourceRoot ("tunnel\tools\libwg-go\" + $inputFile.Name)
    Require-Path $inputPath 'Native source input'
    if ((Get-FileHash -LiteralPath $inputPath -Algorithm SHA256).Hash.ToLowerInvariant() -ne $inputFile.Value) {
        throw "Native source changed after compilation: $($inputFile.Name)"
    }
}
foreach ($abi in @('arm64-v8a', 'armeabi-v7a', 'x86', 'x86_64')) {
    $built = @($nativeMetadata.abi | Where-Object { $_.name -eq $abi })
    if ($built.Count -ne 1) { throw "A rebuilt native library is required for $abi" }
    $nativePath = Join-Path $NativeDirectory "$abi\libwg-go.so"
    Require-Path $nativePath 'Rebuilt protected-start library'
    if ((Get-FileHash -LiteralPath $nativePath -Algorithm SHA256).Hash.ToLowerInvariant() -ne $built[0].sha256) {
        throw "Native build digest mismatch: $abi"
    }
}
foreach ($patchPath in @($projectPatch, $copiedPatch)) {
    $patchHash = (Get-FileHash -LiteralPath $patchPath -Algorithm SHA256).Hash.ToLowerInvariant()
    if ($patchHash -ne $expectedPatchSha256 -or $patchHash -ne $importMetadata.patch.sha256) {
        throw "WireGuard foreground-service patch hash does not match import metadata: $patchPath"
    }
}

if ([string]::IsNullOrWhiteSpace($JavaHome)) {
    throw 'Set JAVA_HOME to JDK 17 or pass -JavaHome.'
}
$javac = Join-Path $JavaHome 'bin\javac.exe'
$jar = Join-Path $JavaHome 'bin\jar.exe'
$javap = Join-Path $JavaHome 'bin\javap.exe'
Require-Path $javac 'JDK 17 javac'
Require-Path $jar 'JDK 17 jar'
Require-Path $javap 'JDK 17 javap'

if ([string]::IsNullOrWhiteSpace($AndroidSdk)) {
    throw 'Set ANDROID_SDK_ROOT or pass -AndroidSdk.'
}
$androidJar = Join-Path $AndroidSdk 'platforms\android-36\android.jar'
Require-Path $androidJar 'Android API 36 platform JAR'

if ([string]::IsNullOrWhiteSpace($OfficialAar)) {
    $gradleHome = if ($env:GRADLE_USER_HOME) { $env:GRADLE_USER_HOME } else { Join-Path $env:USERPROFILE '.gradle' }
    $candidates = @(Get-ChildItem (Join-Path $gradleHome "caches\modules-2\files-2.1\com.wireguard.android\tunnel\$version") -Recurse -Filter '*.aar' -File -ErrorAction SilentlyContinue)
    if ($candidates.Count -ne 1) {
        throw "Expected one official WireGuard $version AAR in Gradle cache; found $($candidates.Count)."
    }
    $OfficialAar = $candidates[0].FullName
}
Require-Path $OfficialAar 'Official WireGuard AAR'
$officialAarHash = (Get-FileHash -LiteralPath $OfficialAar -Algorithm SHA256).Hash.ToLowerInvariant()
if ($officialAarHash -ne $expectedAarSha256) {
    throw "Unexpected official WireGuard AAR SHA-256: $officialAarHash"
}

$annotationJar = Resolve-SingleCachedJar 'caches\modules-2\files-2.1\androidx.annotation\annotation-jvm\1.9.1' 'AndroidX annotation'
$collectionJar = Resolve-SingleCachedJar 'caches\modules-2\files-2.1\androidx.collection\collection-jvm\1.5.0' 'AndroidX collection'
$stage = Join-Path $env:TEMP ("fuzevpn-wireguard-aar-" + [guid]::NewGuid().ToString('N'))

try {
    New-Item -ItemType Directory -Path $stage -Force | Out-Null
    $contents = Join-Path $stage 'contents'
    New-Item -ItemType Directory -Path $contents -Force | Out-Null
    Push-Location $contents
    try {
        & $jar xf $OfficialAar
        if ($LASTEXITCODE -ne 0) { throw 'Unable to unpack official WireGuard AAR.' }
    } finally {
        Pop-Location
    }

    $classesJar = Join-Path $contents 'classes.jar'
    foreach ($abi in @('arm64-v8a', 'armeabi-v7a', 'x86', 'x86_64')) {
        Copy-Item -LiteralPath (Join-Path $NativeDirectory "$abi\libwg-go.so") -Destination (Join-Path $contents "jni\$abi\libwg-go.so") -Force
    }
    Require-Path $classesJar 'WireGuard classes.jar'
    $compiledClasses = Join-Path $stage 'compiled-classes'
    New-Item -ItemType Directory -Path $compiledClasses -Force | Out-Null
    $classPath = @($classesJar, $androidJar, $annotationJar, $collectionJar) -join ';'
    & $javac --release 17 -encoding UTF-8 -classpath $classPath -d $compiledClasses $sourceFile
    if ($LASTEXITCODE -ne 0) { throw 'Unable to compile patched GoBackend.java.' }

    $backendDirectory = Join-Path $compiledClasses 'com\wireguard\android\backend'
    $classEntries = Get-ChildItem -LiteralPath $backendDirectory -Filter 'GoBackend*.class' -File | ForEach-Object {
        "com/wireguard/android/backend/$($_.Name)"
    }
    if ($classEntries.Count -lt 5) { throw 'Patched GoBackend classes are incomplete.' }
    Push-Location $compiledClasses
    try {
        & $jar --update --file $classesJar --date=$archiveTimestamp @classEntries
        if ($LASTEXITCODE -ne 0) { throw 'Unable to update WireGuard classes.jar.' }
    } finally {
        Pop-Location
    }

    # Keep the SDK metadata of the hash-verified published manifest. Copying
    # only its package would make AGP infer legacy phone/storage permissions.
    $manifestOutput = Join-Path $contents 'AndroidManifest.xml'
    $manifestXml = New-WireGuardPackagedManifest `
        -SourceXml (Get-Content -LiteralPath $sourceManifest -Raw) `
        -PublishedXml (Get-Content -LiteralPath $manifestOutput -Raw)
    [IO.File]::WriteAllText($manifestOutput, $manifestXml, [Text.UTF8Encoding]::new($false))
    $rTxt = Join-Path $contents 'R.txt'
    if ((Test-Path -LiteralPath $rTxt) -and (Get-Item -LiteralPath $rTxt).Length -ne 0) {
        throw 'WireGuard R.txt unexpectedly contains resources; refusing to strip it.'
    }
    if (Test-Path -LiteralPath $rTxt) { Remove-Item -LiteralPath $rTxt -Force }

    New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
    $temporaryAar = Join-Path $stage 'tunnel-patched.aar'
    Push-Location $contents
    try {
        & $jar --create --file $temporaryAar --date=$archiveTimestamp .
        if ($LASTEXITCODE -ne 0) { throw 'Unable to package patched WireGuard AAR.' }
    } finally {
        Pop-Location
    }
    Copy-Item -LiteralPath $temporaryAar -Destination $outputAar -Force

    $verifyDirectory = Join-Path $stage 'verify'
    New-Item -ItemType Directory -Path $verifyDirectory -Force | Out-Null
    Push-Location $verifyDirectory
    try {
        & $jar xf $outputAar classes.jar AndroidManifest.xml jni
        if ($LASTEXITCODE -ne 0) { throw 'Unable to inspect patched WireGuard AAR.' }
    } finally {
        Pop-Location
    }
    $vpnServiceJavap = & $javap -private -classpath (Join-Path $verifyDirectory 'classes.jar') 'com.wireguard.android.backend.GoBackend$VpnService'
    if ($LASTEXITCODE -ne 0 -or -not ($vpnServiceJavap -match 'refreshForegroundNotification')) {
        throw 'Patched WireGuard AAR lacks its foreground-service API.'
    }
    if ($vpnServiceJavap -match 'requestStop|awaitDestroyed|isStopping') {
        throw 'Patched WireGuard AAR still contains the rejected blocking teardown lifecycle.'
    }
    $goBackendJavap = & $javap -private -c -classpath (Join-Path $verifyDirectory 'classes.jar') 'com.wireguard.android.backend.GoBackend'
    if ($LASTEXITCODE -ne 0 -or
        -not ($goBackendJavap -match 'startForegroundService') -or
        -not ($goBackendJavap -match 'setHostLifecycleListener') -or
        -not ($goBackendJavap -match 'startHost') -or
        -not ($goBackendJavap -match 'getActiveHost') -or
        -not ($goBackendJavap -match 'stopHost') -or
        -not ($goBackendJavap -match 'wgSetConfig')) {
        throw 'Patched WireGuard AAR lacks the audited shared VPN host lifecycle API.'
    }
    $hostListenerJavap = & $javap -private -classpath (Join-Path $verifyDirectory 'classes.jar') 'com.wireguard.android.backend.GoBackend$HostLifecycleListener'
    if ($LASTEXITCODE -ne 0 -or
        -not ($hostListenerJavap -match 'onSystemStart') -or
        -not ($hostListenerJavap -match 'onHostRevoked') -or
        -not ($hostListenerJavap -match 'onHostDestroyed')) {
        throw 'Patched WireGuard AAR lacks its host lifecycle listener.'
    }
    $verifiedManifest = Get-Content -LiteralPath (Join-Path $verifyDirectory 'AndroidManifest.xml') -Raw
    if ($verifiedManifest -notmatch 'package="com.wireguard.android.tunnel"' -or
        $verifiedManifest -notmatch 'foregroundServiceType="specialUse"' -or
        $verifiedManifest -notmatch 'android.net.VpnService.SUPPORTS_ALWAYS_ON"\s+android:value="true"') {
        throw 'Patched WireGuard AAR manifest lacks the approved system VPN host declaration.'
    }
    $aarEntries = & $jar tf $outputAar
    if ($LASTEXITCODE -ne 0 -or $aarEntries -contains 'R.txt') {
        throw 'Patched WireGuard AAR unexpectedly contains R.txt.'
    }
    foreach ($abi in @('arm64-v8a', 'armeabi-v7a', 'x86', 'x86_64')) {
        $nativeDirectory = Join-Path $contents "jni\$abi"
        $verifiedNativeDirectory = Join-Path $verifyDirectory "jni\$abi"
        $nativeLibraries = @(Get-ChildItem -LiteralPath $nativeDirectory -Filter '*.so' -File)
        if ($nativeLibraries.Count -eq 0) { throw "WireGuard native libraries are missing for $abi" }
        foreach ($native in $nativeLibraries) {
            $verifiedNative = Join-Path $verifiedNativeDirectory $native.Name
            Require-Path $verifiedNative "Packaged WireGuard native library for $abi"
            if ((Get-FileHash -LiteralPath $native.FullName -Algorithm SHA256).Hash -ne (Get-FileHash -LiteralPath $verifiedNative -Algorithm SHA256).Hash) {
                throw "WireGuard native library changed while packaging: $abi/$($native.Name)"
            }
        }
    }

    $result = [ordered]@{
        schema = 'https://fuzevpn.com/schemas/wireguard-patched-aar-v1.json'
        artifact = [IO.Path]::GetFileName($outputAar)
        sha256 = (Get-FileHash -LiteralPath $outputAar -Algorithm SHA256).Hash.ToLowerInvariant()
        upstreamAarSha256 = $officialAarHash
        sourceCommit = $expectedCommit
        patchSha256 = $expectedPatchSha256
        protectedStartPatchSha256 = $startupPatchHash
        jdk = (& (Join-Path $JavaHome 'bin\java.exe') -version 2>&1 | Select-Object -First 1).ToString()
        nativeLibraries = 'libwg-go rebuilt from pinned source with protected-start JNI; other libraries unchanged from official AAR.'
        nativeBuild = $nativeMetadata
        emptyRTxt = 'Excluded because AGP 9.3 fails transforming a local AAR with empty R.txt.'
        abi = @('arm64-v8a', 'armeabi-v7a', 'x86', 'x86_64')
    } | ConvertTo-Json -Depth 8
    [IO.File]::WriteAllText($outputMetadata, "$result`n", [Text.UTF8Encoding]::new($false))
    Write-Host "Built audited WireGuard AAR: $outputAar"
} finally {
    if (Test-Path -LiteralPath $stage) {
        $resolvedStage = [IO.Path]::GetFullPath($stage)
        $resolvedTemp = [IO.Path]::GetFullPath($env:TEMP).TrimEnd('\') + '\'
        if (-not $resolvedStage.StartsWith($resolvedTemp, [StringComparison]::OrdinalIgnoreCase) -or
            -not ([IO.Path]::GetFileName($resolvedStage)).StartsWith('fuzevpn-wireguard-aar-')) {
            throw 'Refusing to remove an unverified build staging directory.'
        }
        Remove-Item -LiteralPath $resolvedStage -Recurse -Force
    }
}
