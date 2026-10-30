# SPDX-License-Identifier: Apache-2.0
<#
Stages the exact WireGuard Android source that is reviewed for the Android
release.  This script deliberately does not download, compile or silently
alter upstream sources: the patched AAR must be produced and reviewed in a
Linux CI/WSL runner, then copied to the dist path checked by Gradle.

The foreground-service patch belongs in the source bundle, with its SHA-256
and a patch series.  The pinned source tag is signed upstream; callers are
responsible for verifying its OpenPGP signature in their release environment.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateScript({ Test-Path -LiteralPath $_ -PathType Container })]
    [string]$WireGuardAndroidSource,

    [ValidateScript({ Test-Path -LiteralPath $_ -PathType Leaf })]
    [string]$ForegroundServicePatch = (Join-Path $PSScriptRoot '..\patches\wireguard-android\0001-go-backend-real-foreground-service.patch'),

    [ValidateScript({ Test-Path -LiteralPath $_ -PathType Leaf })]
    [string]$ProtectedStartPatch = (Join-Path $PSScriptRoot '..\patches\wireguard-android\0002-go-backend-protected-start.patch'),

    [ValidateScript({ Test-Path -LiteralPath $_ -PathType Leaf })]
    [string]$NativeRuntimePatch = (Join-Path $PSScriptRoot '..\patches\wireguard-android\0003-go-runtime-and-handshake-update.patch')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'wireguard_patch_series.ps1')

$expectedCommit = '09b75c2bd37f749e2a8c85876394854113c74be7'
$expectedTag = '1.0.20260102'
$expectedAnnotatedTagObject = '3831cab2da844319291459308a6e535d36dde4b3'
$root = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$destination = [IO.Path]::GetFullPath((Join-Path $root 'android\third_party\wireguard-android'))

