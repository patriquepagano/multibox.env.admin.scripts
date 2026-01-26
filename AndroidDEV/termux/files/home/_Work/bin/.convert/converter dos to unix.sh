#!/system/bin/sh

if [ ! "$var" == "" ]; then
    /system/bin/busybox find $var -name "*.sh"|while read fname; do
        echo "$fname"
        /system/bin/busybox dos2unix -u "$fname"
    done
else
    echo 'Precisa dar o comando convertx $PWD'
fi




