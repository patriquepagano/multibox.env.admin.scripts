#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )

/system/bin/busybox mount -o remount,rw /system
rm /system/.pin


/system/bin/busybox find "$path" -name "*.sh" ! -name "1 STOP ALL HERE !!!.sh" | sort | while read fname; do
    echo "$fname"
    sh "$fname"
    sleep 1
done

if [ ! "$1" == "skip" ]; then
    echo "Press any key to exit."
    read bah
fi

