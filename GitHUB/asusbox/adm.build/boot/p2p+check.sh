#!/system/bin/sh

export cronRunning=yes # necessário para passar a instrução para o boot updatesystem
date > /data/asusbox/crontab/LOCK_cron.updates

torFile=".install"

DIR=$( cd "${0%/*}" && pwd -P )
if [ "$DIR" == "/storage/DevMount/GitHUB/asusbox/adm.build/boot" ] ; then
    EnableDEVMode="YES"
fi

### PARA DESATIVAR O DEBUG COMENTE A LINHA ABAIXO
#echo "Debug ForceUpdate" >> "/data/asusbox/.install.torrent"
# /system/bin/busybox md5sum "/data/asusbox/.install.torrent" | /system/bin/busybox cut -d ' ' -f1 #>> $FCheck/keys.hash 2>&1

### ALTERAR O FileMark para um endereço que não exista via vscode para simular box de cliente
FileMark="/storage/asusboxUpdate/GitHUB/asusbox/adm.2.install/.install.torrent"

function Download_torrent_File () {
# erro 301 esta baixando o link
# 1 - nosso linode oficial
# 2 - site do asusbox
# 3 - linode do elton
multilinks="
http://45.79.133.216/asusboxA1/.install.torrent
https://asusbox.com.br/asusboxA1/.install.torrent
http://45.79.48.215/asusboxA1/.install.torrent
"
    ### DOWNLOAD COM SISTEMA MULTI-LINKS
    for LinkUpdate in $multilinks; do 
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### Entrando na função > Download_torrent_File"
        echo "ADM DEBUG ### tentando o link > $LinkUpdate"
        TorrentFileInstall="false" # ate que se prove o contrario não baixou o arquivo
        # Tenta conectar ao link 7 vezes 
        #/system/bin/wget --timeout=1 --tries=7 -O $bootFile --no-check-certificate $LinkUpdate
        /system/bin/wget -N --no-check-certificate --timeout=1 --tries=7 -P /data/asusbox/ $LinkUpdate > "/data/asusbox/wget.log" 2>&1
        CheckWgetCode=`/system/bin/busybox cat "/data/asusbox/wget.log" | /system/bin/busybox grep "HTTP request sent, awaiting response..."`
        #rm "/data/asusbox/wget.log"
            # Se tiver acesso finaliza esta função
            if [ "$CheckWgetCode" == "HTTP request sent, awaiting response... 200 OK" ] ; then
                echo "ADM DEBUG ### Wget :) $CheckWgetCode"
                echo "ADM DEBUG ### Novo torrent baixado! iniciando update do pacote"
                TorrentFileInstall="true"
                TorrentAction="updatePack"
                break # fecha a função por completo
            fi
            if [ "$CheckWgetCode" == "HTTP request sent, awaiting response... 304 Not Modified" ] ; then
                echo "ADM DEBUG ### Wget :) $CheckWgetCode"
                echo "ADM DEBUG ### Torrent local esta atualizado [304]"
                TorrentFileInstall="true"
                TorrentAction="skip"
                break # fecha a função por completo
            fi            
    done ### DOWNLOAD COM SISTEMA MULTI-LINKS
    echo "ADM DEBUG ### fim da função TorrentFileInstall > TorrentFileInstall=$TorrentFileInstall"
}


function LoopForceDownloadtorrent_File () { # entra em looping até baixar o arquivo de boot
while true; do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Entrando na função > LoopForceDownloadtorrent_File"
    Download_torrent_File 
	if [ "$TorrentFileInstall" == "false" ]; then
        echo "ADM DEBUG ### Nova tentativa em loop para baixar"
        logcat -c
    else
        break
    fi
done
}

FileMark="/storage/asusboxUpdate/GitHUB/asusbox/adm.2.install/.install.torrent"
if [ ! -f $FileMark ]; then
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### tvbox de cliente detectada"
    # verifica se for um symlink apaga
    CheckSymlink=`/system/bin/busybox readlink -fn /data/asusbox/.install.torrent`
    if [ ! "$CheckSymlink" == "/data/asusbox/.install.torrent" ] ; then
        rm /data/asusbox/.install.torrent
    fi
    # rm /data/asusbox/.install.torrent # NÃO FAZ SENTIDO APAGAR O TORRENT! FICA CAUSANDO GASTO DE BANDA A TODA NO VPS
    LoopForceDownloadtorrent_File
