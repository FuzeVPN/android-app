# SPDX-License-Identifier: Apache-2.0
<#
Builds libwg-go.so for Android directly from Windows with the reviewed
WireGuard source tree. This does not package an AAR.

It intentionally uses the upstream Go 1.24.3 Windows toolchain, patched with
WireGuard's goruntime-boottime-over-monotonic.diff, rather than the workstation
Go installation. Every output and its verification record is placed below
build/wireguard-native.
#>
[CmdletBinding()]
param(
    [string]$AndroidSdk = $(if ($env:ANDROID_SDK_ROOT) { $env:ANDROID_SDK_ROOT } else { $env:ANDROID_HOME }),
    [string]$GoToolchain = (Join-Path (Split-Path -Parent $PSScriptRoot) 'build\toolchains\go1.24.3-wireguard'),
    [string[]]$Abi = @('arm64-v8a', 'armeabi-v7a', 'x86_64', 'x86')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
if (-not $AndroidSdk) { throw 'Set ANDROID_SDK_ROOT or pass -AndroidSdk.' }

$goVersion = '1.24.3'
$goArchive = "go${goVersion}.windows-amd64.zip"
$goArchiveSha256 = 'be9787cb08998b1860fe3513e48a5fe5b96302d358a321b58e651184fa9638b3'
$goDownload = "https://dl.google.com/go/$goArchive"
$ndkVersion = '28.2.13676358'
$apiLevel = 21
$expectedWireGuardModule = 'golang.zx2c4.com/wireguard v0.0.0-20250521234502-f333402bd9cb'

$root = Split-Path -Parent $PSScriptRoot
$source = Join-Path $root 'android\third_party\wireguard-android\tunnel\tools\libwg-go'
$output = Join-Path $root 'build\wireguard-native'
$ndk = Join-Path $AndroidSdk "ndk\$ndkVersion"
$llvmBin = Join-Path $ndk 'toolchains\llvm\prebuilt\windows-x86_64\bin'
$readelf = Join-Path $llvmBin 'llvm-readelf.exe'
$nm = Join-Path $llvmBin 'llvm-nm.exe'
$patch = Join-Path $source 'goruntime-boottime-over-monotonic.diff'
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
    $marker = Join-Path $GoToolchain '.fuzevpn-wireguard-boottime-patch'
    $patchHash = (Get-FileHash -LiteralPath $patch -Algorithm SHA256).Hash.ToLowerInvariant()
    if (Test-Path -LiteralPath $marker -PathType Leaf) {
        if ((Get-Content -LiteralPath $marker -Raw).Trim() -eq $patchHash) { return }
        throw 'The existing Go runtime patch marker does not match the reviewed WireGuard patch.'
    }
    # This patch was authored against Go 1.20. Go 1.24.3 retains each targeted
    # instruction, but surrounding runtime assembly changed, so git apply cannot
    # match its hunks. Apply the same reviewed substitutions and reject every
    # unexpected source shape rather than weakening the pinned compiler check.
    $changes = @(
        @('src/runtime/sys_linux_386.s', 'MOVL\t$1, 0(SP)\t// CLOCK_MONOTONIC', 'MOVL\t$7, 0(SP)\t// CLOCK_BOOTTIME'),
        @('src/runtime/sys_linux_386.s', 'MOVL\t$1, BX\t\t// CLOCK_MONOTONIC', 'MOVL\t$7, BX\t\t// CLOCK_BOOTTIME'),
        @('src/runtime/sys_linux_amd64.s', 'MOVL\t$1, DI // CLOCK_MONOTONIC', 'MOVL\t$7, DI // CLOCK_BOOTTIME'),
        @('src/runtime/sys_linux_arm.s', '#define CLOCK_MONOTONIC\t1', '#define CLOCK_BOOTTIME\t7'),
        @('src/runtime/sys_linux_arm.s', 'MOVW\t$CLOCK_MONOTONIC, R0', 'MOVW\t$CLOCK_BOOTTIME, R0'),
        @('src/runtime/sys_linux_arm64.s', '#define CLOCK_MONOTONIC 1', '#define CLOCK_BOOTTIME 7'),
        @('src/runtime/sys_linux_arm64.s', 'MOVW\t$CLOCK_MONOTONIC, R0', 'MOVW\t$CLOCK_BOOTTIME, R0'),
        @('src/runtime/sys_linux_mips64x.s', 'MOVW\t$1, R4 // CLOCK_MONOTONIC', 'MOVW\t$7, R4 // CLOCK_BOOTTIME', 2),
        @('src/runtime/sys_linux_mipsx.s', 'MOVW\t$1, R4\t// CLOCK_MONOTONIC', 'MOVW\t$7, R4\t// CLOCK_BOOTTIME'),
        @('src/runtime/sys_linux_ppc64x.s', 'MOVD\t$1, R3\t\t// CLOCK_MONOTONIC', 'MOVD\t$7, R3\t\t// CLOCK_BOOTTIME'),
        @('src/runtime/sys_linux_s390x.s', 'MOVW\t$1, R2\t\t\t// CLOCK_MONOTONIC', 'MOVW\t$7, R2\t\t\t// CLOCK_BOOTTIME')
    )
    foreach ($change in $changes) {
        $path = Join-Path $GoToolchain $change[0]
        $before = $change[1].Replace('\t', "`t")
        $after = $change[2].Replace('\t', "`t")
        $content = Get-Content -LiteralPath $path -Raw -Encoding UTF8
        $occurrences = ([regex]::Matches($content, [regex]::Escape($before))).Count
        $expectedOccurrences = if ($change.Count -gt 3) { [int]$change[3] } else { 1 }
        if ($occurrences -ne $expectedOccurrences) { throw "The reviewed Go runtime patch has an incompatible target: $($change[0])" }
        [IO.File]::WriteAllText($path, $content.Replace($before, $after), [Text.UTF8Encoding]::new($false))
    }
    [IO.File]::WriteAllText($marker, ($patchHash + "`n"), [Text.UTF8Encoding]::new($false))
}

