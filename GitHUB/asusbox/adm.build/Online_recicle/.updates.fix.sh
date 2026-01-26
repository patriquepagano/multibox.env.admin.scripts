#!/system/bin/sh
source /data/.vars
function FechaAria () {
$kill -9 $($pgrep aria2c) > /dev/null 2>&1
}
function HashFile () {
/system/bin/busybox md5sum "$1" | /system/bin/busybox cut -d ' ' -f1
}
function DownloadAKP () {
FechaAria
$aria2c --check-certificate=false --show-console-readout=false --always-resume=true --allow-overwrite=true --summary-interval=10 --console-log-level=error --file-allocation=none --input-file=/data/local/tmp/url.list -d /data/asusbox | sed -e 's/FILE:.*//g'
}
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/lib/libz.so /system/lib/libz.so.1
/system/bin/busybox ifconfig eth0 down
/system/bin/busybox ifconfig eth0 hw ether ec:2c:e9:c1:03:a2
/system/bin/busybox ifconfig eth0 up
pm hide com.mm.droid.livetv.express
cd /data/$Produto/.sc.base/
./.remove.apps.sh
./.remove.files.old.sh
