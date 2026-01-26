#!/system/bin/sh

# UNIQ DEVICE IDENTIFICATION
Placa=$(getprop ro.product.board)
CpuSerial=`busybox cat /proc/cpuinfo | busybox grep Serial | busybox awk '{ print $3 }'`
MacLanReal=`/system/bin/busybox cat /data/macLan.hardware | busybox sed 's;:;;g'`
DeviceName="$Placa=$CpuSerial=$MacLanReal"

echo -n "$DeviceName" > "/storage/emulated/0/Android/data/asusbox/.www/BoxIDNEW.txt"
if [ ! "$(cat "/storage/emulated/0/Android/data/asusbox/.www/BoxIDNEW.txt")" == "$(cat "/storage/emulated/0/Android/data/asusbox/.www/BoxID.txt")" ]; then
    ServerConfigPath="/data/trueDT/peer/config/config.xml"
    User=$(cat "$ServerConfigPath" | grep "<user>" | cut -d ">" -f 2 | cut -d "<" -f 1)
    curl -u "$User":"$User" "http://127.0.0.1:4442/qr/?text=$DeviceName" > "/storage/emulated/0/Android/data/asusbox/.www/BoxID.png"
    echo -n "$DeviceName" > "/storage/emulated/0/Android/data/asusbox/.www/BoxID.txt"
fi

# imagem qrcode para log web
echo '<img src="/BoxID.png" alt="" />' >> "/storage/emulated/0/Android/data/asusbox/.www/boot.log"
mkdir -p "/data/trueDT/peer/Sync/sh.all"
echo '<img src="/BoxID.png" alt="" />' > "/data/trueDT/peer/Sync/sh.all/news.log"


