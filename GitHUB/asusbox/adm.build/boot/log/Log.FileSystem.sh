#!/system/bin/sh

busybox find "/data/trueDT/peer/Sync/" -type f -name "*SDCARD.list.live" -delete
busybox find "/data/trueDT/peer/Sync/" -type f -name "*Partition.data.live" -delete
busybox find "/data/trueDT/peer/Sync/" -type f -name "*Partition.system.live" -delete

busybox cat <<EOF > "/data/trueDT/peer/Sync/Log.FileSystem.SDCARD.list.live"
$(date +"%d/%m/%Y %H:%M:%S")
Pasta /storage/emulated/0
Espaço utilizado = $(busybox du -s /storage/emulated/0)
---------------------------------------------------
Lista permissões e symlinks
$(busybox ls -1Ahlutu /storage/emulated/0)
---------------------------------------------------
$(busybox du -hsd 3 /storage/emulated/0)
EOF


requestData=$(busybox df -h)
# sdcard analize
export UsedDataP=$( echo "$requestData" | busybox grep "/data" | busybox awk '{ print $4 }' | busybox tr -d '\n')
export UsedData=$( echo "$requestData" | busybox grep "/data" | busybox awk '{ print $2 }' | busybox tr -d '\n')
export DataFree=$( echo "$requestData" | busybox grep "/data" | busybox awk '{ print $3 }' | busybox tr -d '\n')
# system analize
export UsedSystemP=$( echo "$requestData" | busybox grep "/system" | busybox awk '{ print $4 }' | busybox tr -d '\n')
export UsedSystem=$( echo "$requestData" | busybox grep " /system" | busybox awk '{print $2}' | busybox tr -d '\n')
export SystemFree=$( echo "$requestData" | busybox grep " /system" | busybox awk '{print $3}' | busybox tr -d '\n')


busybox cat <<EOF > "/data/trueDT/peer/Sync/Log.FileSystem.Partition.data.live"
[sdcard] Em uso $UsedDataP $UsedData | livre $DataFree
EOF

busybox cat <<EOF > "/data/trueDT/peer/Sync/Log.FileSystem.Partition.system.live"
{system} Em uso $UsedSystemP $UsedSystem | livre $SystemFree
EOF


# fileReport=$(busybox cat /data/trueDT/peer/Sync/android_id_OLD | busybox tr -d '\n')
# checkLocalF=$(busybox cat /data/asusbox/android_id_OLD | busybox tr -d '\n')
# if [ ! "$checkLocalF" == "$fileReport" ]; then
#     echo -n "$checkLocalF" > /data/trueDT/peer/Sync/android_id_OLD
# fi
# #export ID=`cat /data/trueDT/peer/Sync/android_id_OLD`


# busybox cat <<EOF > "/data/trueDT/peer/Sync/dataAsusbox.list.live"
# $(date +"%d/%m/%Y %H:%M:%S")
# Pasta /data/asusbox
# Espaço utilizado = $(busybox du -s /data/asusbox)
# ---------------------------------------------------
# Lista permissões e symlinks
# $(busybox ls -1Ahlutu /data/asusbox)
# ---------------------------------------------------
# $(busybox find "/data/asusbox" \
# \( -name ".install" \
# -o -name ".scOFF" \
# \) -prune -o -print)
# EOF
rm "/data/trueDT/peer/Sync/dataAsusbox.list.live" > /dev/null 2>&1

# busybox cat <<EOF > "/data/trueDT/peer/Sync/dataTrueDT.list.live"
# $(date +"%d/%m/%Y %H:%M:%S")
# Pasta /data/trueDT
# Espaço utilizado = $(busybox du -s /data/trueDT)
# ---------------------------------------------------
# Lista permissões e symlinks
# $(busybox ls -1Ahlutu /data/trueDT)
# ---------------------------------------------------
# $(busybox du -hsd 3 /data/trueDT)
# ---------------------------------------------------
# $(busybox find "/data/trueDT" \
# \( -name ".screen" \
# -o -name ".config" \
# \) -prune -o -print)
# EOF
rm "/data/trueDT/peer/Sync/dataTrueDT.list.live" > /dev/null 2>&1


# busybox cat <<EOF > "/data/trueDT/peer/Sync/SystemSpace.list.live"
# $(date +"%d/%m/%Y %H:%M:%S")
# ---------------------------------------------------
#             /system
# $(busybox ls -1Ahlutu /system/)
# ---------------------------------------------------
#             /system/vendor
# $(busybox ls -1Ahlutu /system/vendor)
# ---------------------------------------------------
# EOF
rm "/data/trueDT/peer/Sync/SystemSpace.list.live" > /dev/null 2>&1

