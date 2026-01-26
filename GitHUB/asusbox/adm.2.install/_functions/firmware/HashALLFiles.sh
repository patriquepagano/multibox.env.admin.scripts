# check crc para testar escrita e loopa ate conseguir
function HashALLFiles() {
    /system/bin/busybox rm /data/tmp.hash >/dev/null 2>&1
    /system/bin/busybox find $1 -type f \( -iname \* \) | /system/bin/busybox sort | while read fname; do
        /system/bin/busybox md5sum "$fname" | /system/bin/busybox cut -d ' ' -f1 >>/data/tmp.hash 2>&1
    done
    export HashResult=$(/system/bin/busybox cat /data/tmp.hash)
    /system/bin/busybox rm /data/tmp.hash >/dev/null 2>&1
}

