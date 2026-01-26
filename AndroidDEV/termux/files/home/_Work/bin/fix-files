#!/system/bin/sh

var="/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/"
echo "permissões para scripts em > $var"

/system/bin/busybox find $var -type f ! -name "*.ldb" ! -name "*.log" -name "*"|while read fname; do
    perms=`/system/bin/busybox stat -c '%a' "$fname"`
    if [ ! "$perms" == "700" ]; then
        echo "$fname"
        /system/bin/busybox chmod 700 "$fname"
    fi
done

/system/bin/busybox find $var -type d -name "*"|while read fname; do
    perms=`/system/bin/busybox stat -c '%a' "$fname"`
    if [ ! "$perms" == "700" ]; then
        echo "$fname"
        /system/bin/busybox chmod 755 "$fname"
    fi
done

cd $var
lx



