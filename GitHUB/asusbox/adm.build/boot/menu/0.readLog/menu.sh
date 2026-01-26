#!/system/bin/sh
function readLog () {
/system/bin/busybox cat "${0%/*}/log.txt"
}
while true; do
    sleep 1
    clear
    readLog
done

