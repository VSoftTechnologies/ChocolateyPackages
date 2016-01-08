﻿$ErrorActionPreference = 'Stop'; #Stop on all errors

$packageName = 'automiserunner' #Unique name of the package
$installerType = 'EXE' #Installer is an executable. 
$url = 'http://downloads.automise.com/downloads/automise/400/AutomiseRunner400_852.exe' #URL to download installer for current version. 
$silentArgs = '/SP /VERYSILENT /SUPPRESSMSGBOXES /CLOSEAPPLICATIONS' #Silent install arguments for our installer
$validExitCodes = @(0) #Valid return codes from the installer for success

#Run chocolatey install package commandlet
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes