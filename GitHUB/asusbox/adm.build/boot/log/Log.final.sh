
path=$( cd "${0%/*}" && pwd -P )

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


LogRealtime="/data/trueDT/peer/Sync/LogRealtime.live"


FirmwareFullSpecsID=`busybox cat /data/trueDT/peer/Sync/FirmwareFullSpecsID`
Placa=$(getprop ro.product.board)
CpuSerial=`busybox cat /proc/cpuinfo | busybox grep Serial | busybox awk '{ print $3 }'`
MacLanReal=`/system/bin/busybox cat /data/macLan.hardware | /system/bin/busybox sed 's;:;;g'`


checkUptime=`busybox uptime | busybox awk '{ print substr ($0, 11 ) }' | busybox cut -d "," -f 1`
bootLog="/storage/emulated/0/Android/data/asusbox/.www/boot.log"

IPLocalAtual=`/system/bin/busybox cat /data/trueDT/peer/Sync/LocationIPlocal.atual`

DateFirmwareInstallHuman=`cat /data/trueDT/peer/Sync/Log.Firmware.Install.atual | busybox tr -d '\n'`
DateHardResetHuman=`cat /data/trueDT/peer/Sync/Log.Firmware.HardReset.atual | busybox tr -d '\n'`

requestData=$(busybox df -h)
DataFree=$( echo "$requestData" | busybox grep "/data" | busybox awk '{ print $3 }' | busybox tr -d '\n')
SystemFree=$( echo "$requestData" | busybox grep " /system" | busybox awk '{print $3}' | busybox tr -d '\n')


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



echo "ADM DEBUG ##########################################################################################################"
echo "ADM DEBUG ##########################################################################################################"
echo "ADM DEBUG ### UserRealtimeData.log"

FileMark="/data/trueDT/peer/Sync/UserRealtimeData.log"
CMDFn=`echo "$(date +"%d/%m/%Y %H:%M:%S")\
|$IPLocalAtual\
| $(busybox cat /data/trueDT/peer/Sync/LocationGeoIP.v6.atual)\
|D $DataFree\
|S $SystemFree\
|$checkUptime\
"`
WriteLog "100"

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### gerando log para a interface web "
#DownloadStorage=`busybox du -hs $EXTERNAL_STORAGE/Download`
echo "<h4>
Sistema instalado em : $DateFirmwareInstallHuman
Reinstalado em       : $DateHardResetHuman
</h4>
<h3>
IP Local       : $IPLocalAtual
Firmware       : <b>$FirmwareFullSpecsID</b>
KEY         : <b>$Placa=$CpuSerial=$MacLanReal</b>
</h3>
<h4>Sistema atualizado! : $(date +"%d/%m/%Y %H:%M:%S")
Obs: Conexão via cabo de rede sempre é mais rápido!</h4>
" > $bootLog 2>&1






