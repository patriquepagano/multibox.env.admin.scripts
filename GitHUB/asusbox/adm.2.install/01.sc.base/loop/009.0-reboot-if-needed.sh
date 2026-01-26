
if [ ! -f /system/etc/init/initRc.adm.drv.rc ]; then
    if [ -f "/data/asusbox/reboot" ];then
        killTransmission
        rm /data/asusbox/reboot
        USBLOGCALL="reboot if needed"
        OutputLogUsb
        am start -a android.intent.action.REBOOT
        sleep 60
        exit
    fi
fi



