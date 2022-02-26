# New-WebSite -Name "Default Web Site" -Port 80 -HostHeader webcon-web  -PhysicalPath "C:\inetpub\wwwroot\" -Force

function webcon-install {
    $Folder = 'C:\WebconBPS'
    Expand-Archive -LiteralPath C:\WebconBPS.zip -DestinationPath C:\
    $workflowService = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'WebCon.WorkFlow.Service.Installer.msi' } | Select-Object Fullname  -First 1
    msiexec /i (Resolve-Path $workflowService[0].FullName) /QN /L*V C:\msilog.log /norestart
    $bpsSearch = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'WebCon.WorkFlow.Service.Installer.msi' } | Select-Object Fullname  -First 1
    msiexec /i (Resolve-Path $bpsSearch[0].FullName) /QN /L*V C:\msilog.log /norestart
    $bpsPortal = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'WebCon.BPSPortal.Standalone.msi' } | Select-Object Fullname  -First 1
    msiexec /i (Resolve-Path $bpsPortal[0].FullName) /QN /L*V C:\msilog.log /norestart
    $studio = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'StudioInstall.bat' } | Select-Object Fullname  -First 1
    & $studio[0].FullName
}