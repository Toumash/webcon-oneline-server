FROM mcr.microsoft.com/windows:20H2

RUN dism /online /enable-feature /all /featurename:iis-webserver /NoRestart

RUN powershell.exe -command "Set-ExecutionPolicy RemoteSigned"

RUN powershell.exe -command Invoke-WebRequest -Uri "https://download.visualstudio.microsoft.com/download/pr/cf7b17e3-ed6d-4ded-8ae6-9f83ffaaca98/9d2ca844baa4a4a9ed83861ffc8e293e/dotnet-hosting-2.1.30-win.exe" -OutFile "C:\\dotnet-hosting-2.1-win.exe"
RUN powershell.exe -command Start-Process -FilePath "C:\dotnet-hosting-2.1-win.exe" -ArgumentList "/quiet","/norestart" -NoNewWindow -Wait -PassThru

#RUN netsh advfirewall set allprofiles state off
COPY source/dockerbuild.ps1 C:/dockerbuild.ps1
RUN powershell.exe -command "& { . C:\\dockerbuild.ps1; webcon-install }"

CMD [ "ping", "localhost", "-t" ]