# Ensure script stops on errors
$ErrorActionPreference = "Stop"

# Run the setup script (if it exists)
if (Test-Path ".\venv-3.12.8\Scripts\Activate.ps1") {
    .\venv-3.12.8\Scripts\Activate.ps1
} else {
    Write-Host "Setup script not found!"
}
