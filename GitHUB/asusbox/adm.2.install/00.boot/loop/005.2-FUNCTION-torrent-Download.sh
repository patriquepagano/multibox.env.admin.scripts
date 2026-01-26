
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
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### Entrando na função > Download_torrent_File"
        echo "ADM DEBUG ### Tentando o link > $LinkUpdate"
        # Tenta conectar ao link 7 vezes
        /system/bin/wget -N --no-check-certificate --timeout=1 --tries=7 -P /data/asusbox/ $LinkUpdate > "/data/asusbox/wget.log" 2>&1
        torrentcheckCRC
    done
    echo "ADM DEBUG ### Fim da função TorrentFileInstall > TorrentFileInstall=$TorrentFileInstall"
}


function LoopForceDownloadtorrent_File () {
    local attempt_counter=0
    local max_attempts=8
    while true; do
        if [ "$TorrentFileInstall" == "false" ]; then
            echo "ADM DEBUG ########################################################"
            echo "ADM DEBUG ### Entrando na função > LoopForceDownloadtorrent_File"
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
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### Reduzindo número de linhas do log $FileMark"
        NEWLogSwp=$(busybox head -n100 "$FileMark")
        echo -n "$NEWLogSwp" > "$FileMark"
    fi
}


FileMark="/storage/asusboxUpdate/GitHUB/asusbox/adm.2.install/.install.torrent"
if [ ! -f $FileMark ]; then
    # code for box customers
    LoopForceDownloadtorrent_File
else
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### build generator testes detectado."
    echo "ADM DEBUG ### torrent vai fazer share do torrent local"
    rm /data/asusbox/.install.torrent
    /system/bin/busybox ln -sf $FileMark /data/asusbox/.install.torrent
fi



USBLOGCALL="download p2p key"
OutputLogUsb

