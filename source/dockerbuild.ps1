# New-WebSite -Name "Default Web Site" -Port 80 -HostHeader webcon-web  -PhysicalPath "C:\inetpub\wwwroot\" -Force

function webcon-install {
    $Folder = 'C:\WebconBPS'
    if (!(Test-Path -Path $Folder)) {
        "WebconBPS.zip extracting..."
        Expand-Archive -LiteralPath C:\vendor\WebconBPS.zip -DestinationPath C:\WebconBPS
        "WebconBPS.zip extracted"
    }
    $workflowService = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'WebCon.WorkFlow.Service.Installer.msi' } | Select-Object Fullname  -First 1
    msiexec /i (Resolve-Path $workflowService[0].FullName) /QN /L*V C:\msilog.log /norestart
    'WebCon.WorkFlow.Service.Installer.msi'

    $bpsSearch = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'WebCon.WorkFlow.Service.Installer.msi' } | Select-Object Fullname  -First 1
    msiexec /i (Resolve-Path $bpsSearch[0].FullName) /QN /L*V C:\msilog.log /norestart
    'WebCon.WorkFlow.Service.Installer.msi'

    $bpsPortal = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'WebCon.BPSPortal.Standalone.msi' } | Select-Object Fullname  -First 1
    msiexec /i (Resolve-Path $bpsPortal[0].FullName) /QN /L*V C:\msilog.log /norestart
    'WebCon.BPSPortal.Standalone.msi'

    $studio = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'StudioInstall.bat' } | Select-Object Fullname  -First 1
    & $studio[0].FullName
    'StudioInstall.bat'
}