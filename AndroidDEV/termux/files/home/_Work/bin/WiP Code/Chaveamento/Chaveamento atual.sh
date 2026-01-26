#!/system/bin/sh
path="$( cd "${0%/*}" && pwd -P )"
clear


# 01-11-365-4936-3020-6481-1413

RevendedorCode="01"
ProdutoCode="11"
ValidadeAcesso="365"
Serial="4936-3020-6481-1413"

# Lista de IPs em ordem de prioridade, primeiro que responder seta a variavel
IPs=(
  "http://10.0.0.15:4848"
  "http://10.0.0.11:4848"
  "http://10.0.0.29:4848"
  "http://66.175.210.64:4646"
)

ServerAPI=""

for url in "${IPs[@]}"; do
  ip=$(echo "$url" | cut -d/ -f3 | cut -d: -f1)
  if ping -c1 -W1 "$ip" &>/dev/null; then
    ServerAPI="$url"
    break
  fi
done

# Se nenhum IP respondeu
if [ -z "$ServerAPI" ]; then
  echo "Nenhum servidor respondeu. Encerrando."
  exit 1
fi

echo "ServerAPI: $ServerAPI"


# padrão do chaveamento
# rk30sdk=90e49e092c39962b=A8190AFD5EFC

Placa=$(getprop ro.product.board)
CpuSerial=`busybox cat /proc/cpuinfo | busybox grep Serial | busybox awk '{ print $3 }'`
MacLan=`/system/bin/busybox cat /data/macLan.hardware | busybox sed 's;:;;g'`
DeviceName="$Placa=$CpuSerial=$MacLan"


#( mostrou no asubox e xiaomi termux )
export MacWiFiReal=`busybox iplink show wlan0 | busybox grep "link/ether" | busybox awk '{ print $2 }'` #  | busybox sed -e 's/:/-/g'
#export CpuSerial=`busybox cat /proc/cpuinfo | busybox grep Serial | busybox awk '{ print $3 }'`

# informação variavel
export FirmwareVer=`busybox blkid | busybox sed -n '/system/s/.*UUID=\"\([^\"]*\)\".*/\1/p'`
export ID=`settings get secure android_id`
export IPLocalAtual=`/system/bin/busybox ifconfig \
| /system/bin/busybox grep -v 'P-t-P' \
| /system/bin/busybox grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' \
| /system/bin/busybox grep -Eo '([0-9]*\.){3}[0-9]*' \
| /system/bin/busybox grep -v '127.0.0.1' \
| /system/bin/busybox head -1`


UsedData=$(busybox df -h | busybox grep "/data" | busybox awk '{ print $4 }' | busybox tr -d '\n')
UsedSystem=$(busybox df -h | busybox grep "/system" | busybox awk '{ print $4 }' | busybox tr -d '\n')

checkUptime=`busybox uptime | busybox awk '{ print substr ($0, 11 ) }' | busybox cut -d "," -f 1`
SizeCheckTotalSpace=`busybox df -hTa`
SizeSystemInstall=`busybox du -hs /system/.install`
SizeSdcard0Install=`busybox du -hs /storage/emulated/0/Download/AsusBOX-UPDATE`

SystemFlog=`busybox ls -1Ahlutu /system`
DataFlog=`busybox ls -1Ahlutu /data`
DataHomeFlog=`busybox ls -1Ahlutu /data/asusbox`
ListBlockDevices=`busybox blkid`
ListMountedDevices=`busybox mount | busybox grep "/storage/" | busybox grep "/dev/fuse" | busybox grep -v "/storage/emulated" | busybox cut -d " " -f 3`

if [ "$ListMountedDevices" == "" ]; then
	UsingMountedDevices="no"
else
	UsingMountedDevices="yes"
fi

ListUSBDevices=`busybox lsusb | busybox grep -v "1d6b:0001" | busybox grep -v "1d6b:0002"`
ListDataAsusbox=`busybox find "/data/asusbox" \
\( -name ".install" \
-o -name ".sc" \
\) -prune -o -print`


ListSdcard0=`busybox find "/storage/emulated/0" \
\( -name "AsusBOX-UPDATE" \
-o -name ".www" \
-o -name "com.vanced.android.youtube" \
-o -name "com.integration.unitviptv" \
-o -name "com.zze.iptvbsatip" \
-o -name "com.mixplorer" \
\) -prune -o -print`



#rm "/data/Serial" # debug pois o serial é gerado no server
# # ler o serial
if [ -f "/data/Serial" ]; then
export LocalSerial=`/system/bin/busybox cat /data/Serial`
fi




# # funciona bem mas é impossivel enviar data e upload arquivo ao mesmo tempo
# # unica pratica de segurança seria restringir extensões e criar uma ext. maluca e cota por arquivo
# cp /system/app/notify.apk "/data/$DeviceName.zip"
# curl -X POST -F "arquivo=@/data/$DeviceName.zip" "$IPTest/upload.php"


# limpando variaveis com aspas
MacWiFiReal=`busybox iplink show wlan0 | busybox grep "link/ether" | busybox awk '{ print $2 }' | busybox sed 's;:;;g'`
FirmwareInstall=`busybox cat /data/trueDT/peer/Sync/Log.Firmware.Install.atual | busybox sed "s;';;g"`
FirmwareInstallUnix=`busybox stat -c '%Y' /system/build.prop`
FirmwareInstallLOG=`busybox cat /data/trueDT/peer/Sync/Log.Firmware.Install.log | busybox sed "s;';;g"`
FirmwareHardReset=`busybox cat /data/trueDT/peer/Sync/Log.Firmware.HardReset.atual | busybox sed "s;';;g"`
FirmwareHardResetUnix=`busybox stat -c '%Y' /data/asusbox/android_id`
FirmwareHardResetLOG=`busybox cat /data/trueDT/peer/Sync/Log.Firmware.HardReset.log | busybox sed "s;';;g"`
LocationGeoIP=`busybox cat /data/trueDT/peer/Sync/LocationGeoIP.v6.atual | busybox sed "s;';;g"`
FirmwareFullSpecs=`busybox cat /data/trueDT/peer/Sync/FirmwareFullSpecs.sh | busybox sed "s;';;g"`
FirmwareFullSpecsID=`busybox cat /data/trueDT/peer/Sync/FirmwareFullSpecsID | busybox sed "s;';;g"`
AppInUse=`busybox cat /data/trueDT/peer/Sync/App.in.use.live | busybox sed "s;';;g"`
AppInUseLOG=`busybox cat /data/trueDT/peer/Sync/App.in.use.log | busybox sed "s;';;g"`
ExternalDrivers=`busybox cat /data/trueDT/peer/Sync/Log.ExternalDrivers.live | busybox sed "s;';;g"`
FileSystemPartitionData=`busybox cat /data/trueDT/peer/Sync/Log.FileSystem.Partition.data.live | busybox sed "s;';;g"`
FileSystemPartitionSystem=`busybox cat /data/trueDT/peer/Sync/Log.FileSystem.Partition.system.live | busybox sed "s;';;g"`
FileSystemSDCARD=`busybox cat /data/trueDT/peer/Sync/Log.FileSystem.SDCARD.list.live | busybox sed "s;';;g"`
checkUptime=`busybox uptime | busybox awk '{ print substr ($0, 11 ) }' | busybox cut -d "," -f 1 | busybox sed "s;';;g"`
UpdateSystemUnix=`busybox stat -c '%Y' /data/asusbox/UpdateSystem.sh | busybox cut -d "." -f 1`
UpdateSystemDate=`busybox stat -c '%y' /data/asusbox/UpdateSystem.sh | busybox cut -d "." -f 1`
UpdateSystemMD5=`busybox md5sum /data/asusbox/UpdateSystem.sh | busybox awk '{ print $1 }'`
UpdateSystemVersion="TorrentPack=\"$TorrentPackVersion\"|SHCBootVersion=\"$SHCBootVersion\"|$UpdateSystemUnix|$UpdateSystemDate|$UpdateSystemMD5"

# pin para proteger de bots online ficar postando
export secretAPI="65fads876f586a7sd5f867ads5f967a5sd876f5asd876f5as7d6f58a7sd65f7"

# read bah
# exit




curl -w "%{http_code}" -d  "secretAPI=$secretAPI&\
UUID=$UUID&\
RevendedorCode=$RevendedorCode&\
ProdutoCode=$ProdutoCode&\
ValidadeAcesso=$ValidadeAcesso&\
Serial=$Serial&\
Placa=$Placa&\
MacLan=$MacLan&\
MacWiFiReal=$MacWiFiReal&\
CpuSerial=$CpuSerial&\
FirmwareInstall=$FirmwareInstall&\
FirmwareInstallUnix=$FirmwareInstallUnix&\
FirmwareInstallLOG=$FirmwareInstallLOG&\
FirmwareHardReset=$FirmwareHardReset&\
FirmwareHardResetUnix=$FirmwareHardResetUnix&\
FirmwareHardResetLOG=$FirmwareHardResetLOG&\
LocationGeoIP=$LocationGeoIP&\
FirmwareFullSpecs=$FirmwareFullSpecs&\
FirmwareFullSpecsID=$FirmwareFullSpecsID&\
AppInUse=$AppInUse&\
AppInUseLOG=$AppInUseLOG&\
ExternalDrivers=$ExternalDrivers&\
FileSystemPartitionData=$FileSystemPartitionData&\
FileSystemPartitionSystem=$FileSystemPartitionSystem&\
FileSystemSDCARD=$FileSystemSDCARD&\
checkUptime=$checkUptime&\
UpdateSystemVersion=$UpdateSystemVersion&\
" "$ServerAPI/auth.php"


read bah


