function GetWorkingDirectoryPath {
    param (
        [string] $defaultLocation
    )

    # get user-entered path
    $userLocation = Read-Host "Please enter full path for working directory init (leave blank = Desktop)"

    if ([string]::IsNullOrEmpty($userLocation)) {
        $userLocation = $defaultLocation
    }
    
    return $userLocation
}

function ConfirmWorkingDirectoryPath {
    param (
        [string] $defaultLocation
    )
    
    # Boolean variable for loop
    $isRunning = $true
    
    $checkingLocation = ""
    
    while ($isRunning) {
        # User-entered location for init
        $checkingLocation = GetWorkingDirectoryPath -defaultLocation $defaultLocation

        # If user want to abort script
        if ($checkingLocation -eq 'exit') {
            $isRunning = $false
            exit
        } 

        # Check can we set location using user-entered path
        if (Test-Path $checkingLocation) {
            $isRunning = $false
        } else {
            Write-Host "Can't set-location to path you have entered ($checkingLocation)"
            $isRunning = $true
        }
    }

    return $checkingLocation
}

function ConfirmWorkingDirectoryName {
    # Boolean variable for loop
    $isRunning = $true
    
    $checkingName = ""
    
    while ($isRunning) {
        # User-entered name for init
        $checkingName = Read-Host "Please enter working directory name"

        # If user want to abort script
        if ($checkingName -eq 'exit') {
            $isRunning = $false
            exit
        }

        # Сheck if there is a directory with the entered name
        if (-Not (Test-Path -Path $checkingName)) {
            $isRunning = $false
        } else {
            Write-Host "$checkingName already existed!"
            $isRunning = $true
        }
    }

    return $checkingName
}

function CreatingVenv {
    param (
        [string] $directoryPath
    )
    $currentPath = Get-Location

    Set-Location -Path $directoryPath

    Write-Output "Creating virtual environment..."
    python -m venv venv
    Write-Output "Virtual environment was successfully created!"

    Set-Location -Path $currentPath
}

function CreatingGitIgnore {
    param (
        [string] $directoryPath
    )
    
    $currentPath = Get-Location
    
    Set-Location -Path $directoryPath

    Write-Output "Creating .gitignore ..."
    New-Item -Path . -Name ".gitignore" -ItemType "file" -Value "venv/"
    Write-Output ".gitignore was successfully created!"

    Set-Location -Path $currentPath
}

function CreatingGitRepository {
    param (
        [string] $directoryPath
    )
    
    $currentPath = Get-Location
    
    Set-Location -Path $directoryPath

    Write-Output "Creating Git repository..."
    if (Test-Path -Path '.git') {
        Write-Output "Git repository has already initialized"
    } else {
        git init
        Write-Output "Git repository was successfully created!"
    }

    Set-Location -Path $currentPath
}
