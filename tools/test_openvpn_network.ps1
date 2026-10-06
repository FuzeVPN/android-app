param([Parameter(Mandatory)][string]$NdkPath, [string]$OutputDirectory)
$ErrorActionPreference = 'Stop'
$networkRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
if (-not $OutputDirectory) { $OutputDirectory = Join-Path $networkRoot 'build/openvpn-network-tests' }
New-Item -ItemType Directory -Force -Path $OutputDirectory | Out-Null
$networkSource = Join-Path $networkRoot 'android/app/src/test/cpp/openvpn_network_test.cpp'
$networkCompilers = Join-Path $NdkPath 'toolchains/llvm/prebuilt/windows-x86_64/bin'
$networkTargets = @{'arm64-v8a' = 'aarch64-linux-android26'; 'armeabi-v7a' = 'armv7a-linux-androideabi26'; 'x86_64' = 'x86_64-linux-android26'}
foreach ($networkAbi in $networkTargets.Keys | Sort-Object) {
    $networkCompiler = Join-Path $networkCompilers ($networkTargets[$networkAbi] + '-clang++.cmd')
    & $networkCompiler -std=c++20 -Wall -Wextra -Werror -UNDEBUG -c $networkSource -o (Join-Path $OutputDirectory ($networkAbi + '.o'))
    if ($LASTEXITCODE -ne 0) { throw "OpenVPN network assertions failed for $networkAbi" }
    Write-Output "$networkAbi : 42 network/profile policy cases evaluated at compile time; PASS"
}
