#Requires -Version 5.1
# Runs under Windows PowerShell 5.1 and PowerShell 7.2+ (A06-turnstile-02).
[CmdletBinding()]
param(
    [string]$Repository,
    [string]$OutputDirectory,
    [string]$BridgeSource,
    [string]$JavaHome = $env:JAVA_HOME,
    [string]$Java,
    [string]$Node = $env:NODE_BINARY,
    [Alias('Cache')][string]$ModuleCache
)
$ErrorActionPreference = 'Stop'
$testStarted = [DateTimeOffset]::UtcNow
# Windows PowerShell 5.1 leaves $PSScriptRoot empty in parameter defaults.
if (-not $Repository) { $Repository = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path) }
$testRepository = [IO.Path]::GetFullPath($Repository)
$testHostRoot = Join-Path $testRepository 'android/app/src/testHost/turnstile'
$testSourceRoot = Join-Path $testRepository 'android/app/src/main/kotlin/com/fuzevpn/android'
if (-not $OutputDirectory) { $OutputDirectory = Join-Path $testRepository 'build/reports/turnstile-bridge-host-tests' }
if (-not $BridgeSource) { $BridgeSource = Join-Path $testSourceRoot 'NativeTurnstileBridge.kt' }
$testOutput = [IO.Path]::GetFullPath($OutputDirectory)
New-Item -ItemType Directory -Force -Path $testOutput | Out-Null
function Invoke-TestNative([string]$Executable, [string[]]$Arguments) {
    # Windows PowerShell 5.1 turns redirected native stderr (java -version,
    # compiler warnings) into terminating NativeCommandError records under
    # 'Stop'. Capture both streams as text; only the exit code decides.
    $previousPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    try {
        $testLines = @(& $Executable @Arguments 2>&1 | ForEach-Object { "$_" })
        $testCode = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $previousPreference
    }
    return [pscustomobject]@{ Output = $testLines; ExitCode = $testCode }
}
function Resolve-TestApplication([string]$Candidate, [string]$Name) {
    if ($Candidate -and (Test-Path -LiteralPath $Candidate -PathType Leaf)) {
        return [IO.Path]::GetFullPath($Candidate)
    }
    $testName = if ($Candidate) { $Candidate } else { $Name }
    $testCommand = Get-Command -Name $testName -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $testCommand) { throw "Required $Name executable not found; supply its explicit parameter or configure PATH." }
    return $testCommand.Source
}
if (-not $Java -and $JavaHome) {
    $testJavaName = if ($env:OS -eq 'Windows_NT') { 'java.exe' } else { 'java' }
    $Java = Join-Path $JavaHome ('bin/' + $testJavaName)
}
$Java = Resolve-TestApplication $Java 'java'
$Node = Resolve-TestApplication $Node 'node'
if (-not $ModuleCache) {
    $testGradleHome = $env:GRADLE_USER_HOME
    if (-not $testGradleHome) {
        $testUserProfile = [Environment]::GetFolderPath('UserProfile')
        if (-not $testUserProfile) { throw 'Gradle module cache not configured; supply -ModuleCache or GRADLE_USER_HOME.' }
        $testGradleHome = Join-Path $testUserProfile '.gradle'
    }
    $ModuleCache = Join-Path $testGradleHome 'caches/modules-2/files-2.1'
}
$ModuleCache = [IO.Path]::GetFullPath($ModuleCache)
if (-not (Test-Path -LiteralPath $ModuleCache -PathType Container)) {
    throw "Gradle module cache not found: $ModuleCache. Supply -ModuleCache or populate the pinned dependencies before running."
}
$testJavaVersionRun = Invoke-TestNative $Java @('-version')
if ($testJavaVersionRun.ExitCode -ne 0) { throw 'Java version query failed.' }
$testJavaVersion = $testJavaVersionRun.Output -join "`n"
if ($testJavaVersion -notmatch 'version\s+"(?<major>\d+)') { throw 'Cannot identify the Java runtime version.' }
if ([int]$Matches.major -lt 17) { throw 'Turnstile host tests require Java 17 or newer; supply -JavaHome or -Java.' }
$testNodeVersionRun = Invoke-TestNative $Node @('--version')
if ($testNodeVersionRun.ExitCode -ne 0) { throw 'Node.js version query failed.' }
$testNodeVersion = ($testNodeVersionRun.Output -join "`n").Trim()
function Find-TestJar([string]$Group, [string]$Name, [string]$Version) {
    $testJarDirectory = Join-Path $ModuleCache "$Group/$Name/$Version"
    if (-not (Test-Path -LiteralPath $testJarDirectory -PathType Container)) { throw "Missing pinned dependency in module cache: $Group/$Name/$Version" }
    $testCandidates = @(Get-ChildItem -LiteralPath $testJarDirectory -Recurse -File -Filter "$Name-$Version.jar")
    if ($testCandidates.Count -ne 1) { throw "Expected one cached dependency: $Group/$Name/$Version" }
    return $testCandidates[0].FullName
}
$testStdlib = Find-TestJar 'org.jetbrains.kotlin' 'kotlin-stdlib' '2.3.20'
$testCompiler = Find-TestJar 'org.jetbrains.kotlin' 'kotlin-compiler-embeddable' '2.3.20'
$testScript = Find-TestJar 'org.jetbrains.kotlin' 'kotlin-script-runtime' '2.3.20'
$testReflect = Find-TestJar 'org.jetbrains.kotlin' 'kotlin-reflect' '1.6.10'
$testDaemon = Find-TestJar 'org.jetbrains.kotlin' 'kotlin-daemon-embeddable' '2.3.20'
$testCompilerCoroutines = Find-TestJar 'org.jetbrains.kotlinx' 'kotlinx-coroutines-core-jvm' '1.8.0'
$testAnnotations = Find-TestJar 'org.jetbrains' 'annotations' '23.0.0'
$testJunit = Find-TestJar 'junit' 'junit' '4.13.2'
$testHamcrest = Find-TestJar 'org.hamcrest' 'hamcrest-core' '1.3'
$testJson = Find-TestJar 'org.json' 'json' '20240303'
$testCompilerPath = @($testCompiler,$testStdlib,$testScript,$testReflect,$testDaemon,$testCompilerCoroutines,$testAnnotations) -join [IO.Path]::PathSeparator
$testRuntimePath = @($testStdlib,$testAnnotations,$testJunit,$testHamcrest,$testJson) -join [IO.Path]::PathSeparator
$testClasses = Join-Path $testOutput 'classes'
New-Item -ItemType Directory -Force -Path $testClasses | Out-Null
$testSources = @(
    (Join-Path $testSourceRoot 'TurnstilePolicy.kt'),
    (Join-Path $testSourceRoot 'TurnstileDocument.kt'),
    [IO.Path]::GetFullPath($BridgeSource),
    (Join-Path $testRepository 'android/app/src/test/kotlin/com/fuzevpn/android/TurnstilePolicyTest.kt'),
    (Join-Path $testHostRoot 'NativeTurnstileBridgeHostTest.kt'),
    (Join-Path $testHostRoot 'TurnstileFixture.kt')
)
$testSources += @(Get-ChildItem -LiteralPath (Join-Path $testHostRoot 'stubs') -Filter '*.kt' -File | ForEach-Object FullName)
$testHashes = @($testSources | ForEach-Object { Get-FileHash -LiteralPath $_ -Algorithm SHA256 | Select-Object Path,Hash })
$testHashes | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath (Join-Path $testOutput 'source-hashes.json') -Encoding UTF8
[pscustomobject]@{startedAt=$testStarted.ToString('o'); repository=$testRepository; bridgeSource=$BridgeSource; outputDirectory=$testOutput; java=$Java; javaVersion=$testJavaVersion; node=$Node; nodeVersion=$testNodeVersion; moduleCache=$ModuleCache; androidOrNetworkUsed=$false} |
    ConvertTo-Json | Set-Content -LiteralPath (Join-Path $testOutput 'run-context.json') -Encoding UTF8
