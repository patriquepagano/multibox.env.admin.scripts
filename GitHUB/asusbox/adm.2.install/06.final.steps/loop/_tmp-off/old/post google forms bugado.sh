
# desativei momentaneamente posso apagar mais facil pelo server syncthing
# # só consigo apagar depois de carregar o syncthing ou ele puxa do meu server
# # limpando minhas debugagems
# /system/bin/busybox find /data/trueDT/peer/Sync  -maxdepth 1 -name 'city*.log' | while read fname; do
#     rm "$fname" > /dev/null 2>&1
# done
# busybox rm /data/trueDT/peer/Sync/data.log > /dev/null 2>&1
# busybox rm /data/trueDT/peer/Sync/ExpiryTime.log > /dev/null 2>&1

# ## upload registro box
# FileMark=/system/RegisterUUID
# if [ ! -e $FileMark ] ; then
# DeviceID=`/system/bin/initRc.drv.05.08.98 -device-id -home=/data/trueDT/peer/config/`
# Gform=1xv3jd_OkKglHljQ2hU_WI562fyv78SpqOLK-LFugXoo
# while [ 1 ]; do
#     CheckCurl=`/system/bin/curl -w "%{http_code}" -k https://docs.google.com/forms/d/$Gform/formResponse \
#     -d ifq \
#     -d entry.888911116="$DeviceID" \
#     -d entry.729880858="$DateFirmwareInstall" \
#     -d entry.1968457322="$DateHardReset" \
#     -d submit=Submit`
#     export httpCode=`echo -n "$CheckCurl" | tail -c 3`
#     if [ "$httpCode" == "200" ]; then break; fi; # check return value, break if successful (0)
#     sleep 3;
# done;
# /system/bin/busybox mount -o remount,rw /system
# echo -n $DeviceID > $FileMark
# fi
