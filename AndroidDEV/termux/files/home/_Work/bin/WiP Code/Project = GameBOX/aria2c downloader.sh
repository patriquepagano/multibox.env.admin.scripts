#!/system/bin/sh
source /data/asusbox/.sc.base/vars.sh

$kill -9 $($pgrep aria2c) > /dev/null 2>&1

path="/data/$Produto"
$find $path -name "*.sh"|while read fname; do
#echo $fname
$chmod 755 $fname
done

echo "Download iniciado por favor aguarde" > "$www/boot.log"

/system/bin/busybox mount -o remount,rw /system

tor="/storage/emulated/0/Download/Crash.Of.The.Titans.cso.torrent"
path="/system"
/system/bin/busybox mount -o remount,rw /system
$aria2c --summary-interval=2147483647 --console-log-level=error --bt-enable-lpd=true --enable-dht6=false --seed-time=0 \
 --allow-overwrite=true --file-allocation=none -d $path -T $tor >> "$www/boot.log" 2>&1

# path sem a barra no final / ex. path="/system"
# ativar o --bt-enable-lpd=true mesmo sem internet encontra o peer local mas DEMORA um pouco
# [#66567c 432MiB/585MiB(73%) CN:1 SD:1 DL:3.4MiB ETA:43s] < copiando de rede local sem internet e sem webseeds
 


exit
--summary-interval=1

$aria2c --download-result=hide -V 

--console-log-level=<LEVEL>
Set log level to output to console. LEVEL is either debug, info, notice, warn or error. Default: notice