function Assert-ChildPath([string]$Path, [string]$Parent, [string]$Description) {
    $resolvedPath = [IO.Path]::GetFullPath($Path)
    $resolvedParent = [IO.Path]::GetFullPath($Parent).TrimEnd('\') + '\'
    if (-not $resolvedPath.StartsWith($resolvedParent, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing $Description outside its verified parent: $resolvedPath"
    }
    return $resolvedPath
}

function Invoke-Git([string[]]$Arguments) {
    $output = & git -C $WireGuardAndroidSource @Arguments 2>&1
    if ($LASTEXITCODE -ne 0) {
        throw "Git verification failed: $($output -join [Environment]::NewLine)"
    }
    return ($output -join "`n").Trim()
}

if (Test-Path -LiteralPath $destination) {
    throw "Refusing to replace an existing reviewed source tree: $destination"
}

$head = Invoke-Git @('rev-parse', 'HEAD')
if ($head -ne $expectedCommit) {
    throw "WireGuard Android must be checked out at $expectedCommit; found $head."
}
if ((Invoke-Git @('status', '--porcelain=v1'))) {
    throw 'WireGuard Android source contains local changes; supply a clean upstream checkout.'
}
$origin = Invoke-Git @('remote', 'get-url', 'origin')
if ($origin -notmatch 'git\.zx2c4\.com[/:]wireguard-android(?:\.git)?$') {
    throw "Unexpected WireGuard Android origin: $origin"
}
$tagObject = Invoke-Git @('rev-parse', $expectedTag)
if ($tagObject -ne $expectedAnnotatedTagObject) {
    throw "Unexpected annotated tag object for ${expectedTag}: $tagObject"
}
$tagCommit = Invoke-Git @('rev-parse', "$expectedTag^{commit}")
if ($tagCommit -ne $expectedCommit) {
    throw "Tag $expectedTag does not resolve to the pinned commit."
}

# The source tag includes two required nested repositories. Verify their
# checked-out commits, not merely empty submodule directories left by a plain
# clone. libwg-go is tracked directly by the parent source tree.
$submodules = [ordered]@{
    'tunnel/tools/wireguard-tools' = 'e2ecaaa739144997ccff89d6ad6ec81698ea6ced'
    'tunnel/tools/elf-cleaner' = '7efc05090675ec6161b7def862728086a26c3b1f'
}
foreach ($relative in $submodules.Keys) {
    $candidate = Join-Path $WireGuardAndroidSource $relative
    if (-not (Test-Path -LiteralPath (Join-Path $candidate '.git'))) {
        throw "Required WireGuard submodule is not initialised: $relative. Run git submodule update --init --recursive."
    }
    $submoduleHead = (& git -C $candidate rev-parse HEAD 2>&1 | Out-String).Trim()
    if ($LASTEXITCODE -ne 0 -or $submoduleHead -ne $submodules[$relative]) {
        throw "WireGuard submodule $relative is not pinned at $($submodules[$relative])."
    }
}
if (-not (Test-Path -LiteralPath (Join-Path $WireGuardAndroidSource 'tunnel/tools/libwg-go/Makefile') -PathType Leaf)) {
    throw 'Required WireGuard libwg-go source is absent.'
}

$stage = [IO.Path]::GetFullPath((Join-Path $env:TEMP ("fuzevpn-wireguard-stage-" + [guid]::NewGuid().ToString('N'))))
try {
    New-Item -ItemType Directory -Path $stage -Force | Out-Null
    # Pass the output path as the value of `-o`, rather than as a
    # `--output=...` expression.  With PowerShell and a Windows drive letter,
    # the latter can be parsed by Git as an archive tree-ish (C:\...) instead
    # of an option value.
    $archivePath = Join-Path $stage 'wireguard.zip'
    # Export the committed bytes whatever the workstation's core.autocrlf is.
    & git -C $WireGuardAndroidSource -c core.autocrlf=false -c core.eol=lf archive --format=zip -o $archivePath $expectedCommit
    if ($LASTEXITCODE -ne 0) { throw 'Unable to archive the pinned WireGuard source.' }
    Expand-Archive -LiteralPath (Join-Path $stage 'wireguard.zip') -DestinationPath $stage -Force

    # git archive preserves the project root only as files, so create the
    # target and move all checked-out files into it.
    $stagedSource = Join-Path $stage 'source'
    New-Item -ItemType Directory -Path $stagedSource -Force | Out-Null
    Get-ChildItem -LiteralPath $stage -Force | Where-Object {
        $_.Name -notin @('source', 'wireguard.zip')
    } | Move-Item -Destination $stagedSource

    # `git archive` excludes submodules. Copy the reviewed checked-out nested
    # sources, then apply the supplied reviewable patch in a staging tree.
    foreach ($relative in @('tunnel/tools/wireguard-tools', 'tunnel/tools/elf-cleaner')) {
        $from = Join-Path $WireGuardAndroidSource $relative
        $to = Join-Path $stagedSource $relative
        if (Test-Path -LiteralPath $to) {
            Remove-Item -LiteralPath (Assert-ChildPath $to $stagedSource 'a staged submodule') -Recurse -Force
        }
        New-Item -ItemType Directory -Path (Split-Path -Parent $to) -Force | Out-Null
        Copy-Item -LiteralPath $from -Destination $to -Recurse
    }
    & git -C $stagedSource init --quiet
    if ($LASTEXITCODE -ne 0) { throw 'Unable to initialise staged source tree.' }
    # Runtime patches carry byte-exact LF manifests. A workstation-wide
    # core.autocrlf=true must not rewrite their reviewed hashes during import.
    & git -C $stagedSource config core.autocrlf false
    if ($LASTEXITCODE -ne 0) { throw 'Unable to preserve reviewed patch line endings.' }
    & git -C $stagedSource config core.eol lf
    if ($LASTEXITCODE -ne 0) { throw 'Unable to select reviewed LF source line endings.' }
    $patches = @(
        [ordered]@{ path = $ForegroundServicePatch; purpose = 'Expose the shared Android VPN host, its foreground notification and lifecycle callbacks.' },
        [ordered]@{ path = $ProtectedStartPatch; purpose = 'Start wireguard-go without peers, protect its bound sockets, then install peer-only configuration.' },
        [ordered]@{ path = $NativeRuntimePatch; purpose = 'Update the pinned Go toolchain, reviewed CLOCK_BOOTTIME adaptation and upstream WireGuard handshake concurrency and IPv6 length fixes.' }
    )
    # The reviewed patches mix CRLF and LF preimages: apply them independently of
    # line endings (tools/wireguard_patch_series.ps1). Files they touch end in LF.
    Invoke-WireGuardPatchSeries -StagedSource $stagedSource -Patches @($patches | ForEach-Object { $_.path })
    foreach ($patch in $patches) {
        $patch.name = [IO.Path]::GetFileName((Resolve-Path -LiteralPath $patch.path))
        $patch.sha256 = (Get-FileHash -LiteralPath $patch.path -Algorithm SHA256).Hash.ToLowerInvariant()
    }
    Remove-Item -LiteralPath (Assert-ChildPath (Join-Path $stagedSource '.git') $stagedSource 'staged Git metadata') -Recurse -Force

    $patchDirectory = Join-Path $stagedSource 'patches\fuzevpn'
    New-Item -ItemType Directory -Path $patchDirectory -Force | Out-Null
    foreach ($patch in $patches) { Copy-Item -LiteralPath $patch.path -Destination (Join-Path $patchDirectory $patch.name) }
    [IO.File]::WriteAllText((Join-Path $patchDirectory 'series'), (($patches.name -join "`n") + "`n"), [Text.UTF8Encoding]::new($false))
    $metadata = [ordered]@{
        schema = 'https://fuzevpn.com/schemas/wireguard-android-import-v1.json'
        source = [ordered]@{
            url = 'https://git.zx2c4.com/wireguard-android'
            tag = $expectedTag
            annotatedTagObject = $expectedAnnotatedTagObject
            commit = $expectedCommit
            license = 'Apache-2.0'
        }
        patch = [ordered]@{
            path = "patches/fuzevpn/$($patches[0].name)"
            sha256 = $patches[0].sha256
            purpose = $patches[0].purpose
        }
        protectedStartPatch = [ordered]@{
            path = "patches/fuzevpn/$($patches[1].name)"
            sha256 = $patches[1].sha256
            purpose = $patches[1].purpose
        }
        nativeRuntimePatch = [ordered]@{
            path = "patches/fuzevpn/$($patches[2].name)"
            sha256 = $patches[2].sha256
            purpose = $patches[2].purpose
        }
        nativeRuntime = [ordered]@{
            goVersion = '1.26.9'
            wireguardModule = 'v0.0.0-20261024220952-b3bc704ef0ee'
            wireguardCommit = 'b3bc704ef0ee21a36298601a9e1e5ff90377ac52'
            reviewedAt = '2026-10-29'
            reviewedChanges = @('device: noise: reject response consumption after intermediate initiation', 'tun: clear virtioNetHdr when deleting item from tcpGROTable', "device: don't overflow uint16 when adding v4 header length")
            runtimePatch = 'tunnel/tools/libwg-go/goruntime-go1.26.9-boottime.diff'
            runtimePatchSha256 = 'd0b1fc4c89ea06186c5a3926efd12ea0a570fd65e111e699fb1b55de5e483d4a'
            runtimePatchManifest = 'tunnel/tools/libwg-go/goruntime-go1.26.9-boottime.json'
            runtimePatchManifestSha256 = '9580d03064a6c0247bd543ae6311991b330dd94ff6352e2fd0e09761ab9d0127'
            purpose = 'Use a maintained Go release and the upstream handshake concurrency and IPv6 length corrections while preserving the reviewed CLOCK_BOOTTIME semantics, extended to time.now on linux/amd64, and protected-start JNI.'
        }
    } | ConvertTo-Json -Depth 5
    [IO.File]::WriteAllText((Join-Path $stagedSource 'FUZEVPN-IMPORT-METADATA.json'), "$metadata`n", [Text.UTF8Encoding]::new($false))
    New-Item -ItemType Directory -Path (Split-Path -Parent $destination) -Force | Out-Null
    Move-Item -LiteralPath (Assert-ChildPath $stagedSource $stage 'the staged source tree') -Destination $destination
} finally {
    if (Test-Path -LiteralPath $stage) {
        $tempRoot = [IO.Path]::GetFullPath($env:TEMP).TrimEnd('\') + '\'
        if (-not $stage.StartsWith($tempRoot, [StringComparison]::OrdinalIgnoreCase) -or
            -not ([IO.Path]::GetFileName($stage)).StartsWith('fuzevpn-wireguard-stage-')) {
            throw "Refusing to remove an unverified staging directory: $stage"
        }
        Remove-Item -LiteralPath $stage -Recurse -Force
    }
}

Write-Host "Staged pinned WireGuard source at $destination. Run build_wireguard_native.ps1, then build_wireguard_patched_aar.ps1 and verify the approved digest before enabling -Pfuzevpn.usePatchedWireGuardAar=true."
