param(
    [Parameter(Mandatory=$true)]
    [string]$NameOrPath,
    [string]$Scope = 'env',
    [switch]$DryRun
)

if ($NameOrPath -match '[\\/]') {
    $TargetFile = $NameOrPath
} else {
    switch ($Scope) {
        'project' { $TargetFile = Join-Path (Get-Location) "Agents\$NameOrPath" }
        'env'     { $TargetFile = Join-Path $env:USERPROFILE ".config\gemini\agents\$NameOrPath" }
        default { Write-Error "Invalid scope: $Scope"; exit 2 }
    }
}

if (-not (Test-Path $TargetFile)) {
    Write-Error "Not found: $TargetFile"
    exit 1
}

if ($DryRun) {
    Write-Output "DRY RUN: would remove $TargetFile"
    exit 0
}

Remove-Item -Path $TargetFile -Force
Write-Output "Removed $TargetFile"
