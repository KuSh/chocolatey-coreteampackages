﻿$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$file = 'graphviz-install-2.44.1-win32.exe'
$file64 = 'graphviz-install-2.44.1-win64.exe'

$packageArgs = @{
  packageName    = 'graphviz'
  fileType       = 'exe'
  file           = "$toolsPath\$file"
  file64         = "$toolsPath\$file64"
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'graphviz cmake (stable)'
}

Install-ChocolateyPackage @packageArgs
Remove-Item $toolsPath\*.exe -ea 0

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

@('dot') |ForEach-Object {Install-BinFile $_ "$installLocation\bin\$_.exe"}
