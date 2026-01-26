#!/system/bin/sh

var="/storage/DevMount/GitHUB/"
echo "permissões para scripts em > $var"
/system/bin/busybox find $var -name "*.sh"|while read fname; do
    perms=`/system/bin/busybox stat -c '%a' "$fname"`
    if [ ! "$perms" == "700" ]; then
        echo "$fname"
        /system/bin/busybox chmod 700 "$fname"
    fi
done

var="/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/"
echo "permissões para scripts em > $var"
/system/bin/busybox find $var -name "*.sh"|while read fname; do
    perms=`/system/bin/busybox stat -c '%a' "$fname"`
    if [ ! "$perms" == "700" ]; then
        echo "$fname"
        /system/bin/busybox chmod 700 "$fname"
    fi
done





