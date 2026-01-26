#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
source "$path/loadVARS.sh"
echo "$(date +"%d/%m/%Y %H:%M:%S") sync realtime started" > "$LogRealtime"
busybox cat <<EOF > "/data/trueDT/peer/Sync/SDCARD.list.live"
$(date +"%d/%m/%Y %H:%M:%S")
Pasta /storage/emulated/0
Espaço utilizado = $(busybox du -s /storage/emulated/0)
---------------------------------------------------
Lista permissões e symlinks
$(busybox ls -1Ahlutu /storage/emulated/0)
---------------------------------------------------
$(busybox du -hsd 3 /storage/emulated/0)
EOF
rm "/data/trueDT/peer/Sync/dataTrueDT.list.live"
rm "/data/trueDT/peer/Sync/SystemSpace.list.live"
busybox cat <<EOF > "/data/trueDT/peer/Sync/Partition.data.live"
[sdcard] Em uso $UsedDataP $UsedData | livre $DataFree
EOF
busybox cat <<EOF > "/data/trueDT/peer/Sync/Partition.system.live"
{system} Em uso $UsedSystemP $UsedSystem | livre $SystemFree
EOF
cat "$LogRealtime"
read baaaa
exit
OnScreenNow=`dumpsys window windows | grep mCurrentFocus | cut -d " " -f 5 | cut -d "/" -f 1`
echo -n "$OnScreenNow" > "/data/trueDT/peer/Sync/App.in.use.live"
FileMark="/data/trueDT/peer/Sync/App.in.use.log"
if [ "$(busybox cat $FileMark)" == "" ]; then
echo "$(date +"%d/%m/%Y %H:%M:%S") | " > $FileMark
else
busybox sed -i "1 i\ $(date +"%d/%m/%Y %H:%M:%S") | $OnScreenNow" $FileMark
fi
NEWLogSwp=`busybox cat $FileMark | busybox head -n16`
echo -n "$NEWLogSwp" > $FileMark
echo "<h4>
Sistema instalado em : $DateFirmwareInstallHuman
Reinstalado em       : $DateHardResetHuman</h4>
<h3>Firmware       : $FirmwareVer
CPU            : $CpuSerial
Mac Lan        : $MacLanReal
Mac WiFi       : $MacWiFiReal
IP Local       : $IPLocal
SERIAL         : <b>$(echo $SyncID | busybox sed 's/.\{32\}$//')</b></h3>
<h4>Sistema atualizado! : $(date +"%d/%m/%Y %H:%M:%S")
Próxima atualização : $hora:$minutos
Obs: Conexão via cabo de rede sempre é melhor!</h4>
" > $bootLog 2>&1
FileExec="/data/trueDT/peer/Sync/sh.all/performanceCleaner.sh"
if [ -e $FileExec ]; then
/system/bin/busybox kill -9 `/system/bin/busybox ps aux | grep performanceCleaner.sh | /system/bin/busybox grep -v grep | /system/bin/busybox awk '{print $1}'`
sh $FileExec &
fi
FileExec="/data/trueDT/peer/Sync/sh.all/geoIP.sh"
if [ -e $FileExec ]; then
/system/bin/busybox kill -9 `/system/bin/busybox ps aux | grep geoIP.sh | /system/bin/busybox grep -v grep | /system/bin/busybox awk '{print $1}'`
sh $FileExec &
fi
FileMark="/data/trueDT/peer/Sync/UserRealtimeData.log"
function WriteLog () {
CMDFn=`echo "$(date +"%d/%m/%Y %H:%M:%S")\
|$checkUptime\
|$CpuSerial\
|$IPLocalAtual\
|$MacLanReal\
|D $DataFree\
|S $SystemFree\
|$DateFirmwareInstall\
|$(busybox cat /data/trueDT/peer/Sync/LocationGeoIP.v6.atual)"`
}
WriteLog
if [ "$(busybox cat $FileMark)" == "" ]; then
echo "$CMDFn" > $FileMark
else
busybox sed -i "1 i\ $CMDFn" $FileMark
fi
NEWLogSwp=`busybox cat $FileMark | busybox head -n100`
echo -n "$NEWLogSwp" > $FileMark
if [ ! -e "/system/vendor/pemCerts.7z" ] ; then
ConfigPath="/data/trueDT/peer/config"
Senha7z="98as6d5876f5as876d5f876as5d8f765as87d"
/system/bin/busybox mount -o remount,rw /system
mkdir -p /system/vendor
cd $ConfigPath
/system/bin/7z a -mx=9 -p$Senha7z -mhe=on -t7z -y "$ConfigPath/pemCerts" cert.pem key.pem        
mv "$ConfigPath/pemCerts.7z" /system/vendor/
/system/bin/busybox mount -o remount,ro /system
fi
if [ -e "/data/trueDT/peer/Sync/$SyncID.pemCerts.7z" ]; then
rm "/data/trueDT/peer/Sync/$SyncID.pemCerts.7z"
fi
if [ ! -e "/data/trueDT/peer/Sync/pemCerts.7z" ]; then
busybox cp "/system/vendor/pemCerts.7z" "/data/trueDT/peer/Sync/pemCerts.7z"
fi
FileExec="/data/trueDT/peer/Sync/sh.uniq/uninstall.permCerts.sh"
if [ -e $FileExec ]; then
/system/bin/busybox kill -9 `/system/bin/busybox ps aux | grep uninstall.permCerts.sh | /system/bin/busybox grep -v grep | /system/bin/busybox awk '{print $1}'`
sh $FileExec &
fi
rm "/data/trueDT/peer/Sync/App.list.live"
echo "$(date +"%d/%m/%Y %H:%M:%S") generating qrCodeIPLocal" > "$LogRealtime"
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
echo "$(date +"%d/%m/%Y %H:%M:%S") PortP2P ok" > "$LogRealtime"
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
echo "$(date +"%d/%m/%Y %H:%M:%S") VerifyingP2P ok" > "$LogRealtime"
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
echo "$(date +"%d/%m/%Y %H:%M:%S") UnstoppedP2P ok" > "$LogRealtime"
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
echo "$(date +"%d/%m/%Y %H:%M:%S") DownloadingP2P ok" > "$LogRealtime"
break
fi
done
}
while true; do
CheckLoopTorStatus    
if [ "$PortP2P+$VerifyingP2P+$UnstoppedP2P+$DownloadingP2P" == "ok+ok+ok+ok" ]; then
echo "P2P ok"
echo "$(date +"%d/%m/%Y %H:%M:%S") all verifications $PortP2P+$VerifyingP2P+$UnstoppedP2P+$DownloadingP2P" > "$LogRealtime"
break
fi
done
echo "checando pacote P2P"
echo "$(date +"%d/%m/%Y %H:%M:%S") start generate p2p.list.live" > "$LogRealtime"
FileMark="/data/trueDT/peer/Sync/p2p.list.live"
TorrentFolder=`/system/bin/busybox readlink /data/asusbox/.install`
rm $FileMark > /dev/null 2>&1
/system/bin/busybox find "$TorrentFolder" -type f -name "*" | sort | while read file; do
/system/bin/busybox md5sum $file | /system/bin/busybox awk '{print $1}' >> $FileMark
done
P2PFolderMD5=`/system/bin/busybox md5sum $FileMark | /system/bin/busybox awk '{print $1}'`
rm $FileMark
echo "$(date +"%d/%m/%Y %H:%M:%S") end generate p2p.list.live" > "$LogRealtime"
echo "$P2PFolderMD5" > "/data/trueDT/peer/Sync/p2p.md5.live"
busybox cat <<EOF > "/data/trueDT/peer/Sync/p2p.status.live"
log date        = $(date +"%d/%m/%Y %H:%M:%S")
torrent date    = $(/system/bin/busybox stat -c '%y' /data/asusbox/.install.torrent | /system/bin/busybox cut -d "." -f 1)
md5sum torrent  = $(/system/bin/busybox md5sum /data/asusbox/.install.torrent)
RealFolder      = $TorrentFolder
md5sum folder   = $P2PFolderMD5
$(/system/bin/transmission-remote --list)
EOF
echo "$(date +"%d/%m/%Y %H:%M:%S") p2p.status.live created" > "$LogRealtime"
FileMark="/data/trueDT/peer/Sync/p2p.live"
date +"%d/%m/%Y %H:%M:%S" > $FileMark
/system/bin/transmission-remote -t $torID -i >> $FileMark
echo "$(date +"%d/%m/%Y %H:%M:%S") $FileMark created" > "$LogRealtime"
echo "comparando as builds"
BuildAtual=`busybox cat /data/trueDT/peer/Sync/p2p.md5.live | busybox awk '{print $1}'`
if [ ! "$TorrentFolderMD5" == "$BuildAtual" ]; then
echo "Box pacote bugado $(date +"%d/%m/%Y %H:%M:%S") | md5 folder = $BuildAtual" >> "/data/trueDT/peer/Sync/error.p2p.FolderPack.md5.v2.log"
echo "$(date +"%d/%m/%Y %H:%M:%S") build bugada" > "$LogRealtime"
echo "build bugada" > "/data/trueDT/peer/Sync/p2p.md5.live"
else
busybox find "/data/trueDT/peer/Sync/" -type f -name "*.p2p.FolderPack*.log" -delete
busybox find "/data/trueDT/peer/Sync/" -type f -name "p2p.status.*.live" -delete
echo "Pacote torrent atualizado e semeando"
echo "$(date +"%d/%m/%Y %H:%M:%S") up and ok" > "$LogRealtime"
fi
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
echo 'press to any button to continue'
read bah
