param(
    [Parameter(Mandatory)][string]$NdkPath,
    [string]$OutputDirectory
)
$ErrorActionPreference = 'Stop'
$recoveryRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
if (-not $OutputDirectory) { $OutputDirectory = Join-Path $recoveryRoot 'build/openvpn-state-tests' }
New-Item -ItemType Directory -Force -Path $OutputDirectory | Out-Null
$recoverySource = Join-Path $recoveryRoot 'android/app/src/test/cpp/openvpn_connection_state_test.cpp'
$recoveryCompilerDirectory = Join-Path $NdkPath 'toolchains/llvm/prebuilt/windows-x86_64/bin'
$recoveryTargets = @{
    'arm64-v8a' = 'aarch64-linux-android26'
    'armeabi-v7a' = 'armv7a-linux-androideabi26'
    'x86_64' = 'x86_64-linux-android26'
}
foreach ($recoveryAbi in $recoveryTargets.Keys | Sort-Object) {
    $recoveryCompiler = Join-Path $recoveryCompilerDirectory ($recoveryTargets[$recoveryAbi] + '-clang++.cmd')
    $recoveryObject = Join-Path $OutputDirectory ($recoveryAbi + '.o')
    # static_assert evaluates all 11 lifecycle cases using the production
    # C++20 state machine. A failed assertion makes compilation fail.
    & $recoveryCompiler -std=c++20 -Wall -Wextra -Werror -UNDEBUG -c $recoverySource -o $recoveryObject
    if ($LASTEXITCODE -ne 0) { throw "OpenVPN state assertions failed for $recoveryAbi" }
    Write-Output "$recoveryAbi : 11 lifecycle cases evaluated at compile time; PASS"
}
