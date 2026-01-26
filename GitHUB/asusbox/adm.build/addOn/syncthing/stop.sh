#!/system/bin/sh

function killsyncthing () {
checkPort=`/system/bin/busybox ps \
| /system/bin/busybox grep "syncthing" \
| /system/bin/busybox grep -v "grep" \
| /system/bin/busybox grep -v "stop.sh" \
| /system/bin/busybox awk '{print $1}' \
| /system/bin/busybox sed -e 's/[^0-9]*//g'`

echo $checkPort

    if [ ! "$checkPort" == "" ]; then
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### Desligando serviço syncthing"
        echo "ADM DEBUG ### syncthing rodando na porta $checkPort"
        /system/bin/busybox kill -9 $checkPort
    fi
}

killsyncthing



# desmontar o hdd usb
sync

### desmontar a montagem automatica ta bugando o android
Partition="B86AE59E6AE559A0"
mountPoint=`sm list-volumes | grep "$Partition" | cut -d " " -f 2`
if [ ! "$mountPoint" == "unmounted" ]; then
    mountPoint=`sm list-volumes | grep "$Partition" | cut -d ":" -f 2 | cut -d " " -f 1`
    sm unmount public:$mountPoint
fi


sm list-volumes
sync

echo "Pode desconectar o HDD $Partition"

