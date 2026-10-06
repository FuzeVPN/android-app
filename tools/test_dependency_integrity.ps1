param([string]$OutputDirectory)
$ErrorActionPreference = 'Stop'
$integrityRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
if (-not $OutputDirectory) {
    $OutputDirectory = Join-Path $integrityRoot 'build/dependency-integrity-tests'
}
$OutputDirectory = [IO.Path]::GetFullPath($OutputDirectory)
New-Item -ItemType Directory -Force -Path $OutputDirectory | Out-Null
$metadataPath = Join-Path $integrityRoot 'android/gradle/verification-metadata.xml'
$metadataHash = (Get-FileHash -LiteralPath $metadataPath -Algorithm SHA256).Hash
$wrapperPath = Join-Path $integrityRoot 'android/gradlew.bat'
$caseResults = [Collections.Generic.List[object]]::new()

# Resolve one real, already cached application dependency in isolated fixtures.
# Never modify the application's metadata, locks or downloaded artifacts.
function Invoke-IntegrityCase {
    param([string]$Name, [string]$LockVersion, [bool]$CorruptChecksum,
        [string]$ExpectedFailure)
    $fixture = Join-Path $OutputDirectory $Name
    if (Test-Path -LiteralPath $fixture) {
        throw "Fixture already exists: $fixture. Choose a new output directory."
    }
    New-Item -ItemType Directory -Path (Join-Path $fixture 'gradle') -Force | Out-Null
    "rootProject.name = 'dependency-integrity-probe'" |
        Set-Content -LiteralPath (Join-Path $fixture 'settings.gradle') -Encoding utf8
    @'
repositories { mavenCentral() }
configurations { probe }
dependencies { probe 'org.json:json:20240303' }
dependencyLocking {
    lockAllConfigurations()
    lockMode = LockMode.STRICT
}
tasks.register('resolveProbe') {
    doLast {
        assert configurations.probe.files.size() == 1
        println 'DEPENDENCY_INTEGRITY_PROBE_OK'
    }
}
'@ | Set-Content -LiteralPath (Join-Path $fixture 'build.gradle') -Encoding utf8
    if ($LockVersion) {
        "org.json:json:$LockVersion=probe`nempty=" |
            Set-Content -LiteralPath (Join-Path $fixture 'gradle.lockfile') -Encoding utf8
    }
    $fixtureMetadata = Join-Path $fixture 'gradle/verification-metadata.xml'
    Copy-Item -LiteralPath $metadataPath -Destination $fixtureMetadata
    if ($CorruptChecksum) {
        [xml]$verification = Get-Content -LiteralPath $fixtureMetadata -Raw
        $artifact = $verification.SelectSingleNode("//*[local-name()='component' and @group='org.json' and @name='json' and @version='20240303']/*[local-name()='artifact' and @name='json-20240303.jar']")
        if ($null -eq $artifact -or $artifact.ChildNodes.Count -ne 1) {
            throw 'Expected one reviewed SHA-256 for the JSON artifact'
        }
        $artifact.FirstChild.SetAttribute('value', ('0' * 64))
        $verification.Save($fixtureMetadata)
    }
    $log = Join-Path $OutputDirectory "$Name.log"
    $ErrorActionPreference = 'Continue'
    & $wrapperPath @('-p', $fixture, 'resolveProbe', '--offline', '--console=plain') *> $log
    $probeExit = $LASTEXITCODE
    $ErrorActionPreference = 'Stop'
    $output = Get-Content -LiteralPath $log -Raw
    if ($ExpectedFailure) {
        if ($probeExit -eq 0 -or $output -notmatch $ExpectedFailure -or
            $output -match 'DEPENDENCY_INTEGRITY_PROBE_OK') {
            throw "$Name did not fail for the expected integrity reason; see $log"
        }
    } elseif ($probeExit -ne 0 -or $output -notmatch 'DEPENDENCY_INTEGRITY_PROBE_OK') {
        throw "$Name failed; see $log"
    }
    $caseResults.Add([pscustomobject]@{
        name = $Name; passed = $true; expectedRejection = [bool]$ExpectedFailure;
        exitCode = $probeExit
    })
    Write-Output "PASS $Name"
}

Invoke-IntegrityCase 'approved-dependency' '20240303' $false ''
Invoke-IntegrityCase 'altered-checksum' '20240303' $true 'Dependency verification failed|checksum'
Invoke-IntegrityCase 'changed-lock-version' '20231013' $false 'strictly|dependency lock state'
Invoke-IntegrityCase 'missing-lock-state' '' $false 'does not have lock state|lock state.*not.*found|did not find.*lock state'
if ((Get-FileHash -LiteralPath $metadataPath -Algorithm SHA256).Hash -ne $metadataHash) {
    throw 'Application verification metadata changed during isolated probes'
}
$caseResults | ConvertTo-Json -Depth 4 |
    Set-Content -LiteralPath (Join-Path $OutputDirectory 'results.json') -Encoding utf8
Write-Output "Dependency integrity: $($caseResults.Count) cases passed"
exit 0
