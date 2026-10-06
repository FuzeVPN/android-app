# SPDX-License-Identifier: MPL-2.0
<#
Builds the small, auditable Android dependency prefix consumed by
openvpn3_core.cmake. It is intentionally offline: callers pass clean local
Git checkouts that have already been fetched from the official repositories.

The source revisions below are the revisions selected by the vcpkg snapshot
used by the pinned OpenVPN 3 Core checkout. The OpenVPN-maintained Asio patch
series is applied to a temporary export, never to the review checkout.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$OpenVpn3Source,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$AsioSource,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$FmtSource,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$Lz4Source,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$NdkPath,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$OutputDirectory,

    [string]$CmakePath,

    [string]$NinjaPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$openVpnCommit = '28469efe3ae770268b2b5c6aa607ed1489e101f0'
$asioCommit = '231cb29bab30f82712fcd54faaea42424cc6e710'
$fmtCommit = '407c905e45ad75fc29bf0f9bb7c5c2fd3475976f'
$lz4Commit = 'ebb370ca83af193212df4dcbadcc5d87bc0de2f0'
$vcpkgSnapshot = 'd7b75fa8a30478ae5b5eb86ac730f851ef036875'
$abis = @('arm64-v8a', 'armeabi-v7a', 'x86_64')
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

function Write-Utf8NoBom([string]$Path, [string]$Value) {
    [IO.File]::WriteAllText($Path, $Value, $utf8NoBom)
}

function Resolve-RequiredDirectory([string]$Path, [string]$Label) {
    $resolved = (Resolve-Path -LiteralPath $Path -ErrorAction Stop).Path
    if (-not (Test-Path -LiteralPath $resolved -PathType Container)) {
        throw "$Label is not a directory."
    }
    return $resolved
}

function Invoke-Git([string]$WorkingDirectory, [string[]]$Arguments) {
    $output = & git -C $WorkingDirectory @Arguments 2>&1
    if ($LASTEXITCODE -ne 0) {
        throw "Git verification failed for ${WorkingDirectory}: $($output -join [Environment]::NewLine)"
    }
    return ($output -join "`n").Trim()
}

function Assert-CleanPinnedGitTree(
    [string]$Path,
    [string]$ExpectedCommit,
    [string]$ExpectedRemote,
    [string]$Label
) {
    $head = Invoke-Git $Path @('rev-parse', 'HEAD')
    if ($head -ne $ExpectedCommit) {
        throw "$Label must be checked out at $ExpectedCommit; found $head."
    }
    $remote = Invoke-Git $Path @('remote', 'get-url', 'origin')
    if ($remote -notmatch $ExpectedRemote) {
        throw "$Label origin is not the expected official upstream remote."
    }
    $dirty = Invoke-Git $Path @('status', '--porcelain=v1')
    if ($dirty) {
        throw "$Label contains local changes. Supply a clean upstream checkout."
    }
}

function Export-GitTree([string]$Source, [string]$Revision, [string]$Destination) {
    $archive = Join-Path $stageRoot ([guid]::NewGuid().ToString('N') + '.zip')
    & git -C $Source archive --format=zip --output=$archive $Revision
    if ($LASTEXITCODE -ne 0) { throw "Could not archive $Source at $Revision." }
    Expand-Archive -LiteralPath $archive -DestinationPath $Destination -Force
    Remove-Item -LiteralPath $archive -Force
}

function Find-SingleArchive([string]$Root, [string]$Name) {
    $matches = @(Get-ChildItem -LiteralPath $Root -Filter $Name -File -Recurse)
    if ($matches.Count -ne 1) {
        throw "Expected exactly one $Name below $Root; found $($matches.Count)."
    }
    return $matches[0].FullName
}

