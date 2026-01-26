
# input vindo do secretAPI do firmware
IPTest="http://137.184.131.95"

#IPTest="http://10.0.0.91:777"

# entra em loop de espera 
while [ 1 ]; do
	echo "GeoIPinfo"
	GeoIPinfo
	if [ "$httpCode" == "200" ]; then break; fi; # se for igual a 200 sai deste loop
	# tempo para a box tentar enviar as vars novamente
	busybox sleep 3 
done;

# pin para proteger de bots online ficar postando
export secretAPI="65fads876f586a7sd5f867ads5f967a5sd876f5asd876f5as7d6f58a7sd65f7"

export MacLanReal=`busybox cat /data/macLan.hardware`

#( mostrou no asubox e xiaomi termux )
export MacWiFiReal=`busybox iplink show wlan0 | busybox grep "link/ether" | busybox awk '{ print $2 }'` #  | busybox sed -e 's/:/-/g'
export CpuSerial=`busybox cat /proc/cpuinfo | busybox grep Serial | busybox awk '{ print $3 }'`

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


# # ler o serial
if [ -f "/data/Serial" ]; then
export LocalSerial=`/system/bin/busybox cat /data/Serial`
fi

function LoginAuth () {
CheckCurl=`curl -w "%{http_code}" -d  "secretAPI=$secretAPI&\
Serial=$LocalSerial&\
MacLanReal=$MacLanReal&\
MacWiFiReal=$MacWiFiReal&\
CpuSerial=$CpuSerial&\
FirmwareVer=$FirmwareVer&\
ID=$ID&\
IPLocalAtual=$IPLocalAtual&\
UsedData=$UsedData&\
UsedSystem=$UsedSystem&\
checkUptime=$checkUptime&\
SizeCheckTotalSpace=$SizeCheckTotalSpace&\
SizeSystemInstall=$SizeSystemInstall&\
SizeSdcard0Install=$SizeSdcard0Install&\
SystemFlog=$SystemFlog&\
DataFlog=$DataFlog&\
DataHomeFlog=$DataHomeFlog&\
ListBlockDevices=$ListBlockDevices&\
ListMountedDevices=$ListMountedDevices&\
UsingMountedDevices=$UsingMountedDevices&\
ListUSBDevices=$ListUSBDevices&\
ListDataAsusbox=$ListDataAsusbox&\
ListSdcard0=$ListSdcard0&\
country=$country&\
region=$region&\
city=$city&\
loc=$loc&\
org=$org&\
" "$IPTest/auth.php" | busybox sed 's/\r$//'`
# extract vars
export Serial=`echo -n $CheckCurl | busybox cut -d ";" -f 1 | busybox cut -d " " -f 1 | busybox sed 's/\r$//'`
export httpCode=`echo -n $CheckCurl | busybox cut -d " " -f 2 | busybox sed 's/\r$//'`

# echo "
# $CheckCurl
# "
# echo "ADM DEBUG ### Serial   : $Serial"
# echo "ADM DEBUG ### httpCode : $httpCode"
# exit

}

# entra em loop de espera para ver se o vps recebeu as vars
# o vps vai entregar o arquivo shell baseado em trial, fullacess ou banido
while [ 1 ]; do
	echo "post data vars"
	LoginAuth
	if [ "$httpCode" == "200" ]; then break; fi; # se for igual a 200 sai deste loop
	# tempo para a box tentar enviar as vars novamente
	busybox sleep 30  
done;

# primeiro install do serial na box
if [ ! -f "/data/Serial" ]; then
	echo "ADM DEBUG ### gravando Serial na system   : $Serial"
	echo -n $Serial > "/data/Serial"
fi
echo "ADM DEBUG ### Serial        : $Serial"
echo "ADM DEBUG ### LocalSerial   : $LocalSerial"
echo "ADM DEBUG ### httpCode      : $httpCode"

