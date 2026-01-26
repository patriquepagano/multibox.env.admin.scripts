#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
function WriteLog () {
if [ "$(busybox cat $FileMark)" == "" ]; then
echo "$CMDFn" > $FileMark
else
busybox sed -i "1 i\ $CMDFn" $FileMark
fi
NEWLogSwp=`busybox cat $FileMark | busybox head -n$1`
echo -n "$NEWLogSwp" > $FileMark
}
LogRealtime="/data/trueDT/peer/Sync/LogRealtime.live"
SyncID=`busybox cat /data/trueDT/peer/TMP/serial.live`
checkUptime=`busybox uptime | busybox awk '{ print substr ($0, 11 ) }' | busybox cut -d "," -f 1`
bootLog="/storage/emulated/0/Android/data/asusbox/.www/boot.log"
CpuSerial=`busybox cat /proc/cpuinfo | busybox grep Serial | busybox awk '{ print $3 }'`
FirmwareVer=`busybox blkid | busybox sed -n '/system/s/.*UUID=\"\([^\"]*\)\".*/\1/p'`
MacLanReal=`/system/bin/busybox cat /data/macLan.hardware`
MacWiFiReal=`/system/bin/busybox ifconfig | /system/bin/busybox grep wlan0 | /system/bin/busybox awk '{ print $5 }'`
IPLocalAtual=`/system/bin/busybox cat /data/trueDT/peer/Sync/LocationIPlocal.atual`
DateFirmwareInstallHuman=`cat /data/trueDT/peer/Sync/Log.Firmware.Install.atual | busybox tr -d '\n'`
DateHardResetHuman=`cat /data/trueDT/peer/Sync/Log.Firmware.HardReset.atual | busybox tr -d '\n'`
requestData=$(busybox df -h)
DataFree=$( echo "$requestData" | busybox grep "/data" | busybox awk '{ print $3 }' | busybox tr -d '\n')
SystemFree=$( echo "$requestData" | busybox grep " /system" | busybox awk '{print $3}' | busybox tr -d '\n')
OnScreenNow=`dumpsys window windows | grep mCurrentFocus | cut -d " " -f 5 | cut -d "/" -f 1`
echo -n "$OnScreenNow" > "/data/trueDT/peer/Sync/App.in.use.live"
FileMark="/data/trueDT/peer/Sync/App.in.use.log"
CMDFn=`echo "$(date +"%d/%m/%Y %H:%M:%S")\
| $OnScreenNow"`
WriteLog "16"
rm "/data/trueDT/peer/Sync/App.list.live" > /dev/null 2>&1
FileMark="/data/trueDT/peer/Sync/UserRealtimeData.log"
CMDFn=`echo "$(date +"%d/%m/%Y %H:%M:%S")\
|cpu $CpuSerial\
|mac $MacLanReal\
|$IPLocalAtual\
| $(busybox cat /data/trueDT/peer/Sync/LocationGeoIP.v6.atual)\
|D $DataFree\
|S $SystemFree\
|$checkUptime\
"`
WriteLog "100"
echo "<h4>
Sistema instalado em : $DateFirmwareInstallHuman
Reinstalado em       : $DateHardResetHuman</h4>
<h3>Firmware       : $FirmwareVer
CPU            : $CpuSerial
Mac Lan        : $MacLanReal
Mac WiFi       : $MacWiFiReal
IP Local       : $IPLocalAtual
SERIAL         : <b>$(echo $SyncID | busybox sed 's/.\{32\}$//')</b></h3>
<h4>Sistema atualizado! : $(date +"%d/%m/%Y %H:%M:%S")
Obs: Conexão via cabo de rede sempre é melhor!</h4>
" > $bootLog 2>&1
echo 'press to any button to continue'
read bah
