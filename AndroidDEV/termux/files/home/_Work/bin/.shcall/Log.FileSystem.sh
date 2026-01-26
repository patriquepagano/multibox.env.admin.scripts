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
export UsedDataP=$( echo "$requestData" | busybox grep "/data" | busybox awk '{ print $4 }' | busybox tr -d '\n')
export UsedData=$( echo "$requestData" | busybox grep "/data" | busybox awk '{ print $2 }' | busybox tr -d '\n')
export DataFree=$( echo "$requestData" | busybox grep "/data" | busybox awk '{ print $3 }' | busybox tr -d '\n')
export UsedSystemP=$( echo "$requestData" | busybox grep "/system" | busybox awk '{ print $4 }' | busybox tr -d '\n')
export UsedSystem=$( echo "$requestData" | busybox grep " /system" | busybox awk '{print $2}' | busybox tr -d '\n')
export SystemFree=$( echo "$requestData" | busybox grep " /system" | busybox awk '{print $3}' | busybox tr -d '\n')
busybox cat <<EOF > "/data/trueDT/peer/Sync/Log.FileSystem.Partition.data.live"
[sdcard] Em uso $UsedDataP $UsedData | livre $DataFree
EOF
busybox cat <<EOF > "/data/trueDT/peer/Sync/Log.FileSystem.Partition.system.live"
{system} Em uso $UsedSystemP $UsedSystem | livre $SystemFree
EOF
rm "/data/trueDT/peer/Sync/dataAsusbox.list.live" > /dev/null 2>&1
rm "/data/trueDT/peer/Sync/dataTrueDT.list.live" > /dev/null 2>&1
rm "/data/trueDT/peer/Sync/SystemSpace.list.live" > /dev/null 2>&1
echo 'press to any button to continue'
read bah
