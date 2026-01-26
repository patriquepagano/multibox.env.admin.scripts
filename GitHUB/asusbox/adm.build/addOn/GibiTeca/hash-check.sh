#!/system/bin/sh

FCheck="$(dirname $0)"

rm $FCheck/keys.hash > /dev/null 2>&1
/system/bin/busybox find $FCheck -type f \( -iname \*.sh -o -iname \*.ini -o -iname \.vars -o -iname \*.conf -o -iname fcgiserver \) | /system/bin/busybox sort | while read fname; do
    #echo "$fname"
    /system/bin/busybox md5sum "$fname" | /system/bin/busybox cut -d ' ' -f1 >> $FCheck/keys.hash 2>&1
done

/system/bin/busybox md5sum "$FCheck/keys.hash" | /system/bin/busybox cut -d ' ' -f1

