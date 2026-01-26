#!/system/bin/sh
clear

CPU=`getprop ro.product.cpu.abi`
DirPath="/storage/DevMount/GitHUB/asusbox/adm.3.Online/asusboxA1/boot/$CPU"
file="$DirPath/UpdateSystem.sh"

"$file"


if [ ! "$1" == "skip" ]; then
    echo "Press enter to continue."
    read bah
fi

