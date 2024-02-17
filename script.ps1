<#
.SYNOPSIS
  This PowerShell script configures the Windows environment by removing unnecessary bloatware, installing required tools, and more.	
.DESCRIPTION
	"WinConfigWizard" is a PowerShell script for automating and optimizing new Windows installations, providing customization, security, and performance enhancements.
.EXAMPLE
	PS> ./script.ps1
.LINK
	https://github.com/Armoghans-Organization/WinConfigWizard
.NOTES
   File Name      : script.ps1
   Author         : Armoghan-ul-Mohmin
   Copyright 2024 - Armoghan-ul-Mohmin
#>

# Check if the script is running with Administrator privileges; if not, restart with elevated privileges
if (-not ([System.Security.Principal.WindowsPrincipal][System.Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
    # Restart script with elevated privileges
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

##########################################################################
# Functions
##########################################################################

function Write-Banner {
    # Define the hardcoded ASCII art banner
    $hardcodedBanner = @"

  ====================================================================================================================
  =  ====  ====  ================     ================    ===============  ====  ====  ============================  =
  =  ====  ====  ===============  ===  ==============  ==  ==============  ====  ====  ============================  =
  =  ====  ====  ==============  ====================  ==================  ====  ====  ============================  =
  =  ====  ====  =  =  = ======  ========   ==  = ==    ====  ==   ======  ====  ====  =  =      ==   ==  =   =====  =
  =   ==    ==  =====     =====  =======     =     ==  ========  =  =====   ==    ==  =========  =  =  =    =  ==    =
  ==  ==    ==  ==  =  =  =====  =======  =  =  =  ==  =====  ==    ======  ==    ==  ==  ====  =====  =  ======  =  =
  ==  ==    ==  ==  =  =  =====  =======  =  =  =  ==  =====  ====  ======  ==    ==  ==  ===  ====    =  ======  =  =
  ===    ==    ===  =  =  ======  ===  =  =  =  =  ==  =====  =  =  =======    ==    ===  ==  ====  =  =  ======  =  =
  ====  ====  ====  =  =  =======     ===   ==  =  ==  =====  ==   =========  ====  ====  =      ==    =  =======    =
  ==================================================================================================================== 

"@
    $BannerInfo = @"
            Welcome WinConfigWizard - My Windows Setup Script.
            Author: Armoghan-ul-Mohmin                                  
            Version: 1.0.0                                              
            Url: https://github.com/Armoghans-Organization/WinConfigWizard   
"@

    # Print the colored ASCII art banner to the console
    Write-Host $hardcodedBanner -ForegroundColor Red
    Write-Host "      ------------------------------------------------------------------------"
    Write-Host $BannerInfo -ForegroundColor Blue
    Write-Host "      ------------------------------------------------------------------------"
    Write-Host
}

function Install-Chocolatey {
    # Check if Chocolatey is installed
    $chocoInstalled = Get-Command choco -ErrorAction SilentlyContinue

    if ($chocoInstalled -eq $null) {
        # Chocolatey is not installed; download and install
        Write-Host -ForegroundColor Yellow "Chocolatey is not installed. Installing Chocolatey..."

        # Define the temporary folder path
        $tempFolder = [System.IO.Path]::GetTempPath()
        $installerPath = Join-Path -Path $tempFolder -ChildPath "ChocolateyInstall.ps1"

        # Download Chocolatey installer to the temporary folder
        Invoke-WebRequest -Uri "https://chocolatey.org/install.ps1" -OutFile $installerPath

        # Install Chocolatey
        Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression "& '$installerPath'"

        # Check if Chocolatey installation was successful
        $chocoInstalled = Get-Command choco -ErrorAction SilentlyContinue
        if ($chocoInstalled -eq $null) {
            Write-Host -ForegroundColor Red "Failed to install Chocolatey."
        }
        else {
            Write-Host -ForegroundColor Green "Chocolatey has been successfully installed."
        }

        # Remove the installer file after installation
        Remove-Item $installerPath -ErrorAction SilentlyContinue
    }
    else {
        # Chocolatey is already installed
        Write-Host -ForegroundColor Green "Chocolatey is already installed."
    }
}



##########################################################################
# Main script logic
##########################################################################

Clear-Host
# Call the function to print the ASCII art banner
Write-Banner
# Pause for 2 seconds
Start-Sleep -Seconds 2
# Call the function to check and install Chocolatey if necessary
Install-Chocolatey
# Add a line break for readability
Write-Host

