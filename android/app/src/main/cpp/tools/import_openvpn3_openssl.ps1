# SPDX-License-Identifier: MPL-2.0
<#
Strict offline importer for the OpenVPN 3 + OpenSSL Android native bundle.
No patch is applied: ECDSA is delegated to Android Keystore by OpenVPN 3's
upstream OpenSSL XKey provider.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)] [string]$OpenVpn3Source,
    [Parameter(Mandatory)] [string]$DependenciesSource,
    [Parameter(Mandatory)] [string]$OpenSslPrefixSource,
    [Parameter(Mandatory)] [string]$OpenSslSourceArchive,
    [Parameter(Mandatory)]
    [ValidatePattern('^[A-Fa-f0-9]{64}$')]
    [string]$DependenciesManifestSha256,
    [string]$JavaHome = $env:JAVA_HOME,
    [string]$DestinationRoot
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'native_bundle_import.ps1')

$coreCommit = '28469efe3ae770268b2b5c6aa607ed1489e101f0'
$opensslVersion = '3.5.9'
$opensslCommit = '45e844fa2a14ec92d146bd8f5778ac130b6625fb'
$opensslArchiveSha256 = '603f5602e2eef00d77fbd429d34dcd5822bb301757a1bc9cdb24c670f1eb859a'
$abis = @('arm64-v8a', 'armeabi-v7a', 'x86_64')
$utf8NoBom = [Text.UTF8Encoding]::new($false)
$androidRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../../../../..'))
$verifier = Join-Path $androidRoot 'buildSrc/src/main/java/com/fuzevpn/build/NativeBundlePolicy.java'
$provenanceRoot = Join-Path $androidRoot 'native-provenance'
$trustedManifest = Join-Path $provenanceRoot 'bundle.sha256'
if (-not $JavaHome) { $JavaHome = Join-Path $env:USERPROFILE '.codex/toolchains/temurin-17' }
$java = Join-Path $JavaHome 'bin/java.exe'
if (-not (Test-Path -LiteralPath $java)) { $java = Join-Path $JavaHome 'bin/java' }
if (-not $DestinationRoot) { $DestinationRoot = Resolve-NativeBundleDestination $PSScriptRoot }
$thirdParty = [IO.Path]::GetFullPath($DestinationRoot)
Assert-NativePathHasNoLinks $thirdParty
if (Test-Path -LiteralPath $thirdParty) {
    throw "Refusing to replace an existing native bundle: $thirdParty. Use a new isolated destination for review."
}

function Resolve-Directory([string]$Path, [string]$Label) {
    $resolved = (Resolve-Path -LiteralPath $Path -ErrorAction Stop).Path
    if (-not (Test-Path -LiteralPath $resolved -PathType Container)) {
        throw "$Label is not a directory."
    }
    return $resolved
}

function Assert-File([string]$Path, [string]$Label) {
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        throw "$Label is missing: $Path"
    }
}

function Invoke-Git([string]$Directory, [string[]]$Arguments) {
    $result = & git -C $Directory @Arguments 2>&1
    if ($LASTEXITCODE -ne 0) { throw "Git verification failed in ${Directory}: $result" }
    return ($result -join "`n").Trim()
}

function Invoke-NativeIntegrity([string]$Root, [string]$Component) {
    $arguments = if ($Component) { @('component', $Root, $trustedManifest, $Component) }
        else { @('bundle', $Root, $trustedManifest) }
    & $java --source 17 $verifier @arguments
    if ($LASTEXITCODE -ne 0) { throw "Native provenance verification failed: $Root" }
}

$core = Resolve-Directory $OpenVpn3Source 'OpenVPN 3 source'
$deps = Resolve-Directory $DependenciesSource 'dependency prefix'
$openssl = Resolve-Directory $OpenSslPrefixSource 'OpenSSL Android prefix'
$sourceArchive = (Resolve-Path -LiteralPath $OpenSslSourceArchive -ErrorAction Stop).Path
Assert-File $java 'JDK 17 runtime'
Assert-File $verifier 'shared native verifier'
Assert-File $trustedManifest 'reviewed native manifest'

