# Docker
> Running on Windows 10 host


# State of project

The project is considered ready to use when all below marks are checked.

[More info about the planned tasks and features.](https://github.com/Toumash/webcon-oneline-server/issues/1)
- [x] Install Windows Server
- [x] Install prerequisites
- [x] Install webcon components
- [ ] Create database
- [ ] Start the workflow service
- [ ] Run BPSPortal
- [ ] Connect BPS Studio to the instance

# Running it

Currently the repo supports running the webcon server by two technologies:
* Vagrant
* Docker

The goal is to run everything in docker, but for the ease of development the vagrant box is being used. They are meant to share scripts files.

## Vagrant

1. Install prerequisites
```
choco install ruby vagrant
``` 
2. Run from elevated powershell
```
vagrant up --provision
```
## Docker
1. Make sure that hyper-v and virtualization is enabled on your machine (BIOS + Windows)
2. Run in Powershell following commands:
```
Enable-WindowsOptionalFeature -Online -FeatureName containers –All
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V –All
```
3. After reboot download Docker for Windows and install it
4. [Switch docker to Windows containers](https://sithummeegahapola.medium.com/docker-windows-containers-6a2d454114e)
5. In settings of the Docker Engine set[ `"experimental": true`](https://mresetar.github.io/2020-03-18-how-to-enable-docker-experimental-mode-on-windows/)

## Build it
1. Clone the repo.
2. Move your `WebconBPS.zip` to ./vendor repo dir.
3. Build and run using `docker compose up --build`

## Credentials

| Role            	| Login/Password  	|
|-----------------	|-----------------	|
| Windows Machine 	| vagrant/vagrant 	|
| SQL Server      	| sa/Vagrant42    	|


# Folders on the machine


| Path            	| Role  	|
|-----------------	|-----------------	|
| C:\install     	| Installation scripts 	|
| C:\vendor      	| Additional files that the dev need to provide to successfuly build the image/box    	|
