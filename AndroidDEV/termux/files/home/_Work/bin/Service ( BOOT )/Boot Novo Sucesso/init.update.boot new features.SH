#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear
PidProcess="/data/local/tmp/init.update.boot.PID"
LogTime="/data/local/tmp/logTime.LOG"
export TZ=UTC−03:00
Log="/data/trueDT/peer/TMP/init.p2p.LOG"
toolx="/system/bin/busybox"
export FolderPath="/storage/MultiBOX"

#################################################################################################################################
function DownloadFiles () {
if [ ! -d "/data/trueDT/DownloadList" ]; then
    mkdir -p "/data/trueDT/DownloadList"
fi
echo "$multilinks" | $toolx sed -e '/^\s*$/d' | while IFS= read -r LineDownload ; do
    echo "ADM DEBUG ############################################################################################" >> "$Log"
    echo "ADM DEBUG ### download link > $LineDownload" >> "$Log"
    /system/bin/wget -N --no-check-certificate --timeout=1 --tries=7 -P $DowloadPath/ "$LineDownload" > "/data/trueDT/DownloadList/$FileName-wget.log" 2>&1
    CheckWgetCode=`$toolx cat "/data/trueDT/DownloadList/$FileName-wget.log" | $toolx grep "HTTP request sent, awaiting response..."`
    cat "/data/trueDT/DownloadList/$FileName-wget.log"
    # Se tiver acesso finaliza esta função
    if [ "$CheckWgetCode" == "HTTP request sent, awaiting response... 200 OK" ] ; then
        echo "ADM DEBUG ### Wget :) $CheckWgetCode" >> "$Log"
        echo "$FileName" > "/data/trueDT/DownloadList/$FileName-wget.log"
        echo "$CheckWgetCode" >> "/data/trueDT/DownloadList/$FileName-wget.log"
        break # fecha a função por completo
    fi
    if [ "$CheckWgetCode" == "HTTP request sent, awaiting response... 304 Not Modified" ] ; then
        echo "ADM DEBUG ### Wget :) $CheckWgetCode" >> "$Log"
        echo "$FileName" > "/data/trueDT/DownloadList/$FileName-wget.log"
        echo "$CheckWgetCode" >> "/data/trueDT/DownloadList/$FileName-wget.log"
        break # fecha a função por completo
    fi 
done
}
#################################################################################################################################
function Downloadcheck () {
while true; do
    echo "ADM DEBUG ### Entrando na função > LoopForceDownloadLauncher" >> "$Log"
    DownloadFiles
    FileOK=`cat "/data/trueDT/DownloadList/$FileName-wget.log" | sed -n '1p'`
    echo "ADM DEBUG ### download result = $FileOK" >> "$Log"
	if [ ! "$FileOK" == "$FileName" ]; then
        echo "ADM DEBUG ### Nova tentativa em loop para baixar" >> "$Log"
        logcat -c
    else
        break
    fi
done
}





# inicio do script para executar as funções
# não botar links quebrados ou redirecionados pois vai baixar um arquivo provocando download do arquivo sempre.
DowloadPath="/data/trueDT/DownloadList"

FileName=".install.torrent"
multilinks="
http://45.79.133.216/asusboxA1/.install.torrent
http://45.79.48.215/asusboxA1/.install.torrent
"
Downloadcheck


FileName="kubuntu-22.10-desktop-amd64.iso.torrent"
multilinks="
https://cdimage.ubuntu.com/kubuntu/releases/22.10/release/kubuntu-22.10-desktop-amd64.iso.torrent
"
Downloadcheck


FileName="ubuntu-22.10-desktop-amd64.iso.torrent"
multilinks="
https://releases.ubuntu.com/22.10/ubuntu-22.10-desktop-amd64.iso.torrent
"
Downloadcheck



mv /data/trueDT/DownloadList/.install.torrent /data/trueDT/DownloadList/.install.key
mv /data/trueDT/DownloadList/kubuntu-22.10-desktop-amd64.iso.torrent /data/trueDT/DownloadList/kubuntu-22.10-desktop-amd64.iso.key
mv /data/trueDT/DownloadList/ubuntu-22.10-desktop-amd64.iso.torrent /data/trueDT/DownloadList/ubuntu-22.10-desktop-amd64.iso.key


