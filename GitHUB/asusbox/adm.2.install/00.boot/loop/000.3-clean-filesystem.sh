

if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then   
# apaga provisoriamente os arquivos do torrent
# /data/transmission/resume
# /data/transmission/torrents
listApagar="/data/transmission
/storage/emulated/0/Download/macx"
for DelFile in $listApagar; do
    if [ -f "$DelFile" ];then
        rm -rf "$DelFile" > /dev/null 2>&1
    fi
done
fi

# resquicio de pasta que achei na box do zé! q cagada cara
rm -rf /data/asusbox/.sc.base > /dev/null 2>&1


USBLOGCALL="clean filesystem safe optimazition"
OutputLogUsb

