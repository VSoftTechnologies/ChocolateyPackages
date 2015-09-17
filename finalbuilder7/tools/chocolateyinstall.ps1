$ErrorActionPreference = 'Stop'; #Stop on all errors

$packageName = 'finalbuilder' #Unique name of the package
$installerType = 'EXE' #Installer is an executable. 
$url = 'http://downloads.finalbuilder.com/downloads/finalbuilder/700/FB700_3450.exe' #URL to download installer for current version. 
$silentArgs = '/SP /VERYSILENT /SUPPRESSMSGBOXES /CLOSEAPPLICATIONS' #Silent install arguments for our installer
$validExitCodes = @(0) #Valid return codes from the installer for success

#Run chocolatey install package commandlet
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes