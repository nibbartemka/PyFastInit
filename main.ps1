Import-Module .\scripts.psm1

# Get location for init by default
$defaultLocation = [System.Environment]::GetFolderPath('Desktop')

# Confirming user-entered path
$userLocation = ConfirmWorkingDirectoryPath -defaultLocation $defaultLocation
Write-Output "Working directory location: $userLocation"

# Move to user-entered directory
Set-Location -Path $userLocation

# Confirming directory name
$workingDirectory = ConfirmWorkingDirectoryName

# Creating directory using confirmed name
New-Item -ItemType Directory -Name $workingDirectory
Write-Output "Working directory $workingDirectory was successfully created!"

# Creating venv and git repository
CreatingVenv -directoryPath $workingDirectory
CreatingGitRepository -directoryPath $workingDirectory
CreatingGitIgnore -directoryPath $workingDirectory

# Turning on VS Code in this directory
code $workingDirectory