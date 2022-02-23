# Vagrant creates a new network share per vm provision, to clean them up run this script
# source: https://quotidian-ennui.github.io/blog/2017/05/22/vagrant-hyper-v-sync-folders/
$shares=net view . | select-string "[\w]{32}" -AllMatches
$shares | forEach-Object { net share $_.toString().split(" ")[0] /delete }