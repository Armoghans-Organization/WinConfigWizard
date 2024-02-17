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





##########################################################################
# Main script logic
##########################################################################

Clear-Host
# Call the function to print the ASCII art banner
Write-Banner
# Pause for 2 seconds
Start-Sleep -Seconds 2
