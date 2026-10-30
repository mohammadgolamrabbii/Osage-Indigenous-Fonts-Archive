# Open Typography Foundation - Osage Font Installer
$ErrorActionPreference = "Stop"

$FontsFolder = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Fonts)
Write-Host "Installing Osage fonts into Windows..." -ForegroundColor Cyan

$CurrentDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$fontFiles = Get-ChildItem -Path $CurrentDir -Include "*.ttf", "*.otf" -Recurse

foreach ($font in $fontFiles) {
    $targetPath = Join-Path $FontsFolder $font.Name
    if (-not (Test-Path $targetPath)) {
        Copy-Item -Path $font.FullName -Destination $targetPath -Force
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" -Name $font.Name -Value $font.Name -PropertyType String -Force | Out-Null
        Write-Host "  Installed: $($font.Name)" -ForegroundColor Green
    }
}

Write-Host "Completed Osage font installation!" -ForegroundColor Cyan
