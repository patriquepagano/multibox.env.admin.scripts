
if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then
    if [ ! -f /data/asusbox/fullInstall ]; then 
        am start -n jackpal.androidterm/.Term
    fi
fi

USBLOGCALL="start usb logging"
OutputLogUsb






