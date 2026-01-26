#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
export DateFirmwareInstall=`/system/bin/busybox stat -c '%y' /system/build.prop | /system/bin/busybox cut -d "." -f 1`
diaH=$(echo $DateFirmwareInstall | cut -d "-" -f 3 | cut -d " " -f 1)
mesH=$(echo $DateFirmwareInstall | cut -d "-" -f 2 | cut -d "-" -f 1)
anoH=$(echo $DateFirmwareInstall | cut -d "-" -f 1 | cut -d "-" -f 1)
horaH=$(echo $DateFirmwareInstall | cut -d " " -f 2)
export DateFirmwareInstallHuman=$(echo "$diaH/$mesH/$anoH $horaH")
export DateHardReset=`/system/bin/busybox stat -c '%y' /data/asusbox/android_id | /system/bin/busybox cut -d "." -f 1`
diaH=$(echo $DateHardReset | cut -d "-" -f 3 | cut -d " " -f 1)
mesH=$(echo $DateHardReset | cut -d "-" -f 2 | cut -d "-" -f 1)
anoH=$(echo $DateHardReset | cut -d "-" -f 1 | cut -d "-" -f 1)
horaH=$(echo $DateHardReset | cut -d " " -f 2)
export DateHardResetHuman=$(echo "$diaH/$mesH/$anoH $horaH")
busybox find "/data/trueDT/peer/Sync/" -type f -name "DateFirmwareInstall.atual" -delete
busybox find "/data/trueDT/peer/Sync/" -type f -name "DateHardReset.atual" -delete
if [ -f "/data/trueDT/peer/Sync/DateFirmwareInstall.log" ]; then
mv "/data/trueDT/peer/Sync/DateFirmwareInstall.log" "/data/trueDT/peer/Sync/Log.Firmware.Install.log"
fi
if [ -f "/data/trueDT/peer/Sync/DateHardReset.log" ]; then
mv "/data/trueDT/peer/Sync/DateHardReset.log" "/data/trueDT/peer/Sync/Log.Firmware.HardReset.log"
fi
ExpiryTime="/data/trueDT/peer/Sync/Log.Firmware.Install"
checkLocalF=$(busybox cat $ExpiryTime.atual | busybox tr -d '\n')
if [ ! "$checkLocalF" == "$DateFirmwareInstallHuman" ]; then
if [ ! -e "$ExpiryTime.log" ];then
busybox touch "$ExpiryTime.log"
fi
busybox sed -i \
"1 i\ Firmware instalando em: $DateFirmwareInstallHuman" \
"$ExpiryTime.log"
echo $DateFirmwareInstallHuman > "$ExpiryTime.atual"
fi
ExpiryTime="/data/trueDT/peer/Sync/Log.Firmware.HardReset"
checkLocalF=$(busybox cat $ExpiryTime.atual | busybox tr -d '\n')
if [ ! "$checkLocalF" == "$DateHardResetHuman" ]; then
if [ ! -e "$ExpiryTime.log" ];then
busybox touch "$ExpiryTime.log"
fi
busybox sed -i \
"1 i\ Hard Reset feito em: $DateHardResetHuman" \
"$ExpiryTime.log"
echo $DateHardResetHuman > "$ExpiryTime.atual"
fi
echo 'press to any button to continue'
read bah
