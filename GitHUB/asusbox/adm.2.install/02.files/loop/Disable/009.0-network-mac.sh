

export MacLanReal=`/system/bin/busybox ifconfig | /system/bin/busybox grep eth0 | /system/bin/busybox awk '{ print $5 }'`
export MacWiFiReal=`/system/bin/busybox ifconfig | /system/bin/busybox grep wlan0 | /system/bin/busybox awk '{ print $5 }'`
export IPLocalAtual=`/system/bin/busybox ifconfig | /system/bin/busybox grep -v 'P-t-P' | /system/bin/busybox grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | /system/bin/busybox grep -Eo '([0-9]*\.){3}[0-9]*' | /system/bin/busybox grep -v '127.0.0.1'`


echo "ADM DEBUG ###########################################################"
echo "ADM DEBUG ### ativando mac oficial para emulação clone"
/data/asusbox/.sc/OnLine/mac.sh


