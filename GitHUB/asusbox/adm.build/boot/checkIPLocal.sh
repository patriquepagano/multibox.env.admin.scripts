#!/system/bin/sh

function CheckIPLocal () {
WlanIP=`/system/bin/busybox ip addr show wlan0 \
| /system/bin/busybox grep "inet " \
| /system/bin/busybox awk '{print $2}' \
| /system/bin/busybox cut -d "/" -f 1 \
| /system/bin/busybox head -1`

LanIP=`/system/bin/busybox ip addr show eth0 \
| /system/bin/busybox grep "inet " \
| /system/bin/busybox awk '{print $2}' \
| /system/bin/busybox cut -d "/" -f 1 \
| /system/bin/busybox head -1`

# echo "Lista de IPs
# Se o IP da wlan não estiver disponivel pega o da lan
# WlanIP  $WlanIP
# LanIP   $LanIP
# "
if [ "$LanIP" == "" ]; then
    export IPLocal="$WlanIP"
else
    export IPLocal="$LanIP"
fi
}

CheckIPLocal
echo $IPLocal