function Add-Manifest([string]$Root, [string]$ManifestPath) {
    $entries = Get-ChildItem -LiteralPath $Root -File -Recurse |
        Where-Object { $_.FullName -ne $ManifestPath } |
        Sort-Object FullName |
        ForEach-Object {
            $relative = $_.FullName.Substring($Root.Length).TrimStart('\', '/').Replace('\', '/')
            "$((Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash.ToLowerInvariant())  $relative"
        }
    Write-Utf8NoBom $ManifestPath (($entries -join "`n") + "`n")
}

$openVpnSource = Resolve-RequiredDirectory $OpenVpn3Source 'OpenVPN 3 Core source'
$asioSource = Resolve-RequiredDirectory $AsioSource 'Asio source'
$fmtSource = Resolve-RequiredDirectory $FmtSource 'fmt source'
$lz4Source = Resolve-RequiredDirectory $Lz4Source 'lz4 source'
$ndk = Resolve-RequiredDirectory $NdkPath 'Android NDK'

Assert-CleanPinnedGitTree $openVpnSource $openVpnCommit 'github\.com[/:]OpenVPN/openvpn3(?:\.git)?$' 'OpenVPN 3 Core source'
Assert-CleanPinnedGitTree $asioSource $asioCommit 'github\.com[/:]chriskohlhoff/asio(?:\.git)?$' 'Asio source'
Assert-CleanPinnedGitTree $fmtSource $fmtCommit 'github\.com[/:]fmtlib/fmt(?:\.git)?$' 'fmt source'
Assert-CleanPinnedGitTree $lz4Source $lz4Commit 'github\.com[/:]lz4/lz4(?:\.git)?$' 'lz4 source'

$toolchain = Join-Path $ndk 'build\cmake\android.toolchain.cmake'
if (-not (Test-Path -LiteralPath $toolchain -PathType Leaf)) {
    throw "Android NDK toolchain is missing: $toolchain"
}
if ([string]::IsNullOrWhiteSpace($CmakePath)) {
    $sdkRoot = Split-Path -Parent (Split-Path -Parent $ndk)
    $candidate = Get-ChildItem -LiteralPath (Join-Path $sdkRoot 'cmake') -Directory -ErrorAction SilentlyContinue |
        Sort-Object Name -Descending |
        ForEach-Object { Join-Path $_.FullName 'bin\cmake.exe' } |
        Where-Object { Test-Path -LiteralPath $_ -PathType Leaf } |
        Select-Object -First 1
    if (Test-Path -LiteralPath $candidate -PathType Leaf) {
        $CmakePath = $candidate
    } else {
        $CmakePath = 'cmake'
    }
}
if ([string]::IsNullOrWhiteSpace($NinjaPath)) {
    $candidate = Join-Path (Split-Path -Parent $CmakePath) 'ninja.exe'
    if (Test-Path -LiteralPath $candidate -PathType Leaf) {
        $NinjaPath = $candidate
    } else {
        $ninjaCommand = Get-Command ninja -ErrorAction SilentlyContinue
        if ($null -eq $ninjaCommand) {
            throw 'Ninja is required to build the audited Android dependency prefix. Supply -NinjaPath from the Android SDK CMake package.'
        }
        $NinjaPath = $ninjaCommand.Source
    }
}

$output = [IO.Path]::GetFullPath($OutputDirectory)
if (Test-Path -LiteralPath $output) {
    throw "Refusing to replace an existing dependency prefix: $output"
}
$outputParent = Split-Path -Parent $output
if (-not (Test-Path -LiteralPath $outputParent -PathType Container)) {
    throw "Dependency output parent does not exist: $outputParent"
}

$stageRoot = Join-Path $outputParent ('.openvpn-deps-' + [guid]::NewGuid().ToString('N'))
try {
    New-Item -ItemType Directory -Path $stageRoot -Force | Out-Null
    $stageDeps = Join-Path $stageRoot 'deps'
    $stageInclude = Join-Path $stageDeps 'include'
    New-Item -ItemType Directory -Path $stageInclude -Force | Out-Null

    # OpenVPN 3 Core's overlay contains an Android-relevant extension to Asio
    # (async_connect_post_open), so use the whole upstream-maintained series.
    $stagedAsio = Join-Path $stageRoot 'asio'
    Export-GitTree $asioSource $asioCommit $stagedAsio
    & git -C $stagedAsio init --quiet
    if ($LASTEXITCODE -ne 0) { throw 'Could not initialise staged Asio patch workspace.' }
    $asioPatches = @(Get-ChildItem -LiteralPath (Join-Path $openVpnSource 'deps\vcpkg-ports\asio') -Filter '*.patch' -File | Sort-Object Name)
    if ($asioPatches.Count -ne 6) { throw 'Pinned OpenVPN checkout does not contain its expected six-patch Asio series.' }
    foreach ($patch in $asioPatches) {
        & git -C $stagedAsio apply --check $patch.FullName
        if ($LASTEXITCODE -ne 0) { throw "OpenVPN Asio patch does not apply: $($patch.Name)" }
        & git -C $stagedAsio apply $patch.FullName
        if ($LASTEXITCODE -ne 0) { throw "Could not apply OpenVPN Asio patch: $($patch.Name)" }
    }

    Get-ChildItem -LiteralPath (Join-Path $stagedAsio 'asio\include') |
        ForEach-Object { Copy-Item -LiteralPath $_.FullName -Destination $stageInclude -Recurse }
    Copy-Item -LiteralPath (Join-Path $fmtSource 'include\fmt') -Destination $stageInclude -Recurse
    Get-ChildItem -LiteralPath (Join-Path $lz4Source 'lib') -Filter '*.h' -File |
        ForEach-Object { Copy-Item -LiteralPath $_.FullName -Destination $stageInclude }

    foreach ($abi in $abis) {
        $abiRoot = Join-Path $stageRoot $abi
        $lz4Build = Join-Path $abiRoot 'lz4'
        $fmtBuild = Join-Path $abiRoot 'fmt'

        & $CmakePath -G Ninja "-DCMAKE_MAKE_PROGRAM=$NinjaPath" -S (Join-Path $lz4Source 'build\cmake') -B $lz4Build `
            "-DCMAKE_TOOLCHAIN_FILE=$toolchain" "-DANDROID_ABI=$abi" '-DANDROID_PLATFORM=android-26' `
            '-DCMAKE_BUILD_TYPE=Release' '-DBUILD_SHARED_LIBS=OFF' '-DLZ4_BUILD_CLI=OFF'
        if ($LASTEXITCODE -ne 0) { throw "lz4 configure failed for $abi." }
        & $CmakePath --build $lz4Build --config Release
        if ($LASTEXITCODE -ne 0) { throw "lz4 build failed for $abi." }

        & $CmakePath -G Ninja "-DCMAKE_MAKE_PROGRAM=$NinjaPath" -S $fmtSource -B $fmtBuild `
            "-DCMAKE_TOOLCHAIN_FILE=$toolchain" "-DANDROID_ABI=$abi" '-DANDROID_PLATFORM=android-26' `
            '-DCMAKE_BUILD_TYPE=Release' '-DBUILD_SHARED_LIBS=OFF' '-DFMT_TEST=OFF' '-DFMT_DOC=OFF' '-DFMT_INSTALL=OFF'
        if ($LASTEXITCODE -ne 0) { throw "fmt configure failed for $abi." }
        & $CmakePath --build $fmtBuild --config Release
        if ($LASTEXITCODE -ne 0) { throw "fmt build failed for $abi." }

        $abiLib = Join-Path $stageDeps "lib\$abi"
        New-Item -ItemType Directory -Path $abiLib -Force | Out-Null
        Copy-Item -LiteralPath (Find-SingleArchive $lz4Build 'liblz4.a') -Destination (Join-Path $abiLib 'liblz4.a')
        Copy-Item -LiteralPath (Find-SingleArchive $fmtBuild 'libfmt.a') -Destination (Join-Path $abiLib 'libfmt.a')
    }

    $metadata = [ordered]@{
        schema = 'https://fuzevpn.com/schemas/openvpn3-android-dependencies-v1.json'
        androidApi = 26
        vcpkgSnapshot = $vcpkgSnapshot
        sources = @(
            [ordered]@{ name = 'asio'; url = 'https://github.com/chriskohlhoff/asio.git'; ref = 'asio-1-36-0'; commit = $asioCommit; license = 'BSL-1.0'; openvpnPatchDirectory = 'deps/vcpkg-ports/asio' },
            [ordered]@{ name = 'fmt'; url = 'https://github.com/fmtlib/fmt.git'; ref = '12.1.0'; commit = $fmtCommit; license = 'MIT' },
            [ordered]@{ name = 'lz4'; url = 'https://github.com/lz4/lz4.git'; ref = 'v1.10.0'; commit = $lz4Commit; license = 'BSD-2-Clause'; toolsFeature = 'not-built' }
        )
        asioPatches = @($asioPatches | ForEach-Object {
            [ordered]@{ name = $_.Name; sha256 = (Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash.ToLowerInvariant() }
        })
    }
    $metadataPath = Join-Path $stageDeps 'DEPENDENCIES-METADATA.json'
    Write-Utf8NoBom $metadataPath ($metadata | ConvertTo-Json -Depth 6)
    Add-Manifest $stageDeps (Join-Path $stageDeps 'MANIFEST.sha256')

    Move-Item -LiteralPath $stageDeps -Destination $output
} finally {
    if (Test-Path -LiteralPath $stageRoot) {
        Remove-Item -LiteralPath $stageRoot -Recurse -Force
    }
}

Write-Host "Prepared verified OpenVPN dependency prefix at $output. Review its MANIFEST.sha256 before importing it."
