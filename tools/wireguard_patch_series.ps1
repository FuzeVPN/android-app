# SPDX-License-Identifier: Apache-2.0
# Applies the reviewed WireGuard Android patch series to a staged source tree,
# independently of line endings (A10-wireguard-05). The reviewed patches mix
# CRLF (0001, 0003) and LF (0002) preimages, while `git archive` follows the
# workstation's core.autocrlf. Each patch is therefore applied from an LF copy
# to LF copies of the files it names; the reviewed patch bytes, their SHA-256
# and every other staged file stay unchanged. Dot-source this file.

function ConvertTo-WireGuardLfText([string]$Path) {
    # Latin-1 maps each byte to one character, so only CR before LF changes.
    $latin1 = [Text.Encoding]::GetEncoding(28591)
    $text = $latin1.GetString([IO.File]::ReadAllBytes($Path))
    return $text.Replace("`r`n", "`n")
}

function Get-WireGuardPatchTargets([string]$PatchText) {
    $targets = [Collections.Generic.List[string]]::new()
    foreach ($match in [regex]::Matches($PatchText, '(?m)^(?:---|\+\+\+) (?:a|b)/([^\t\n]+)$')) {
        $relative = $match.Groups[1].Value
        if ($relative -match '(^|/)\.\.(/|$)' -or [IO.Path]::IsPathRooted($relative)) {
            throw "Refusing a patch target outside the staged source: $relative"
        }
        if (-not $targets.Contains($relative)) { $targets.Add($relative) }
    }
    return ,$targets.ToArray()
}

function Invoke-WireGuardPatchSeries {
    param(
        [Parameter(Mandatory)][string]$StagedSource,
        [Parameter(Mandatory)][string[]]$Patches,
        [string]$Git = 'git'
    )
    $latin1 = [Text.Encoding]::GetEncoding(28591)
    $source = [IO.Path]::GetFullPath($StagedSource)
    $work = Join-Path ([IO.Path]::GetTempPath()) ('fuzevpn-wireguard-series-' + [guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $work -Force | Out-Null
    try {
        $index = 0
        foreach ($patch in $Patches) {
            $index++
            $patchText = ConvertTo-WireGuardLfText $patch
            foreach ($relative in (Get-WireGuardPatchTargets $patchText)) {
                $target = [IO.Path]::GetFullPath((Join-Path $source $relative))
                if (-not $target.StartsWith($source.TrimEnd('\', '/') + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)) {
                    throw "Refusing a patch target outside the staged source: $relative"
                }
                if (Test-Path -LiteralPath $target -PathType Leaf) {
                    [IO.File]::WriteAllBytes($target, $latin1.GetBytes((ConvertTo-WireGuardLfText $target)))
                }
            }
            $normalized = Join-Path $work ('{0:D2}-{1}' -f $index, [IO.Path]::GetFileName($patch))
            [IO.File]::WriteAllBytes($normalized, $latin1.GetBytes($patchText))
            & $Git -C $source -c core.autocrlf=false -c core.eol=lf apply --whitespace=nowarn --check $normalized
            if ($LASTEXITCODE -ne 0) { throw "The required patch does not apply cleanly: $patch" }
            & $Git -C $source -c core.autocrlf=false -c core.eol=lf apply --whitespace=nowarn $normalized
            if ($LASTEXITCODE -ne 0) { throw "Unable to apply required patch: $patch" }
        }
    } finally {
        Remove-Item -LiteralPath $work -Recurse -Force -ErrorAction SilentlyContinue
    }
}
