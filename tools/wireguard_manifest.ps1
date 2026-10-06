# SPDX-License-Identifier: Apache-2.0
# Shared by the AAR repackager and its isolated regression tests.
function Read-WireGuardManifestXml([string]$Xml) {
    $settings = [Xml.XmlReaderSettings]::new()
    $settings.DtdProcessing = [Xml.DtdProcessing]::Prohibit
    $settings.XmlResolver = $null
    $reader = [Xml.XmlReader]::Create([IO.StringReader]::new($Xml), $settings)
    try {
        $document = [Xml.XmlDocument]::new()
        $document.PreserveWhitespace = $true
        $document.XmlResolver = $null
        $document.Load($reader)
        return ,$document
    } finally { $reader.Dispose() }
}

function New-WireGuardPackagedManifest([string]$SourceXml, [string]$PublishedXml) {
    $androidNamespace = 'http://schemas.android.com/apk/res/android'
    $source = Read-WireGuardManifestXml $SourceXml
    $published = Read-WireGuardManifestXml $PublishedXml
    if ($source.DocumentElement.Name -ne 'manifest' -or
        $published.DocumentElement.GetAttribute('package') -ne 'com.wireguard.android.tunnel') {
        throw 'Unexpected WireGuard manifest identity.'
    }
    $sdkNodes = @($published.DocumentElement.SelectNodes('uses-sdk'))
    if ($sdkNodes.Count -ne 1) { throw 'Published WireGuard AAR must declare one uses-sdk element.' }
    $minimum = 0
    if (-not [int]::TryParse($sdkNodes[0].GetAttribute('minSdkVersion', $androidNamespace), [ref]$minimum) -or $minimum -lt 24) {
        throw 'Published WireGuard minimum SDK is missing or unexpected.'
    }
    $targetText = $sdkNodes[0].GetAttribute('targetSdkVersion', $androidNamespace)
    $target = $minimum
    if ($targetText -and (-not [int]::TryParse($targetText, [ref]$target) -or $target -lt $minimum)) {
        throw 'Published WireGuard target SDK is unexpected.'
    }
    $source.DocumentElement.SetAttribute('package', 'com.wireguard.android.tunnel')
    foreach ($existing in @($source.DocumentElement.SelectNodes('uses-sdk'))) {
        $null = $source.DocumentElement.RemoveChild($existing)
    }
    # Source manifests have no Gradle-injected SDK metadata. Carry it over from
    # the hash-verified publication; otherwise AGP infers targetSdkVersion=1.
    $null = $source.DocumentElement.PrependChild($source.ImportNode($sdkNodes[0], $true))
    return $source.OuterXml
}
