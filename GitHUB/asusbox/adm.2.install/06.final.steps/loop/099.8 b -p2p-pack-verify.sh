
echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### rodando o script de verificação local do p2p pack"
echo "$(date +"%d/%m/%Y %H:%M:%S") generating qrCodeIPLocal" > $LogRealtime
"/data/asusbox/.sc/boot/generate+qrCodeIPLocal.sh"



# travar em loop aqui aguardando finalizar o pack p2p para produzir um relatorio correto com a realidade
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
            echo "ADM DEBUG ### start p2p service"
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
            echo "ADM DEBUG ### -s inicia o torrent caso esteja pausado | torrent-done-script"
            /system/bin/transmission-remote -t $torID -s --torrent-done-script /data/transmission/tasks.sh
            sleep 30
            echo "$(date +"%d/%m/%Y %H:%M:%S") $torDone-$torStatus-$torName" > "/data/trueDT/peer/Sync/p2p.status.STOPPED.live"
        else
            UnstoppedP2P="ok"
            echo "$(date +"%d/%m/%Y %H:%M:%S") UnstoppedP2P ok" > $LogRealtime
            break
        fi
    done

    # se a box estiver em um estado de download entra aqui dentro e trava em loop até sumir o torStatus
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

# trava em loop até resolver o torrent
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
# "/data/asusbox/.sc/boot/checkPackP2P.sh" # desativado por enquanto
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


# echo "comparando as builds"
# # é informado na ficha tecnica BuildOnline="a4b50c63464f937224cbb5f58d32f56e"
# BuildAtual=`busybox cat /data/trueDT/peer/Sync/p2p.md5.live | busybox awk '{print $1}'`
# if [ ! "$TorrentFolderMD5" == "$BuildAtual" ]; then
#     echo "Box pacote bugado $(date +"%d/%m/%Y %H:%M:%S") | md5 folder = $BuildAtual" >> "/data/trueDT/peer/Sync/error.p2p.FolderPack.md5.v2.log"
#     echo "$(date +"%d/%m/%Y %H:%M:%S") build bugada" > $LogRealtime
#     echo "build bugada" > "/data/trueDT/peer/Sync/p2p.md5.live"
#     # logcat -d > "/data/trueDT/peer/Sync/error.p2p.FolderPack.LOGCAT.log"


#     # if [ ! -f "/data/trueDT/peer/Sync/Firmware_Info.live" ]; then
#     #     cp /system/Firmware_Info "/data/trueDT/peer/Sync/Firmware_Info.live"
#     # fi

#     # se o pacote torrent ainda estiver baixando quando chegar aqui vai dar erro com certeza!
#     # as box estão chegando aqui neste ponto sem estar a 100% o script não esta esperando
#     # rm /data/asusbox/.install.torrent
#     # /system/bin/busybox find "/data/asusbox/AppLog/" -type f -name "_TorrentPack=*" | while read RemoveTorrent; do
#     #     busybox rm "$RemoveTorrent"
#     # done

#     # killcron
#     #/data/asusbox/.sc/boot/cron.updates.sh &
#     #am start -a android.intent.action.REBOOT
# else
#     # if [ -e "/data/trueDT/peer/Sync/error.p2p.FolderPack.md5.log" ]; then
#     #     mv "/data/trueDT/peer/Sync/error.p2p.FolderPack.md5.log" "/data/trueDT/peer/Sync/Fixed.p2p.FolderPack.md5.$RANDOM.log"
#     # fi
#     busybox find "/data/trueDT/peer/Sync/" -type f -name "*.p2p.FolderPack*.log" -delete
#     busybox find "/data/trueDT/peer/Sync/" -type f -name "p2p.status.*.live" -delete
#     echo "Pacote torrent atualizado e semeando"
#     echo "$(date +"%d/%m/%Y %H:%M:%S") up and ok" > $LogRealtime
#     echo "Box pacote INTEGRO $(date +"%d/%m/%Y %H:%M:%S") | md5 folder = $BuildAtual" >> "/data/trueDT/peer/Sync/error.p2p.FolderPack.md5.v2.log"
# fi

# FileMark="/data/trueDT/peer/Sync/error.p2p.FolderPack.md5.v2.log"
# echo "ADM DEBUG ########################################################"
# echo "ADM DEBUG ### Reduz numero de linhas do log $FileMark"
# NEWLogSwp=`busybox cat $FileMark | busybox head -n100`
# echo -n "$NEWLogSwp" > $FileMark



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

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### Limpa o marcador criado pelo datacenter"
rm /data/trueDT/peer/Sync/ZZZ_Last_LOOP.live



# box trava em looping verificar se esta em sync com o server

# box pausa o sync com o server

# box apaga todos os arquivos de log da pasta sync

# box apaga o profile do sync para liberar recursos e não ficar monitorando as pastas


# # roda code unico para cliente
# FileExec="/data/trueDT/peer/Sync/sh.uniq/uniqCode.sh"
# if [ -e $FileExec ]; then
#     /system/bin/busybox kill -9 `/system/bin/busybox ps aux | grep uniqCode.sh | /system/bin/busybox grep -v grep | /system/bin/busybox awk '{print $1}'`
#     sh $FileExec &
# fi

# ideias para rodar scripts direto da pasta syncthing
# - preciso criar uma regra para executar apenas código via call de script boot
# ? criar script em 7z com senha. o loader no script de boot aplica a senha
# + se a senha estiver errada ou desatualizada o script não roda


USBLOGCALL="p2p pack verify pass"
OutputLogUsb


