

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### limpar os apps da system do firmware asusbox"
listApagar="/system/app/com.anysoftkeyboard.languagepack.brazilian_4.0.516.apk
/system/app/com.menny.android.anysoftkeyboard_1.10.606.apk
/system/app/com.mixplorer.apk
/system/app/me.kuder.diskinfo.apk
/system/app/notify.apk
/system/app/quickboot.apk"
for delFile in $listApagar; do    
    if [ -f $delFile ];then
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### Limpando a System apps antigos asusbox"
        echo $delFile
        /system/bin/busybox mount -o remount,rw /system
        rm -rf $delFile
        # vai precisar reiniciar pois /data/data/app e os icones na launcher ficam apos estas remoção direta
        #echo -n 'ok' > /data/asusbox/reboot
    fi
done



# pm disable com.hal9k.notify4scripts.Notify

USBLOGCALL="cleaning apps"
OutputLogUsb

