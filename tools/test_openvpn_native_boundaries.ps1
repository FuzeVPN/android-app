param(
    [Parameter(Mandatory)][string]$NdkPath,
    [string]$VcVarsPath,
    [string]$OutputDirectory
)
$ErrorActionPreference = 'Stop'
$boundaryRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$boundaryNdk = [IO.Path]::GetFullPath($NdkPath)
if (-not $OutputDirectory) { $OutputDirectory = Join-Path $boundaryRoot 'build/native-boundary-tests' }
$boundaryOutput = [IO.Path]::GetFullPath($OutputDirectory)
New-Item -ItemType Directory -Force -Path $boundaryOutput | Out-Null
if (-not $VcVarsPath) {
    $boundaryVsWhere = Join-Path ${env:ProgramFiles(x86)} 'Microsoft Visual Studio/Installer/vswhere.exe'
    if (Test-Path -LiteralPath $boundaryVsWhere) {
        $VcVarsPath = & $boundaryVsWhere -latest -products '*' -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -find 'VC/Auxiliary/Build/vcvars64.bat' | Select-Object -First 1
    }
}
if (-not $VcVarsPath -or -not (Test-Path -LiteralPath $VcVarsPath)) {
    throw 'Windows host tests require Visual Studio C++ Build Tools; supply -VcVarsPath.'
}
$boundaryVcVars = [IO.Path]::GetFullPath($VcVarsPath)
foreach ($boundaryPath in @($boundaryRoot, $boundaryNdk, $boundaryOutput, $boundaryVcVars)) {
    if ($boundaryPath.Contains('"') -or $boundaryPath.Contains("`r") -or $boundaryPath.Contains("`n") -or $boundaryPath.Contains('%')) {
        throw 'Test toolchain/output paths must not contain shell metacharacters.'
    }
}
# Copy this one interface header only. Putting Android's entire sysroot on a
# Windows host include path would replace the host C runtime headers.
$boundaryJniInclude = Join-Path $boundaryOutput 'jni-include'
New-Item -ItemType Directory -Force -Path $boundaryJniInclude | Out-Null
Copy-Item -LiteralPath (Join-Path $boundaryNdk 'toolchains/llvm/prebuilt/windows-x86_64/sysroot/usr/include/jni.h') -Destination (Join-Path $boundaryJniInclude 'jni.h')
$boundaryHost = Join-Path $boundaryRoot 'android/app/src/test/cpp/host'
$boundaryCore = Join-Path $boundaryRoot 'android/app/src/main/cpp/third_party/openvpn3-core'
$boundaryProfile = Join-Path $boundaryRoot 'android/app/src/main/cpp/openvpn_profile.cpp'
$boundaryAdapterTest = Join-Path $boundaryRoot 'android/app/src/test/cpp/openvpn_adapter_host_test.cpp'
$boundaryJniTest = Join-Path $boundaryRoot 'android/app/src/test/cpp/openvpn_jni_host_test.cpp'
# A12-openvpn-native-01: the original validator against the unmodified pinned
# Core OptionList parser (header-only; asio and fmt from the audited deps).
$boundaryProfileTest = Join-Path $boundaryRoot 'android/app/src/test/cpp/openvpn_profile_host_test.cpp'
$boundaryDeps = Join-Path $boundaryRoot 'android/app/src/main/cpp/third_party/deps/include'
$boundaryRunner = Join-Path $boundaryOutput 'run-host.cmd'
$boundaryCommands = @(
    '@echo off',
    "call `"$boundaryVcVars`" >nul",
    'if errorlevel 1 exit /b 1',
    "cl /nologo /std:c++20 /EHsc /W4 /WX /DWIN32_LEAN_AND_MEAN /I`"$boundaryHost`" /I`"$boundaryCore`" `"$boundaryAdapterTest`" `"$boundaryProfile`" /Fe:`"$boundaryOutput/adapter-host.exe`" /Fo:`"$boundaryOutput/`" /link ws2_32.lib",
    'if errorlevel 1 exit /b 1',
    "`"$boundaryOutput/adapter-host.exe`"",
    'if errorlevel 1 exit /b 1',
    "cl /nologo /std:c++20 /EHsc /W4 /WX /DWIN32_LEAN_AND_MEAN /I`"$boundaryHost`" /I`"$boundaryJniInclude`" `"$boundaryJniTest`" `"$boundaryProfile`" /Fe:`"$boundaryOutput/jni-host.exe`" /Fo:`"$boundaryOutput/`" /link ws2_32.lib",
    'if errorlevel 1 exit /b 1',
    "`"$boundaryOutput/jni-host.exe`"",
    'if errorlevel 1 exit /b 1',
    "cl /nologo /std:c++20 /EHsc /W4 /WX /utf-8 /DWIN32_LEAN_AND_MEAN /DNOMINMAX /D_WIN32_WINNT=0x0A00 /DUSE_ASIO /DASIO_STANDALONE /DFMT_HEADER_ONLY /D_CRT_SECURE_NO_WARNINGS /external:anglebrackets /external:W0 /I`"$boundaryHost`" /I`"$boundaryCore`" /I`"$boundaryDeps`" `"$boundaryProfileTest`" `"$boundaryProfile`" /Fe:`"$boundaryOutput/profile-host.exe`" /Fo:`"$boundaryOutput/`" /link ws2_32.lib",
    'if errorlevel 1 exit /b 1',
    "`"$boundaryOutput/profile-host.exe`"",
    'if errorlevel 1 exit /b 1'
)
[IO.File]::WriteAllLines($boundaryRunner, $boundaryCommands, [Text.Encoding]::ASCII)
& $boundaryRunner
if ($LASTEXITCODE -ne 0) { throw 'Native host boundary tests failed.' }

$boundaryBin = Join-Path $boundaryNdk 'toolchains/llvm/prebuilt/windows-x86_64/bin'
$boundaryTargets = @{
    'arm64-v8a' = 'aarch64-linux-android26'
    'armeabi-v7a' = 'armv7a-linux-androideabi26'
    'x86_64' = 'x86_64-linux-android26'
}
foreach ($boundaryAbi in $boundaryTargets.Keys | Sort-Object) {
    $boundaryCompiler = Join-Path $boundaryBin ($boundaryTargets[$boundaryAbi] + '-clang++.cmd')
    foreach ($boundarySource in @('openvpn_jni.cpp', 'openvpn_profile.cpp')) {
        & $boundaryCompiler -std=c++20 -Wall -Wextra -Werror -c (Join-Path $boundaryRoot ('android/app/src/main/cpp/' + $boundarySource)) -o (Join-Path $boundaryOutput ($boundaryAbi + '-' + $boundarySource + '.o'))
        if ($LASTEXITCODE -ne 0) { throw "Native boundary compilation failed for $boundaryAbi / $boundarySource" }
    }
    $boundaryFlags = @(
        '-std=c++20', '-fsyntax-only', '-Wall', '-Wextra', '-Wno-unused-parameter',
        '-DOPENVPN_CORE_API_VISIBILITY_HIDDEN', '-DOPENVPN_PLATFORM_ANDROID=',
        '-DASIO_STANDALONE', '-DUSE_ASIO', '-DHAVE_LZ4', '-DUSE_OPENSSL',
        '-DUSE_TUN_BUILDER=', '-DENABLE_EXTERNAL_PKI', '-DASIO_DISABLE_LOCAL_SOCKETS',
        ('-I' + $boundaryCore),
        ('-I' + (Join-Path $boundaryRoot 'android/app/src/main/cpp/third_party/deps/include')),
        ('-I' + (Join-Path $boundaryRoot ('android/app/src/main/cpp/third_party/openssl/include/' + $boundaryAbi)))
    )
    & $boundaryCompiler @boundaryFlags (Join-Path $boundaryRoot 'android/app/src/main/cpp/openvpn_core_adapter.cpp')
    if ($LASTEXITCODE -ne 0) { throw "Real pinned Core adapter compilation failed for $boundaryAbi" }
    Write-Output "$boundaryAbi : JNI/profile objects + adapter against actual pinned Core headers; PASS"
}
