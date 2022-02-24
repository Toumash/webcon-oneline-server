
$Folder = 'C:\install\WebconBPS'
"Test to see if folder [$Folder]  exists"
if (!(Test-Path -Path $Folder)) {
    "WebconBPS.zip extracting..."
    Expand-Archive WebconBPS.zip -DestinationPath C:\install
    "WebconBPS.zip"
}

# $setupFile = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'setup.exe' } | Select-Object Fullname  -First 1
# & $setupFile[0].FullName --silent --sqlServer . --cfgDb --solrAdminUser root --solrAdminPassword root

$workflowService = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'WebCon.WorkFlow.Service.Installer.msi' } | Select-Object Fullname  -First 1
"WebCon.WorkFlow.Service.Installer.msi"
msiexec /i (Resolve-Path $workflowService[0].FullName) /QN /L*V C:\Temp\msilog.log /norestart

$bpsSearch = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'WebCon.WorkFlow.Service.Installer.msi' } | Select-Object Fullname  -First 1
"WebCon.BPSSearchServer.msi"
msiexec /i (Resolve-Path $bpsSearch[0].FullName) /QN /L*V C:\Temp\msilog.log /norestart

$bpsPortal = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'WebCon.BPSPortal.Standalone.msi' } | Select-Object Fullname  -First 1
"WebCon.BPSPortal.Standalone.msi"
msiexec /i (Resolve-Path $bpsPortal[0].FullName) /QN /L*V C:\Temp\msilog.log /norestart


$studio = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'StudioInstall.bat' } | Select-Object Fullname  -First 1
"StudioInstall.bat"
& $studio[0].FullName