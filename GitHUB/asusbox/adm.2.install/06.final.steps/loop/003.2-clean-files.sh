

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### Limpando arquivos lista fora do pack sh local"
listApagar="/data/trueDT/peer/Sync/udp.clock.blocked.by.isp.live
/data/trueDT/peer/Sync/UniqIDentifier.Partitions
/data/trueDT/peer/Sync/UniqIDentifier.LibModules
/data/trueDT/peer/Sync/UniqIDentifier.env
/data/trueDT/peer/Sync/UniqIDentifier.lsmod
/data/trueDT/peer/Sync/UniqIDentifier.WiFi
/data/trueDT/peer/Sync/UniqIDentifier.atual
/data/trueDT/peer/Sync/UniqID.atual
/data/trueDT/peer/Sync/UniqIDentifier.FirmwareID
/data/trueDT/peer/Sync/UniqIDentifier.FirmwareInfo
/data/trueDT/peer/Sync/UniqIDentifier.FirmwareSoft
/data/trueDT/peer/Sync/UniqIDentifier.FirmwareUID
/data/trueDT/peer/Sync/UniqIDentifier.Hardware"
# apaga arquivos!
for DelFile in $listApagar; do
    if [ -e "$DelFile" ];then
        busybox rm "$DelFile" > /dev/null 2>&1
    fi
done


# se a box for um user BoxListBetaInstallers não limpa arquivos cache antigos
checkUserAcess=`echo "$BoxListBetaInstallers" | grep "$Placa=$CpuSerial=$MacLanReal"`
if [ "$checkUserAcess" == "" ]; then
echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### apaga arquivos com mais de 7 dias perfeito para limpar o cache dos apps"
/system/bin/busybox find "/storage/emulated/0/Android" -type f -mtime +7 \
! -path "*/data/asusbox*" \
! -path "*/data/trueDT*" \
! -name "*.nomedia*" \
! -name "*journal*" \
! -name "*.db-journal*" \
! -name "*.db*" \
! -name "*deviceToken*" \
! -name "*.dat*" \
-name "*" \
| while read fname; do
    #busybox du -hs "$fname"
    busybox rm "$fname"
done
fi


# se a box for de um user BoxListBetaInstallers não sera apagado apks no sdcard
checkUserAcess=`echo "$BoxListBetaInstallers" | grep "$Placa=$CpuSerial=$MacLanReal"`
if [ "$checkUserAcess" == "" ]; then
/system/bin/busybox find "/storage/emulated/0/" -type f -name "*.apk" \
| while read fname; do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Limpando apks temporários deixado por updates"
    #Fileloop=`basename $fname`
    echo "eu vou apagar este arquivo > $fname"
    rm -rf "$fname"
done
fi

fileMark="/storage/emulated/0/Download/.nomedia"
if [ ! -e $fileMark ]; then
    mkdir -p /storage/emulated/0/Download
    touch $fileMark
fi

echo "apagar diretorios em branco"
for i in $(seq 1 7); do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Limpando a pastas vazias em /sdcard"
    /system/bin/busybox find "/storage/emulated/0/" -type d -exec /system/bin/busybox rmdir {} + 2>/dev/null
done


echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### apaga arquivo que geralmente serve para reboot em caso de modificação de sistema"
rm /data/asusbox/reboot > /dev/null 2>&1


echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### apaga updates de apps que deu ruim"
rm -rf /data/app/vmdl*.tmp

# virus porre
/data/asusbox/.sc/boot/anti-virus.sh


USBLOGCALL="clean files, optimize fs, check fs"
OutputLogUsb


