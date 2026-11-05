# SPDX-License-Identifier: Apache-2.0
<#
Builds libwg-go.so for Android directly from Windows with the reviewed
WireGuard source tree. This does not package an AAR.

It intentionally uses the upstream Go 1.26.9 Windows toolchain, patched with
the reviewed Go 1.26.9 adaptation of WireGuard's CLOCK_BOOTTIME patch, rather than the workstation
Go installation. Every output and its verification record is placed below
build/wireguard-native.
#>
[CmdletBinding()]
param(
    [string]$AndroidSdk = $(if ($env:ANDROID_SDK_ROOT) { $env:ANDROID_SDK_ROOT } else { $env:ANDROID_HOME }),
    [string]$GoToolchain = (Join-Path (Split-Path -Parent $PSScriptRoot) 'build\toolchains\go1.26.9-wireguard'),
    [string[]]$Abi = @('arm64-v8a', 'armeabi-v7a', 'x86_64', 'x86'),
    [switch]$PrepareOnly
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
if (-not $AndroidSdk) { throw 'Set ANDROID_SDK_ROOT or pass -AndroidSdk.' }

$goVersion = '1.26.9'
$goArchive = "go${goVersion}.windows-amd64.zip"
$goArchiveSha256 = 'd722201a9c0c086d1610e111c48203009af690892ed708072bd5ae20160e7a59'
$goSourceArchiveSha256 = '9735d7dcdb65b35d3fa577f04064737c03b89cf1a2b71e6e69fe2f3c6f9fd4ca'
$runtimePatchManifestSha256 = '9580d03064a6c0247bd543ae6311991b330dd94ff6352e2fd0e09761ab9d0127'
$goDownload = "https://dl.google.com/go/$goArchive"
$ndkVersion = '28.2.13676358'
$apiLevel = 21
$expectedWireGuardModule = 'golang.zx2c4.com/wireguard v0.0.0-20261024220952-b3bc704ef0ee'

$root = Split-Path -Parent $PSScriptRoot
$source = Join-Path $root 'android\third_party\wireguard-android\tunnel\tools\libwg-go'
$output = Join-Path $root 'build\wireguard-native'
$ndk = Join-Path $AndroidSdk "ndk\$ndkVersion"
$llvmBin = Join-Path $ndk 'toolchains\llvm\prebuilt\windows-x86_64\bin'
$readelf = Join-Path $llvmBin 'llvm-readelf.exe'
$nm = Join-Path $llvmBin 'llvm-nm.exe'
$patch = Join-Path $source 'goruntime-go1.26.9-boottime.diff'
$patchManifest = Join-Path $source 'goruntime-go1.26.9-boottime.json'
$goExe = Join-Path $GoToolchain 'bin\go.exe'

function Require-File([string]$Path, [string]$Name) {
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { throw "$Name is missing: $Path" }
}

function Require-Directory([string]$Path, [string]$Name) {
    if (-not (Test-Path -LiteralPath $Path -PathType Container)) { throw "$Name is missing: $Path" }
}

function Assert-ChildPath([string]$Path, [string]$Parent, [string]$Name) {
    $resolvedPath = [IO.Path]::GetFullPath($Path)
    $resolvedParent = [IO.Path]::GetFullPath($Parent).TrimEnd('\', '/') + [IO.Path]::DirectorySeparatorChar
    if (-not $resolvedPath.StartsWith($resolvedParent, [StringComparison]::OrdinalIgnoreCase)) {
        throw "$Name is outside its required parent: $resolvedPath"
    }
    return $resolvedPath
}

function Invoke-Logged([string]$Log, [scriptblock]$Command, [string]$Failure) {
    $priorErrorActionPreference = $ErrorActionPreference
    $exitCode = 0
    try {
        # Go legitimately writes module-download progress to stderr. Keep it in
        # the ABI log and decide from its process exit code after the pipeline.
        $ErrorActionPreference = 'Continue'
        & $Command 2>&1 | Tee-Object -FilePath $Log -Append
        $exitCode = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $priorErrorActionPreference
    }
    if ($exitCode -ne 0) { throw "$Failure (exit $exitCode). See $Log" }
}

function Ensure-PinnedGo {
    if (Test-Path -LiteralPath $goExe -PathType Leaf) {
        $installed = (& $goExe version).Trim()
        if ($installed -eq "go version go${goVersion} windows/amd64") { return }
        throw "Portable Go exists but is not the required version: $installed"
    }

    $downloadDirectory = Join-Path (Split-Path -Parent $GoToolchain) 'downloads'
    $archivePath = Join-Path $downloadDirectory $goArchive
    $toolchainParent = [IO.Path]::GetFullPath((Split-Path -Parent $GoToolchain))
    $toolchainPath = Assert-ChildPath $GoToolchain $toolchainParent 'Portable Go destination'
    New-Item -ItemType Directory -Force -Path $downloadDirectory | Out-Null
    $archiveValid = (Test-Path -LiteralPath $archivePath -PathType Leaf) -and
        ((Get-FileHash -LiteralPath $archivePath -Algorithm SHA256).Hash.ToLowerInvariant() -eq $goArchiveSha256)
    if (-not $archiveValid) {
        if (Test-Path -LiteralPath $archivePath -PathType Leaf) { Remove-Item -LiteralPath $archivePath -Force }
        Write-Host "Downloading upstream Go $goVersion for Windows..."
        Invoke-WebRequest -UseBasicParsing -Uri $goDownload -OutFile $archivePath
    }
    $archiveHash = (Get-FileHash -LiteralPath $archivePath -Algorithm SHA256).Hash.ToLowerInvariant()
    if ($archiveHash -ne $goArchiveSha256) { throw "Go archive hash mismatch: $archiveHash" }

    $temporary = Assert-ChildPath (Join-Path $toolchainParent ('.go-extract-' + [guid]::NewGuid().ToString('N'))) $toolchainParent 'Portable Go extraction directory'
    New-Item -ItemType Directory -Force -Path $temporary | Out-Null
    try {
        Expand-Archive -LiteralPath $archivePath -DestinationPath $temporary -Force
        $extracted = Assert-ChildPath (Join-Path $temporary 'go') $temporary 'Portable Go extracted directory'
        Require-File (Join-Path $extracted 'bin\go.exe') 'Downloaded Go compiler'
        if (Test-Path -LiteralPath $toolchainPath) { throw "Portable Go destination unexpectedly exists: $toolchainPath" }
        Move-Item -LiteralPath $extracted -Destination $toolchainPath
    } finally {
        if (Test-Path -LiteralPath $temporary) {
            Assert-ChildPath $temporary $toolchainParent 'Portable Go extraction cleanup' | Out-Null
            Remove-Item -LiteralPath $temporary -Recurse -Force
        }
    }
}

function Apply-RuntimePatch {
    # Never trust a marker alone: recheck every original/patched runtime file,
    # including warm builds, before modifying or compiling any source.
    $actualManifestHash = (Get-FileHash -LiteralPath $patchManifest -Algorithm SHA256).Hash.ToLowerInvariant()
    if ($actualManifestHash -ne $runtimePatchManifestSha256) { throw 'The reviewed Go runtime patch manifest changed.' }
    $review = Get-Content -LiteralPath $patchManifest -Raw | ConvertFrom-Json
    $patchHash = (Get-FileHash -LiteralPath $patch -Algorithm SHA256).Hash.ToLowerInvariant()
    if ($review.schema -ne 1 -or $review.go_version -ne $goVersion -or
        $review.source_archive_sha256 -ne $goSourceArchiveSha256 -or
        $review.patch_sha256 -ne $patchHash -or @($review.files).Count -ne 9) {
        throw 'The Go runtime adaptation does not match the pinned release and patch.'
    }
    $updates = [Collections.Generic.List[object]]::new()
    foreach ($file in $review.files) {
        # linux/amd64 implements time.now in time_linux_amd64.s; the other
        # Android ABIs derive its monotonic part from the patched nanotime1.
        if ($file.path -notmatch '^src/runtime/(sys_linux_(386|amd64|arm|arm64|mips64x|mipsx|ppc64x|s390x)|time_linux_amd64)\.s$') {
            throw 'Unexpected runtime patch target.'
        }
        $target = Assert-ChildPath (Join-Path $GoToolchain $file.path) $GoToolchain 'Go runtime patch target'
        Require-File $target 'Go runtime source'
        $currentHash = (Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash.ToLowerInvariant()
        if ($currentHash -eq $file.patched_sha256) { continue }
        if ($currentHash -ne $file.original_sha256) { throw "Go runtime source differs from its reviewed original/patched hash: $($file.path)" }
        $content = [IO.File]::ReadAllText($target, [Text.Encoding]::UTF8)
        foreach ($change in $file.substitutions) {
            $count = [regex]::Matches($content, [regex]::Escape($change.before)).Count
            if ($count -ne $change.count) { throw "The reviewed Go runtime patch has an incompatible target: $($file.path)" }
            $content = $content.Replace($change.before, $change.after)
        }
        $bytes = [Text.UTF8Encoding]::new($false).GetBytes($content)
        $hash = [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($bytes)).ToLowerInvariant()
        if ($hash -ne $file.patched_sha256) { throw "Go runtime adaptation differs from reviewed output: $($file.path)" }
        $updates.Add([pscustomobject]@{ path = $target; bytes = $bytes; sha256 = $hash })
    }
    # All files have passed preflight; malformed sources cannot produce a
    # partially reviewed compiler merely by retaining an earlier marker.
    foreach ($update in $updates) {
        [IO.File]::WriteAllBytes($update.path, $update.bytes)
        if ((Get-FileHash -LiteralPath $update.path -Algorithm SHA256).Hash.ToLowerInvariant() -ne $update.sha256) {
            throw 'Go runtime patch write verification failed.'
        }
    }
    $marker = Join-Path $GoToolchain '.fuzevpn-wireguard-boottime-patch'
    [IO.File]::WriteAllText($marker, "$goVersion|$patchHash|$runtimePatchManifestSha256`n", [Text.UTF8Encoding]::new($false))
}

$abiSpec = @{
    'arm64-v8a' = @{ GoArch = 'arm64'; Triple = "aarch64-linux-android$apiLevel"; Machine = 'AArch64' }
    'armeabi-v7a' = @{ GoArch = 'arm'; Triple = "armv7a-linux-androideabi$apiLevel"; Machine = 'ARM' }
    'x86_64' = @{ GoArch = 'amd64'; Triple = "x86_64-linux-android$apiLevel"; Machine = 'Advanced Micro Devices X86-64' }
    'x86' = @{ GoArch = '386'; Triple = "i686-linux-android$apiLevel"; Machine = 'Intel 80386' }
}

Require-Directory $source 'WireGuard libwg-go source'
foreach ($required in @($patch, $patchManifest, (Join-Path $source 'api-android.go'), (Join-Path $source 'jni.c'),
    (Join-Path $source 'go.mod'), (Join-Path $source 'go.sum'), $readelf, $nm)) { Require-File $required 'Build input' }
if ((Get-Content -LiteralPath (Join-Path $source 'go.mod') -Raw) -notmatch [regex]::Escape($expectedWireGuardModule)) {
    throw "go.mod does not retain the reviewed WireGuard module: $expectedWireGuardModule"
}
foreach ($item in $Abi) { if (-not $abiSpec.ContainsKey($item)) { throw "Unsupported ABI: $item" } }

Ensure-PinnedGo
Apply-RuntimePatch
Require-File $goExe 'Pinned Go compiler'
if ($PrepareOnly) { Write-Output 'Verified pinned Go compiler and CLOCK_BOOTTIME runtime sources'; return }

New-Item -ItemType Directory -Force -Path $output, (Join-Path $output 'logs') | Out-Null
$sourceHashes = [ordered]@{}
foreach ($inputName in @('api-android.go', 'jni.c', 'go.mod', 'go.sum', 'goruntime-boottime-over-monotonic.diff', 'goruntime-go1.26.9-boottime.diff', 'goruntime-go1.26.9-boottime.json')) {
    $sourceHashes[$inputName] = (Get-FileHash -LiteralPath (Join-Path $source $inputName) -Algorithm SHA256).Hash.ToLowerInvariant()
}
$metadata = [ordered]@{
    schema = 'https://fuzevpn.com/schemas/wireguard-native-build-v1.json'
    builtAtUtc = [DateTime]::UtcNow.ToString('o')
    go = (& $goExe version).Trim()
    goArchive = @{ url = $goDownload; sha256 = $goArchiveSha256 }
    goSourceArchive = @{ url = "https://dl.google.com/go/go${goVersion}.src.tar.gz"; sha256 = $goSourceArchiveSha256 }
    runtimePatchManifestSha256 = $runtimePatchManifestSha256
    runtimePatchSha256 = (Get-FileHash -LiteralPath $patch -Algorithm SHA256).Hash.ToLowerInvariant()
    ndk = @{ version = $ndkVersion; path = $ndk }
    api = $apiLevel
    module = $expectedWireGuardModule
    sourceHashes = $sourceHashes
    abi = @()
}

foreach ($name in $Abi) {
    $spec = $abiSpec[$name]
    $compiler = Join-Path $llvmBin ("$($spec.Triple)-clang.cmd")
    Require-File $compiler "NDK compiler for $name"
    $abiOutput = Join-Path $output $name
    New-Item -ItemType Directory -Force -Path $abiOutput | Out-Null
    $library = Join-Path $abiOutput 'libwg-go.so'
    $log = Join-Path $output "logs\$name.log"
    Remove-Item -LiteralPath $log -Force -ErrorAction SilentlyContinue

    $buildEnv = @{
        GOROOT = $GoToolchain; GOENV = 'off'; GOFLAGS = ''; GOTOOLCHAIN = 'local'
        GOOS = 'android'; GOARCH = $spec.GoArch; CGO_ENABLED = '1'; CC = $compiler
        CGO_CFLAGS = "--target=$($spec.Triple) --sysroot=$($ndk.Replace('\','/'))/toolchains/llvm/prebuilt/windows-x86_64/sysroot"
        CGO_LDFLAGS = "--target=$($spec.Triple) --sysroot=$($ndk.Replace('\','/'))/toolchains/llvm/prebuilt/windows-x86_64/sysroot -Wl,-soname,libwg-go.so -Wl,-z,max-page-size=16384 -Wl,--build-id=none"
    }
    if ($name -eq 'armeabi-v7a') { $buildEnv.GOARM = '7' }
    Push-Location $source
    try {
        $previous = @{}
        foreach ($key in $buildEnv.Keys) { $previous[$key] = [Environment]::GetEnvironmentVariable($key); Set-Item "Env:$key" $buildEnv[$key] }
        try {
            # This is the installed application ID, independently of the Kotlin/JNI namespace.
            Invoke-Logged $log { & $goExe build -mod=readonly -tags linux '-ldflags=-X golang.zx2c4.com/wireguard/ipc.socketDirectory=/data/data/com.fuzevpn/cache/wireguard -buildid=' -trimpath -buildvcs=false -buildmode=c-shared -o $library } "Go native build failed for $name"
        } finally {
            foreach ($key in $buildEnv.Keys) { if ($null -eq $previous[$key]) { Remove-Item "Env:$key" -ErrorAction SilentlyContinue } else { Set-Item "Env:$key" $previous[$key] } }
        }
    } finally { Pop-Location }

    $headers = [string]::Join("`n", @(& $readelf -hW $library 2>&1))
    $programHeaders = [string]::Join("`n", @(& $readelf -lW $library 2>&1))
    $exports = [string]::Join("`n", @(& $nm -D --defined-only $library 2>&1))
    Add-Content -LiteralPath $log -Value "`n--- llvm-readelf -hW ---`n$headers`n--- llvm-readelf -lW ---`n$programHeaders`n--- llvm-nm -D ---`n$exports"
    if ($LASTEXITCODE -ne 0 -or $headers -notmatch [regex]::Escape($spec.Machine)) { throw "ELF machine verification failed for $name. See $log" }
    $loadLines = @($programHeaders -split "`r?`n" | Where-Object { $_.TrimStart().StartsWith('LOAD') })
    if ($loadLines.Count -eq 0) { throw "ELF has no load segments for $name. See $log" }
    foreach ($load in $loadLines) {
        $alignment = [regex]::Match($load, '(0x[0-9a-fA-F]+)\s*$')
        if (-not $alignment.Success -or [Convert]::ToUInt64($alignment.Groups[1].Value.Substring(2), 16) -lt 0x4000) {
            throw "A load segment lacks 16 KB alignment for $name. See $log"
        }
    }
    foreach ($symbol in @('wgTurnOn', 'wgTurnOff', 'wgGetSocketV4', 'wgGetSocketV6', 'wgSetConfig',
        'Java_com_wireguard_android_backend_GoBackend_wgSetConfig')) {
        if ($exports -notmatch "\b$symbol$" -and $exports -notmatch "\b$symbol\b") { throw "JNI export $symbol is missing from $name. See $log" }
    }
    $metadata.abi += [ordered]@{ name = $name; file = "$name/libwg-go.so"; sha256 = (Get-FileHash -LiteralPath $library -Algorithm SHA256).Hash.ToLowerInvariant(); log = "logs/$name.log" }
}

$metadataPath = Join-Path $output 'metadata.json'
$metadataJson = ($metadata | ConvertTo-Json -Depth 5).Replace("`r`n", "`n")
[IO.File]::WriteAllText($metadataPath, ($metadataJson + "`n"), [Text.UTF8Encoding]::new($false))
Write-Host "Built and verified WireGuard native libraries in $output"
