# SPDX-License-Identifier: MPL-2.0
# Pure destination resolution and non-destructive publication shared by tests.
function Resolve-NativeBundleDestination([string]$ImporterDirectory) {
    return [IO.Path]::GetFullPath((Join-Path (Split-Path -Parent $ImporterDirectory) 'third_party'))
}

function Assert-NativePathHasNoLinks([string]$Path) {
    $cursor = [IO.Path]::GetFullPath($Path)
    while ($cursor) {
        if (Test-Path -LiteralPath $cursor) {
            if ((Get-Item -LiteralPath $cursor -Force).Attributes -band [IO.FileAttributes]::ReparsePoint) {
                throw "Native import refuses linked paths: $cursor"
            }
        }
        $cursor = Split-Path -Parent $cursor
    }
}

function Publish-NativeBundleStage([string]$Stage, [string]$Destination) {
    $stagePath = [IO.Path]::GetFullPath($Stage)
    $destinationPath = [IO.Path]::GetFullPath($Destination)
    $parentPath = Split-Path -Parent $destinationPath
    if ((Split-Path -Parent $stagePath) -ne $parentPath -or
        -not ([IO.Path]::GetFileName($stagePath)).StartsWith('.fuzevpn-native-import-')) {
        throw 'Native import stage must be a verified sibling of its destination.'
    }
    Assert-NativePathHasNoLinks $stagePath
    Assert-NativePathHasNoLinks $destinationPath
    if (Test-Path -LiteralPath $destinationPath) {
        throw "Refusing to replace an existing native bundle: $destinationPath"
    }
    # Same-volume directory rename publishes the complete verified bundle once.
    # An existing destination is never recursively deleted by an import.
    Move-Item -LiteralPath $stagePath -Destination $destinationPath -ErrorAction Stop
}
