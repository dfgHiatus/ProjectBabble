# Ensure script stops on errors
$ErrorActionPreference = "Stop"

# Activate the virtual environment
.\setup_virtual_environment.ps1

# Determine the correct Python executable inside the virtual environment 

# Verify that Python exists before executing
if (Test-Path ".\venv-3.12.8\Scripts\python.exe") {
    .\venv-3.12.8\Scripts\python.exe babbleapp.py
} else {
    Write-Host "Error: Python executable not found at $PythonPath"
    Exit 1
}
