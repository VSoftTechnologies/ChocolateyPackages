$ErrorActionPreference = 'Stop'; #Stop on all errors

$packageName = 'finalbuilder' #Unique name of the package
$registryUninstallerKeyName = '{62D2B81F-145D-4926-A198-449B18290ABD}_is1' #The uninstall registry key for our application. Defined and setup by the installer exe.
$installerType = 'EXE' #Our uninstaller is also an executable
$silentArgs = '/SILENT /VERYSILENT /SUPPRESSMSGBOXES' #Silent arguments to make the uninstaller not show any GUI
$validExitCodes = @(0) #Valid return codes from the uninstaller for success

$shouldUninstall = $true; #We should uninstall if we detect no errors. 
 
#Keys where our uninstall data is stored in registry
$local_key       = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName"
$local_key6432   = "HKCU:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName"
$machine_key     = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName"
$machine_key6432 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName"

#Try each key. The first to return a valid path, and key get the UninstallString value from it. 
$file = @($local_key, $local_key6432, $machine_key, $machine_key6432) `
    | ?{ Test-Path $_ } `
    | Get-ItemProperty `
    | Select-Object -ExpandProperty UninstallString

#If we don't have a valid uninstall executable, then error and don't run uninstall. 
if ($file -eq $null -or $file -eq '') {
    Write-Host "$packageName has already been uninstalled by other means."
    $shouldUninstall = $false
}
	
#If we are still uninstalling then call chocolatey uninstall package commandlet to run our uninstaller
if ($shouldUninstall) {
 Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -SilentArgs "$silentArgs" -validExitCodes $validExitCodes -File "$file"
}