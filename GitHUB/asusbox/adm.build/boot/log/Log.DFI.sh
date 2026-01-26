#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )

# %x     Time of last access
# %X     Time of last access as seconds since Epoch
# %y     Time of last modification
# %Y     Time of last modification as seconds since Epoch
# %z     Time of last change
# %Z     Time of last change as seconds since Epoch

# function getTimeCreation () {
# /system/bin/busybox stat -c '%y' "$File" | /system/bin/busybox cut -d "." -f 1
# /system/bin/busybox stat -c '%Y' "$File" | /system/bin/busybox cut -d "." -f 1
# systemTime=`/system/bin/busybox stat -c '%y' "$File" | /system/bin/busybox cut -d "." -f 1`
# epochTime=`/system/bin/busybox stat -c '%Y' "$File" | /system/bin/busybox cut -d "." -f 1`
# }



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


# echo "ADM DEBUG ##########################################################################################################"
# echo "ADM DEBUG ##########################################################################################################"
# echo "ADM DEBUG ### Clean old files"
busybox find "/data/trueDT/peer/Sync/" -type f -name "DateFirmwareInstall.atual" -delete
busybox find "/data/trueDT/peer/Sync/" -type f -name "DateHardReset.atual" -delete
if [ -f "/data/trueDT/peer/Sync/DateFirmwareInstall.log" ]; then
    mv "/data/trueDT/peer/Sync/DateFirmwareInstall.log" "/data/trueDT/peer/Sync/Log.Firmware.Install.log"
fi
if [ -f "/data/trueDT/peer/Sync/DateHardReset.log" ]; then
    mv "/data/trueDT/peer/Sync/DateHardReset.log" "/data/trueDT/peer/Sync/Log.Firmware.HardReset.log"
fi


FirmwareMarkDate=`/system/bin/busybox stat -c '%Y' "/system/build.prop" | /system/bin/busybox cut -d "." -f 1`
FirmwareMarkLog=`/system/bin/busybox stat -c '%Y' "/data/trueDT/peer/Sync/Log.Firmware.Install.atual" | /system/bin/busybox cut -d "." -f 1`
if [ ! "$FirmwareMarkDate" == "$FirmwareMarkLog" ]; then
    echo "ADM DEBUG ##########################################################################################################"
    echo "ADM DEBUG ### Alterando marcador firmware date "
    /system/bin/busybox touch -r "/system/build.prop" "/data/trueDT/peer/Sync/Log.Firmware.Install.atual"
fi

HardResetMarkDate=`/system/bin/busybox stat -c '%Y' "/data/asusbox/android_id" | /system/bin/busybox cut -d "." -f 1`
HardResetMarkLog=`/system/bin/busybox stat -c '%Y' "/data/trueDT/peer/Sync/Log.Firmware.HardReset.atual" | /system/bin/busybox cut -d "." -f 1`
if [ ! "$HardResetMarkDate" == "$HardResetMarkLog" ]; then
    echo "ADM DEBUG ##########################################################################################################"
    echo "ADM DEBUG ### Alterando marcador HardReset date "
    /system/bin/busybox touch -r "/data/asusbox/android_id" "/data/trueDT/peer/Sync/Log.Firmware.HardReset.atual"
fi



echo "ADM DEBUG ##########################################################################################################"
echo "ADM DEBUG ##########################################################################################################"
echo "ADM DEBUG ### LOGS RELATORIOS DE INSTALAÇÃO "
echo "ADM DEBUG ### system = $DateFirmwareInstall"
echo "ADM DEBUG ### PT-BR  = $DateFirmwareInstallHuman"

ExpiryTime="/data/trueDT/peer/Sync/Log.Firmware.Install"
checkLocalF=$(busybox cat $ExpiryTime.atual | busybox tr -d '\n')
if [ ! "$checkLocalF" == "$DateFirmwareInstallHuman" ]; then
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### registro de log de instalação"
        if [ ! -e "$ExpiryTime.log" ];then
            busybox touch "$ExpiryTime.log"
        fi
    busybox sed -i \
    "1 i\ Firmware instalando em: $DateFirmwareInstallHuman" \
    "$ExpiryTime.log"
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### grava horario direto do stat"
    echo $DateFirmwareInstallHuman > "$ExpiryTime.atual"
fi

echo "ADM DEBUG ##########################################################################################################"
echo "ADM DEBUG ##########################################################################################################"
echo "ADM DEBUG ### LOGS RELATORIOS DE HardReset"
echo "ADM DEBUG ### system = $DateHardReset"
echo "ADM DEBUG ### PT-BR  = $DateHardResetHuman"

ExpiryTime="/data/trueDT/peer/Sync/Log.Firmware.HardReset"
checkLocalF=$(busybox cat $ExpiryTime.atual | busybox tr -d '\n')
if [ ! "$checkLocalF" == "$DateHardResetHuman" ]; then
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### registro de log de Hard Reset"
        if [ ! -e "$ExpiryTime.log" ];then
            busybox touch "$ExpiryTime.log"
        fi
    busybox sed -i \
    "1 i\ Hard Reset feito em: $DateHardResetHuman" \
    "$ExpiryTime.log"
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### grava horario direto do stat"
    echo $DateHardResetHuman > "$ExpiryTime.atual"
fi

