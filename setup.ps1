[CmdletBinding()]
param(
    [string]$Destination = (Get-Location).Path
)

$ErrorActionPreference = 'Stop'

$BASE_URL = 'https://raw.githubusercontent.com/gimenorum/opencode-agents/main'
$FILES = @(
    'opencode.jsonc',
    '.opencode/agents/explore.md',
    '.opencode/agents/scout.md',
    '.opencode/agents/review.md',
    '.opencode/agents/general.md',
    '.opencode/agents/design-fallback.md'
)

function Write-Info {
    param([string]$Message)
    Write-Host $Message
}

if (-not (Test-Path -LiteralPath $Destination -PathType Container)) {
    throw "Destination does not exist: $Destination"
}

$Destination = (Resolve-Path -LiteralPath $Destination).Path

$tmp = Join-Path ([System.IO.Path]::GetTempPath()) ([System.Guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $tmp -Force | Out-Null

try {
    foreach ($file in $FILES) {
        $targetDir = Join-Path $tmp (Split-Path -Path $file -Parent)
        if (-not (Test-Path -LiteralPath $targetDir -PathType Container)) {
            New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        }

        $outFile = Join-Path $tmp $file
        $url = "$BASE_URL/$file"

        try {
            Invoke-WebRequest -Uri $url -OutFile $outFile -UseBasicParsing | Out-Null
        }
        catch {
            throw "Failed to fetch: $file"
        }

        if ((Get-Item -LiteralPath $outFile).Length -eq 0) {
            throw "File is empty: $file"
        }
    }

    Write-Info "Target directory: $Destination"

    foreach ($file in $FILES) {
        $targetPath = Join-Path $Destination $file
        $targetDir = Split-Path -Path $targetPath -Parent

        if (-not (Test-Path -LiteralPath $targetDir -PathType Container)) {
            New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        }

        Copy-Item -Path (Join-Path $tmp $file) -Destination $targetPath -Force
    }

    Write-Info 'Setup completed. The configuration is loaded from opencode.jsonc and .opencode/ in the project root.'
    if (Get-Command opencode -ErrorAction SilentlyContinue) {
        Write-Info 'If you are using an existing background service, run opencode service restart before continuing.'
    }
}
finally {
    if (Test-Path -LiteralPath $tmp -PathType Container) {
        Remove-Item -LiteralPath $tmp -Recurse -Force
    }
}
