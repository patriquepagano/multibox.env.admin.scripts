
# função para reduzir o tamanho do log
function WriteLog () {
    if [ "$(busybox cat $FileMark)" == "" ]; then
        echo "ADM DEBUG ##########################################################################################################"
        echo "ADM DEBUG ### need first file"
        echo "$CMDFn" > $FileMark
    else
        echo "ADM DEBUG ##########################################################################################################"
        echo "ADM DEBUG ### send result to first line"
        busybox sed -i "1 i\ $CMDFn" $FileMark
    fi
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Reduz numero de linhas do log $FileMark"
    NEWLogSwp=`busybox cat $FileMark | busybox head -n$1`
    echo -n "$NEWLogSwp" > $FileMark
}


echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### generate log FileSystem ( Log.FileSystem.sh)"

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


check=`busybox blkid | busybox grep "sd"`
if [ ! "$check" == "" ]; then
	# desta maneira nunca apaga o arquivo de registro. mesmo se o drive tenha sido removido
	echo "External File detected in: $(date +"%d/%m/%Y %H:%M:%S")" > "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "---" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "block info" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "$check" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "---" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "mounted" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "$(busybox mount | busybox grep 'sd')" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "$(busybox mount | busybox grep 'vold')" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "---" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "space" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "$(busybox df -P -h | busybox grep 'vold')" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
	echo "$(busybox df -P -h | busybox grep 'sd')" >> "/data/trueDT/peer/Sync/Log.ExternalDrivers.live"
fi


echo "ADM DEBUG ##########################################################################################################"
echo "ADM DEBUG ##########################################################################################################"
echo "ADM DEBUG ### LOGS Uso de Apps"

OnScreenNow=`dumpsys window windows | grep mCurrentFocus | cut -d " " -f 5 | cut -d "/" -f 1`
echo -n "$OnScreenNow" > "/data/trueDT/peer/Sync/App.in.use.live"

FileMark="/data/trueDT/peer/Sync/App.in.use.log"
CMDFn=`echo "$(date +"%d/%m/%Y %H:%M:%S")\
| $OnScreenNow"`
WriteLog "16"

# # apps abertos! perfeito para rodar no boot quando a box liga
# AppListRunning=`dumpsys window windows | grep "Window #" | sed -e "s/.*u0 //g" -e "s/\/.*//g" -e "s/}://g"`
# echo -n "$AppListRunning" > "/data/trueDT/peer/Sync/AppListRunning.in.use.live"

# busybox cat <<EOF > "/data/trueDT/peer/Sync/App.list.live"
# $(date +"%d/%m/%Y %H:%M:%S")
# $(pm list packages -3 | sed -e 's/.*://' | sort)
# EOF
rm "/data/trueDT/peer/Sync/App.list.live" > /dev/null 2>&1
rm "/data/trueDT/peer/Sync/UserRealtimeData.log" > /dev/null 2>&1