if ((Invoke-Git $core @('rev-parse', 'HEAD')) -ne $coreCommit) {
    throw "OpenVPN 3 must be at $coreCommit."
}
if (Invoke-Git $core @('status', '--porcelain')) {
    throw 'OpenVPN 3 contains local changes; no application crypto patch is accepted.'
}
Assert-File (Join-Path $core 'openvpn\openssl\pki\xkey.hpp') 'OpenVPN XKey adapter'
Assert-File (Join-Path $core 'openvpn\openssl\xkey\xkey_provider.c') 'OpenVPN XKey provider'
$xkey = Get-Content -LiteralPath (Join-Path $core 'openvpn\openssl\pki\xkey.hpp') -Raw
if ($xkey -notmatch 'algstr\s*=\s*"ECDSA"' -or $xkey -notmatch 'xkey_load_generic_key') {
    throw 'The pinned Core does not expose the expected upstream ECDSA XKey path.'
}

$actualSourceHash = (Get-FileHash -LiteralPath $sourceArchive -Algorithm SHA256).Hash.ToLowerInvariant()
if ($actualSourceHash -ne $opensslArchiveSha256) {
    throw "OpenSSL source archive hash mismatch: $actualSourceHash"
}
foreach ($abi in $abis) {
    $header = Join-Path $openssl "include\$abi\openssl\opensslv.h"
    Assert-File $header "OpenSSL $abi version header"
    Assert-File (Join-Path $openssl "include\$abi\openssl\configuration.h") "OpenSSL $abi configuration"
    Assert-File (Join-Path $openssl "lib\$abi\libcrypto.a") "OpenSSL $abi libcrypto"
    Assert-File (Join-Path $openssl "lib\$abi\libssl.a") "OpenSSL $abi libssl"
    if ((Get-Content -LiteralPath $header -Raw) -notmatch "OPENSSL_VERSION_STR `"$opensslVersion`"") {
        throw "OpenSSL headers for $abi are not version $opensslVersion."
    }
}
Assert-File (Join-Path $deps 'MANIFEST.sha256') 'dependency manifest'
$actualDepsHash = (Get-FileHash -LiteralPath (Join-Path $deps 'MANIFEST.sha256') -Algorithm SHA256).Hash
if ($actualDepsHash -ne $DependenciesManifestSha256) {
    throw 'The dependency prefix does not match its reviewed manifest hash.'
}
Invoke-NativeIntegrity $deps 'deps'
Invoke-NativeIntegrity $openssl 'openssl'

$destinationParent = Split-Path -Parent $thirdParty
New-Item -ItemType Directory -Path $destinationParent -Force | Out-Null
$stage = Join-Path $destinationParent ('.fuzevpn-native-import-' + [guid]::NewGuid().ToString('N'))
try {
    New-Item -ItemType Directory -Path $stage -Force | Out-Null
    $stageCore = Join-Path $stage 'openvpn3-core'
    $stageDeps = Join-Path $stage 'deps'
    $stageOpenSsl = Join-Path $stage 'openssl'
    # Export only the pinned Git revision, never untracked files or nested .git.
    $coreArchive = Join-Path $stage '.core-source.zip'
    & git -C $core archive --format=zip -o $coreArchive $coreCommit
    if ($LASTEXITCODE -ne 0) { throw 'Cannot export the reviewed OpenVPN source.' }
    Expand-Archive -LiteralPath $coreArchive -DestinationPath $stageCore
    Remove-Item -LiteralPath $coreArchive -Force
    Copy-Item -LiteralPath $deps -Destination $stageDeps -Recurse
    Copy-Item -LiteralPath $openssl -Destination $stageOpenSsl -Recurse
    Copy-Item -LiteralPath $sourceArchive -Destination (Join-Path $stageOpenSsl 'source\openssl-3.5.9.tar.gz') -Force
    Copy-Item -LiteralPath (Join-Path $provenanceRoot 'core-marker.txt') -Destination (Join-Path $stageCore 'FUZEVPN-PINNED-VERSION.txt')
    Copy-Item -LiteralPath (Join-Path $provenanceRoot 'import-metadata.json') -Destination (Join-Path $stage 'IMPORT-METADATA.json')
    # Do not regenerate a manifest from arbitrary supplied binaries. Check the
    # complete copied tree against the independently pinned reviewed inventory.
    Invoke-NativeIntegrity $stage ''
    Publish-NativeBundleStage $stage $thirdParty
} catch {
    # Keep a failed isolated stage reviewable. Never destroy an existing bundle.
    Write-Warning "Import failed before publication; isolated stage retained at $stage"
    throw
}

Write-Host 'Imported OpenVPN 3 Core with OpenSSL 3.5.9 and the upstream XKey ECDSA path.'