$abiSpec = @{
    'arm64-v8a' = @{ GoArch = 'arm64'; Triple = "aarch64-linux-android$apiLevel"; Machine = 'AArch64' }
    'armeabi-v7a' = @{ GoArch = 'arm'; Triple = "armv7a-linux-androideabi$apiLevel"; Machine = 'ARM' }
    'x86_64' = @{ GoArch = 'amd64'; Triple = "x86_64-linux-android$apiLevel"; Machine = 'Advanced Micro Devices X86-64' }
    'x86' = @{ GoArch = '386'; Triple = "i686-linux-android$apiLevel"; Machine = 'Intel 80386' }
}

Require-Directory $source 'WireGuard libwg-go source'
foreach ($required in @($patch, (Join-Path $source 'api-android.go'), (Join-Path $source 'jni.c'),
    (Join-Path $source 'go.mod'), (Join-Path $source 'go.sum'), $readelf, $nm)) { Require-File $required 'Build input' }
if ((Get-Content -LiteralPath (Join-Path $source 'go.mod') -Raw) -notmatch [regex]::Escape($expectedWireGuardModule)) {
    throw "go.mod does not retain the reviewed WireGuard module: $expectedWireGuardModule"
}
foreach ($item in $Abi) { if (-not $abiSpec.ContainsKey($item)) { throw "Unsupported ABI: $item" } }

Ensure-PinnedGo
Apply-RuntimePatch
Require-File $goExe 'Pinned Go compiler'

New-Item -ItemType Directory -Force -Path $output, (Join-Path $output 'logs') | Out-Null
$sourceHashes = [ordered]@{}
foreach ($input in @('api-android.go', 'jni.c', 'go.mod', 'go.sum', 'goruntime-boottime-over-monotonic.diff')) {
    $sourceHashes[$input] = (Get-FileHash -LiteralPath (Join-Path $source $input) -Algorithm SHA256).Hash.ToLowerInvariant()
}
$metadata = [ordered]@{
    schema = 'https://fuzevpn.com/schemas/wireguard-native-build-v1.json'
    builtAtUtc = [DateTime]::UtcNow.ToString('o')
    go = (& $goExe version).Trim()
    goArchive = @{ url = $goDownload; sha256 = $goArchiveSha256 }
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
            Invoke-Logged $log { & $goExe build -tags linux '-ldflags=-X golang.zx2c4.com/wireguard/ipc.socketDirectory=/data/data/com.fuzevpn/cache/wireguard -buildid=' -trimpath -buildvcs=false -buildmode=c-shared -o $library } "Go native build failed for $name"
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
[IO.File]::WriteAllText($metadataPath, (($metadata | ConvertTo-Json -Depth 5) + "`n"), [Text.UTF8Encoding]::new($false))
Write-Host "Built and verified WireGuard native libraries in $output"
