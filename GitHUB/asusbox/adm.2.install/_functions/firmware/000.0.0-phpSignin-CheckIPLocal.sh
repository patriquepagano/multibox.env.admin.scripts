
# checkup do script para saber se é nosso para rodar
if [ "$1" == "675asd765da4s567f4asd4f765ads4f675a4ds6f754ads6754fa657ds4f675ads467f5ads" ]; then
    echo "Certified.BOOT"
    exit
fi


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


# IPLocal=`/system/bin/busybox ifconfig \
# | /system/bin/busybox grep -v 'P-t-P' \
# | /system/bin/busybox grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' \
# | /system/bin/busybox grep -Eo '([0-9]*\.){3}[0-9]*' \
# | /system/bin/busybox grep -v '127.0.0.1' \
# | /system/bin/busybox head -3`

echo "ADM DEBUG ###########################################################"
echo "ADM DEBUG ### aguardando receber algum ip para interface"
while [ 1 ]; do
    CheckIPLocal
    if [ ! "$IPLocal" = "" ]; then break; fi;
    sleep 1;
done;


echo "primeiro try IPlocal"
CheckIPLocal

