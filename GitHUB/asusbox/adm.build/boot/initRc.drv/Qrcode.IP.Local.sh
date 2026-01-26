#!/system/bin/sh

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

if [ "$LanIP" == "" ]; then
    export IPLocal="$WlanIP"
else
    export IPLocal="$LanIP"
fi

echo -n "http://$IPLocal" > "/storage/emulated/0/Android/data/asusbox/.www/IPLocalNEW.txt"

if [ ! "$(cat "/storage/emulated/0/Android/data/asusbox/.www/IPLocalNEW.txt")" == "$(cat "/storage/emulated/0/Android/data/asusbox/.www/IPLocal.txt")" ]; then
    ServerConfigPath="/data/trueDT/peer/config/config.xml"
    User=$(cat "$ServerConfigPath" | grep "<user>" | cut -d ">" -f 2 | cut -d "<" -f 1)
    curl -u "$User":"$User" "http://127.0.0.1:4442/qr/?text=http://$IPLocal" > "/storage/emulated/0/Android/data/asusbox/.www/IPLocal.png"
    echo -n "http://$IPLocal" > "/storage/emulated/0/Android/data/asusbox/.www/IPLocal.txt"	
fi

