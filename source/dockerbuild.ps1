function prerequisites {
    Set-ExecutionPolicy RemoteSigned
    Expand-Archive -LiteralPath C:\WebconBPS.zip -DestinationPath C:\WebconBPS
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Install-Module -Name SqlServer -Force
    Invoke-WebRequest -Uri "https://download.visualstudio.microsoft.com/download/pr/cf7b17e3-ed6d-4ded-8ae6-9f83ffaaca98/9d2ca844baa4a4a9ed83861ffc8e293e/dotnet-hosting-2.1.30-win.exe" -OutFile "C:\\dotnet-hosting-2.1-win.exe"
    Start-Process -FilePath "C:\dotnet-hosting-2.1-win.exe" -ArgumentList "/quiet","/norestart" -NoNewWindow -Wait -PassThru
}

function webcon-install {
    Start-Sleep -s 30

    $Folder = 'C:\WebconBPS'
    Invoke-Sqlcmd -Query "CREATE DATABASE BPS_Config" -ServerInstance "sqlserver" -Username "sa" -Password "webc0n.BPS"
    $createScript = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'Create_CfgDB.sql' } | Select-Object Fullname  -First 1
    Invoke-Sqlcmd -InputFile (Resolve-Path $createScript[0].FullName) -Database BPS_Config -ServerInstance "sqlserver" -Username "sa" -Password "webc0n.BPS"

    Invoke-Sqlcmd -Query "CREATE DATABASE BPS_Content" -ServerInstance "sqlserver" -Username "sa" -Password "webc0n.BPS"
    $createScript = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'Create_MainDB.sql' } | Select-Object Fullname  -First 1
    Invoke-Sqlcmd -InputFile (Resolve-Path $createScript[0].FullName) -Database BPS_Content -ServerInstance "sqlserver" -Username "sa" -Password "webc0n.BPS"

    $setup = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'setup.exe' } | Select-Object Fullname  -First 1
    Start-Process -wait -FilePath (Resolve-Path $setup[0].FullName) -ArgumentList '--silent','--sqlServer sqlserver','--cfgDb BPS_Config','--solrAdminUser solr','--solrAdminPassword qwerty','--sqlLogin sa','--sqlPassword webc0n.BPS'
    # $workflowService = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'WebCon.WorkFlow.Service.Installer.msi' } | Select-Object Fullname  -First 1
    # msiexec /i (Resolve-Path $workflowService[0].FullName) /QN /L*V C:\msilog.log /norestart
    # 'WebCon.WorkFlow.Service.Installer.msi'
    # $bpsSearch = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'WebCon.WorkFlow.Service.Installer.msi' } | Select-Object Fullname  -First 1
    # msiexec /i (Resolve-Path $bpsSearch[0].FullName) /QN /L*V C:\msilog.log /norestart
    # 'WebCon.WorkFlow.Service.Installer.msi'
    # $bpsPortal = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'WebCon.BPSPortal.Standalone.msi' } | Select-Object Fullname  -First 1
    # msiexec /i (Resolve-Path $bpsPortal[0].FullName) /QN /L*V C:\msilog.log /norestart
    # 'WebCon.BPSPortal.Standalone.msi'
    # $studio = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'StudioInstall.bat' } | Select-Object Fullname  -First 1
    # & $studio[0].FullName
    # 'StudioInstall.bat'
}