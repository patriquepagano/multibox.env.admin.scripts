#!/system/bin/sh


/system/bin/busybox ifconfig | /system/bin/busybox grep -v 'P-t-P' | /system/bin/busybox grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | /system/bin/busybox grep -Eo '([0-9]*\.){3}[0-9]*' | /system/bin/busybox grep -v '127.0.0.1'

ifconfig | grep eth0 | awk '{ print $5 }'
ifconfig | grep wlan0 | awk '{ print $5 }'










exit


/data/asusbox/adm.debugs/debug/led7loop.sh &

echo "script sendo executado ok"



LOGFILE=/data/asusbox/bah.log

echo "$TR_TORRENT_NAME is completed" > "$LOGFILE"

echo Directory is "$TR_TORRENT_DIR" >> "$LOGFILE"
echo Torrent Name is "$TR_TORRENT_NAME" >> "$LOGFILE"
echo Torrent ID is "$TR_TORRENT_ID" >> "$LOGFILE"
echo Torrent Hash is "$TR_TORRENT_HASH" >> "$LOGFILE"

# TR_TORRENT_DIR
# TR_TORRENT_NAME
# TR_TORRENT_ID
# TR_TORRENT_HASH
# TR_TIME_LOCALTIME
# TR_APP_VERSION

exit


a melhor ideia de fila para não fragmentar a memoria e estourar conexões simultaneas!
1 - a box chama o torrent dos binarios
2 - na finalização o script chama o proximo torrent
    $TR_TORRENT_NAME.sh dentro faria um call para chamar o proximo torrent para baixar e no ultimo depois chama o sistema de chaveamento.




path="/storage/149F-0ADC/Backup/*.apk"
for loop in $path; do
echo "$loop"
pm install -r "$loop"
done




