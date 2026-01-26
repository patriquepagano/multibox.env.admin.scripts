#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )
IPLocalNow=$($path/checkIPLocal.sh)
LastIP=`busybox cat /data/trueDT/peer/Sync/LocationIPlocal.atual`
#QrcodeIP="/data/trueDT/assets/QrcodeIP.png"
QrcodeIP="/storage/emulated/0/Android/data/asusbox/.www/qrIP.png"
#QrcodeIP="/storage/DevMount/GitHUB/asusbox/adm.build/www/qrIP.png"

if [ ! -e $QrcodeIP ]; then
    /system/bin/curl --output $QrcodeIP "http://127.0.0.1:4442/qr/?text=http://$IPLocalNow"
fi

if [ ! "$IPLocalNow" == "$LastIP" ]; then
    echo -n "$IPLocalNow" > /data/trueDT/peer/Sync/LocationIPlocal.atual
    /system/bin/curl --output $QrcodeIP "http://127.0.0.1:4442/qr/?text=http://$IPLocalNow"
fi

