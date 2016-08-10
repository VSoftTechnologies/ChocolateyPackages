$ErrorActionPreference = 'Stop'; #Stop on all errors

$packageName = 'finalbuilder' #Unique name of the package
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = '%PRODUCT_DOWNLOAD_URL%' #URL to download installer for current version. 
$url64 = ''
$silentArgs = '/SP /VERYSILENT /SUPPRESSMSGBOXES /CLOSEAPPLICATIONS' #Silent install arguments for our installer
$validExitCodes = @(0) #Valid return codes from the installer for success
$checksum = %RELEASE_SHA256_CHECKSUM%

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' #Installer is an executable. 
  url           = $url
  url64bit      = $url64
  
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  
  softwareName  = "FinalBuilder 8.*" #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  checksum      = $checksum
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512
  checksum64    = ''
  checksumType64= '' 
}

#Run chocolatey install package commandlet
Install-ChocolateyPackage $packageArgs