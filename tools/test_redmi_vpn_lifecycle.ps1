[CmdletBinding()]
param(
    [string]$Serial,
    [ValidateRange(1, 10)]
    [int]$Cycles = 3,
    [ValidatePattern('^[A-Za-z0-9][A-Za-z0-9._-]{0,63}$')]
    [string]$SourceLocation = 'Frankfurt-01',
    [ValidatePattern('^[A-Za-z0-9][A-Za-z0-9._-]{0,63}$')]
    [string]$TargetLocation = 'Frankfurt-02',
    [ValidateRange(30, 300)]
    [int]$ConnectionTimeoutSeconds = 120,
    [ValidateRange(60, 600)]
    [int]$MigrationTimeoutSeconds = 300,
    [string]$ApkPath,
    [string]$AdbPath,
    [string]$JavaHome,
    [switch]$SkipBuild,
    [switch]$AllowAnyModel
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$projectRoot = Split-Path -Parent $PSScriptRoot
$androidRoot = Join-Path $projectRoot 'android'
$reportRoot = Join-Path $projectRoot 'build\reports\device'
$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$reportPath = Join-Path $reportRoot "redmi-vpn-lifecycle-$timestamp.txt"
$packageName = 'com.fuzevpn'
$testRunner = 'com.fuzevpn.test/androidx.test.runner.AndroidJUnitRunner'
$testClass = 'com.fuzevpn.android.RedmiVpnLifecycleInstrumentedTest'

New-Item -ItemType Directory -Force -Path $reportRoot | Out-Null
Set-Content -LiteralPath $reportPath -Value '' -Encoding utf8

function Add-ReportLine {
    param([Parameter(Mandatory)][AllowEmptyString()][string]$Value)
    Add-Content -LiteralPath $reportPath -Value $Value -Encoding utf8
}

function Resolve-AndroidSdk {
    $localProperties = Join-Path $androidRoot 'local.properties'
    if (Test-Path -LiteralPath $localProperties) {
        $sdkLine = Get-Content -LiteralPath $localProperties |
            Where-Object { $_ -match '^sdk\.dir=' } |
            Select-Object -First 1
        if ($sdkLine) {
            $sdkValue = ($sdkLine -replace '^sdk\.dir=', '') -replace '\\\\', '\'
            if (Test-Path -LiteralPath $sdkValue) { return $sdkValue }
        }
    }
    if ($env:ANDROID_HOME -and (Test-Path -LiteralPath $env:ANDROID_HOME)) {
        return $env:ANDROID_HOME
    }
    throw 'Android SDK introuvable. Configurez android/local.properties ou ANDROID_HOME.'
}

function Resolve-AdbExecutable {
    if ($AdbPath) {
        $resolved = (Resolve-Path -LiteralPath $AdbPath).Path
        if (-not (Test-Path -LiteralPath $resolved -PathType Leaf)) {
            throw "ADB introuvable : $resolved"
        }
        return $resolved
    }
    $candidate = Join-Path (Resolve-AndroidSdk) 'platform-tools\adb.exe'
    if (-not (Test-Path -LiteralPath $candidate -PathType Leaf)) {
        throw "ADB introuvable : $candidate"
    }
    return $candidate
}

function Resolve-JavaRuntime {
    if ($JavaHome) {
        $resolved = (Resolve-Path -LiteralPath $JavaHome).Path
        if (Test-Path -LiteralPath (Join-Path $resolved 'bin\java.exe')) { return $resolved }
        throw "JDK invalide : $resolved"
    }
    if ($env:JAVA_HOME -and (Test-Path -LiteralPath (Join-Path $env:JAVA_HOME 'bin\java.exe'))) {
        return $env:JAVA_HOME
    }
    $standardJdk17 = 'C:\Program Files\Java\jdk-17'
    if (Test-Path -LiteralPath (Join-Path $standardJdk17 'bin\java.exe')) {
        return $standardJdk17
    }
    $androidStudioJbr = 'C:\Program Files\Android\Android Studio\jbr'
    if (Test-Path -LiteralPath (Join-Path $androidStudioJbr 'bin\java.exe')) {
        return $androidStudioJbr
    }
    throw 'JDK 17 introuvable. Utilisez -JavaHome avec un JDK 17.'
}

$script:adbExecutable = Resolve-AdbExecutable
$script:adbTarget = @()

function Invoke-Adb {
    param(
        [Parameter(Mandatory)][string[]]$Arguments,
        [switch]$AllowFailure
    )
    $previousErrorAction = $ErrorActionPreference
    try {
        # Windows PowerShell 5 converts native stderr into ErrorRecord objects.
        # Capture it as diagnostic output and decide from the native exit code.
        $ErrorActionPreference = 'Continue'
        $output = & $script:adbExecutable @script:adbTarget @Arguments 2>&1
        $exitCode = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $previousErrorAction
    }
    if (-not $AllowFailure -and $exitCode -ne 0) {
        throw "ADB a echoue ($exitCode) : $($Arguments -join ' ')`n$($output -join "`n")"
    }
    return [pscustomobject]@{ Output = @($output); ExitCode = $exitCode }
}

function Test-PhoneUnlocked {
    $trust = (Invoke-Adb -Arguments @('shell', 'dumpsys', 'trust')).Output -join "`n"
    return $trust -notmatch 'deviceLocked=1'
}

function Restore-StayAwakeSetting {
    param(
        [AllowNull()][string]$PreviousValue,
        [bool]$WasUnset
    )
    if ([string]::IsNullOrEmpty($PreviousValue) -and -not $WasUnset) { return }
    if ($WasUnset) {
        Invoke-Adb -AllowFailure -Arguments @(
            'shell', 'settings', 'delete', 'global', 'stay_on_while_plugged_in'
        ) | Out-Null
        return
    }
    Invoke-Adb -AllowFailure -Arguments @(
        'shell', 'settings', 'put', 'global', 'stay_on_while_plugged_in', $PreviousValue
    ) | Out-Null
}

function Get-InstalledVersion {
    $packageDump = (Invoke-Adb -Arguments @('shell', 'dumpsys', 'package', $packageName)).Output
    $versionCode = ($packageDump | Select-String 'versionCode=' | Select-Object -First 1).Line.Trim()
    $versionName = ($packageDump | Select-String 'versionName=' | Select-Object -First 1).Line.Trim()
    if (-not $versionCode) { throw "$packageName n'est pas installe." }
    return "$versionCode; $versionName"
}

function Get-PostRunState {
    $services = (Invoke-Adb -Arguments @('shell', 'dumpsys', 'activity', 'services', $packageName)).Output
    $vpnServiceCount = @($services | Select-String 'GoBackend\$VpnService|OpenVpnService|VpnForegroundService').Count
    $connectivity = (Invoke-Adb -Arguments @('shell', 'dumpsys', 'connectivity')).Output
    $vpnNetworkCount = @($connectivity | Select-String 'TRANSPORT_VPN').Count
    # HyperOS refuses `ip link` to the ADB shell. /proc/net/dev exposes the
    # active interface names without elevated privileges. Exclude kernel
    # placeholders such as tunl0 and count only concrete VPN interfaces.
    $interfaces = (Invoke-Adb -Arguments @('shell', 'cat', '/proc/net/dev')).Output
    $tunInterfaceCount = @(
        $interfaces | Select-String '^\s*(tun[0-9]+|wg[0-9]+|vpn[A-Za-z0-9._-]*):'
    ).Count
    return [pscustomobject]@{
        VpnServiceCount = $vpnServiceCount
        VpnNetworkCount = $vpnNetworkCount
        TunInterfaceCount = $tunInterfaceCount
    }
}

Add-ReportLine 'FuzeVPN - validation Redmi WireGuard/OpenVPN'
Add-ReportLine "Date: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss zzz')"
Add-ReportLine "Scenario: $Cycles cycles/protocole; WireGuard -> OpenVPN -> WireGuard; $SourceLocation -> $TargetLocation"
Add-ReportLine 'Confidentialite: aucun logcat, jeton, profil, certificat, cle ou reponse API collecte.'

$testPassed = $false
$instrumentationStarted = $false
$previousStayAwake = $null
$stayAwakeWasUnset = $false
try {
    $devicesOutput = (& $script:adbExecutable devices) 2>&1
    if ($LASTEXITCODE -ne 0) { throw "Impossible de lister les appareils ADB.`n$($devicesOutput -join "`n")" }
    $connectedDevices = @(
        $devicesOutput |
            Where-Object { $_ -match '^([^\s]+)\s+device(?:\s|$)' } |
            ForEach-Object { [regex]::Match($_, '^([^\s]+)').Groups[1].Value }
    )
    if ($Serial) {
        if ($Serial -notin $connectedDevices) { throw "Appareil ADB demande introuvable : $Serial" }
        $selectedSerial = $Serial
    } elseif ($connectedDevices.Count -eq 1) {
        $selectedSerial = $connectedDevices[0]
    } elseif ($connectedDevices.Count -eq 0) {
        throw 'Aucun appareil ADB autorise.'
    } else {
        throw 'Plusieurs appareils ADB sont connectes. Utilisez -Serial.'
    }
    $script:adbTarget = @('-s', $selectedSerial)

    $model = ((Invoke-Adb -Arguments @('shell', 'getprop', 'ro.product.model')).Output -join '').Trim()
    $deviceCode = ((Invoke-Adb -Arguments @('shell', 'getprop', 'ro.product.device')).Output -join '').Trim()
    if (-not $AllowAnyModel -and $model -notmatch 'Redmi|2312DRA50G' -and $deviceCode -ne 'garnet') {
        throw "Appareil non Redmi Note 13 Pro detecte : $model ($deviceCode). Utilisez -AllowAnyModel pour l'autoriser."
    }
    $serialSuffix = if ($selectedSerial.Length -gt 4) { $selectedSerial.Substring($selectedSerial.Length - 4) } else { $selectedSerial }
    Add-ReportLine "Appareil: $model ($deviceCode), serie ...$serialSuffix"

    if (-not (Test-PhoneUnlocked)) {
        throw "Telephone verrouille. Deverrouillez l'ecran et relancez le script."
    }

    $previousStayAwake = ((Invoke-Adb -Arguments @(
        'shell', 'settings', 'get', 'global', 'stay_on_while_plugged_in'
    )).Output -join '').Trim()
    $stayAwakeWasUnset = [string]::IsNullOrWhiteSpace($previousStayAwake) -or $previousStayAwake -eq 'null'
    $stayAwakeValue = 0
    if (-not [int]::TryParse($previousStayAwake, [ref]$stayAwakeValue)) {
        $stayAwakeValue = 0
    }
    Invoke-Adb -Arguments @(
        'shell', 'settings', 'put', 'global', 'stay_on_while_plugged_in',
        (($stayAwakeValue -bor 2).ToString())
    ) | Out-Null

    if ($ApkPath) {
        $resolvedApk = (Resolve-Path -LiteralPath $ApkPath).Path
        if ([IO.Path]::GetExtension($resolvedApk) -ne '.apk') { throw "Fichier APK invalide : $resolvedApk" }
        Add-ReportLine "Installation: mise a jour sur place de $([IO.Path]::GetFileName($resolvedApk))"
        $installResult = Invoke-Adb -Arguments @('install', '-r', $resolvedApk)
        if (($installResult.Output -join "`n") -notmatch 'Success') {
            throw "L'installation de l'APK n'a pas ete confirmee."
        }
    }

    Add-ReportLine "Application: $(Get-InstalledVersion)"

    if (-not $SkipBuild) {
        $resolvedJavaHome = Resolve-JavaRuntime
        $env:JAVA_HOME = $resolvedJavaHome
        Add-ReportLine 'Build instrumentation: :app:assembleDebugAndroidTest avec WireGuard patche'
        Push-Location $androidRoot
        try {
            & .\gradlew.bat :app:assembleDebugAndroidTest '-Pfuzevpn.usePatchedWireGuardAar=true' | Out-Null
            if ($LASTEXITCODE -ne 0) { throw 'La compilation du test Android a echoue.' }
        } finally {
            Pop-Location
        }
    }

    $testApk = Join-Path $projectRoot 'build\app\outputs\apk\androidTest\debug\app-debug-androidTest.apk'
    if (-not (Test-Path -LiteralPath $testApk -PathType Leaf)) {
        throw "APK de test introuvable : $testApk"
    }
    $testInstall = Invoke-Adb -Arguments @('install', '-r', '-t', $testApk)
    if (($testInstall.Output -join "`n") -notmatch 'Success') {
        throw "L'installation de l'APK de test n'a pas ete confirmee."
    }

    Add-ReportLine '--- Sortie instrumentation sure ---'
    $instrumentationStarted = $true
    $instrumentation = Invoke-Adb -AllowFailure -Arguments @(
        'shell', 'am', 'instrument', '-w', '-r',
        '-e', 'class', $testClass,
        '-e', 'cycles', $Cycles.ToString(),
        '-e', 'source_location', $SourceLocation,
        '-e', 'target_location', $TargetLocation,
        '-e', 'connection_timeout_seconds', $ConnectionTimeoutSeconds.ToString(),
        '-e', 'migration_timeout_seconds', $MigrationTimeoutSeconds.ToString(),
        $testRunner
    )
    $instrumentation.Output | ForEach-Object { Add-ReportLine ([string]$_) }
    $instrumentationText = $instrumentation.Output -join "`n"
    $testPassed =
        $instrumentation.ExitCode -eq 0 -and
        $instrumentationText -match 'OK \(' -and
        $instrumentationText -notmatch 'FAILURES!!!|INSTRUMENTATION_FAILED'

    $postRun = Get-PostRunState
    Add-ReportLine '--- Etat final hote ---'
    Add-ReportLine "Reseaux VPN detectes: $($postRun.VpnNetworkCount)"
    Add-ReportLine "Services VPN detectes: $($postRun.VpnServiceCount)"
    Add-ReportLine "Interfaces TUN/WG/VPN detectees: $($postRun.TunInterfaceCount)"
    if ($postRun.VpnNetworkCount -ne 0 -or $postRun.VpnServiceCount -ne 0 -or $postRun.TunInterfaceCount -ne 0) {
        $testPassed = $false
        Add-ReportLine 'ECHEC: le controle ADB final detecte encore un reseau, service ou interface VPN.'
    }

    if (-not $testPassed) { throw 'La matrice Redmi a echoue. Consultez le rapport.' }
    Add-ReportLine 'RESULTAT: SUCCES'
} catch {
    Add-ReportLine "RESULTAT: ECHEC - $($_.Exception.Message)"
    if ($instrumentationStarted) {
        $beforeCleanup = Get-PostRunState
        if ($beforeCleanup.VpnNetworkCount -ne 0 -or $beforeCleanup.VpnServiceCount -ne 0 -or $beforeCleanup.TunInterfaceCount -ne 0) {
            Add-ReportLine 'Securite: arret force du processus applicatif apres echec du nettoyage normal.'
            Invoke-Adb -AllowFailure -Arguments @('shell', 'am', 'force-stop', $packageName) | Out-Null
        }
    }
    Restore-StayAwakeSetting -PreviousValue $previousStayAwake -WasUnset $stayAwakeWasUnset
    Write-Error "Validation Redmi echouee. Rapport : $reportPath`n$($_.Exception.Message)"
    exit 1
}

Restore-StayAwakeSetting -PreviousValue $previousStayAwake -WasUnset $stayAwakeWasUnset
Write-Output "Validation Redmi reussie. Rapport : $reportPath"
exit 0
