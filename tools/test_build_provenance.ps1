# SPDX-License-Identifier: Apache-2.0
[CmdletBinding()]
param(
    [string]$JavaHome = $env:JAVA_HOME,
    [string]$OutputDirectory
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
if (-not $JavaHome) { throw 'Set JAVA_HOME to JDK 17 or pass -JavaHome.' }
$root = Split-Path -Parent $PSScriptRoot
if (-not $OutputDirectory) { $OutputDirectory = Join-Path $root 'build/native-provenance-tests' }
$OutputDirectory = [IO.Path]::GetFullPath($OutputDirectory)
New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null
$sources = Join-Path $root 'android/buildSrc/src'
$java = Join-Path $JavaHome 'bin/java.exe'
$javac = Join-Path $JavaHome 'bin/javac.exe'
& $javac --release 17 -encoding UTF-8 -d $OutputDirectory `
    (Join-Path $sources 'main/java/com/fuzevpn/build/NativeBundlePolicy.java') `
    (Join-Path $sources 'main/java/com/fuzevpn/build/AndroidManifestPolicy.java') `
    (Join-Path $sources 'test/java/com/fuzevpn/build/NativeBundlePolicyTest.java') `
    (Join-Path $sources 'test/java/com/fuzevpn/build/AndroidManifestPolicyTest.java')
if ($LASTEXITCODE -ne 0) { throw 'Native/manifest policy test compilation failed.' }
& $java -classpath $OutputDirectory com.fuzevpn.build.NativeBundlePolicyTest `
    (Join-Path $root 'android/app/src/main/cpp/third_party') (Join-Path $root 'android/native-provenance/bundle.sha256')
if ($LASTEXITCODE -ne 0) { throw 'Native integrity tests failed.' }
& $java -classpath $OutputDirectory com.fuzevpn.build.AndroidManifestPolicyTest
if ($LASTEXITCODE -ne 0) { throw 'Merged permission tests failed.' }

. (Join-Path $PSScriptRoot 'wireguard_manifest.ps1')
. (Join-Path $root 'android/app/src/main/cpp/tools/native_bundle_import.ps1')
$namespace = 'http://schemas.android.com/apk/res/android'
$source = '<manifest xmlns:android="http://schemas.android.com/apk/res/android"><application /></manifest>'
$published = '<manifest xmlns:android="http://schemas.android.com/apk/res/android" package="com.wireguard.android.tunnel"><uses-sdk android:minSdkVersion="24" android:targetSdkVersion="36"/></manifest>'
$packaged = Read-WireGuardManifestXml (New-WireGuardPackagedManifest $source $published)
$sdk = $packaged.DocumentElement.SelectSingleNode('uses-sdk')
if ($sdk.GetAttribute('minSdkVersion', $namespace) -ne '24' -or $sdk.GetAttribute('targetSdkVersion', $namespace) -ne '36') {
    throw 'Repackaging discarded published SDK metadata.'
}
Write-Host 'PASS: repackaging preserves published minSdk and targetSdk.'
$publishedWithoutTarget = $published.Replace(' android:targetSdkVersion="36"', '')
$packagedWithoutTarget = New-WireGuardPackagedManifest $source $publishedWithoutTarget
if ($packagedWithoutTarget -notmatch 'minSdkVersion="24"') { throw 'Default target=minSdk was not preserved.' }
Write-Host 'PASS: published minSdk-only metadata remains valid.'
foreach ($invalid in @($source, $published.Replace('minSdkVersion="24"', 'minSdkVersion="1"'), $published.Replace('targetSdkVersion="36"', 'targetSdkVersion="3"'))) {
    $rejected = $false
    try { $null = New-WireGuardPackagedManifest $source $invalid } catch { $rejected = $true }
    if (-not $rejected) { throw 'Invalid published SDK metadata was accepted.' }
}
Write-Host 'PASS: missing/legacy/inconsistent SDK metadata is rejected.'

$fixture = Join-Path $OutputDirectory ('import-destination-' + [guid]::NewGuid().ToString('N'))
$importer = Join-Path $fixture 'android/app/src/main/cpp/tools'
$destination = Resolve-NativeBundleDestination $importer
$expected = [IO.Path]::GetFullPath((Join-Path $fixture 'android/app/src/main/cpp/third_party'))
if ($destination -ne $expected) { throw 'Importer destination differs from the CMake third_party directory.' }
$stage = Join-Path (Split-Path -Parent $destination) ('.fuzevpn-native-import-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path (Join-Path $stage 'openvpn3-core') -Force | Out-Null
[IO.File]::WriteAllText((Join-Path $stage 'openvpn3-core/import-fixture.txt'), 'isolated fixture')
Publish-NativeBundleStage $stage $destination
if (-not (Test-Path -LiteralPath (Join-Path $expected 'openvpn3-core/import-fixture.txt'))) { throw 'Staged bundle was published to the wrong directory.' }
Write-Host 'PASS: isolated import publishes under cpp/third_party, matching CMake.'
$replacementStage = Join-Path (Split-Path -Parent $destination) ('.fuzevpn-native-import-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $replacementStage | Out-Null
$rejected = $false
try { Publish-NativeBundleStage $replacementStage $destination } catch { $rejected = $true }
if (-not $rejected) { throw 'Importer replaced an existing bundle.' }
if ([IO.File]::ReadAllText((Join-Path $expected 'openvpn3-core/import-fixture.txt')) -ne 'isolated fixture') { throw 'Existing bundle changed during refused replacement.' }
Write-Host 'PASS: existing native bundle is preserved when replacement is refused.'
Write-Host "Build provenance checks passed. Fixtures: $OutputDirectory"
