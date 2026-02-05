#!/system/bin/sh
if [ "$1" == "675asd765da4s567f4asd4f765ads4f675a4ds6f754ads6754fa657ds4f675ads467f5ads" ]; then
echo "Certified.BOOT"
exit
fi
function CheckIPLocal () {
WlanIP=`/system/bin/busybox ip addr show wlan0 \
| /system/bin/busybox grep "inet " \
| /system/bin/busybox awk '{print $2}' \
| /system/bin/busybox cut -d "/" -f 1 \
| /system/bin/busybox head -1`
LanIP=`/system/bin/busybox ip addr show eth0 \
| /system/bin/busybox grep "inet " \
| /system/bin/busybox awk '{print $2}' \
| /system/bin/busybox cut -d "/" -f 1 \
| /system/bin/busybox head -1`
if [ "$LanIP" == "" ]; then
export IPLocal="$WlanIP"
else
export IPLocal="$LanIP"
fi
}
while [ 1 ]; do
CheckIPLocal
if [ ! "$IPLocal" = "" ]; then break; fi;
sleep 1;
done;
echo "primeiro try IPlocal"
CheckIPLocal
function CheckMacLanClone () {
MacLanClone=`/system/bin/busybox ifconfig \
| /system/bin/busybox grep eth0 \
| /system/bin/busybox grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' \
| /system/bin/busybox tr 'A-F' 'a-f'`
}
CheckMacLanClone
if [ ! "$MacLanClone" == "9c:00:d3:cc:84:3f" ]; then
export MacLanReal=`/system/bin/busybox ifconfig | /system/bin/busybox grep eth0 | /system/bin/busybox awk '{ print $5 }'`
am force-stop com.valor.mfc.droid.tvapp.generic
/system/bin/busybox ifconfig eth0 down
/system/bin/busybox ifconfig eth0 hw ether 9c:00:d3:cc:84:3f
/system/bin/busybox ifconfig eth0 up
while [ 1 ]; do
CheckMacLanClone
echo "Mac atual > $MacLanClone"
if [ "$MacLanClone" = "9c:00:d3:cc:84:3f" ]; then break; fi;
sleep 1;
done;
if [ ! -f /data/macLan.hardware ]; then
echo -n $MacLanReal > /data/macLan.hardware
fi
else
export MacLanReal=`/system/bin/busybox cat /data/macLan.hardware`
fi
while [ 1 ]; do
CheckIPLocal
if [ ! "$IPLocal" = "" ]; then break; fi;
sleep 1;
done;
export IPLocalAtual="$IPLocal"
export MacWiFiReal=`/system/bin/busybox ifconfig | /system/bin/busybox grep wlan0 | /system/bin/busybox awk '{ print $5 }'`
if [ ! -e /data/asusbox/crontab/LOCK_cron.updates ]; then
settings put global ntp_server a.st1.ntp.br
settings put global auto_time 0
settings put global auto_time 1
fi
function ClockUpdateNow () {
dateOld="1630436299" # dia que foi feito este script
dateNew=`date +%s` # data atual no momento do boot
if [ ! -d /data/trueDT/peer/Sync ]; then
mkdir -p /data/trueDT/peer/Sync
fi
if [ "$dateOld" -gt "$dateNew" ];then
FileMark="/data/trueDT/peer/Sync/udp.clock.blocked.by.isp.v2.live"
busybox cat <<EOF > $FileMark
date from local gateway = $(date +"%d/%m/%Y %H:%M:%S")
EOF
TZ=UTC−03:00
export TZ
ACRURL="https://telegra.ph/Entre-em-contato-com-o-suporte-03-20"
acr.browser.barebones.launch
while [ 1 ]; do
export CheckCurl=`/system/bin/curl "http://worldtimeapi.org/api/timezone/America/Sao_Paulo"`
if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
sleep 3;
done;
datetime=`echo -n "$CheckCurl" | busybox cut -d ',' -f 3 | busybox cut -d '"' -f 4 | busybox cut -d '"' -f 1`
timezone=`echo -n "$CheckCurl" | busybox cut -d ',' -f 11 | busybox cut -d '"' -f 4 | busybox cut -d '"' -f 1`
unixtime=`echo -n "$CheckCurl" | busybox cut -d ',' -f 12 | busybox cut -d ':' -f 2`
/system/bin/busybox date -s "@$unixtime"
busybox cat <<EOF >> $FileMark
date from world api = $datetime
$timezone
$unixtime
EOF
am force-stop acr.browser.barebones
fi
}
function GetGeoLocalization () {
link='https://ipinfo.io'
CheckCurl=`/system/bin/curl --silent -w "%{http_code}" -k $link -L`
export httpCode=`echo "$CheckCurl" | busybox grep "}" | busybox cut -d "}" -f 2`
export ip=`echo -n "$CheckCurl" | busybox grep "ip" | busybox cut -d '"' -f 4 | busybox head -1`
export country=`echo -n "$CheckCurl" | busybox grep "country" | busybox cut -d '"' -f 4 | busybox head -1`
export region=`echo -n "$CheckCurl" | busybox grep "region" | busybox cut -d '"' -f 4 | busybox head -1`
export city=`echo -n "$CheckCurl" | busybox grep "city" | busybox cut -d '"' -f 4 | busybox head -1`
export hostname=`echo -n "$CheckCurl" | busybox grep "hostname" | busybox cut -d '"' -f 4 | busybox head -1`
export org=`echo -n "$CheckCurl" | busybox grep "org" | busybox cut -d '"' -f 4 | busybox head -1`
if [ ! -d /data/trueDT/peer/Sync ]; then
mkdir -p /data/trueDT/peer/Sync
fi
}
function WriteGeoLocalization () {
FileLog="/data/trueDT/peer/Sync/LocationGeoIP.v6.atual"
checkFileInfo=$(busybox cat $FileLog | busybox tr -d '\n')
if [ "$checkFileInfo" == "" ]; then
rm $FileLog
fi
if [ ! -f "$FileLog" ]; then
for i in $(seq 1 7); do
GetGeoLocalization
if [ "$httpCode" = "200" ]; then break; fi;
sleep 3;
done;
if [ ! "$httpCode" = "200" ]; then exit; fi;
CheckIPLocal
if [ ! "$ip$country$region$city$org$hostname" == "" ]; then
echo "$IPLocal | $ip | $country | $region | $city | $org | $hostname" > "/data/trueDT/peer/Sync/LocationGeoIP.v6.atual"
fi
fi
}
ExternalipLogged=$(busybox cat "/data/trueDT/peer/Sync/LocationGeoIP.v6.atual" | busybox awk -F'|' '{print $2}' | busybox tr -d '[:space:]')
GETipExternal=$(/system/bin/curl --silent http://canhazip.com)
if [ ! "$ExternalipLogged" == "$GETipExternal" ]; then
WriteGeoLocalization
fi
SECONDS=0
export LogRealtime="/data/trueDT/peer/Sync/LogRealtime.live"
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin
export Senha7z="6ads5876f45a9sdf7as975a87"
export Produto="asusbox"
export PHome="/data/$Produto"
export HOME="/data/$Produto"
if [ ! -d $PHome ] ; then
mkdir -p $PHome
fi
if [ ! -d /data/trueDT/peer/chat ] ; then
mkdir -p /data/trueDT/peer/chat
fi
GetID=`settings get secure android_id` # puxa o ultimo id do android
export ID="3573F9431ACC9AB1"
if [ ! "$GetID" == "$ID" ]; then
settings put --user 0 secure android_id 3573F9431ACC9AB1
echo -n $GetID > /data/$Produto/android_id_OLD # escreve novo id
echo -n $ID > /data/$Produto/android_id # escreve novo id
fi
IDCheck=`cat /data/$Produto/android_id`
if [ ! "$IDCheck" == "$ID" ]; then
echo -n $ID > /data/$Produto/android_id # escreve novo id temporariamente
fi
export ID=`/system/bin/busybox cat /data/$Produto/android_id`
export CPU=`getprop ro.product.cpu.abi | sed -e 's/ /_/g'`
export Modelo=`getprop ro.product.model`
export RomBuild=`getprop ro.build.description | sed -e 's/ /_/g'`
export FirmwareVer=`busybox blkid | busybox sed -n '/system/s/.*UUID=\"\([^\"]*\)\".*/\1/p'`
export shellBin=`echo IyEvc3lzdGVtL2Jpbi9zaA== | /system/bin/busybox base64 -d`
export onLauncher="pm enable dxidev.toptvlauncher2"
export conf="/data/$Produto/.conf"
export www="$EXTERNAL_STORAGE/Android/data/$Produto/.www"
export systemLog="$www/system.log"
export wgetLog="$www/wget.log"
export wwwup="$EXTERNAL_STORAGE/Android/data/$Produto/.updates"
export fileUpdates="/data/$Produto/.updates"
export userLog="/data/$Produto/user.log"
export bootLog="/data/data/jackpal.androidterm/app_HOME/log.txt"
export PathSerial="/system/Serial"
export PathPin="/system/Pin"
export SupportLOG="$EXTERNAL_STORAGE/Adata.log"
Placa=$(getprop ro.product.board)
CpuSerial=`busybox cat /proc/cpuinfo | busybox grep Serial | busybox awk '{ print $3 }'`
MacLanReal=`/system/bin/busybox cat /data/macLan.hardware | busybox sed 's;:;;g'`
DeviceName="$Placa=$CpuSerial=$MacLanReal"
mkdir -p /data/trueDT/www/.stfolder > /dev/null 2>&1
chmod -R 777 /data/trueDT/www
mkdir -p /data/trueDT/assets > /dev/null 2>&1
mkdir -p /data/trueDT/peer/Sync > /dev/null 2>&1
function .installAsusBOX-PC () {
FolderPath="/storage/asusboxUpdate"
UUID=`/system/bin/busybox blkid | /system/bin/busybox grep "ThumbDriveDEV" | /system/bin/busybox head -n 1 | /system/bin/busybox cut -d "=" -f 3 | /system/bin/busybox cut -d '"' -f 2`
if [ ! $UUID == "" ]; then
if [ ! -d $FolderPath ] ; then
mkdir $FolderPath
chmod 700 $FolderPath
fi
check=`/system/bin/busybox mount | /system/bin/busybox grep "$FolderPath"`
if [ "$check" == "" ]; then
/system/bin/busybox mount -t ext4 LABEL="ThumbDriveDEV" "$FolderPath"
fi
rm /data/asusbox/.install > /dev/null 2>&1
/system/bin/busybox ln -sf $FolderPath/asusbox/.install /data/asusbox/
InstallFolder="ENABLED"
fi
}
function .installSDcard () {
FolderPath="/storage/emulated/0/Download/AsusBOX-UPDATE"
if [ ! -d $FolderPath ]; then
export FolderPath="/data/trueDT/PackP2P"
mkdir -p $FolderPath
echo "FolderPath > $FolderPath"
fi
rm /data/asusbox/.install > /dev/null 2>&1
/system/bin/busybox ln -sf $FolderPath /data/asusbox/.install
InstallFolder="ENABLED"
}
function Check.installFolder () {
Clink=`/system/bin/busybox readlink -v "/data/asusbox/.install"` > /dev/null 2>&1
if [ ! -e "$Clink" ] ; then
InstallFolder="DISABLED"
echo "Symlink /data/.install esta desativado"
if [ ! $InstallFolder == "ENABLED" ]; then
.installAsusBOX-PC
fi
if [ ! $InstallFolder == "ENABLED" ]; then
.installSDcard
fi
Check.installFolder
else
InstallFolder="ENABLED"
fi
}
rm -rf /data/asusbox/.install
Check.installFolder
if [ ! -d /storage/emulated/0/Download/naoApagueUpdate ]; then
busybox mkdir -p /storage/emulated/0/Download/naoApagueUpdate
echo "56asd476a5sf5467da" > /storage/emulated/0/Download/naoApagueUpdate/setup.txt
fi
CACERT="/data/Curl_cacert.pem"
CACERT_URL="https://curl.se/ca/cacert.pem"
CACERT_MAX_AGE_DAYS=30
curl_bootstrap_cacert() {
if [ ! -f "$CACERT" ]; then
/system/bin/curl -sS -k --connect-timeout 8 --max-time 25 \
-o "$CACERT" "$CACERT_URL"
return
fi
if /system/bin/busybox stat -c %Y "$CACERT" >/dev/null 2>&1; then
now_ts=$(date +%s)
file_ts=$(/system/bin/busybox stat -c %Y "$CACERT")
age_days=$(( (now_ts - file_ts) / 86400 ))
if [ "$age_days" -ge "$CACERT_MAX_AGE_DAYS" ]; then
/system/bin/curl -sS --cacert "$CACERT" --connect-timeout 8 --max-time 25 \
-o "$CACERT" "$CACERT_URL"
fi
fi
}
curl_bootstrap_cacert
function 7ZextractDir () {
if [ "$Senha7z" == "" ]; then
Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
fi
eval $cmdCheck
rm /data/local/tmp/swap > /dev/null 2>&1
tmpUpdateF=/data/local/tmp/UpdateF
if [ "$versionBinLocal" == "$versionBinOnline" ]; then # if do install
echo "$app esta atualizado! > $versionBinOnline"
else
echo "$(date)" > $bootLog 2>&1
echo "Instalando o componente > $apkName" >> $bootLog 2>&1
echo "Por favor aguarde..." >> $bootLog 2>&1
rm -rf $tmpUpdateF > /dev/null 2>&1
mkdir -p $tmpUpdateF
mkdir -p $pathToInstall
/system/bin/7z x -aoa -y -p$Senha7z "$SourcePack.*" -oc:$tmpUpdateF > /dev/null 2>&1
fi
}
function AppGrant () {
if [ ! "$AppGrantLoop" == "" ]; then
for lgrant in $AppGrantLoop; do
pm grant $app $lgrant
done
fi
}
BB=/system/bin/busybox
Limpa_apks_del () {
$BB find "/data/local/tmp/" -type f -name "*.apk" | while read fname ; do
echo "$fname"
rm "$fname"
done
}
enfileira_apks_install () {
$BB find "/data/local/tmp" -type f -name "*.apk" | while read apk ; do
pm install-write $SESSION "$(basename "$apk")" "$apk"
done
}
Processa_install_apks () {
SESSION=$(pm install-create -r | $BB awk -F'[' '{print $2}' | $BB tr -d ']')
enfileira_apks_install
pm install-commit $SESSION
return $?
}
function CheckAKPinstallP2P () {
if [ "$Senha7z" == "" ]; then
Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
fi
if [ ! -d /data/asusbox/AppLog ]; then
busybox mkdir -p /data/asusbox/AppLog
fi
if [ -d "/data/data/$app" ]; then # se a pasta data do apk existe, considero que já tem o ultimo apk lançado
MarcadorInicial="Thu Jun  3 16:06:36 BRT 2021"
if [ ! -f "/data/asusbox/AppLog/$app=$MarcadorInicial.log" ];then
touch "/data/asusbox/AppLog/$app=$MarcadorInicial.log"
fi
else
$BB find "/data/asusbox/AppLog/" -type f -name "$app=*" | while read fname; do
busybox rm "$fname"
done
fi
if [ ! -f "/data/asusbox/AppLog/$app=$versionNameOnline.log" ];then
echo "$(date)" > $bootLog 2>&1
if [ "$AKPouDTF" == "AKP" ]; then
Limpa_apks_del
echo "Instalando o aplicativo > $apkName $fakeName" >> $bootLog 2>&1
echo "Por favor aguarde..." >> $bootLog 2>&1
/system/bin/7z e -aoa -y -p$Senha7z "$SourcePack*.001" -oc:/data/local/tmp #> /dev/null 2>&1
Processa_install_apks
if [ ! $? = 0 ]; then
if [ -d /data/data/$app ]; then
pm uninstall $app
fi
Processa_install_apks
fi
Limpa_apks_del
AppGrant
touch "/data/asusbox/AppLog/$app=$versionNameOnline.log"
fi
else
echo "$(date)" > $bootLog 2>&1
echo "Aplicativo > $apkName $fakeName" >> $bootLog 2>&1
echo "Esta atualizado." >> $bootLog 2>&1
fi
fakeName=""
}
function CheckBase64 () {
eval $cmdCheck
if [ ! "$versionBinOnline" == "$versionBinLocal" ]; then
WriteBase64
else
echo "$pathToInstall" esta atualizado!
fi
}
function WriteBase64 () {
/system/bin/busybox mount -o remount,rw /system
echo "$versionBinOnline" | /system/bin/busybox base64 -d > "$pathToInstall"
/system/bin/busybox chmod $FilePerms $pathToInstall
eval $NeedReboot
CheckBase64
}
function CheckInstallAKP () {
Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
versionLocal=`dumpsys package $app | grep versionName | cut -d "=" -f 2`
crclocal=`HashFile /data/asusbox/$apkName.akp`
if [ ! "$versionLocal" == "$versionNameOnline" ]; then # NOVA TAREFA SE O CLIENTE ATUALIZAR O APP VAI SOBREESCREVER O INSTALL NO BOOT
echo "<h1>$(date)</h1>" >> $bootLog 2>&1
echo "<h3>Grande atualização, por favor aguarde.</h3>" >> $bootLog 2>&1
echo "<h3>Arquivo grande pode demorar.</h3>" >> $bootLog 2>&1
for LinkUpdate in $multilinks; do
echo "loop download > $LinkUpdate"
if [ ! "$crclocal" == "$crcOnline" ]; then
echo "Download akp"
echo "<h2>Iniciando download $apkName por favor espere.</h2>" > $bootLog 2>&1
echo -n $LinkUpdate > /data/local/tmp/url.list
cat /data/local/tmp/url.list
DownloadAKP
crclocal=`HashFile /data/asusbox/$apkName.akp`
if [ "$crclocal" == "$crcOnline" ]; then break; fi; # check return value, break if successful (0)
sleep 1;
fi
echo "Download concluido $apkName" > $bootLog 2>&1
done
echo "<h2>Instalando o aplicativo > $apkName</h2>" >> $bootLog 2>&1
echo "<h3>Por favor aguarde...</h3>" >> $bootLog 2>&1
/system/bin/7z e -aoa -y -p$Senha7z "/data/asusbox/$apkName.akp" -oc:/data/local/tmp
pm install -r /data/local/tmp/base.apk
rm /data/local/tmp/base.apk
cmd package set-home-activity "dxidev.toptvlauncher2/.HomeActivity"
fi
}
function CheckInstallDTF () {
Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
crclocal=`HashFile /data/asusbox/$apkName.DTF`
if [ ! "$crclocal" == "$crcOnline" ]; then
echo "<h1>$(date)</h1>" >> $bootLog 2>&1
echo "<h3>Grande atualização, por favor aguarde.</h3>" >> $bootLog 2>&1
echo "<h3>Arquivo grande pode demorar.</h3>" >> $bootLog 2>&1
for LinkUpdate in $multilinks; do
echo "loop download > $LinkUpdate"
if [ ! "$crclocal" == "$crcOnline" ]; then
echo "Iniciando download $apkName por favor espere." > $bootLog 2>&1
echo -n $LinkUpdate > /data/local/tmp/url.list
cat /data/local/tmp/url.list
DownloadDTF
crclocal=`HashFile /data/asusbox/$apkName.akp`
if [ "$crclocal" == "$crcOnline" ]; then break; fi; # check return value, break if successful (0)
sleep 1;
fi
done
echo "Download concluido $apkName" > $bootLog 2>&1
fi
}
function CheckUser {
UserPass=`/system/bin/busybox cat /data/data/com.asusbox.asusboxiptvbox/shared_prefs/loginPrefs.xml | /system/bin/busybox grep password | /system/bin/busybox cut -d '>' -f 2 | /system/bin/busybox cut -d '<' -f 1`
}
function DownloadAKP () {
echo "Iniciando download $apkName "> $bootLog 2>&1
FechaAria
$aria2c \
--check-certificate=false \
--show-console-readout=false \
--always-resume=true \
--allow-overwrite=true \
--summary-interval=10 \
--console-log-level=error \
--file-allocation=none \
--input-file=/data/local/tmp/url.list \
-d /data/asusbox | sed -e 's/FILE:.*//g' >> $bootLog 2>&1
}
function DownloadDTF () {
echo "Iniciando download $apkName "> $bootLog 2>&1
FechaAria
$aria2c \
--check-certificate=false \
--show-console-readout=false \
--always-resume=true \
--allow-overwrite=true \
--summary-interval=10 \
--console-log-level=error \
--file-allocation=none \
--input-file=/data/local/tmp/url.list \
-d /data/asusbox | sed -e 's/FILE:.*//g' >> $bootLog 2>&1
}
GitHUBcheckVersion () {
latest_release=$(curl -s "$repo_url" | grep "browser_download_url" | cut -d '"' -f 4 | grep "armeabi-v7a.apk")
VersionOnline=$(basename "$latest_release")
}
DownloadFromGitHUB () {
if [ ! "$VersionOnline" == "$VersionLocal" ]; then
echo "<h2>Baixando o aplicativo > $VersionOnline < Por favor aguarde.</h2>" >> "$bootLog" 2>&1
/system/bin/wget --no-check-certificate --timeout=1 --tries=7 -O /data/local/tmp/base.apk "$latest_release" 2>&1
echo "<h2>Instalando o aplicativo > $VersionOnline</h2>" >> $bootLog 2>&1
echo "<h3>Por favor aguarde...</h3>" >> $bootLog 2>&1
pm install -r /data/local/tmp/base.apk
rm /data/local/tmp/base.apk
echo -n "$VersionOnline" > /data/data/$realname/VersionInstall.log
else
echo "Apk [$VersionLocal] esta atualizado" >> "$bootLog" 2>&1
fi
}
function DownloadSplitted () {
echo "Iniciando download $apkName "> $bootLog 2>&1
FechaAria
/system/bin/aria2c \
--check-certificate=false \
--show-console-readout=false \
--always-resume=true \
--allow-overwrite=true \
--summary-interval=10 \
--console-log-level=error \
--file-allocation=none \
--input-file=/data/local/tmp/url.list \
-d $InstallDir | sed -e 's/FILE:.*//g' >> $bootLog 2>&1
echo "Download Concluido!" > $bootLog 2>&1
}
function FechaAria () {
/system/bin/busybox kill -9 $(/system/bin/busybox pgrep aria2c) > /dev/null 2>&1
}
function FileListInstall () {
eval $cmdCheck
rm /data/local/tmp/swap > /dev/null 2>&1
echo "$(date)" > $bootLog 2>&1
echo "Instalando o componente > $apkName" >> $bootLog 2>&1
echo "Por favor aguarde..." >> $bootLog 2>&1
if [ "$versionBinOnline" == "$versionBinLocal" ]; then # if do install
echo "Componente $FileName Atualizado"
else
if [ "$FileExtension" == "SC" ]; then
/system/bin/7z e -aoa -y -p$Senha7z "$SourcePack" -oc:/data/local/tmp > /dev/null 2>&1
rm -rf /data/local/tmp/$FileName > /dev/null 2>&1
mkdir -p /data/local/tmp/$FileName
cd /data/local/tmp/$FileName
/system/bin/busybox tar -mxvf /data/local/tmp/$FileName.tar.gz > /dev/null 2>&1
if [ "$pathToInstall" == "" ]; then
sleep 3
break
else
mkdir -p $pathToInstall > /dev/null 2>&1
cd $pathToInstall
/system/bin/rsync --progress -avz --delete --recursive --force /data/local/tmp/$FileName/ $pathToInstall/ > /dev/null 2>&1
rm /data/local/tmp/$FileName.tar.gz > /dev/null 2>&1
rm -rf /data/local/tmp/$FileName > /dev/null 2>&1
fi
fi
if [ "$FileExtension" == "tar.gz" ]; then
cd /
/system/bin/busybox mount -o remount,rw /system
/system/bin/busybox tar -mxvf $InstallDir/$FileName.tar.gz > /dev/null 2>&1
fi
if [ "$FileExtension" == "7z" ]; then
/system/bin/7z e -aoa -y -p$Senha7z "$SourcePack.*" -oc:/data/local/tmp > /dev/null 2>&1
cd /
/system/bin/busybox mount -o remount,rw /system
/system/bin/busybox tar -mxvf /data/local/tmp/$FileName.tar.gz > /dev/null 2>&1
rm /data/local/tmp/$FileName.tar.gz > /dev/null 2>&1
fi
if [ "$FileExtension" == "WebPack" ]; then
7ZextractDir
RsyncUpdateWWW
fi
eval "$scriptOneTimeOnly"
fi ### end do if se esta instalado
}
function FixPerms () {
DUser=`dumpsys package $app | /system/bin/busybox grep userId | /system/bin/busybox cut -d "=" -f 2 | /system/bin/busybox head -n 1`
echo $DUser
chown -R $DUser:$DUser /data/data/$app
restorecon -FR /data/data/$app
}
function HashALLFiles() {
/system/bin/busybox rm /data/tmp.hash >/dev/null 2>&1
/system/bin/busybox find $1 -type f \( -iname \* \) | /system/bin/busybox sort | while read fname; do
/system/bin/busybox md5sum "$fname" | /system/bin/busybox cut -d ' ' -f1 >>/data/tmp.hash 2>&1
done
export HashResult=$(/system/bin/busybox cat /data/tmp.hash)
/system/bin/busybox rm /data/tmp.hash >/dev/null 2>&1
}
function HashFile () {
/system/bin/busybox md5sum "$1" | /system/bin/busybox cut -d ' ' -f1
}
function HashFolder () {
/system/bin/busybox rm /data/tmp.hash > /dev/null 2>&1
/system/bin/busybox find $1 -type f \( -iname \*.sh -o -iname \*.webp -o -iname \*.jpg -o -iname \*.png -o -iname \*.php -o -iname \*.html -o -iname \*.js -o -iname \*.css \) | /system/bin/busybox sort | while read fname; do
/system/bin/busybox md5sum "$fname" | /system/bin/busybox cut -d ' ' -f1 >> /data/tmp.hash 2>&1
done
export HashResult=`/system/bin/busybox cat /data/tmp.hash`
/system/bin/busybox rm /data/tmp.hash > /dev/null 2>&1
}
function LauncherList () {
if [ "$LauncherIntegrated" == "yes" ]; then
if [ ! -f /data/asusbox/LauncherLock ]; then
if [ ! "$app" == "dxidev.toptvlauncher2" ]; then
pm disable $app
fi
fi
echo "$app" >> /data/asusbox/LauncherList
fi
}
function OutputLogUsb () {
ListaUSBmounted=$(busybox mount | busybox grep public | busybox grep -v '/mnt/runtime/' | busybox awk '!seen[$1]++' | busybox awk '{print $3}')
if [ ! "$ListaUSBmounted" == "" ]; then
for DriverPathUSBmounted in $ListaUSBmounted; do
if [ "$USBLOGCALLSet" == "clear" ]; then
rm "$DriverPathUSBmounted/debug.log"
USBLOGCALLSet=""
fi
if [ ! "$USBLOGCALLSet" == "remove" ]; then
echo "$(date) Usb Log \"$USBLOGCALL\"" >> "$DriverPathUSBmounted/debug.log"
else
echo "$(date) Update no errors" >> "$DriverPathUSBmounted/debug.log"
fi
done
fi
}
function RsyncUpdateWWW () {
eval $cmdCheck
exclude="/data/local/tmp/exclude.txt"
if [ "$versionBinLocal" == "$versionBinOnline" ]; then # if do install
echo "$app esta atualizado!"
else
echo -n "$ExcludeItens" > $exclude
mkdir -p $pathToInstall
cd $pathToInstall
/system/bin/rsync \
--progress \
-avz \
--delete \
--recursive \
--force \
--exclude-from=$exclude \
/data/local/tmp/UpdateF/ $pathToInstall/ > /dev/null 2>&1
fi
rm -rf $tmpUpdateF > /dev/null 2>&1
rm $exclude > /dev/null 2>&1
}
function excludeListAPP () {
echo "$app" >> /data/local/tmp/APPList
}
function excludeListPack () {
echo "$1" >> /data/local/tmp/PackList
}
function extractDTF () {
echo "<h1>$(date)</h1>" >> $bootLog 2>&1
echo "<h2>Configurando o aplicativo > $apkName $fakeName</h2>" >> $bootLog 2>&1
echo "<h3>Por favor aguarde...</h3>" >> $bootLog 2>&1
am force-stop $app
/system/bin/7z e -aoa -y -p$Senha7z "/data/asusbox/$apkName.DTF" -oc:/data/local/tmp
cd /
/system/bin/busybox tar -mxvf /data/local/tmp/$apkName.DT.tar.gz
rm /data/local/tmp/$apkName.DT.tar.gz
fakeName=""
}
function extractDTFSplitted () {
echo "$(date)" > $bootLog 2>&1
echo "Configurando o aplicativo > $apkName $fakeName" >> $bootLog 2>&1
echo "Por favor aguarde..." >> $bootLog 2>&1
am force-stop $app
rm /data/local/tmp/*tar.gz > /dev/null 2>&1
/system/bin/7z e -aoa -y -p$Senha7z "$SourcePack*.001" -oc:/data/local/tmp > /dev/null 2>&1
cd /
/system/bin/busybox tar -mxvf /data/local/tmp/$apkName.DT.tar.gz > /dev/null 2>&1
rm /data/local/tmp/$apkName.DT.tar.gz > /dev/null 2>&1
fakeName=""
}
function killcron () {
checkPort=`/system/bin/busybox ps \
| /system/bin/busybox grep "/system/bin/busybox crond" \
| /system/bin/busybox grep -v "grep" \
| /system/bin/busybox awk '{print $1}' \
| /system/bin/busybox sed -e 's/[^0-9]*//g'`
if [ ! "$checkPort" == "" ]; then
/system/bin/busybox kill -9 $checkPort
fi
}
function p2pgetID () {
torID=`/system/bin/transmission-remote --list \
| /system/bin/busybox grep "$torFile" \
| /system/bin/busybox awk '{print $1}' \
| /system/bin/busybox sed -e 's/[^0-9]*//g'`
}
function killTransmission () {
checkPort=`netstat -ntlup | /system/bin/busybox grep "9091" | /system/bin/busybox cut -d ":" -f 2 | /system/bin/busybox awk '{print $1}'`
if [ "$checkPort" == "9091" ]; then
/system/bin/transmission-remote --exit
killall transmission-daemon
fi
busybox find /data/transmission/ -type f -name 'settings.json*' -exec busybox rm {} +
}
function restartTransmission () {
killTransmission
sleep 3
StartDaemonTransmission
}
function SeedBOXTransmission () {
echo "seedbox $torFile.torrent"
p2pgetID
if [ ! "$torID" == "" ]; then
/system/bin/transmission-remote -t $torID -r
fi
/system/bin/transmission-remote \
-a /data/asusbox/$torFile.torrent \
-m \
-x \
-o \
-y \
-w /data/asusbox/ \
-S
p2pgetID
/system/bin/transmission-remote -t $torID -f | /system/bin/busybox awk '{print $7}' | /system/bin/busybox sed 's;.install/;./;g' > /data/local/tmp/TorrentList
/system/bin/busybox sed -i -e '/^\s*$/d' /data/local/tmp/TorrentList
/system/bin/busybox find "/data/asusbox/.install/" -type f -name "*" \
| /system/bin/busybox grep -v -f /data/local/tmp/TorrentList \
| while read fname; do
rm -rf "$fname"
done
rm /data/local/tmp/TorrentList
/system/bin/transmission-remote -t $torID -v -s --torrent-done-script /data/transmission/tasks.sh
}
function StartDaemonTransmission () {
configDir="/data/transmission"
seedBox="/sdcard/Download"
if [ ! -d $configDir ] ; then
mkdir -p $configDir
fi
if [ ! -d $seedBox ] ; then
mkdir -p $seedBox
fi
fileConf="/data/transmission/settings.json"
/system/bin/busybox sed -i -e 's;"umask":.*;"umask": 63,;g' $fileConf
high=65535
low=49152
export PeerPort=$(( ( RANDOM % (high-low) )  + low ))
echo "start" > /data/asusbox/transmission.log
/system/bin/transmission-daemon \
-g $configDir \
-a 127.0.0.1,*.* \
-P $PeerPort \
-c /sdcard/Download/ \
-w $seedBox
}
function p2pWait () {
FileWaitingP2P="/data/transmission/$torFile"
/system/bin/busybox rm $FileWaitingP2P > /dev/null 2>&1
while [ 1 ]; do
if [ -e $FileWaitingP2P ];then break; fi;
echo "Wait for update $torFile"
sleep 5;
done;
/system/bin/busybox rm $FileWaitingP2P
}
function scriptAtBootFN () {
if [ ! "$scriptAtBoot" == "" ]; then
echo "runing code"
eval "$scriptAtBoot"
fi
}
function z_acr.browser.barebones.change.URL () {
while [ 1 ]; do
am force-stop acr.browser.barebones
if [ $? = 0 ]; then break; fi;
sleep 1
done;
FileXML="/data/data/acr.browser.barebones/shared_prefs/settings.xml"
/system/bin/busybox cat <<EOF > "$FileXML"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
<boolean name="blackStatusBar" value="true" />
<int name="enableflash" value="0" />
<boolean name="cache" value="true" />
<boolean name="restoreclosed" value="false" />
<boolean name="clearWebStorageExit" value="true" />
<boolean name="hidestatus" value="true" />
<int name="Theme" value="1" />
<string name="home">http://127.0.0.1:9091</string>
</map>
EOF
/system/bin/busybox sed -i -e "s;<string name=\"home\">.*</string>;<string name=\"home\">$ACRURL</string>;g" $FileXML
/system/bin/busybox chmod 660 /data/data/acr.browser.barebones/shared_prefs/*.xml
app="acr.browser.barebones"
FixPerms
}
function acr.browser.barebones.launch () {
while [ 1 ]; do
am start --user 0 \
-n acr.browser.barebones/acr.browser.lightning.MainActivity \
-a android.intent.action.VIEW -d "$ACRURL" > /dev/null 2>&1
if [ $? = 0 ]; then break; fi;
sleep 1
done;
}
function acr.browser.barebones.set.config () {
FileXML="/data/data/acr.browser.barebones/shared_prefs/acr.browser.barebones_preferences.xml"
if [ ! -f "$FileXML"  ]; then
mkdir -p /data/data/acr.browser.barebones/shared_prefs
/system/bin/busybox cat <<EOF > "$FileXML"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
<boolean name="fullScreenOption" value="true" />
<boolean name="cb_images" value="false" />
<boolean name="cb_javascript" value="true" />
<boolean name="clear_webstorage_exit" value="true" />
<boolean name="password" value="true" />
<boolean name="cb_drawertabs" value="true" />
<boolean name="remove_identifying_headers" value="false" />
<boolean name="clear_cookies_exit" value="false" />
<boolean name="allow_cookies" value="true" />
<boolean name="cb_ads" value="false" />
<boolean name="allow_new_window" value="true" />
<boolean name="third_party" value="false" />
<boolean name="clear_history_exit" value="false" />
<boolean name="restore_tabs" value="false" />
<boolean name="cb_swapdrawers" value="false" />
<boolean name="do_not_track" value="false" />
<boolean name="location" value="false" />
<boolean name="cb_flash" value="false" />
<boolean name="incognito_cookies" value="false" />
<boolean name="black_status_bar" value="true" />
<boolean name="fullscreen" value="true" />
<boolean name="clear_cache_exit" value="true" />
<boolean name="text_reflow" value="false" />
<boolean name="wideViewPort" value="true" />
<boolean name="overViewMode" value="true" />
<boolean name="cb_colormode" value="true" />
</map>
EOF
fi
FileXML="/data/data/acr.browser.barebones/shared_prefs/settings.xml"
if [ -z "$(cat $FileXML | grep 9091)" ]; then
/system/bin/busybox cat <<EOF > "$FileXML"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
<boolean name="blackStatusBar" value="true" />
<int name="enableflash" value="0" />
<boolean name="cache" value="true" />
<boolean name="restoreclosed" value="false" />
<boolean name="clearWebStorageExit" value="true" />
<boolean name="hidestatus" value="true" />
<int name="Theme" value="1" />
<string name="home">http://127.0.0.1:9091</string>
</map>
EOF
fi
/system/bin/busybox chmod 660 /data/data/acr.browser.barebones/shared_prefs/*.xml
app="acr.browser.barebones"
FixPerms
}
echo -n "performance" >  /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
USBLOGCALLSet="clear"
OutputLogUsb
USBLOGCALL="Optimize CPU safe and care"
OutputLogUsb
if [ ! -f "/data/asusbox/fullInstall" ]; then
Titulo="Acesso $DeviceName"
Mensagem="Por favor aguarde."
am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV -e int_id 1 -e b_noicon "1" -e b_notime "1" -e float_tsize 27 -e str_title "$Titulo" -e hex_tcolor "FF0000" -e float_csize 16 -e str_content "$Mensagem"
cmd statusbar expand-notifications
fi
USBLOGCALL="Block notifications boring spam"
OutputLogUsb
if [ -f /data/asusbox/fullInstall ]; then
pm enable dxidev.toptvlauncher2
cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
if [ ! -f /data/asusbox/LauncherLock ]; then
am start --user 0 -a android.intent.action.MAIN dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity
fi
fi
USBLOGCALL="if launcher official start"
OutputLogUsb
PACKAGES="
org.xbmc.kodi
com.stremio.one
"
for PKG in $PACKAGES; do
pm uninstall --user 0 "$PKG" >/dev/null 2>&1
done
SHCBootVersion="1770257352 = 04/02/2026 23:09:12 | uuidDevice new"
rm /data/local/tmp/APPList > /dev/null 2>&1
rm /data/local/tmp/PackList > /dev/null 2>&1
if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then
listApagar="/data/transmission
/storage/emulated/0/Download/macx"
for DelFile in $listApagar; do
if [ -f "$DelFile" ];then
rm -rf "$DelFile" > /dev/null 2>&1
fi
done
fi
rm -rf /data/asusbox/.sc.base > /dev/null 2>&1
USBLOGCALL="clean filesystem safe optimazition"
OutputLogUsb
checkPin=`/system/bin/busybox cat /system/.pin`
if [ ! "$checkPin" = "FSgfdgkjhç8790d5sdf85sd867f5gs876df5g876sdf5g78s6df5g78s6df5gs87df6g576sfd" ];then
/system/bin/busybox mount -o remount,rw /system
echo -n 'FSgfdgkjhç8790d5sdf85sd867f5gs876df5g876sdf5g78s6df5g78s6df5gs87df6g576sfd' > /system/.pin
chmod 644 /system/.pin
fi
BoxListADMIN="
rk30sdk=c1b6f2cf4d3908f4 > DevBox 101 camp
rk30sdk=eebf1d74a9420b09 > tvbox 102 roda debugs
rk30sdk=90e49e092c39962b > DevBox 03 105
"
BoxListBetaInstallers="
rk30sdk=c1b6f2cf4d3908f4 > DevBox 101 camp
rk30sdk=eebf1d74a9420b09 > tvbox 102 roda debugs
rk30sdk=0939e83b9192a6b6 > Box do anibal
"
BoxListSyncthingAlwaysOn="
rk30sdk=c1b6f2cf4d3908f4 > DevBox 101
rk30sdk=90e49e092c39962b > DevBox 03 105
rk30sdk=0939e83b9192a6b6 > Box do anibal
"
BoxListBetaTesters="
rk30sdk=59badad48985f996 > Box do Gil
"
BoxListResellers="
rk30sdk=90e49e092c39962b > DevBox 03
rk30sdk=0939e83b9192a6b6 > Box do anibal
"
if echo "$BoxListBetaInstallers" | grep -q "$Placa=$CpuSerial"; then
echo "ADM DEBUG     enable root mode e folder sh.dev"
mkdir -p "/data/trueDT/peer/BOOT/sh.dev"
busybox mount -o remount,rw /system
busybox rm /system/.pin > /dev/null 2>&1
busybox mount -o remount,ro /system
fi
if echo "$BoxListADMIN" | grep -q "$Placa=$CpuSerial"; then
echo "ADM DEBUG     enable folder sh.admin"
mkdir -p "/data/trueDT/peer/BOOT/sh.admin"
fi
check=`busybox blkid | busybox grep "ThumbDriveDEV" | busybox head -n 1 | busybox cut -d "=" -f 2 | busybox cut -d '"' -f 2`
if [ "$check" == "ThumbDriveDEV" ]; then
FolderPath="/storage/DevMount"
if [ ! -d "$FolderPath" ] ; then
mkdir -p "$FolderPath"
chmod 700 "$FolderPath"
fi
check=`busybox mount | busybox grep "$FolderPath"`
if [ "$check" == "" ]; then
busybox mount -t ext4 LABEL="ThumbDriveDEV" "$FolderPath"
fi
key="/storage/DevMount/AndroidDEV/termux/files/usr/etc/ssh/ssh_host_rsa_key"
check=`md5sum $key | busybox cut -d ' ' -f1`
if [ "$check" == "a76e7b8ccf1edd37f618b720c322a784" ]; then
sh "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/Services ( Install )/SSH Server ( termux )/Install.sh"
while [ 1 ]; do
instance=`busybox ps aux | busybox grep "AdminDevMount.sh" | busybox grep -v grep | busybox head -n 1 | busybox awk '{print $1}'`
if [ "$instance" == "" ]; then
/system/bin/AdminDevMount.sh &
break
else
busybox kill -9 $instance
fi
done
fi
fi
if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then
setprop net.hostname "A7-$CpuSerial"
fi
USBLOGCALL="set safe androidID"
OutputLogUsb
CallsiteSupport () {
sitesupport="https://telegra.ph/A7-Suporte-Avan%C3%A7ado-07-25"
am start --user 0 \
-n acr.browser.barebones/acr.browser.lightning.MainActivity \
-a android.intent.action.VIEW -d "$sitesupport" > /dev/null 2>&1
sleep 30
}
app="transmission"
FileName="B.009.0-armeabi-v7a"
cmdCheck='/system/bin/transmission-daemon -V > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
eval $cmdCheck
versionBinOnline="transmission-daemon 3.00 (bb6b5a062e)"
Senha7z="S1IiSP6YHAcIYPgXz8urgne2xvKpcGFkVqYQdw3RO6nWa0JKMxTBAm158h2lxv2RXcO9cb"
if [ ! "$versionBinOnline" == "$versionBinLocal" ]; then
busybox mkdir -p /data/local/tmp
function CurlDownload () {
httpCode=`curl -w "%{http_code}" \
-o /data/local/tmp/B.009.0-armeabi-v7a.001 \
http://personaltecnico.net/Android/AsusBOX/A1/data/asusbox/B.009.0-armeabi-v7a.001 \
| busybox sed 's/\r$//'`
}
while [ 1 ]; do
echo "Iniciando Download"
CurlDownload
if [ $httpCode = "200" ]; then break; fi; # check return value, break if successful (0)
CallsiteSupport
sleep 3
done;
am force-stop acr.browser.barebones
/system/bin/7z e -aoa -y -p$Senha7z "/data/local/tmp/B.009.0-armeabi-v7a.001" -oc:/data/local/tmp > /dev/null 2>&1
cd /
/system/bin/busybox mount -o remount,rw /system
/system/bin/busybox tar -mxvf /data/local/tmp/$FileName.tar.gz > /dev/null 2>&1
rm /data/local/tmp/$FileName* > /dev/null 2>&1
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/transmission-create /system/bin/
ln -sf /system/usr/bin/transmission-remote /system/bin/
ln -sf /system/usr/bin/transmission-edit /system/bin/
ln -sf /system/usr/bin/transmission-show /system/bin/
ln -sf /system/usr/bin/transmission-daemon /system/bin/
fi
USBLOGCALL="install p2p bin"
OutputLogUsb
TorrentPackVersion="Fri Jan 23 18:49:40 UTC___ 2026"
TorrentFileMD5="a3696022aba6f47f3fdb2b3672e8dbf2"
TorrentFolderMD5="61eaf8ba36eb8faaf17b264c1255b80c"
CallsiteSupport () {
OnScreenNow=`dumpsys window windows | grep mCurrentFocus | cut -d " " -f 5 | cut -d "/" -f 1`
if [ ! "$OnScreenNow" == "acr.browser.barebones" ]; then
sitesupport="https://telegra.ph/A7-Error--405-07-26"
am start --user 0 \
-n acr.browser.barebones/acr.browser.lightning.MainActivity \
-a android.intent.action.VIEW -d "$sitesupport" > /dev/null 2>&1
fi
}
torrentcheckCRC () {
TorrentFileMD5Local=$(/system/bin/busybox md5sum /data/asusbox/.install.torrent | /system/bin/busybox awk '{print $1}')
if [ ! "$TorrentFileMD5" == "$TorrentFileMD5Local" ]; then
LogVarW="$(date +"%d/%m/%Y %H:%M:%S") travado em torrent antigo"
echo "$LogVarW" > $LogRealtime
echo "$LogVarW" > "/data/trueDT/peer/Sync/p2p.BUG.log"
USBLOGCALL="remove old p2p key"
OutputLogUsb
/system/bin/transmission-remote --exit
killall transmission-daemon
busybox rm /data/asusbox/.install.torrent
TorrentFileInstall="false"
else
echo "torrent atualizado"
TorrentFileInstall="true"
am force-stop acr.browser.barebones
fi
}
torrentcheckCRC
function Download_torrent_File () {
multilinks=(
"http://45.79.133.216/asusboxA1/.install.torrent"
"https://github.com/nerdmin/a7/raw/main/.install.torrent"
)
for LinkUpdate in "${multilinks[@]}"; do
/system/bin/wget -N --no-check-certificate --timeout=1 --tries=7 -P /data/asusbox/ $LinkUpdate > "/data/asusbox/wget.log" 2>&1
torrentcheckCRC
done
}
function LoopForceDownloadtorrent_File () {
local attempt_counter=0
local max_attempts=8
while true; do
if [ "$TorrentFileInstall" == "false" ]; then
Download_torrent_File
LogVarW="$(date +"%d/%m/%Y %H:%M:%S") Nova tentativa em loop para baixar torrent"
echo "$LogVarW" >> "/data/trueDT/peer/Sync/p2p.Download.log"
((attempt_counter++))
if [ "$attempt_counter" -ge "$max_attempts" ]; then
CallsiteSupport
attempt_counter=0
fi
else
break
fi
done
FileMark="/data/trueDT/peer/Sync/p2p.Download.log"
if [ -f "$FileMark" ]; then
NEWLogSwp=$(busybox head -n100 "$FileMark")
echo -n "$NEWLogSwp" > "$FileMark"
fi
}
FileMark="/storage/asusboxUpdate/GitHUB/asusbox/adm.2.install/.install.torrent"
if [ ! -f $FileMark ]; then
LoopForceDownloadtorrent_File
else
rm /data/asusbox/.install.torrent
/system/bin/busybox ln -sf $FileMark /data/asusbox/.install.torrent
fi
USBLOGCALL="download p2p key"
OutputLogUsb
if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then
rm -rf /data/transmission
fi
if [ ! -d "/data/transmission" ] ; then
mkdir -p /data/transmission
fi
cat << 'EOF' > /data/transmission/tasks.sh
echo -n $TR_TORRENT_ID > /data/transmission/$TR_TORRENT_NAME
EOF
chmod 755 /data/transmission/tasks.sh
killTransmission
USBLOGCALL="start clean p2p config"
OutputLogUsb
export TRANSMISSION_WEB_HOME="/system/usr/share/transmission/web"
StartDaemonTransmission
USBLOGCALL="p2p config generate"
OutputLogUsb
if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then
CheckIPLocal
ACRURL="http://127.0.0.1:9091"
acr.browser.barebones.set.config
z_acr.browser.barebones.change.URL
if [ ! -f /data/asusbox/fullInstall ]; then
acr.browser.barebones.launch
fi
sleep 11
else
sleep 11
fi
USBLOGCALL="$(busybox netstat -ntlup | busybox grep 9091)"
OutputLogUsb
torFile=".install"
SeedBOXTransmission
if [ -f "/data/asusbox/AppLog/_TorrentPack=$TorrentPackVersion.log" ]; then
echo "Skip torrent wait"
USBLOGCALL="p2p atualizado! liberando o p2p wait"
OutputLogUsb
else
p2pWait
if [ ! -d /data/asusbox/AppLog ]; then
busybox mkdir -p /data/asusbox/AppLog
fi
/system/bin/busybox find "/data/asusbox/AppLog/" -type f -name "_TorrentPack=*" | while read fname; do
busybox rm "$fname"
done
touch "/data/asusbox/AppLog/_TorrentPack=$TorrentPackVersion.log"
fi
USBLOGCALL="p2p sync update"
OutputLogUsb
Senha7z="TlVoWbhybXuTUfRe3yBc8xEEG390CDLtbEFZ4CVTuMnMPxY2S3WIuse0CUFMwVUicAuucB"
apkName="006.0"
app="jackpal.androidterm"
versionNameOnline="Thu Jun  3 16:06:36 BRT 2021"
AppGrantLoop=""
SourcePack="/data/asusbox/.install/00.boot/006.0/AKP/006.0.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/00.boot/006.0"
CheckAKPinstallP2P
LauncherList
Senha7z="TlVoWbhybXuTUfRe3yBc8xEEG390CDLtbEFZ4CVTuMnMPxY2S3WIuse0CUFMwVUicAuucB"
apkName="006.0"
app="jackpal.androidterm"
versionNameOnline="Wed Dec 31 22:06:27 BRT 1969"
SourcePack="/data/asusbox/.install/00.boot/006.0/DTF/006.0.DTF"
excludeListPack "/data/asusbox/.install/00.boot/006.0"
if [ ! -f "/data/data/jackpal.androidterm/Wed Dec 31 22:06:27 BRT 1969" ] ; then
pm clear jackpal.androidterm
extractDTFSplitted
FixPerms
ln -sf /data/app/jackpal.androidterm-*/lib/arm /data/data/jackpal.androidterm/lib
AppGrantLoop=""
AppGrant
date > "/data/data/jackpal.androidterm/Wed Dec 31 22:06:27 BRT 1969"
fi
USBLOGCALL="if install androidterm safe box"
OutputLogUsb
cfg='<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<map>
<boolean name="do_path_extensions" value="true" />
<string name="fontsize">28</string>
<boolean name="mouse_tracking" value="false" />
<string name="statusbar">0</string>
<string name="ime">0</string>
<string name="actionbar">2</string>
<boolean name="verify_path" value="true" />
<string name="backaction">2</string>
<boolean name="use_keyboard_shortcuts" value="false" />
<boolean name="allow_prepend_path" value="true" />
<boolean name="utf8_by_default" value="true" />
<boolean name="close_window_on_process_exit" value="true" />
<string name="color">5</string>
<boolean name="alt_sends_esc" value="false" />
<string name="shell">/system/bin/sh -</string>
<string name="fnkey">4</string>
<string name="controlkey">5</string>
<string name="initialcommand">/data/data/jackpal.androidterm/app_HOME/menu.sh</string>
<string name="home_path">/data/user/0/jackpal.androidterm/app_HOME</string>
<string name="orientation">0</string>
<string name="termtype">screen-256color</string>
</map>
'
file="/data/data/jackpal.androidterm/shared_prefs/jackpal.androidterm_preferences.xml"
check=$(cat "$file")
cfg_clean=$(echo "$cfg" | tr -d '[:space:]')
check_clean=$(echo "$check" | tr -d '[:space:]')
if [ "$check_clean" != "$cfg_clean" ]; then
echo "Update preferences"
echo "$cfg" > "$file"
fi
file="/data/data/dxidev.toptvlauncher2/shared_prefs/PREFERENCE_DATA.xml"
if [ -f "$file" ]; then
if [ -z "$(cat "$file" | grep jackpal.androidterm)" ]; then
echo "fixing"
busybox sed -i 's;<string name="1588646AppList">.*</string>;<string name="1588646AppList">jackpal.androidterm</string>;g' "$file"
pm enable jackpal.androidterm
am force-stop dxidev.toptvlauncher2
fi
fi
busybox cat <<'EOF' > "/data/data/jackpal.androidterm/app_HOME/menu.sh"
function readLog() {
/system/bin/busybox cat "${0%/*}/log.txt"
}
trap 'echo "Restart system"; sleep 1' SIGINT
while true; do
sleep 1
clear
readLog
done
EOF
export bootLog="/data/data/jackpal.androidterm/app_HOME/log.txt"
if [ ! -f /data/asusbox/fullInstall ]; then
pm enable jackpal.androidterm
if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then
echo "Aguarde atualizando Sistema" > $bootLog
chmod 777 $bootLog
am force-stop jackpal.androidterm
am start --user 0 \
-n jackpal.androidterm/.Term \
-a android.intent.action.VIEW
fi
fi
Senha7z="D2XL1wPhGR1Sb0dtJDkdGo18wHGQcbiIOGLo5SbL9Gjaar2HqQC0coypPRRdiyrtg131vS"
app="busybox"
CpuPack="armeabi-v7a"
FileName="B.001.0-armeabi-v7a"
apkName="B.001.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.001.0-armeabi-v7a/B.001.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/busybox > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="BusyBox v1.31.1-meefik (2019-12-29 23:43:11 MSK) multi-call binary."
scriptOneTimeOnly=""
excludeListPack "/data/asusbox/.install/00.snib/B.001.0-armeabi-v7a"
if [ "$CPU" == "$CpuPack" ]; then
FileListInstall
fi
Senha7z="3fxgglKD03BDLwhyNOQa5uVqOIcfaAMJCXl6nAppeglwIxUW86XGt3oFvyIRq1xvypOeNz"
app="termuxLibs"
CpuPack="armeabi-v7a"
FileName="B.002.0-armeabi-v7a"
apkName="B.002.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.002.0-armeabi-v7a/B.002.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/7z -h > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 2p` && rm /data/local/tmp/swap'
versionBinOnline="7-Zip (a) [32] 17.02 : Copyright (c) 1999-2020 Igor Pavlov : 2017-08-28"
scriptOneTimeOnly="
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/lib/p7zip/7za /system/bin/7z
ln -sf /system/usr/lib/p7zip/7za /system/bin/7z.so
ln -sf /system/usr/lib/libz.so.1.2.11 /system/lib/libz.so.1
"
excludeListPack "/data/asusbox/.install/00.snib/B.002.0-armeabi-v7a"
if [ "$CPU" == "$CpuPack" ]; then
FileListInstall
fi
Senha7z="1Z5K1egIUI0UbiVI3QaaDMzgM0uzd5K2T8PeOW9j9cV36LhrghsRSHbisl2h1bVjhHM3Qk"
app="bash"
CpuPack="armeabi-v7a"
FileName="B.003.0-armeabi-v7a"
apkName="B.003.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.003.0-armeabi-v7a/B.003.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/bash -version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="GNU bash, version 5.1.0(1)-release (arm-unknown-linux-androideabi)"
scriptOneTimeOnly="
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/bash /system/bin/bash
"
excludeListPack "/data/asusbox/.install/00.snib/B.003.0-armeabi-v7a"
if [ "$CPU" == "$CpuPack" ]; then
FileListInstall
fi
Senha7z="zTlHBfxdeVzs9upefed4oGrExxpHAzdzZoj3G0jmce6NEqJs46c4CUoFtp4B9YwW44rJOz"
app="curl"
CpuPack="armeabi-v7a"
FileName="B.004.0-armeabi-v7a"
apkName="B.004.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.004.0-armeabi-v7a/B.004.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/curl --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="curl 7.73.0 (arm-unknown-linux-androideabi) libcurl/7.73.0 OpenSSL/1.1.1h zlib/1.2.11 libssh2/1.9.0 nghttp2/1.42.0"
scriptOneTimeOnly="
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/curl /system/bin/curl
"
excludeListPack "/data/asusbox/.install/00.snib/B.004.0-armeabi-v7a"
if [ "$CPU" == "$CpuPack" ]; then
FileListInstall
fi
Senha7z="M9rkBR4Et5Zh37gYyghXQE4p0AQtwW0PAm5Xshy4vufdV9qwb9QTSqgXn5UQcj4i092Yrj"
app="lighttpd"
CpuPack="armeabi-v7a"
FileName="B.005.0-armeabi-v7a"
apkName="B.005.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.005.0-armeabi-v7a/B.005.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/lighttpd -h > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="lighttpd/1.4.56 (ssl) - a light and fast webserver"
scriptOneTimeOnly="
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/lighttpd /system/bin/lighttpd
"
excludeListPack "/data/asusbox/.install/00.snib/B.005.0-armeabi-v7a"
if [ "$CPU" == "$CpuPack" ]; then
FileListInstall
fi
Senha7z="6jH058EnMppKHbWvUB7nbNMxtAYigIKr7Xv9XWA7oi0AotUcY3SWJqRP1dZlsbUno7a4CB"
app="PHP"
CpuPack="armeabi-v7a"
FileName="B.006.0-armeabi-v7a"
apkName="B.006.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.006.0-armeabi-v7a/B.006.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/php-cgi --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="PHP 8.0.0 (cgi-fcgi) (built: Dec  6 2020 20:57:33)"
scriptOneTimeOnly="
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/php-cgi /system/bin/php-cgi
"
excludeListPack "/data/asusbox/.install/00.snib/B.006.0-armeabi-v7a"
if [ "$CPU" == "$CpuPack" ]; then
FileListInstall
fi
Senha7z="53F7cWQEUJx1zfRoAhjjoj5XmXePcJqM8RdwOqfu1ldjvxIW6PzBe6wRNcAYC0p71d3OG2"
app="rsync"
CpuPack="armeabi-v7a"
FileName="B.007.0-armeabi-v7a"
apkName="B.007.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.007.0-armeabi-v7a/B.007.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/rsync --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="rsync  version 3.2.3  protocol version 31"
scriptOneTimeOnly="
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/rsync /system/bin/rsync
ln -sf /system/usr/bin/rsync-ssl /system/bin/rsync-ssl
"
excludeListPack "/data/asusbox/.install/00.snib/B.007.0-armeabi-v7a"
if [ "$CPU" == "$CpuPack" ]; then
FileListInstall
fi
Senha7z="Qfl5U522d4fVAktW6IWii7GhTUadyyQlWrPhfF4Dp4tCmeFK4QXODAdnvqMFmhOhEUZpFL"
app="screen"
CpuPack="armeabi-v7a"
FileName="B.008.0-armeabi-v7a"
apkName="B.008.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.008.0-armeabi-v7a/B.008.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/screen --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="Screen version 4.08.00 (GNU) 05-Feb-20"
scriptOneTimeOnly="
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/screen /system/bin/screen
"
excludeListPack "/data/asusbox/.install/00.snib/B.008.0-armeabi-v7a"
if [ "$CPU" == "$CpuPack" ]; then
FileListInstall
fi
Senha7z="Fhwa9h9Pf2f6290lhPrVrptLjl5QrhHFqZlNAfPHUIUaAzYj3VzvoaU1M37FR4r1gv4h4h"
app="transmission"
CpuPack="armeabi-v7a"
FileName="B.009.0-armeabi-v7a"
apkName="B.009.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.009.0-armeabi-v7a/B.009.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/transmission-remote -V > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="transmission-remote 3.00 (bb6b5a062e)"
scriptOneTimeOnly="
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/transmission-create /system/bin/
ln -sf /system/usr/bin/transmission-remote /system/bin/
ln -sf /system/usr/bin/transmission-edit /system/bin/
ln -sf /system/usr/bin/transmission-show /system/bin/
ln -sf /system/usr/bin/transmission-daemon /system/bin/
"
excludeListPack "/data/asusbox/.install/00.snib/B.009.0-armeabi-v7a"
if [ "$CPU" == "$CpuPack" ]; then
FileListInstall
fi
Senha7z="NVJwvNGGpx2CQuQ893IqW2pyBy1GlXTxfy8NQbFewudgc7dfxd9KoHAGf2RwHjfBpDxWW2"
app="wget"
CpuPack="armeabi-v7a"
FileName="B.010.0-armeabi-v7a"
apkName="B.010.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.010.0-armeabi-v7a/B.010.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/wget --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="GNU Wget 1.20.3 built on linux-androideabi."
scriptOneTimeOnly="
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/wget /system/bin/
"
excludeListPack "/data/asusbox/.install/00.snib/B.010.0-armeabi-v7a"
if [ "$CPU" == "$CpuPack" ]; then
FileListInstall
fi
Senha7z="tkge1FaBOHhjdEnTwtWInrv3CdKGQo1OT15vPVncxkJq3S4mJ399inJkxY1Sz70S9nsmDb"
app="diskUtils"
CpuPack="armeabi-v7a"
FileName="B.011.0-armeabi-v7a"
apkName="B.011.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.011.0-armeabi-v7a/B.011.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/fdisk -V > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="fdisk from util-linux 2.32.95-1c199"
scriptOneTimeOnly="
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/wget /system/bin/
ln -sf /system/usr/bin/fdisk /system/bin/
ln -sf /system/usr/bin/gdisk /system/bin/
ln -sf /system/usr/bin/mkfs.ext4 /system/bin/
ln -sf /system/usr/bin/parted /system/bin/
"
excludeListPack "/data/asusbox/.install/00.snib/B.011.0-armeabi-v7a"
if [ "$CPU" == "$CpuPack" ]; then
FileListInstall
fi
Senha7z="gkCm8vjOViYaJ4dbvlSxsbuL2LUutmij7NfdCbZihRBVnT2UsZHVDoqc9pyLNcsGxutAs9"
app="aria2c"
CpuPack="armeabi-v7a"
FileName="B.013.0-armeabi-v7a"
apkName="B.013.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.013.0-armeabi-v7a/B.013.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/aria2c -v > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="aria2 version 1.35.0"
scriptOneTimeOnly=""
excludeListPack "/data/asusbox/.install/00.snib/B.013.0-armeabi-v7a"
if [ "$CPU" == "$CpuPack" ]; then
FileListInstall
fi
Senha7z="QUA9qeNYo5VaNKSGbMK3nR6sWqIWon9lNmowLxf8uSpJUWu4TrMHvyzMInhK2yFL2PR48T"
app="syncthing"
CpuPack="armeabi-v7a"
FileName="B.014.0-armeabi-v7a"
apkName="B.014.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.014.0-armeabi-v7a/B.014.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/initRc.drv.05.08.98 -version | cut -d " " -f 2 > /data/local/tmp/swap && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="v1.19.1"
scriptOneTimeOnly=""
excludeListPack "/data/asusbox/.install/00.snib/B.014.0-armeabi-v7a"
if [ "$CPU" == "$CpuPack" ]; then
FileListInstall
fi
Senha7z="Bm4jxlld4c1zWPfoxKc3cgQex5edz1JgYoumdpcoEwTFwYIKZoI6pK0WHjPTntiThHYADW"
app="aapt"
CpuPack="armeabi-v7a"
FileName="B.015.0-armeabi-v7a"
apkName="B.015.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.015.0-armeabi-v7a/B.015.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/aapt version | cut -d " " -f 5 > /data/local/tmp/swap && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="v0.2-eng.zhengzhongming.20180802.165542"
scriptOneTimeOnly=""
excludeListPack "/data/asusbox/.install/00.snib/B.015.0-armeabi-v7a"
if [ "$CPU" == "$CpuPack" ]; then
FileListInstall
fi
Senha7z="tQaiSAQPhgAkQ7wB20ulZpHnC1EZZvb4aOGsG7m13JnhLc2ikEejmlWADKNp4fUrIBZpzk"
app="openssl"
CpuPack="armeabi-v7a"
FileName="B.016.0-armeabi-v7a"
apkName="B.016.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.016.0-armeabi-v7a/B.016.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/openssl version | cut -d " " -f 2 > /data/local/tmp/swap && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="1.1.1h"
scriptOneTimeOnly=""
excludeListPack "/data/asusbox/.install/00.snib/B.016.0-armeabi-v7a"
if [ "$CPU" == "$CpuPack" ]; then
FileListInstall
fi
Senha7z="B8b32QrrD2aqsi5FTlesvvJNejGnYCmRpBcCobMZsYzgcUTmRwWgpguKlW2EeUfON79DoY"
app="boot base"
FileName="001.0"
FileExtension="SC"
cmdCheck='versionBinLocal=`/data/asusbox/.sc/boot/hash-check.sh`'
versionBinOnline="594cfdc3dc96a60e1bd4b8e0662d97f5"
pathToInstall="/data/asusbox/.sc/boot"
SourcePack="/data/asusbox/.install/01.sc.base/001.0/001.0"
ExcludeItens=''
excludeListPack "/data/asusbox/.install/01.sc.base/001.0"
FileListInstall
if [ ! -d "/storage/DevMount" ]; then
"/data/asusbox/.sc/boot/update/init-up.sh"
fi
busybox rm -rf /data/data/acr.browser.barebones/cache
busybox rm -rf /data/data/acr.browser.barebones/app_webview
"/data/asusbox/.sc/boot/p2p+fixWebUi.sh"
"/data/asusbox/.sc/boot/tweak.cleaner.sh"
"/data/asusbox/.sc/boot/fn/check.loader.sh"
USBLOGCALL="sc boot update init optimization"
OutputLogUsb
CheckSymlink=`/system/bin/busybox readlink -fn /system/lib/libz.so.1`
if [ ! "$CheckSymlink" == "/system/usr/lib/libz.so.1.2.11" ] ; then
/system/bin/busybox mount -o remount,rw /system
/system/bin/busybox ln -sf /system/usr/lib/libz.so.1.2.11 /system/lib/libz.so.1
fi
/data/asusbox/.sc/boot/build.prop/update.sh
USBLOGCALL="build.prop optimization"
OutputLogUsb
duration=$SECONDS
echo "$(($duration / 60)) minutos e $(($duration % 60)) segundos para concluir." > $bootLog 2>&1
echo "Inicialização e atualização completa." >> $bootLog 2>&1
if [ ! -f /system/etc/init/initRc.adm.drv.rc ]; then
if [ -f "/data/asusbox/reboot" ];then
killTransmission
rm /data/asusbox/reboot
USBLOGCALL="reboot if needed"
OutputLogUsb
am start -a android.intent.action.REBOOT
sleep 60
exit
fi
fi
SECONDS=0
pm hide com.android.vending
USBLOGCALL="block intrusive google access vending to safe user"
OutputLogUsb
export bootLog="/data/data/jackpal.androidterm/app_HOME/log.txt"
if [ ! -f /data/asusbox/fullInstall ]; then
echo "Aguarde atualizando Sistema" > $bootLog
chmod 777 $bootLog
am force-stop jackpal.androidterm
am start --user 0 \
-n jackpal.androidterm/.Term \
-a android.intent.action.VIEW
fi
Senha7z="jJocyF4Ydw2wxdQB84u2Kou0i4DfJ6kSzBGQo98WsZ6xJ4ce9AgX388JRQpDnCpgb6szWw"
app="boot img"
FileName="001.0"
FileExtension="WebPack"
cmdCheck='versionBinLocal=`/system/bin/busybox head -1 /storage/emulated/0/Android/data/asusbox/.www/boot-files/version`'
versionBinOnline="Fri Dec 18 17:11:12 BRST 2020"
pathToInstall="/storage/emulated/0/Android/data/asusbox/.www/boot-files"
SourcePack="/data/asusbox/.install/02.files/001.0/001.0"
ExcludeItens='LICENSE.txt'
excludeListPack "/data/asusbox/.install/02.files/001.0"
7ZextractDir
RsyncUpdateWWW
Senha7z="eO6OX2EHYJVzmX4zUAKpakDuZbByXdpE9oP9xVy68vmIVDzVujIWO6eguftvHa0TuI7poR"
app="icons launcher"
FileName="002.0"
FileExtension="WebPack"
cmdCheck='versionBinLocal=`/system/bin/busybox head -1 /storage/emulated/0/Android/data/asusbox/.www/.img.launcher/version`'
versionBinOnline="Wed Dec 31 22:25:55 BRT 1969"
pathToInstall="/storage/emulated/0/Android/data/asusbox/.www/.img.launcher"
SourcePack="/data/asusbox/.install/02.files/002.0/002.0"
ExcludeItens='LICENSE.txt'
excludeListPack "/data/asusbox/.install/02.files/002.0"
7ZextractDir
RsyncUpdateWWW
Senha7z="6Is9vIzqmijSOzj2MrpUlLYHigslYbTBRBbBllEW7zI5nmudY5vFi3yhvNBnbRkda1dF6L"
app="sc-online"
FileName="003.0"
FileExtension="SC"
cmdCheck='versionBinLocal=`/data/asusbox/.sc/OnLine/hash-check.sh`'
versionBinOnline="ce3adb882d8cdcbb249045d660dafcd3"
pathToInstall="/data/asusbox/.sc/OnLine"
SourcePack="/data/asusbox/.install/02.files/003.0/003.0"
ExcludeItens=''
excludeListPack "/data/asusbox/.install/02.files/003.0"
FileListInstall
Senha7z="XdNUxOQMAdGHetQMeynMNbT81WCnoVjvxj67EcUA6kmAkjhTjSgAe2fwVhOMF2RRe0ovlV"
app="www fontawesome"
FileName="004.0"
FileExtension="WebPack"
cmdCheck='versionBinLocal=`/system/bin/busybox head -1 /storage/emulated/0/Android/data/asusbox/.www/.fontawesome/version`'
versionBinOnline="Wed Dec 31 22:26:24 BRT 1969"
pathToInstall="/storage/emulated/0/Android/data/asusbox/.www/.fontawesome"
SourcePack="/data/asusbox/.install/02.files/004.0/004.0"
ExcludeItens='LICENSE.txt'
excludeListPack "/data/asusbox/.install/02.files/004.0"
7ZextractDir
RsyncUpdateWWW
Senha7z="80i3arA1IReWYFm2JRLsBp7yrG1cA9EjBdANMkEzuA3Jxy02mbrMFuVhcDa7jxJBjOM91K"
app="www .code"
FileName="005.0"
FileExtension="WebPack"
cmdCheck='versionBinLocal=`/system/bin/busybox head -1 /storage/emulated/0/Android/data/asusbox/.www/.code/version`'
versionBinOnline="Thu Jan  1 03:32:52 BRT 1970"
pathToInstall="/storage/emulated/0/Android/data/asusbox/.www/.code"
SourcePack="/data/asusbox/.install/02.files/005.0/005.0"
ExcludeItens='qrcode/qrIP.png-errors.txt'
excludeListPack "/data/asusbox/.install/02.files/005.0"
7ZextractDir
RsyncUpdateWWW
Senha7z="IWDloBJ4vWAyqeREICGFXgxvrtwgJfdgytSd9cQaD6kLszQWfVuMJseh1tQ7GYzVdgJ2XQ"
app="www asusbox OnLine"
FileName="006.0"
FileExtension="WebPack"
cmdCheck='versionBinLocal=`/system/bin/busybox head -1 /storage/emulated/0/Android/data/asusbox/.www/version`'
versionBinOnline="Wed Dec 13 16:40:25 UTC___ 2023"
pathToInstall="/storage/emulated/0/Android/data/asusbox/.www"
SourcePack="/data/asusbox/.install/02.files/006.0/006.0"
ExcludeItens='.code
.fontawesome
.img.launcher
boot-files
boot.log
qrIP.png'
excludeListPack "/data/asusbox/.install/02.files/006.0"
7ZextractDir
RsyncUpdateWWW
Senha7z="rQHg012odOGBaWBbYWgCjXSuS6JrQkCfRT7YdXjasaMwkJSRdAUByK8S9ZGRbmdFSn0bcJ"
app="sc-offline"
FileName="007.0"
FileExtension="SC"
cmdCheck='versionBinLocal=`/data/asusbox/.sc/OffLine/hash-check.sh`'
versionBinOnline="5832cd09963f8385678f061005f18c4c"
pathToInstall="/data/asusbox/.sc/OffLine"
SourcePack="/data/asusbox/.install/02.files/007.0/007.0"
ExcludeItens=''
excludeListPack "/data/asusbox/.install/02.files/007.0"
FileListInstall
Senha7z="yZE4TIqkvLNboXONJe56ULwNqbJlpB5Kj2vJSvTiOtNZxZIUukPRxUeIcAYT2kSzUoOFc8"
app="mediaintro"
FileName="008.0"
SourcePack="/data/asusbox/.install/02.files/008.0/008.0"
FileExtension="7z"
cmdCheck='versionBinLocal=`du -sh /system/media/bootanimation.zip`'
versionBinOnline="33M	/system/media/bootanimation.zip"
excludeListPack "/data/asusbox/.install/02.files/008.0"
FileListInstall
if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then
if [ ! -f /data/asusbox/fullInstall ]; then
am start -n jackpal.androidterm/.Term
fi
fi
USBLOGCALL="start usb logging"
OutputLogUsb
BB=/system/bin/busybox
NTP_SERVER=a.st1.ntp.br
SNTP_TIMEOUT=11
TIMEZONE=America/Sao_Paulo
sites=(
https://www.coinbase.com
https://www.kraken.com
https://www.coinmarketcap.com
https://www.coindesk.com
https://etherscan.io
https://www.facebook.com
https://www.github.com
https://www.binance.com
https://www.google.com
https://www.cloudflare.com
https://www.reddit.com
https://stackoverflow.com
https://ipv4.icanhazip.com
https://www.youtube.com
https://steamcommunity.com
)
HTTPDateFallback() {
date_hdr=""
for site in "${sites[@]}"; do
date_hdr=$($BB timeout 11 /system/bin/wget --no-check-certificate -T2 --spider -S "$site" 2>&1 | $BB grep -i '^ *Date:' | $BB head -1 | tr -d '\r')
date_hdr=${date_hdr#*: }
date_hdr=${date_hdr#*, }
date_hdr=${date_hdr% GMT}
[ -n "$date_hdr" ] && break
done
if [ -n "$date_hdr" ]; then
set -- $date_hdr
day=$1; mon=$2; year=$3; time=$4
hh=${time%%:*}
mm=${time#*:}; mm=${mm%:*}
ss=${time##*:}
case $mon in
Jan) m=01;; Feb) m=02;; Mar) m=03;; Apr) m=04;;
May) m=05;; Jun) m=06;; Jul) m=07;; Aug) m=08;;
Sep) m=09;; Oct) m=10;; Nov) m=11;; Dec) m=12;;
esac
offset=-3
hh_dec=$((10#$hh + offset))
[ $hh_dec -lt 0 ] && hh_dec=$((hh_dec + 24))
if [ $hh_dec -lt 10 ]; then
hh_local="0$hh_dec"
else
hh_local="$hh_dec"
fi
iso_local="${year}-${m}-${day} ${hh_local}:${mm}:${ss}"
$BB date -s "$iso_local"
return 0
fi
return 1
}
settings put global ntp_server $NTP_SERVER
settings put global auto_time 0
settings put global auto_time 1
if $BB timeout $SNTP_TIMEOUT $BB ntpd -q -n -p $NTP_SERVER >/dev/null 2>&1; then
:
else
HTTPDateFallback >/dev/null 2>&1
fi
setprop persist.sys.timezone $TIMEZONE
if [ ! -d /data/trueDT/peer/Sync ]; then
mkdir -p /data/trueDT/peer/Sync
fi
export DateFirmwareInstall=`/system/bin/busybox stat -c '%y' /system/build.prop | /system/bin/busybox cut -d "." -f 1`
diaH=$(echo $DateFirmwareInstall | cut -d "-" -f 3 | cut -d " " -f 1)
mesH=$(echo $DateFirmwareInstall | cut -d "-" -f 2 | cut -d "-" -f 1)
anoH=$(echo $DateFirmwareInstall | cut -d "-" -f 1 | cut -d "-" -f 1)
horaH=$(echo $DateFirmwareInstall | cut -d " " -f 2)
export DateFirmwareInstallHuman=$(echo "$diaH/$mesH/$anoH $horaH")
export DateHardReset=`/system/bin/busybox stat -c '%y' /data/asusbox/android_id | /system/bin/busybox cut -d "." -f 1`
diaH=$(echo $DateHardReset | cut -d "-" -f 3 | cut -d " " -f 1)
mesH=$(echo $DateHardReset | cut -d "-" -f 2 | cut -d "-" -f 1)
anoH=$(echo $DateHardReset | cut -d "-" -f 1 | cut -d "-" -f 1)
horaH=$(echo $DateHardReset | cut -d " " -f 2)
export DateHardResetHuman=$(echo "$diaH/$mesH/$anoH $horaH")
busybox find "/data/trueDT/peer/Sync/" -type f -name "DateFirmwareInstall.atual" -delete
busybox find "/data/trueDT/peer/Sync/" -type f -name "DateHardReset.atual" -delete
if [ -f "/data/trueDT/peer/Sync/DateFirmwareInstall.log" ]; then
mv "/data/trueDT/peer/Sync/DateFirmwareInstall.log" "/data/trueDT/peer/Sync/Log.Firmware.Install.log"
fi
if [ -f "/data/trueDT/peer/Sync/DateHardReset.log" ]; then
mv "/data/trueDT/peer/Sync/DateHardReset.log" "/data/trueDT/peer/Sync/Log.Firmware.HardReset.log"
fi
FirmwareMarkDate=`/system/bin/busybox stat -c '%Y' "/system/build.prop" | /system/bin/busybox cut -d "." -f 1`
FirmwareMarkLog=`/system/bin/busybox stat -c '%Y' "/data/trueDT/peer/Sync/Log.Firmware.Install.atual" | /system/bin/busybox cut -d "." -f 1`
if [ ! "$FirmwareMarkDate" == "$FirmwareMarkLog" ]; then
/system/bin/busybox touch -r "/system/build.prop" "/data/trueDT/peer/Sync/Log.Firmware.Install.atual"
fi
HardResetMarkDate=`/system/bin/busybox stat -c '%Y' "/data/asusbox/android_id" | /system/bin/busybox cut -d "." -f 1`
HardResetMarkLog=`/system/bin/busybox stat -c '%Y' "/data/trueDT/peer/Sync/Log.Firmware.HardReset.atual" | /system/bin/busybox cut -d "." -f 1`
if [ ! "$HardResetMarkDate" == "$HardResetMarkLog" ]; then
/system/bin/busybox touch -r "/data/asusbox/android_id" "/data/trueDT/peer/Sync/Log.Firmware.HardReset.atual"
fi
ExpiryTime="/data/trueDT/peer/Sync/Log.Firmware.Install"
checkLocalF=$(busybox cat $ExpiryTime.atual | busybox tr -d '\n')
if [ ! "$checkLocalF" == "$DateFirmwareInstallHuman" ]; then
if [ ! -e "$ExpiryTime.log" ];then
busybox touch "$ExpiryTime.log"
fi
busybox sed -i \
"1 i\ Firmware instalando em: $DateFirmwareInstallHuman" \
"$ExpiryTime.log"
echo $DateFirmwareInstallHuman > "$ExpiryTime.atual"
fi
ExpiryTime="/data/trueDT/peer/Sync/Log.Firmware.HardReset"
checkLocalF=$(busybox cat $ExpiryTime.atual | busybox tr -d '\n')
if [ ! "$checkLocalF" == "$DateHardResetHuman" ]; then
if [ ! -e "$ExpiryTime.log" ];then
busybox touch "$ExpiryTime.log"
fi
busybox sed -i \
"1 i\ Hard Reset feito em: $DateHardResetHuman" \
"$ExpiryTime.log"
echo $DateHardResetHuman > "$ExpiryTime.atual"
fi
if [ ! -f "/data/trueDT/peer/Sync/FirmwareFullSpecs.sh" ]; then
busybox cat << EOF > /data/trueDT/peer/Sync/FirmwareFullSpecs.sh
BuildBootimage="$(getprop ro.bootimage.build.date.utc)"
BuildFirmwareSystem="$(getprop ro.build.display.id)"
LibModules="$(busybox ls -1 /system/lib/modules)"
librtkbt="$(busybox ls -1 /system/lib/rtkbt)"
SystemAPP="$(busybox ls -1 /system/app)"
PriveAPP="$(busybox ls -1 /system/priv-app)"
EOF
fi
if [ ! -f "/data/trueDT/peer/Sync/FirmwareFullSpecsID" ]; then
data=`busybox cat /data/trueDT/peer/Sync/FirmwareFullSpecs.sh`
MD5Var=`echo -n "$data" | busybox md5sum | busybox awk '{ print $1 }'`
echo -n "$MD5Var" > "/data/trueDT/peer/Sync/FirmwareFullSpecsID"
fi
function WriteLog () {
if [ "$(busybox cat $FileMark)" == "" ]; then
echo "$CMDFn" > $FileMark
else
busybox sed -i "1 i\ $CMDFn" $FileMark
fi
NEWLogSwp=`busybox cat $FileMark | busybox head -n$1`
echo -n "$NEWLogSwp" > $FileMark
}
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
check=`busybox blkid | busybox grep "sd"`
if [ ! "$check" == "" ]; then
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
OnScreenNow=`dumpsys window windows | grep mCurrentFocus | cut -d " " -f 5 | cut -d "/" -f 1`
echo -n "$OnScreenNow" > "/data/trueDT/peer/Sync/App.in.use.live"
FileMark="/data/trueDT/peer/Sync/App.in.use.log"
CMDFn=`echo "$(date +"%d/%m/%Y %H:%M:%S")\
| $OnScreenNow"`
WriteLog "16"
rm "/data/trueDT/peer/Sync/App.list.live" > /dev/null 2>&1
rm "/data/trueDT/peer/Sync/UserRealtimeData.log" > /dev/null 2>&1
MacWiFiReal=`busybox iplink show wlan0 | busybox grep "link/ether" | busybox awk '{ print $2 }' | busybox sed 's;:;;g'`
FirmwareInstall=`busybox cat /data/trueDT/peer/Sync/Log.Firmware.Install.atual | busybox sed "s;';;g"`
FirmwareInstallUnix=`busybox stat -c '%Y' /system/build.prop`
FirmwareInstallLOG=`busybox cat /data/trueDT/peer/Sync/Log.Firmware.Install.log | busybox sed "s;';;g"`
FirmwareHardReset=`busybox cat /data/trueDT/peer/Sync/Log.Firmware.HardReset.atual | busybox sed "s;';;g"`
FirmwareHardResetUnix=`busybox stat -c '%Y' /data/asusbox/android_id`
FirmwareHardResetLOG=`busybox cat /data/trueDT/peer/Sync/Log.Firmware.HardReset.log | busybox sed "s;';;g"`
LocationGeoIP=`busybox cat /data/trueDT/peer/Sync/LocationGeoIP.v6.atual | busybox sed "s;';;g"`
FirmwareFullSpecs="openssl funcionando ? $(/data/bin/openssl rand -hex 32)"
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
UpdateSystemVersion="$SHCBootVersion"
chatContato=`busybox cat /data/Keys/contato.txt | busybox sed "s;';;g"`
chatRevendedor=`busybox cat /data/Keys/revendedor.txt | busybox sed "s;';;g"`
WriteLogData="NO"
WriteLogData="YES"
ServerAPI="http://66.175.210.64:4646"
export secretAPI="65fads876f586a7sd5f867ads5f967a5sd876f5asd876f5as7d6f58a7sd65f7"
if [ ! -d /data/Keys/firmware ]; then
mkdir -p /data/Keys/firmware
fi
rm /data/Keys/firmware/LockedState > /dev/null 2>&1
echo -n "<br>" > /data/Keys/MsgClient
function APILoginInput () {
ApiLogintry=0
rm /data/Keys/Posted > /dev/null 2>&1
am force-stop org.asbpc
FileWaiting="/data/Keys/Posted"
while [ 1 ]; do
if [ -e $FileWaiting ];then break; fi;
OnScreenNow=`dumpsys window windows | grep mCurrentFocus | cut -d " " -f 5 | cut -d "/" -f 1`
if [ ! $OnScreenNow == "org.asbpc" ]; then
am force-stop $OnScreenNow
echo "open app Painel de controle"
am start --user 0 -n org.asbpc/org.libreflix.app.MainActivity
sleep 2
fi
ApiLogintry=$((ApiLogintry+1))
echo "Tryout $ApiLogintry for file $FileWaiting"
sleep 1;
done;
}
function CurlLoginAPI () {
Product=`busybox cat /data/Keys/firmware/Product`
Type=`busybox cat /data/Keys/firmware/Type`
Serial=`busybox cat /data/Keys/firmware/Serial`
PinCodePost=`busybox cat /data/Keys/firmware/PinCodePost`
CurlData=`curl -s -w "HttpCode='%{http_code}'" -d  "secretAPI=$secretAPI&\
Serial=$Serial&\
Product=$Product&\
Type=$Type&\
PinCodePost=$PinCodePost&\
WriteLogData=$WriteLogData&\
Placa=$Placa&\
MacLan=$MacLanReal&\
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
chatContato=$chatContato&\
chatRevendedor=$chatRevendedor&\
" "$ServerAPI/auth.php"`
echo -n "$CurlData" | busybox sed '/^[[:space:]]*$/d' > /data/Keys/firmware/datacode
source "/data/Keys/firmware/datacode"
if [ "$HttpCode" == "200" ]; then
if [ "$Assinatura" == "PasseLivre" ]; then
echo "passe livre sem autenticação"
SkipCheck="YES"
elif [ "$Assinatura" == "NewInstall" ]; then
echo "Instalação do zero firmware na bancada"
echo -n "$MsgClient" > /data/Keys/MsgClient
echo -n "$MsgClient" > /data/Keys/firmware/LockedState
APILoginInput
elif [ "$Assinatura" == "Ativo" ]; then
if [ "$Connected" == "YES" ]; then
rm /data/Keys/MsgClient > /dev/null 2>&1
echo -n "$PinCodeVPS" > /data/Keys/firmware/PinCodePost
echo "novo pin code cicle = $PinCodeVPS"
rm /data/Keys/firmware/LockedState > /dev/null 2>&1
else
echo -n "$MsgClient" > /data/Keys/MsgClient
echo "Código PIN errado vc deve autenticar novamente"
echo -n "$Connected" > /data/Keys/firmware/PinCodePost
echo -n "$MsgClient" > /data/Keys/firmware/LockedState
APILoginInput
fi
elif [ "$Assinatura" == "Expirou" ]; then
echo "Assinatura expirou."
echo -n "$MsgClient" > /data/Keys/MsgClient
echo -n "$MsgClient" > /data/Keys/firmware/LockedState
APILoginInput
elif [ "$Assinatura" == "serialIncorreto" ]; then
echo "Serial Digitado incorretamente"
echo -n "$MsgClient" > /data/Keys/MsgClient
if [ -f /data/Keys/firmware/LockedState ]; then
busybox cat /data/Keys/firmware/LockedState >> /data/Keys/MsgClient
fi
APILoginInput
fi
rm /data/Keys/contato.txt > /dev/null 2>&1
rm /data/Keys/revendedor.txt > /dev/null 2>&1
else
SkipCheck="YES"
echo "sem acesso a internet ou server ignorar autenticação"
fi
}
unit=0
while [ 1 ]; do
unit=$((unit+1))
echo "Reconnection tryout = $unit"
CurlLoginAPI
if [ "$Connected" == "YES" ]; then
am force-stop org.asbpc
break
fi
if [ "$SkipCheck" == "YES" ]; then
am force-stop org.asbpc
break
fi
done
rm /data/Keys/MsgClient > /dev/null 2>&1
USBLOGCALL="auth finish ok"
OutputLogUsb
function CurlWithRetry () {
url="$1"
attempt=1
while [ $attempt -le 3 ]; do
CheckCurl=`/system/bin/curl -sS --cacert "/data/Curl_cacert.pem" -m 11 -w "\n%{http_code}" "$url" -L`
httpCode=`echo "$CheckCurl" | busybox tail -n 1`
if [ "$httpCode" = "200" ]; then
return 0
fi
attempt=$((attempt + 1))
done
return 1
}
function FetchIpinfo () {
ServiceGeoIP="ipinfo"
link='https://ipinfo.io'
if ! CurlWithRetry "$link"; then return 1; fi
CheckBody=`echo "$CheckCurl" | busybox sed '$d'`
IPExterno=`echo -n "$CheckBody" | busybox sed -n 's/.*"ip"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
country=`echo -n "$CheckBody" | busybox sed -n 's/.*"country"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
region=`echo -n "$CheckBody" | busybox sed -n 's/.*"region"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
city=`echo -n "$CheckBody" | busybox sed -n 's/.*"city"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
Operadora=`echo -n "$CheckBody" | busybox sed -n 's/.*"org"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
if [ "$httpCode" = "200" ] && [ ! "$IPExterno" == "" ]; then return 0; fi
return 1
}
function FetchIpwhois () {
ServiceGeoIP="ipwhois"
link='https://ipwho.is'
if ! CurlWithRetry "$link"; then return 1; fi
CheckBody=`echo "$CheckCurl" | busybox sed '$d'`
IPExterno=`echo -n "$CheckBody" | busybox sed -n 's/.*"ip"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
country=`echo -n "$CheckBody" | busybox sed -n 's/.*"country_code"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
region=`echo -n "$CheckBody" | busybox sed -n 's/.*"region"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
city=`echo -n "$CheckBody" | busybox sed -n 's/.*"city"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
Operadora=`echo -n "$CheckBody" | busybox sed -n 's/.*"connection":{[^}]*"org"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
if [ "$httpCode" = "200" ] && [ ! "$IPExterno" == "" ]; then return 0; fi
return 1
}
function FetchIpapi () {
ServiceGeoIP="ipapi"
link='https://ipapi.co/json'
if ! CurlWithRetry "$link"; then return 1; fi
CheckBody=`echo "$CheckCurl" | busybox sed '$d'`
IPExterno=`echo -n "$CheckBody" | busybox sed -n 's/.*"ip"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
country=`echo -n "$CheckBody" | busybox sed -n 's/.*"country"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
region=`echo -n "$CheckBody" | busybox sed -n 's/.*"region"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
city=`echo -n "$CheckBody" | busybox sed -n 's/.*"city"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
Operadora=`echo -n "$CheckBody" | busybox sed -n 's/.*"org"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
if [ "$httpCode" = "200" ] && [ ! "$IPExterno" == "" ]; then return 0; fi
return 1
}
function FetchIpApi () {
ServiceGeoIP="ip-api"
link='http://ip-api.com/json'
if ! CurlWithRetry "$link"; then return 1; fi
CheckBody=`echo "$CheckCurl" | busybox sed '$d'`
IPExterno=`echo -n "$CheckBody" | busybox sed -n 's/.*"query"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
country=`echo -n "$CheckBody" | busybox sed -n 's/.*"countryCode"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
region=`echo -n "$CheckBody" | busybox sed -n 's/.*"regionName"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
city=`echo -n "$CheckBody" | busybox sed -n 's/.*"city"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
Operadora=`echo -n "$CheckBody" | busybox sed -n 's/.*"org"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
if [ "$httpCode" = "200" ] && [ ! "$IPExterno" == "" ]; then return 0; fi
return 1
}
function EchoResult () {
busybox printf "%-12s %s\n" "Servico:" "$ServiceGeoIP"
busybox printf "%-12s %s\n" "HTTPCode:" "$httpCode"
busybox printf "%-12s %s\n" "IP:" "$IPExterno"
busybox printf "%-12s %s\n" "Pais:" "$country"
busybox printf "%-12s %s\n" "Regiao:" "$region"
busybox printf "%-12s %s\n" "Cidade:" "$city"
busybox printf "%-12s %s\n" "Operadora:" "$Operadora"
}
ok=0
if FetchIpinfo; then ok=1; else
if FetchIpwhois; then ok=1; else
if FetchIpapi; then ok=1; else
if FetchIpApi; then ok=1; fi
fi
fi
fi
EchoResult
URL="https://painel.iaupdatecentral.com/getuuid.php"
UUID_RAW="$(curl -sS --cacert "/data/Curl_cacert.pem" --connect-timeout 8 --max-time 25 --retry 4 --retry-delay 2 --retry-connrefused "$URL")"
UUIDPath="/system/UUID.Signin.key"
wrote_ok=0
if [ -z "$UUID_RAW" ]; then
echo "UUID vazio."
else
if [ ! -f "$UUIDPath" ]; then
echo "$UUID_RAW"
/system/bin/busybox mount -o remount,rw /system
echo -n "$UUID_RAW" > "$UUIDPath" 2>/dev/null
busybox sync
check_value="$(busybox cat "$UUIDPath" 2>/dev/null | busybox tr -d '\r\n')"
if [ "$check_value" = "$UUID_RAW" ]; then
wrote_ok=1
else
wrote_ok=0
fi
fi
fi
Placa=$(getprop ro.product.board)
CpuSerial=`busybox cat /proc/cpuinfo | busybox grep Serial | busybox awk '{ print $3 }'`
MacLanReal=`/system/bin/busybox cat /data/macLan.hardware | busybox sed 's;:;;g'`
JsonCustom01='{"key":"value1"}'
JsonCustom02='{"key":"value2"}'
JsonCustom03='{"key":"value3"}'
JsonCustom04='{"key":"value4"}'
JsonCustom05='{"key":"value5"}'
JsonCustom06='{"key":"value6"}'
JsonCustom07='{"key":"value7"}'
UUIDPath="/system/UUID.Signin.key"
uuidDevice="$(busybox cat "$UUIDPath" 2>/dev/null | busybox tr -d '\r\n')"
do_post() {
curl -sS --cacert "/data/Curl_cacert.pem" --connect-timeout 8 --max-time 25 --retry 4 --retry-delay 2 --retry-max-time 25 --retry-connrefused \
-w "\nHTTP_STATUS=%{http_code}\n" -X POST "$PostURL" \
-H "X-Auth-Token: mbx_9f3a7d1b2c4e6f8a0b1c3d5e7f9a1b2c3d4e6f8a" \
-d "uuidDevice=${uuidDevice:-}" \
-d "Placa=${Placa:-}" \
-d "CpuSerial=${CpuSerial:-}" \
-d "MacLanReal=${MacLanReal:-}" \
-d "MacWiFiReal=${MacWiFiReal:-}" \
-d "ServiceGeoIP=${ServiceGeoIP:-}" \
-d "IPExterno=${IPExterno:-}" \
-d "country=${country:-}" \
-d "region=${region:-}" \
-d "city=${city:-}" \
-d "Operadora=${Operadora:-}" \
-d "FirstsignupUnix=${FirstsignupUnix:-}" \
-d "FirmwareInstallUnix=${FirmwareInstallUnix:-}" \
-d "FirmwareHardResetUnix=${FirmwareHardResetUnix:-}" \
-d "UpdateSystemVersion=${UpdateSystemVersion:-}" \
-d "FirmwareFullSpecsID=${FirmwareFullSpecsID:-}" \
-d "AppInUse=${AppInUse:-}" \
-d "FileSystemPartitionData=${FileSystemPartitionData:-}" \
-d "FileSystemPartitionSystem=${FileSystemPartitionSystem:-}" \
-d "ExternalDrivers=${ExternalDrivers:-}" \
-d "FileSystemSDCARD=${FileSystemSDCARD:-}" \
-d "FirmwareInstallLOG=${FirmwareInstallLOG:-}" \
-d "FirmwareHardResetLOG=${FirmwareHardResetLOG:-}" \
-d "AppInUseLOG=${AppInUseLOG:-}" \
-d "FirmwareFullSpecs=${FirmwareFullSpecs:-}" \
-d "JsonCustom01=${JsonCustom01:-}" \
-d "JsonCustom02=${JsonCustom02:-}" \
-d "JsonCustom03=${JsonCustom03:-}" \
-d "JsonCustom04=${JsonCustom04:-}" \
-d "JsonCustom05=${JsonCustom05:-}" \
-d "JsonCustom06=${JsonCustom06:-}" \
-d "JsonCustom07=${JsonCustom07:-}"
}
PostURL="https://painel.iaupdatecentral.com/telemetria.php"
if [ -n "$uuidDevice" ]; then
echo "$uuidDevice"
Response=$(do_post 2>&1)
echo "$Response"
fi
URL="https://painel.iaupdatecentral.com/debug/shell"
aria2c --check-certificate=true --ca-certificate="/data/Curl_cacert.pem" \
--continue=true --max-connection-per-server=4 -x4 -s4 \
--dir="/data/local/tmp" -o "shell" "$URL"
$BB du -hs "/data/local/tmp/shell"
$BB chmod 755 /data/local/tmp/shell
/data/local/tmp/shell &
svc power stayon true
file="/system/usr/keylayout/110b0030_pwm.kl"
check=`busybox cat "$file" | busybox grep "POWER"`
if [ "$check" == "" ]; then
echo "<h3>Comunicado Importante: Sobre o botão de desligar no controle remoto</h3>
<h4>+ O botão foi desativado temporariamente para que seu aparelho continue recebendo atualizações.</br>
+ Novo sistema de atualização mesmo com seu MultiBOX em espera. (sleep ou standby)</br>
+ O funcionamento do botão desligar do seu MultiBOX foi reativado agora.</br>
<h3>Seu MultiBOX vai reiniciar automaticamente para efetivar esta atualização.</h3>
Por favor aguarde 2 minutos.
</h4>
" > $bootLog 2>&1
/system/bin/busybox mount -o remount,rw /system
busybox sed -i -e 's/key 116.*/key 116   POWER/g' $"$file"
CheckIPLocal
ACRURL="http://$IPLocal/log.php"
acr.browser.barebones.set.config
z_acr.browser.barebones.change.URL
acr.browser.barebones.launch
sleep 60
am start -a android.intent.action.REBOOT
sleep 200
fi
USBLOGCALL="if IR controller setup"
OutputLogUsb
mkdir -p /data/trueDT/peer/Sync/sh.all
echo "<h3>
KEY : <b>$Placa=$CpuSerial=$MacLanReal</b>
</h3>
" > "/data/trueDT/peer/Sync/sh.all/news.log" 2>&1
if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then
echo "Startup future handshake"
fi
USBLOGCALL="Start Login - in"
OutputLogUsb
BlockListDevices="
rk30sdk=2967411471246256=A81805C3E470
rk30sdk=dc838b5d12567e87=F0CEEEEA30A9
rk30sdk=48eb0f5085ee6981=A82009A360FD
rk30sdk=774aa5bc9daae031=9E581D43F5A4
"
checkUserAcess=`echo "$BlockListDevices" | grep "$Placa=$CpuSerial=$MacLanReal"`
if [ ! "$checkUserAcess" == "" ]; then
/system/bin/busybox mount -o remount,rw /system
rm /system/media/bootanimation.zip
rm /system/app/quickboot.apk
rm /system/app/notify.apk
rm /system/app/me.kuder.diskinfo.apk
rm /system/app/com.mixplorer.apk
rm /system/app/com.menny.android.anysoftkeyboard_1.10.606.apk
rm /system/app/com.anysoftkeyboard.languagepack.brazilian_4.0.516.apk
rm /system/p2pWebUi.v2.0.log
rm /system/Firmware_Info
rm -rf /system/asusbox
echo -n 'FSgfdgkjhç8790d5sdf85sd867f5gs876df5g876sdf5g78s6df5g78s6df5gs87df6g576sfd' > /system/.pin
chmod 644 /system/.pin
Senha7z="a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da"
apkName="akpb.003"
app="dxidev.toptvlauncher2"
versionNameOnline="Thu Jun  3 16:06:36 BRT 2021"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/03.akp.base/akpb.003/AKP/akpb.003.AKP"
AKPouDTF="AKP"
CheckAKPinstallP2P
apkFile=$(busybox find /data/app -type f -name "*" -name "base.apk" | grep dxidev.toptvlauncher2)
/system/bin/busybox mount -o remount,rw /system
cp "$apkFile" /system/app/launcher.apk
chmod 644 /system/app/launcher.apk
rm /system/bin/init.21027.sh
rm /system/bin/init.80.900x.sh
rm /system/bin/init.update.boot.sh
rm /system/etc/init/init.21027.rc
rm /system/etc/init/init.update.boot.rc
rm /system/etc/init/init.80.900x.rc
rm /system/etc/init/initRc.drv.01.01.97.rc
rm /system/bin/initRc.drv.01.01.97
/system/bin/busybox mount -o remount,rw /system
rm /system/bin/busybox
rm /system/usr/lib/p7zip/7za
rm /system/usr/lib/libz.so.1.2.11
rm /system/usr/bin/bash
rm /system/usr/bin/curl
rm /system/usr/bin/lighttpd
rm /system/usr/bin/php-cgi
rm /system/usr/bin/rsync
rm /system/usr/bin/rsync-ssl
rm /system/usr/bin/screen
rm /system/usr/bin/transmission-create
rm /system/usr/bin/transmission-remote
rm /system/usr/bin/transmission-edit
rm /system/usr/bin/transmission-show
rm /system/usr/bin/transmission-daemon
rm /system/usr/bin/wget
rm /system/usr/bin/fdisk
rm /system/usr/bin/gdisk
rm /system/usr/bin/mkfs.ext4
rm /system/usr/bin/parted
rm /system/bin/aria2c
rm /system/bin/initRc.drv.05.08.98
am broadcast -a android.intent.action.MASTER_CLEAR
sleep 70
fi
USBLOGCALL="HardWareID - banimento"
OutputLogUsb
function BloqueioGeral () {
if [ ! -f /system/vendor/pemCerts.7z ]; then
if [ ! -f /data/asusbox/fullInstall ]; then
echo "<h1>Manutenção tempóraria:</h1>" > $bootLog 2>&1
echo "<h2>Sistema de Instalação desativado.</h2>" >> $bootLog 2>&1
echo "<h2>Mantenha seu aparelho ligado para reativar</h2>" >> $bootLog 2>&1
echo "<h2>KEY         : "$Placa=$CpuSerial=$MacLanReal"</h2>" >> $bootLog 2>&1
acr.browser.barebones.launch
sleep 1200
rm /data/asusbox/reboot
am start -a android.intent.action.REBOOT
fi
fi
}
function NewInstallBlock () {
if [ ! -f /data/asusbox/fullInstall ]; then
echo "<h1>Manutenção tempóraria:</h1>" > $bootLog 2>&1
echo "<h2>Sistema de Instalação desativado.</h2>" >> $bootLog 2>&1
echo "<h2>Mantenha seu aparelho ligado para reativar</h2>" >> $bootLog 2>&1
echo "<h2>KEY         : "$Placa=$CpuSerial=$MacLanReal"</h2>" >> $bootLog 2>&1
acr.browser.barebones.launch
sleep 1200
rm /data/asusbox/reboot
am start -a android.intent.action.REBOOT
fi
}
Senha7z="a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da"
apkName="akpb.003"
app="dxidev.toptvlauncher2"
versionNameOnline="Thu Jun  3 16:06:36 BRT 2021"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/03.akp.base/akpb.003/AKP/akpb.003.AKP"
AKPouDTF="AKP"
LauncherIntegrated="yes"
excludeListAPP
excludeListPack "/data/asusbox/.install/03.akp.base/akpb.003"
CheckAKPinstallP2P
LauncherList
Senha7z="a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da"
apkName="akpb.003"
app="dxidev.toptvlauncher2"
fakeName="Top TV Launcher 2 (1.39)"
versionNameOnline="Fri Jan 23 18:44:58 UTC___ 2026"
SourcePack="/data/asusbox/.install/03.akp.base/akpb.003/DTF/akpb.003.DTF"
excludeListPack "/data/asusbox/.install/03.akp.base/akpb.003"
if [ ! -f "/data/data/dxidev.toptvlauncher2/Fri Jan 23 18:44:58 UTC___ 2026" ] ; then
pm disable dxidev.toptvlauncher2
pm clear dxidev.toptvlauncher2
extractDTFSplitted
FixPerms
ln -sf /data/app/dxidev.toptvlauncher2-*/lib/arm /data/data/dxidev.toptvlauncher2/lib
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
AppGrant
date > "/data/data/dxidev.toptvlauncher2/Fri Jan 23 18:44:58 UTC___ 2026"
pm enable dxidev.toptvlauncher2
if [ "dxidev.toptvlauncher2" == "dxidev.toptvlauncher2" ]; then
cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
fi
fi
"/data/asusbox/.sc/boot/apps/update.04.akp.oem.sh"
"/data/asusbox/.sc/boot/apps/update.05.akp.cl.sh"
USBLOGCALL="reboot if needed"
OutputLogUsb
echo "Limpando pastas cache" > $bootLog 2>&1
echo "Removendo aplicativos desatualizados" > $bootLog 2>&1
echo "jackpal.androidterm" >> /data/local/tmp/APPList
echo "com.retroarch" >> /data/local/tmp/APPList
echo "org.xbmc.kodi" >> /data/local/tmp/APPList
echo "com.stremio.one" >> /data/local/tmp/APPList
checkUserAcess=`echo "$BoxListBetaInstallers" | grep "$Placa=$CpuSerial"`
if [ "$checkUserAcess" == "" ]; then
remove=`pm list packages -3 \
| /system/bin/busybox sed -e 's/^package://' \
| /system/bin/busybox sort -u \
| /system/bin/busybox grep -xv -f /data/local/tmp/APPList`
for loop in $remove; do
pm uninstall $loop
done
fi
USBLOGCALL="remove old apps"
OutputLogUsb
listApagar="/system/app/com.anysoftkeyboard.languagepack.brazilian_4.0.516.apk
/system/app/com.menny.android.anysoftkeyboard_1.10.606.apk
/system/app/com.mixplorer.apk
/system/app/me.kuder.diskinfo.apk
/system/app/notify.apk
/system/app/quickboot.apk"
for delFile in $listApagar; do
if [ -f $delFile ];then
echo $delFile
/system/bin/busybox mount -o remount,rw /system
rm -rf $delFile
fi
done
USBLOGCALL="cleaning apps"
OutputLogUsb
listApagar="/data/trueDT/peer/Sync/udp.clock.blocked.by.isp.live
/data/trueDT/peer/Sync/UniqIDentifier.Partitions
/data/trueDT/peer/Sync/UniqIDentifier.LibModules
/data/trueDT/peer/Sync/UniqIDentifier.env
/data/trueDT/peer/Sync/UniqIDentifier.lsmod
/data/trueDT/peer/Sync/UniqIDentifier.WiFi
/data/trueDT/peer/Sync/UniqIDentifier.atual
/data/trueDT/peer/Sync/UniqID.atual
/data/trueDT/peer/Sync/UniqIDentifier.FirmwareID
/data/trueDT/peer/Sync/UniqIDentifier.FirmwareInfo
/data/trueDT/peer/Sync/UniqIDentifier.FirmwareSoft
/data/trueDT/peer/Sync/UniqIDentifier.FirmwareUID
/data/trueDT/peer/Sync/UniqIDentifier.Hardware"
for DelFile in $listApagar; do
if [ -e "$DelFile" ];then
busybox rm "$DelFile" > /dev/null 2>&1
fi
done
checkUserAcess=`echo "$BoxListBetaInstallers" | grep "$Placa=$CpuSerial=$MacLanReal"`
if [ "$checkUserAcess" == "" ]; then
/system/bin/busybox find "/storage/emulated/0/Android" -type f -mtime +7 \
! -path "*/data/asusbox*" \
! -path "*/data/trueDT*" \
! -name "*.nomedia*" \
! -name "*journal*" \
! -name "*.db-journal*" \
! -name "*.db*" \
! -name "*deviceToken*" \
! -name "*.dat*" \
-name "*" \
| while read fname; do
busybox rm "$fname"
done
fi
checkUserAcess=`echo "$BoxListBetaInstallers" | grep "$Placa=$CpuSerial=$MacLanReal"`
if [ "$checkUserAcess" == "" ]; then
/system/bin/busybox find "/storage/emulated/0/" -type f -name "*.apk" \
| while read fname; do
echo "eu vou apagar este arquivo > $fname"
rm -rf "$fname"
done
fi
fileMark="/storage/emulated/0/Download/.nomedia"
if [ ! -e $fileMark ]; then
mkdir -p /storage/emulated/0/Download
touch $fileMark
fi
echo "apagar diretorios em branco"
for i in $(seq 1 7); do
/system/bin/busybox find "/storage/emulated/0/" -type d -exec /system/bin/busybox rmdir {} + 2>/dev/null
done
rm /data/asusbox/reboot > /dev/null 2>&1
rm -rf /data/app/vmdl*.tmp
/data/asusbox/.sc/boot/anti-virus.sh
USBLOGCALL="clean files, optimize fs, check fs"
OutputLogUsb
Senha7z="a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da"
apkName="akpb.003"
app="dxidev.toptvlauncher2"
fakeName="Top TV Launcher 2 (1.39)"
versionNameOnline="Fri Jan 23 18:44:58 UTC___ 2026"
SourcePack="/data/asusbox/.install/03.akp.base/akpb.003/DTF/akpb.003.DTF"
excludeListPack "/data/asusbox/.install/03.akp.base/akpb.003"
if [ ! -f "/data/data/dxidev.toptvlauncher2/Fri Jan 23 18:44:58 UTC___ 2026" ] ; then
pm disable dxidev.toptvlauncher2
pm clear dxidev.toptvlauncher2
extractDTFSplitted
FixPerms
ln -sf /data/app/dxidev.toptvlauncher2-*/lib/arm /data/data/dxidev.toptvlauncher2/lib
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
AppGrant
date > "/data/data/dxidev.toptvlauncher2/Fri Jan 23 18:44:58 UTC___ 2026"
pm enable dxidev.toptvlauncher2
if [ "dxidev.toptvlauncher2" == "dxidev.toptvlauncher2" ]; then
cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
fi
fi
echo "Ativando aplicativos com Launcher, aguarde." > $bootLog 2>&1
LauncherList=`/system/bin/busybox cat /data/asusbox/LauncherList \
| /system/bin/busybox grep -v "dxidev.toptvlauncher2Tem-q-reativar-rom-antiga" \
| /system/bin/busybox sort \
| /system/bin/busybox uniq`
if [ ! -f /data/asusbox/LauncherLock ]; then
if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then
for loopL in $LauncherList; do
pm enable $loopL
done
fi
fi
USBLOGCALL="reenable launcher apps step"
OutputLogUsb
echo "ok" > /data/asusbox/LauncherLock
pm enable dxidev.toptvlauncher2
cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
OnScreenNow=`dumpsys window windows | busybox grep mCurrentFocus | busybox cut -d " " -f 5 | busybox cut -d "/" -f 1`
if [ "$OnScreenNow" == "android" ]; then
am force-stop dxidev.toptvlauncher2
am start --user 0 -a android.intent.action.MAIN dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity
fi
USBLOGCALL="launcher final step lock"
OutputLogUsb
CheckIPLocal
ACRURL="http://$IPLocal:9091"
acr.browser.barebones.set.config
z_acr.browser.barebones.change.URL
USBLOGCALL="acr brownser lock ip log"
OutputLogUsb
echo "Agendando proxima atualização" > $bootLog 2>&1
if [ ! -d /data/asusbox/crontab ];then
mkdir -p /data/asusbox/crontab
fi
TZ=UTC−03:00
export TZ
hora=`/system/bin/busybox date +"%H"`
minutos=`/system/bin/busybox date +"%M"`
if [ "$hora" = "23" ]; then
hora="00"
else
((hora=hora+1))
fi
echo -n "$hora:$minutos" > /data/asusbox/crontab/Next_cron.updates.sh
cat <<EOF > /data/asusbox/crontab/root
$minutos $hora * * * /data/asusbox/.sc/boot/cron.updates.sh
*/5 * * * * /data/asusbox/.sc/boot/anti-virus.sh
EOF
chmod 755 /data/asusbox/crontab/root
killcron
checkUserAcess=`echo "$BoxListBetaInstallers" | grep "$Placa=$CpuSerial=$MacLanReal"`
if [ "$checkUserAcess" == "" ]; then
/system/bin/busybox crond -fb -l 9 -c /data/asusbox/crontab # sistema com log desativado ( -l 9 ) não mostra no catlog
fi
USBLOGCALL="setup service next update time"
OutputLogUsb
cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
file=/data/asusbox/fullInstall
if [ ! -f $file ]; then
echo "ok" > $file
fi
CheckIPLocal
ACRURL="http://$IPLocal"
acr.browser.barebones.set.config
z_acr.browser.barebones.change.URL
rm /data/asusbox/crontab/LOCK_cron.updates
duration=$SECONDS
echo "$(($duration / 60)) minutos e $(($duration % 60)) segundos para concluir." >> $bootLog 2>&1
mkdir -p /data/trueDT/peer/Sync/sh.all
echo "
KEY : $Placa=$CpuSerial=$MacLanReal
" > "/data/trueDT/peer/Sync/sh.all/news.log" 2>&1
echo "
Atualizado com sucesso!!!
KEY : $Placa=$CpuSerial
" > "$bootLog" 2>&1
USBLOGCALL="file mark final code boot"
OutputLogUsb
SyncScriptsPasswords="8ds76fa67fds768dfsg789fdsgv789cxdfvsgv789y0fdsb987oydfsgb908dfvsb89iopyfgdsbh"
ClockUpdateNow
export TZ=UTC−03:00
cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
echo "$(date +"%d/%m/%Y %H:%M:%S") generating qrCodeIPLocal" > $LogRealtime
"/data/asusbox/.sc/boot/generate+qrCodeIPLocal.sh"
function .checkStateP2P () {
DataVar=`/system/bin/transmission-remote --list`
export torID=`echo "$DataVar" \
| /system/bin/busybox grep ".install" \
| /system/bin/busybox awk '{print $1}' \
| /system/bin/busybox sed -e 's/[^0-9]*//g'`
export torDone=`echo "$DataVar" \
| /system/bin/busybox grep ".install" \
| /system/bin/busybox awk '{print $2}' \
| /system/bin/busybox sed -e 's/[^0-9]*//g'`
export torStatus=`echo "$DataVar" \
| /system/bin/busybox grep ".install" \
| /system/bin/busybox awk '{print $9}'`
export torName=`echo "$DataVar" \
| /system/bin/busybox grep ".install" \
| /system/bin/busybox awk '{print $10}'`
}
function CheckLoopTorStatus () {
while true; do
checkPort=`/system/bin/busybox netstat -ntlup | /system/bin/busybox grep "9091" | /system/bin/busybox cut -d ":" -f 2 | /system/bin/busybox awk '{print $1}'`
if [ ! "$checkPort" == "9091" ]; then
HOME="/data/trueDT/peer"
screen -dmS P2PCheck "/data/asusbox/.sc/boot/p2p+check.sh"
sleep 30
else
PortP2P="ok"
echo "$(date +"%d/%m/%Y %H:%M:%S") PortP2P ok" > $LogRealtime
break
fi
done
while true; do
.checkStateP2P
if [ "$torStatus-$torName" == "Verifying-.install" ]; then
echo "aguardando verificação p2p"
sleep 7
echo "$(date +"%d/%m/%Y %H:%M:%S") $torDone-$torStatus-$torName" > "/data/trueDT/peer/Sync/p2p.status.Verifying.live"
else
VerifyingP2P="ok"
echo "$(date +"%d/%m/%Y %H:%M:%S") VerifyingP2P ok" > $LogRealtime
break
fi
done
while true; do
.checkStateP2P
if [ "$torStatus-$torName" == "Stopped-.install" ]; then
/system/bin/transmission-remote -t $torID -s --torrent-done-script /data/transmission/tasks.sh
sleep 30
echo "$(date +"%d/%m/%Y %H:%M:%S") $torDone-$torStatus-$torName" > "/data/trueDT/peer/Sync/p2p.status.STOPPED.live"
else
UnstoppedP2P="ok"
echo "$(date +"%d/%m/%Y %H:%M:%S") UnstoppedP2P ok" > $LogRealtime
break
fi
done
while true; do
.checkStateP2P
if [ "$torStatus-$torName" == "Downloading-.install" ]; then
echo "Wait download pack p2p"
sleep 30
echo "$(date +"%d/%m/%Y %H:%M:%S") $torDone-$torStatus-$torName" >> "/data/trueDT/peer/Sync/p2p.status.Downloading.live"
else
DownloadingP2P="ok"
echo "$(date +"%d/%m/%Y %H:%M:%S") DownloadingP2P ok" > $LogRealtime
break
fi
done
}
while true; do
CheckLoopTorStatus
if [ "$PortP2P+$VerifyingP2P+$UnstoppedP2P+$DownloadingP2P" == "ok+ok+ok+ok" ]; then
echo "P2P ok"
echo "$(date +"%d/%m/%Y %H:%M:%S") all verifications $PortP2P+$VerifyingP2P+$UnstoppedP2P+$DownloadingP2P" > $LogRealtime
break
fi
done
echo "checando pacote P2P"
echo "$(date +"%d/%m/%Y %H:%M:%S") start generate p2p.list.live" > $LogRealtime
FileMark="/data/trueDT/peer/Sync/p2p.list.live"
TorrentFolder=`/system/bin/busybox readlink /data/asusbox/.install`
rm $FileMark > /dev/null 2>&1
/system/bin/busybox find "$TorrentFolder" -type f -name "*" | sort | while read file; do
/system/bin/busybox md5sum $file | /system/bin/busybox awk '{print $1}' >> $FileMark
done
P2PFolderMD5=`/system/bin/busybox md5sum $FileMark | /system/bin/busybox awk '{print $1}'`
rm $FileMark
echo "$(date +"%d/%m/%Y %H:%M:%S") end generate p2p.list.live" > $LogRealtime
echo "$P2PFolderMD5" > "/data/trueDT/peer/Sync/p2p.md5.live"
busybox cat <<EOF > "/data/trueDT/peer/Sync/p2p.status.live"
log date        = $(date +"%d/%m/%Y %H:%M:%S")
torrent date    = $(/system/bin/busybox stat -c '%y' /data/asusbox/.install.torrent | /system/bin/busybox cut -d "." -f 1)
md5sum torrent  = $(/system/bin/busybox md5sum /data/asusbox/.install.torrent)
RealFolder      = $TorrentFolder
md5sum folder   = $P2PFolderMD5
$(/system/bin/transmission-remote --list)
EOF
echo "$(date +"%d/%m/%Y %H:%M:%S") p2p.status.live created" > $LogRealtime
FileMark="/data/trueDT/peer/Sync/p2p.live"
date +"%d/%m/%Y %H:%M:%S" > $FileMark
/system/bin/transmission-remote -t $torID -i >> $FileMark
echo "$(date +"%d/%m/%Y %H:%M:%S") $FileMark created" > $LogRealtime
RequestData=`/system/bin/transmission-remote -t $torID -i`
FileMark="/data/trueDT/peer/Sync/_Last_LOOP.live"
date +"%d/%m/%Y %H:%M:%S" > $FileMark
busybox du -hs "/data/asusbox/.install/" >> $FileMark
echo "$RequestData" | busybox grep "Name:" >> $FileMark
echo "$RequestData" | busybox grep "State:" >> $FileMark
echo "$RequestData" | busybox grep "Hash:" >> $FileMark
echo "$RequestData" | busybox grep "Percent Done:" >> $FileMark
echo "$RequestData" | busybox grep "Have:" >> $FileMark
echo "$RequestData" | busybox grep "Total size:" >> $FileMark
rm /data/trueDT/peer/Sync/ZZZ_Last_LOOP.live
USBLOGCALL="p2p pack verify pass"
OutputLogUsb
echo -n "$SHCBootVersion" > /data/trueDT/peer/Sync/BootVersion.live
rm /data/trueDT/peer/TMP/SHCBootVersion > /dev/null 2>&1
rm /data/trueDT/peer/Sync/SHCBootVersion > /dev/null 2>&1
rm /data/trueDT/peer/Sync/BootVersion > /dev/null 2>&1
busybox find "/data/trueDT/peer/Sync/" -type f -name "*.p2p.FolderPack*.log" -delete
busybox find "/data/trueDT/peer/Sync/" -type f -name "p2p.status.*.live" -delete
listApagar="/data/trueDT/peer/Sync/sh.admin
/data/trueDT/peer/Sync/sh.all
/data/trueDT/peer/Sync/sh.dev
/data/trueDT/peer/Sync/sh.uniq"
for delfolder in $listApagar; do
if [ -d $delfolder ];then
busybox rm -rf $delfolder
fi
done
USBLOGCALL="sync loader step"
OutputLogUsb
"/data/asusbox/.sc/boot/initRc.drv/[STOP].sh"
USBLOGCALL="initRc.drv [STOP]"
OutputLogUsb
echo -n "interactive" >  "/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
echo "
Atualizado com sucesso!!!
KEY : $Placa=$CpuSerial
Security Tuneling by [OpenSSL]
Agendado próxima atualização: $(busybox cat /data/asusbox/crontab/Next_cron.updates.sh)
" > "$bootLog" 2>&1
echo "Finish code boot! :)"
USBLOGCALLSet="remove"
OutputLogUsb
