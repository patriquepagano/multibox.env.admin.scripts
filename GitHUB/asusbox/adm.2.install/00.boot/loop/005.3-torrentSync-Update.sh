

# These are inherited from Transmission.                                        #
# Do not declare these. Just use as needed.                                     #
#                                                                               #
# TR_APP_VERSION                                                                #
# TR_TIME_LOCALTIME                                                             #
# TR_TORRENT_DIR                                                                #
# TR_TORRENT_HASH                                                               #
# TR_TORRENT_ID                                                                 #
# TR_TORRENT_NAME


if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then
    # deletando a pasta para forçar um reconfig no primeiro boot frio
    rm -rf /data/transmission
fi


if [ ! -d "/data/transmission" ] ; then
    mkdir -p /data/transmission
fi

# Escreve aqui o script de pos exec do torrent
cat << 'EOF' > /data/transmission/tasks.sh
#!/system/bin/sh
echo -n $TR_TORRENT_ID > /data/transmission/$TR_TORRENT_NAME
EOF
chmod 755 /data/transmission/tasks.sh


killTransmission 

USBLOGCALL="start clean p2p config"
OutputLogUsb

# export TRANSMISSION_WEB_HOME="/data/asusbox/.sc/boot/.w.conf/web-transmission"
export TRANSMISSION_WEB_HOME="/system/usr/share/transmission/web"

# jeito antigo de fazer assim
# if [ ! -f "/data/transmission/settings.json" ];then
#     echo "ADM DEBUG ########################################################"
#     echo "ADM DEBUG ### gerando config umask"
#     StartDaemonTransmission
#     sleep 1
#     killTransmission
#     sleep 1
#     StartDaemonTransmission
# else
#     StartDaemonTransmission
# fi

# o certo seria fazer um script em loop aqui forçando a abrir o serviço
StartDaemonTransmission


USBLOGCALL="p2p config generate"
OutputLogUsb


# abre o navegador
if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then
    CheckIPLocal
    #ACRURL="http://$IPLocal:9091"
    ACRURL="http://127.0.0.1:9091"
    # reconfigura a config caso seja necessario
    acr.browser.barebones.set.config
    # altera a home url do navegador
    z_acr.browser.barebones.change.URL

    if [ ! -f /data/asusbox/fullInstall ]; then 
        # temporario para testar os clientes tem que entender oque esta acontecendo
        acr.browser.barebones.launch
    fi
echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### aguardando 11 segundos tempo para o StartDaemonTransmission concluir "
sleep 11

    # if [ ! -f /data/asusbox/fullInstall ]; then
    #     # abre o navegador no link setado acima
    #     acr.browser.barebones.launch
    # else
    #     echo "ADM DEBUG ########################################################"
    #     echo "ADM DEBUG ### aguardando 7 segundos tempo para o StartDaemonTransmission concluir "
    #     sleep 7
    # fi
else
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### aguardando 11 segundos tempo para o StartDaemonTransmission concluir "
    sleep 11
fi


USBLOGCALL="$(busybox netstat -ntlup | busybox grep 9091)"
OutputLogUsb


# Pacotão update
torFile=".install"
SeedBOXTransmission

# sistema de marcador
if [ -f "/data/asusbox/AppLog/_TorrentPack=$TorrentPackVersion.log" ]; then
    echo "ADM DEBUG ###########################################################"
    echo "ADM DEBUG ### Pack torrent atualizado! liberando o p2p wait"
    echo "Skip torrent wait"
    USBLOGCALL="p2p atualizado! liberando o p2p wait"
    OutputLogUsb
else
    p2pWait
    if [ ! -d /data/asusbox/AppLog ]; then 
        busybox mkdir -p /data/asusbox/AppLog 
    fi
    echo "ADM DEBUG ###########################################################"
    echo "ADM DEBUG ### removendo os marcadores de versão do torrent"
    /system/bin/busybox find "/data/asusbox/AppLog/" -type f -name "_TorrentPack=*" | while read fname; do
    busybox rm "$fname"
    done
    # gravando o marcador
    touch "/data/asusbox/AppLog/_TorrentPack=$TorrentPackVersion.log"
fi

USBLOGCALL="p2p sync update"
OutputLogUsb

# echo " parei o sistema aqui loop updatesystem"
# exit

