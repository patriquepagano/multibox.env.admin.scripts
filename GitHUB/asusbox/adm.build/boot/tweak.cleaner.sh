#!/system/bin/sh



echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### limpando virus e rootkits"
busybox rm -rf /data/local/tmp/* > /dev/null 2>&1
busybox rm -rf /data/local/tmp/.* > /dev/null 2>&1

# virus porre
checkPort=`/system/bin/busybox pidof storm`
if [ ! "$checkPort" == "" ];then
    /system/bin/busybox kill $checkPort
    echo "ADM DEBUG ### virus rodando na porta $checkPort"
    /system/bin/busybox mount -o remount,rw /system
    rm /system/bin/storm
    rm /system/bin/install-recovery.sh
    rm /system/etc/init/storm.rc
    rm /system/etc/storm.key
    echo "NO!" > /system/bin/storm
    busybox chmod 400 /system/bin/storm
fi
if [ -f /system/bin/storm ]; then
echo "virus encontrado deletando"
    checkPort=`/system/bin/busybox pidof storm`
    /system/bin/busybox kill $checkPort
    /system/bin/busybox mount -o remount,rw /system
    rm /system/bin/storm
    rm /system/bin/install-recovery.sh
    rm /system/etc/init/storm.rc
    rm /system/etc/storm.key
    du -h /system/bin/storm
fi


# Init-script le este arquivo para desativar todas as launchers no boot
# Apaga o arquivo marcador das launchers para que um novo seja feito no processo de boot.sh > UpdateSystem.sh
rm /data/asusbox/LauncherList > /dev/null 2>&1

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### apaga arquivo que geralmente serve para reboot em caso de modificação de sistema"

listApagar="/data/trueDT/peer/Sync/Location.atual
/data/trueDT/peer/Sync/dataAsusbox.list.live
/data/asusbox/reboot
/data/asusbox/com.mm.droid.livetv.express.manutentionV1
/data/asusbox/firstboot.ok
/data/asusbox/com.xyz.fullscreenbrowser-Dump.Log
/data/asusbox/com.asusbox.asusboxiptvbox-Dump.Log
/data/asusbox/as.02.akp.aria2
/data/asusbox/as.02.akp
/data/asusbox/as.02.DTF
/data/asusbox/as.03.DTF
/data/asusbox/as.04.akp
/data/local/tmp/APPList
/data/local/tmp/PackList
/data/data/com.not.aa_image_viewer/cache/*
/data/trueDT/peer/Sync/DataSpace.in.Use.log
/data/trueDT/peer/Sync/SystemSpace.in.Use.log
/storage/emulated/0/TopTVLauncherPreferences*.ttv2
/storage/emulated/0/*.exe
/storage/emulated/0/*.pdf
/storage/emulated/0/*.mp4
/storage/emulated/0/*.png
/storage/emulated/0/*.jpg"
# apaga arquivos!
for DelFile in $listApagar; do    
    if [ -e "$DelFile" ];then
        busybox rm "$DelFile" > /dev/null 2>&1
    fi
done

listApagar="/data/asusbox/.cache
/storage/emulated/0/.tmp
/storage/emulated/0/mfc
/storage/emulated/0/Download/.install
/storage/emulated/0/Android/data/com.mixplorer
/storage/emulated/0/Download/00.snib
/storage/emulated/0/Download/01.sc
/storage/emulated/0/Download/03.akp.base
/storage/emulated/0/Download/04.akp.oem
/storage/emulated/0/Download/05.akp.cl
/storage/emulated/0/Download/07.dev
/storage/emulated/0/time4popcorn
/storage/emulated/0/DCIM"
# apaga diretorios!
for DelFolder in $listApagar; do    
    if [ -d "$DelFolder" ];then
        busybox rm -rf "$DelFolder" > /dev/null 2>&1
    fi
done



listApagar="/system/asusbox
/system/priv-app/DeviceTest
/system/priv-app/StressTest"
for delfolder in $listApagar; do
    if [ -d $delfolder ];then
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### Limpando a priv-app antigos asusbox"
        echo $delfolder
        /system/bin/busybox mount -o remount,rw /system
        rm -rf $delfolder
        # vai precisar reiniciar pois /data/data/app e os icones na launcher ficam apos estas remoção direta
        #echo -n 'ok' > /data/asusbox/reboot
    fi
done


# # 
# if [ ! -e /data/asusbox/SenhaIPTV ]; then
# 	# redireciona os users para novo updatesystem assim toda instalação nova vai para o boot novo
# fi

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### limpando a mensagem de online do rootsudaemon antigo sistema"
service call notification 1
cmd statusbar collapse





# echo "ADM DEBUG ##############################################################"
# echo "ADM DEBUG ### permissoes da pasta install 700 pastas 600 para arquivos"
# # acertando as permissoes locais


# # novo teste:
# # baixar via torrent e verificar quais são as permissões e se baixa a data de criação dos arquivos
# # enviar via rsync mantendo permissoes e datas
# seedBox="/data/asusbox/.install"
# /system/bin/busybox chown -R root:root $seedBox
# /system/bin/busybox find $seedBox -type d -exec chmod 700 {} \; 
# /system/bin/busybox find $seedBox -type f -exec chmod 600 {} \;


# update salvar o code find acima para uso em outra coisa.

# resolvido o lance das permissoes com o umask do torrent





