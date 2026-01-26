#!/system/bin/sh
clear

# Get installed packages
pm list packages -3 -e


# fileio não é confiavel abrorta isto

# $ curl -F "file=@test.txt" https://file.io

# cp "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/1 - Apps/1 - ScreenShot.png" \
#     /data/local/tmp/fc2bb07b-d467-4474-ac4d-79c38333dfd0.sh

# /system/usr/bin/curl -F "file=@/data/local/tmp/fc2bb07b-d467-4474-ac4d-79c38333dfd0.sh" https://file.io
#/system/usr/bin/curl -s -F "file=@/data/local/tmp/fc2bb07b-d467-4474-ac4d-79c38333dfd0.sh" https://file.io



if [ ! "$1" == "skip" ]; then
    echo "Press enter to continue."
    read bah
fi


