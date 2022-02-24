
$Folder = 'C:\install\WebconBPS'
"Test to see if folder [$Folder]  exists"
if (!(Test-Path -Path $Folder)) {
    "[*] START: Expand Archive, because its not extracted"
    Expand-Archive WebconBPS.zip -DestinationPath C:\install
    "[*] DONE: WebconBPS.zip"
}

# $setupFile = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'setup.exe' } | Select-Object Fullname  -First 1
# & $setupFile[0].FullName --silent --sqlServer . --cfgDb --solrAdminUser root --solrAdminPassword root

$serviceInstaller = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'WebCon.WorkFlow.Service.Installer.msi' } | Select-Object Fullname  -First 1
"[*] DONE: WebCon.WorkFLow.Service.Installer.msi"
msiexec /i (Resolve-Path $serviceInstaller[0].FullName) /QN /L*V C:\Temp\msilog.log /norestart


$bpsPortal = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'WebCon.BPSPortal.Standalone.msi' } | Select-Object Fullname  -First 1
"[*] DONE: WebCon.BPSPortal.Standalone.msi"
msiexec /i (Resolve-Path $bpsPortal[0].FullName) /QN /L*V C:\Temp\msilog.log /norestart


$studio = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'StudioInstall.bat' } | Select-Object Fullname  -First 1
"[*] DONE: StudioInstall.bat"
& $bpsPortal[0].FullName