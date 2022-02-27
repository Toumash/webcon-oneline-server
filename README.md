# Docker
> Running on Windows 10 host

## Prepare it
1. Make sure that hyper-v and virtualization is enabled.
2. Run in Powershell following commands:
```
Enable-WindowsOptionalFeature -Online -FeatureName containers –All
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V –All
```
3. After reboot download Docker for Windows and install it
4. Switch docker to Windows containers
5. In settings of the Docker Engine set `"experimental": true`

## Build it
1. Clone the repo.
2. Move your `WebconBPS.zip` to ./vendor repo dir.
3. Build and run using `docker compose up --build`

# Webcon DEV Vagrant Box
> Vagrant webcon provisioning template for developers.

**WORK IN PROGRESS**

# How to run?

1. Install prerequisites
```
choco install ruby vagrant
``` 
2. Run from elevated powershell
```
vagrant up --provision
```


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
