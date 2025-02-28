# Ensure script stops on errors
$ErrorActionPreference = "Stop"

# Activate the virtual environment
.\setup_virtual_environment.ps1

# Run the setup script (if it exists)
if (Test-Path ".\venv-3.12.8\Scripts\pip.exe") {
    .\venv-3.12.8\Scripts\pip.exe install -r requirements.txt
} else {
    Write-Host "Setup script not found!"
}