$testCompileRun = Invoke-TestNative $Java (@('-cp', $testCompilerPath, 'org.jetbrains.kotlin.cli.jvm.K2JVMCompiler', '-no-stdlib', '-no-reflect', '-jvm-target', '17', '-classpath', $testRuntimePath, '-d', $testClasses) + $testSources)
$testCompileCode = $testCompileRun.ExitCode
Set-Content -LiteralPath (Join-Path $testOutput 'compile.log') -Value $testCompileRun.Output -Encoding UTF8
if ($testCompileCode -ne 0) { $testCompileRun.Output; throw 'Turnstile host compilation failed.' }
$testExecutionPath = @($testClasses,$testRuntimePath) -join [IO.Path]::PathSeparator
$testJunitRun = Invoke-TestNative $Java @('-cp', $testExecutionPath, 'org.junit.runner.JUnitCore', 'com.fuzevpn.android.TurnstilePolicyTest', 'com.fuzevpn.android.NativeTurnstileBridgeHostTest')
$testJunitCode = $testJunitRun.ExitCode
Set-Content -LiteralPath (Join-Path $testOutput 'junit.log') -Value $testJunitRun.Output -Encoding UTF8
$testJunitRun.Output
if ($testJunitCode -ne 0) { throw 'Turnstile host regression failed.' }
$testFixtureRun = Invoke-TestNative $Java @('-cp', $testExecutionPath, 'com.fuzevpn.android.TurnstileFixtureKt', $testOutput)
$testFixtureRun.Output
if ($testFixtureRun.ExitCode -ne 0) { throw 'Turnstile document fixture export failed.' }
$testJsRun = Invoke-TestNative $Node @((Join-Path $testHostRoot 'turnstile-document-test.cjs'), $testOutput)
$testJsCode = $testJsRun.ExitCode
Set-Content -LiteralPath (Join-Path $testOutput 'javascript.log') -Value $testJsRun.Output -Encoding UTF8
$testJsRun.Output
if ($testJsCode -ne 0) { throw 'Turnstile generated document regression failed.' }
[pscustomobject]@{startedAt=$testStarted.ToString('o'); finishedAt=[DateTimeOffset]::UtcNow.ToString('o'); compileExitCode=$testCompileCode; junitExitCode=$testJunitCode; javascriptExitCode=$testJsCode} |
    ConvertTo-Json | Set-Content -LiteralPath (Join-Path $testOutput 'result.json') -Encoding UTF8
