function base64encode () {
    resultBase64=`/system/bin/busybox cat "$1" | /system/bin/busybox base64`
}

function base64decode () {
    resultBase64=`/system/bin/busybox cat "$1" | /system/bin/busybox base64 -d`
}

