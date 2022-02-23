
$Folder = 'C:\install\WebconBPS'
"Test to see if folder [$Folder]  exists"
if (!(Test-Path -Path $Folder)) {
    "Expand Arhive, because its not extracted"
    Expand-Archive WebconBPS.zip -DestinationPath C:\install
}
$setupFile = Get-ChildItem -Recurse -Path $Folder | Where-Object { $_.Name -match 'setup.exe' } | Select-Object Fullname  -First 1
# Invoke-Expression $setupFile 
$setupFile
& $setupFile[0].FullName --silent --sqlServer --cfgDb --solrAdminUser --solrAdminPassword