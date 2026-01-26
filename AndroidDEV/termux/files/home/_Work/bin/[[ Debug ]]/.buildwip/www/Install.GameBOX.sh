#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear
#############################################################################################################################
# --- > parar todos os serviços
echo "Desligando transmission torrent downloader"
/system/bin/transmission-remote --exit
killall transmission-daemon

function killcron () {
checkPort=`/system/bin/busybox ps \
| /system/bin/busybox grep "/system/bin/busybox crond" \
| /system/bin/busybox grep -v "grep" \
| /system/bin/busybox awk '{print $1}' \
| /system/bin/busybox sed -e 's/[^0-9]*//g'`
    if [ ! "$checkPort" == "" ]; then
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### Desligando serviço cron"
        echo "ADM DEBUG ### cron rodando na porta $checkPort"
        /system/bin/busybox kill -9 $checkPort
    else
        echo "Cron dont running"    
    fi
}

killcron

#############################################################################################################################
KillApp=`/system/bin/busybox ps aux | grep UpdateSystem.sh | /system/bin/busybox grep -v grep | awk '{print $1}'`
if [ "$KillApp" == "" ]; then
    echo "Update system dont running"
else
    /system/bin/busybox kill -9 $KillApp
fi
#############################################################################################################################
php=`busybox ps aux | grep "php-cgi" | busybox grep -v grep | busybox awk '{print $1}'`
for port in $php; do
	busybox kill -9 $port
done
lighttpd=`busybox ps aux | grep "lighttpd" | busybox grep -v grep | busybox awk '{print $1}'`
for port in $lighttpd; do
	busybox kill -9 $port
done


#############################################################################################################################
# --- > copiar launcher para /system/app
/system/bin/busybox mount -o remount,rw /system
rm "/system/app/acr.browser.barebones_4.5.1.apk"

# baixar online a launcher travado em loop

/system/bin/busybox mount -o remount,rw /system
/system/bin/busybox cp "/storage/DevMount/4Android/App/www.apk.hosted/{Simple TV Launcher} [org.cosinus.launchertv] (1.5.3).apk" "/system/app/launcher.apk"
/system/bin/busybox chmod 644 "/system/app/launcher.apk"




#############################################################################################################################
# --- > remover apps um por vez caso o cliente resete no meio do procedimento
remove=`pm list packages -3 | /system/bin/busybox sed -e 's/.*://' | /system/bin/busybox sort \
| /system/bin/busybox grep -v "com.termux"`
# echo "$remove"
for loop in $remove; do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Desistalando app > $loop"
    pm uninstall $loop
done

#############################################################################################################################
# --- > limpar arquivos data
rm -rf /data/asusbox
rm -rf /data/apps2sd
rm -rf /data/apps2sd-log
rm -rf /data/trueDT

#############################################################################################################################
# --- > limpar init service
/system/bin/busybox mount -o remount,rw /system
rm /system/etc/init/initRc.drv.01.01.97.rc
rm /system/bin/initRc.drv.01.01.97

# apagar antigo init do sei lá oque é isto
rm /system/etc/init/initRc.drv.05.08.98.rc
rm /system/bin/initRc.drv.05.08.98



#############################################################################################################################
# --- > fechando o root
/system/bin/busybox mount -o remount,rw /system
echo "cleaned banned! 6a987ds687ads6f87as9d8" > /system/.pin


#############################################################################################################################
# --- > limpar data files
rm /system/media/bootanimation.zip
rm /system/vendor/pemCerts.7z
rm /system/android_id
rm /system/Firmware_Info
rm /system/p2pWebUi.v1.0.log
rm /system/p2pWebUi.v2.0.log
rm /system/UUID

#############################################################################################################################
# --- > Reset final
am broadcast -a android.intent.action.MASTER_CLEAR




exit

[] Launcher não existe na instalação inicial oque fazer?


#############################################################################################################################
# --- > limpar arquivos da system
/system/bin/busybox mount -o remount,rw /system
rm -rf /system/.install
rm -rf /system/usr/bin
rm -rf /system/usr/lib/bash
rm -rf /system/usr/lib/p7zip




[x] parar todos servicos na box
[x] copiar launcher para /system/app
[x] remover apps um por vez caso o cliente resete no meio do procedimento
[x] limpar binarios instalados
[x] limpar arquivos da system
[x] limpar imagems de boot
[x] limpar bootscreen inicial asusbox
[x] limpar init service
[] 