else
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### build generator testes detectado."
    echo "ADM DEBUG ### torrent vai fazer share do torrent local"
    rm /data/asusbox/.install.torrent # AQUI APAGA PARA USAR APENAS O MEU TORRENT
    /system/bin/busybox ln -sf $FileMark /data/asusbox/.install.torrent
    logcat -c
fi

##############################################################################################################################################
##############################################################################################################################################
##############################################################################################################################################
# verifica se o serviço p2p esta rodando, se o torrent foi pausado ou removido pela interface
#/system/bin/transmission-remote --list
torDone=`/system/bin/transmission-remote --list \
| /system/bin/busybox grep "$torFile" \
| /system/bin/busybox awk '{print $2}' \
| /system/bin/busybox sed -e 's/[^0-9]*//g'`

torStatus=`/system/bin/transmission-remote --list \
| /system/bin/busybox grep "$torFile" \
| /system/bin/busybox awk '{print $9}'`

torName=`/system/bin/transmission-remote --list \
| /system/bin/busybox grep "$torFile" \
| /system/bin/busybox awk '{print $10}'`

if [ ! "$torDone-$torStatus-$torName" == "100-Idle-.install" ]; then
    TorrentAction="updatePack"
fi


#############################################################################################################################
#############################################################################################################################
#############################################################################################################################
# segunda etapa funções 

function P2Pstop () {
if [ "$EnableDEVMode" == "YES" ]; then
    "/storage/DevMount/GitHUB/asusbox/adm.build/boot/p2p+stop.sh"
else
    "/data/asusbox/.sc/boot/p2p+stop.sh"
fi
}

function P2PstartDaemon () {
if [ "$EnableDEVMode" == "YES" ]; then
    "/storage/DevMount/GitHUB/asusbox/adm.build/boot/p2p+startDaemon.sh"
else
    "/data/asusbox/.sc/boot/p2p+startDaemon.sh"
fi
}

function P2PSeedBOX () {
if [ "$EnableDEVMode" == "YES" ]; then
    "/storage/DevMount/GitHUB/asusbox/adm.build/boot/p2p+seedbox.sh"
else
    "/data/asusbox/.sc/boot/p2p+seedbox.sh"
fi
}




# These are inherited from Transmission.                                        #
# Do not declare these. Just use as needed.                                     #
#                                                                               #
# TR_APP_VERSION                                                                #
# TR_TIME_LOCALTIME                                                             #
# TR_TORRENT_DIR                                                                #
# TR_TORRENT_HASH                                                               #
# TR_TORRENT_ID                                                                 #
# TR_TORRENT_NAME

# loop se for necessário o update
if [ "$TorrentAction" == "updatePack" ] ; then

if [ ! -d "/data/transmission" ] ; then
    mkdir -p /data/transmission
fi

# Escreve aqui o script de pos exec do torrent

p2pfiletask="/data/transmission/tasks.sh"
checkFilecrc=`/system/bin/busybox md5sum "$p2pfiletask" | /system/bin/busybox cut -d ' ' -f1`
if [ ! "$checkFilecrc" == "517a419577430cf4138935865c4f14fa" ]; then
echo "ADM DEBUG ### editando arquivo torrent task after download"
cat << 'EOF' > /data/transmission/tasks.sh
#!/system/bin/sh
echo -n $TR_TORRENT_ID > /data/transmission/$TR_TORRENT_NAME
EOF
chmod 755 /data/transmission/tasks.sh
fi

P2Pstop

# export TRANSMISSION_WEB_HOME="/data/asusbox/.sc/boot/.w.conf/web-transmission"
export TRANSMISSION_WEB_HOME="/system/usr/share/transmission/web"
if [ ! -f "/data/transmission/settings.json" ];then
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### gerando config umask"
    P2PstartDaemon
    sleep 1
    P2Pstop
    sleep 1
    P2PstartDaemon
else
    P2PstartDaemon
fi

# Pacotão update
P2PSeedBOX

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### P2P wait required by cron"
FileWaitingP2P="/data/transmission/$torFile"
/system/bin/busybox rm $FileWaitingP2P > /dev/null 2>&1
while [ 1 ]; do
    if [ -e $FileWaitingP2P ];then break; fi;
    echo "Wait for update $torFile"
    # ShellResult=`/system/bin/transmission-remote --list`
    # echo "ADM DEBUG ### escrevendo no log web progresso do torrent"
    # echo "<h2>$ShellResult</h2>" > $bootLog 2>&1
    sleep 5;    
done;
echo "ADM DEBUG ### arquivo $FileWaitingP2P apagado!"
/system/bin/busybox rm $FileWaitingP2P

fi # END loop se for necessário o update


