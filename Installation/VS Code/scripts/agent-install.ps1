param(
    [Parameter(Mandatory=$true)]
    [string]$SourcePath,
    [string]$Scope = 'env',
    [switch]$DryRun,
    [switch]$Force
)

if (-not (Test-Path $SourcePath)) {
    Write-Error "Source file not found: $SourcePath"
    exit 1
}

switch ($Scope) {
    'project' { $TargetDir = Join-Path (Get-Location) '.vscode\prompts\Agents' }
    'env'     { $TargetDir = Join-Path $env:USERPROFILE '.config\Code\User\prompts\Agents' }
    default { Write-Error "Invalid scope: $Scope"; exit 2 }
}

New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null

$TargetFile = Join-Path $TargetDir (Split-Path $SourcePath -Leaf)

if (Test-Path $TargetFile) {
    $srcHash = (Get-FileHash -Path $SourcePath -Algorithm SHA256).Hash
    $tgtHash = (Get-FileHash -Path $TargetFile -Algorithm SHA256).Hash
    if ($srcHash -eq $tgtHash) {
        Write-Output "Target exists and is identical; nothing to do: $TargetFile"
        exit 0
    }
    if ($DryRun) {
        Write-Output "DRY RUN: would replace $TargetFile (existing file differs)"
        exit 0
    }
    if (-not $Force) {
        $bak = "$TargetFile.$((Get-Date).ToString('yyyyMMddTHHmmssZ')).bak"
        Copy-Item -Path $TargetFile -Destination $bak -Force
        Write-Output "Backed up existing file to: $bak"
    }
}

if ($DryRun) {
    Write-Output "DRY RUN: would copy $SourcePath -> $TargetDir"
    exit 0
}

Copy-Item -Path $SourcePath -Destination $TargetDir -Force
Get-Item $TargetFile | ForEach-Object { $_.Attributes = 'Archive' }
Write-Output "Installed $(Split-Path $SourcePath -Leaf) -> $TargetDir"
