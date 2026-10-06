# SPDX-License-Identifier: MPL-2.0
<#
Imports the exact OpenVPN 3 Core source, the verified native dependency prefix
and the prebuilt OpenSSL 3.5.9 Android prefix. This command is deliberately
offline: fetching and building third-party code stays a separate review step.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)] [string]$OpenVpn3Source,
    [Parameter(Mandatory)] [string]$DependenciesSource,
    [Parameter(Mandatory)] [string]$OpenSslPrefixSource,
    [Parameter(Mandatory)] [string]$OpenSslSourceArchive,
    [Parameter(Mandatory)]
    [ValidatePattern('^[A-Fa-f0-9]{64}$')]
    [string]$DependenciesManifestSha256,
    [string]$JavaHome = $env:JAVA_HOME,
    [string]$DestinationRoot
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$implementation = Join-Path $PSScriptRoot '..\android\app\src\main\cpp\tools\import_openvpn3_openssl.ps1'
if (-not (Test-Path -LiteralPath $implementation -PathType Leaf)) {
    throw "OpenVPN/OpenSSL import implementation is missing: $implementation"
}

& $implementation @PSBoundParameters
if ($LASTEXITCODE -and $LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
