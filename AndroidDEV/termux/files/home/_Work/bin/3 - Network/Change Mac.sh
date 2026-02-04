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
echo $IPLocal > "$path/ip_current.txt"
echo $IPLocal



# # desativa a interface eth0
# /system/bin/busybox ifconfig eth0 down

# # altera o endereço MAC da interface eth0
# /system/bin/busybox ifconfig eth0 hw ether 9c:00:d3:cc:84:3f

# # ativa novamente a interface eth0
# /system/bin/busybox ifconfig eth0 up

/system/bin/busybox ifconfig \
| /system/bin/busybox grep eth0 \
| /system/bin/busybox grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' \
| /system/bin/busybox tr 'A-F' 'a-f'

if [ ! "$1" = "skip" ]; then
    echo "Press any key to exit."
    read -r bah
fi






