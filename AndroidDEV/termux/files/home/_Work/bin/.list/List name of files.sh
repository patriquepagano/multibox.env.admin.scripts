#!/system/bin/sh

if [ ! "$var" == "" ]; then
    /system/bin/busybox find "$var" -maxdepth 1 -type f -name "*" ! -name "listx" | sort | while read fname; do
        /system/bin/busybox basename "$fname"
    done
else
    echo 'Precisa dar o comando listx $PWD'
fi
