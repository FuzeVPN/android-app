[CmdletBinding()]
param(
    [string]$JavaHome = $env:JAVA_HOME,
    [string]$AndroidSdk = $(if ($env:ANDROID_SDK_ROOT) { $env:ANDROID_SDK_ROOT } else { $env:ANDROID_HOME }),
    [string]$GradleUserHome = $(if ($env:GRADLE_USER_HOME) { $env:GRADLE_USER_HOME } else { Join-Path $env:USERPROFILE '.gradle' })
)
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
if (-not $JavaHome -or -not $AndroidSdk) { throw 'Set JAVA_HOME and ANDROID_SDK_ROOT, or pass -JavaHome and -AndroidSdk.' }
$java = Join-Path $JavaHome 'bin'
$sdk = $AndroidSdk
$source = Join-Path $root 'android\third_party\wireguard-android\tunnel'
$output = Join-Path $root 'build\wireguard-protected-start-tests'
New-Item -ItemType Directory -Force -Path $output | Out-Null
$cache = Join-Path $GradleUserHome 'caches\modules-2\files-2.1'
function Cached([string]$path, [string]$filter) {
    $found = @(Get-ChildItem -LiteralPath (Join-Path $cache $path) -Recurse -File -Filter $filter)
    if ($found.Count -ne 1) { throw "Expected one cached artifact: $path ($($found.Count))" }
    return $found[0].FullName
}
$aar = Cached 'com.wireguard.android\tunnel\1.0.20260102' '*.aar'
Push-Location $output
try {
    & (Join-Path $java 'jar.exe') xf $aar classes.jar
    if ($LASTEXITCODE -ne 0) { throw 'Cannot extract pinned WireGuard classes.' }
} finally { Pop-Location }
$junit = Cached 'junit\junit\4.13.2' '*.jar'
$hamcrest = Cached 'org.hamcrest\hamcrest-core\1.3' '*.jar'
$annotations = Cached 'androidx.annotation\annotation-jvm\1.9.1' '*.jar'
$collection = Cached 'androidx.collection\collection-jvm\1.5.0' '*.jar'
$classpath = @((Join-Path $sdk 'platforms\android-36\android.jar'), (Join-Path $output 'classes.jar'), $junit, $hamcrest, $annotations, $collection) -join ';'
& (Join-Path $java 'javac.exe') --release 17 -encoding UTF-8 -classpath $classpath -d $output `
    (Join-Path $source 'src\main\java\com\wireguard\android\backend\GoBackend.java') `
    (Join-Path $source 'src\test\java\com\wireguard\android\backend\GoBackendTwoPhaseConfigTest.java')
if ($LASTEXITCODE -ne 0) { throw 'Protected-start test compilation failed.' }
& (Join-Path $java 'java.exe') -classpath "$output;$classpath;$(Join-Path $source 'src\test\resources')" `
    org.junit.runner.JUnitCore com.wireguard.android.backend.GoBackendTwoPhaseConfigTest
if ($LASTEXITCODE -ne 0) { throw 'Protected-start tests failed.' }
