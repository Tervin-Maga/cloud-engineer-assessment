param (
    [switch]$Restart,
    [switch]$IgnoreRestart
)

# Check if PSWindowsUpdate module is installed
if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Write-Host "PSWindowsUpdate module is not installed. Installing..."
    Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser
}

# Import the module
Import-Module PSWindowsUpdate

# Run Windows Update
Write-Host "Running Windows Update..."
$updates = Get-WindowsUpdate -AcceptAll

if ($updates) {
    Write-Host "Updates found: $($updates.Count)"
    $updates | Install-WindowsUpdate -AcceptAll -AutoReboot:$Restart
} else {
    Write-Host "No updates available."
}

if ($Restart) {
    Write-Host "The system will restart after updates."
} elseif ($IgnoreRestart) {
    Write-Host "Updates installed. No restart will occur."
} else {
    Write-Host "Updates installed. Please restart the system to complete the installation."
}
