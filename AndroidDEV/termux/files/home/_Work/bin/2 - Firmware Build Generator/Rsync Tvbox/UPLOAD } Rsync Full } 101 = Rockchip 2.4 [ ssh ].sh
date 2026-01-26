#!/system/bin/sh
clear
IP="10.0.0.101"
path=$( cd "${0%/*}" && pwd -P )
source "$path/function rsync upload to storage DevMount.SH"

if [ ! "$1" == "skip" ]; then
    echo "Press enter to continue."
    read bah
fi

