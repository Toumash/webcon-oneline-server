# Cookbook Name:: main
# Recipe:: default
#

batch "disable-firewall" do
  code <<-EOH
      @echo off
      echo Disabling firewall
      netsh advfirewall set allprofiles state off
      EOH
end

windows_feature "Web-Server" do
  all true
  action :install
  install_method :windows_feature_powershell
end

windows_feature "Web-Mgmt-Tools" do
  all true
  action :install
  install_method :windows_feature_powershell
end

powershell_script "install .net core hosting bundle" do
  code <<-EOH
      Write-Host "Hosting Bundle: Installing..."
      $WebClient = New-Object System.Net.WebClient
      $WebClient.DownloadFile("https://download.visualstudio.microsoft.com/download/pr/cf7b17e3-ed6d-4ded-8ae6-9f83ffaaca98/9d2ca844baa4a4a9ed83861ffc8e293e/dotnet-hosting-2.1.30-win.exe","C:\install\dotnet-hosting-2.1-win.exe")
      $args = New-Object -TypeName System.Collections.Generic.List[System.String]
      $args.Add("/quiet")
      $args.Add("/norestart")
      Start-Process -FilePath "C:\install\dotnet-hosting-2.1-win.exe" -ArgumentList $args -NoNewWindow -Wait -PassThru
      # New-WebSite -Name "Default Web Site" -Port 80 -HostHeader webcon-web  -PhysicalPath "C:\inetpub\wwwroot\" -Force
      Write-Host "Hosting Bundle: Installed"
      EOH
end
