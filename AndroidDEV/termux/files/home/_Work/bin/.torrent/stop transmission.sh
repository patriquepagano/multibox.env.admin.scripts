function killTransmission () {
    checkPort=`netstat -ntlup | /system/bin/busybox grep "9091" | /system/bin/busybox cut -d ":" -f 2 | /system/bin/busybox awk '{print $1}'`
    if [ "$checkPort" == "9091" ]; then
        echo "ADM DEBUG ### Desligando transmission torrent downloader"
        /system/bin/transmission-remote --exit
        killall transmission-daemon
    fi
}

function restartTransmission () {
    killTransmission
    sleep 3
    StartDaemonTransmission
# melhor seria criar uma função e um script anexo para o cron / ai o cliente não tem chance de desativar
# netstat -ntlup | grep transmission
}


function StartDaemonTransmission () {
#source /data/.vars # sera que realmente precisa disto??
configDir="/data/transmission"
seedBox="/sdcard/Download"

# pastas 
if [ ! -d $configDir ] ; then
    mkdir -p $configDir
fi
if [ ! -d $seedBox ] ; then
    mkdir -p $seedBox
fi
fileConf="/data/transmission/settings.json"
/system/bin/busybox sed -i -e 's;"umask":.*;"umask": 63,;g' $fileConf

# iniciei o daemon basico e no remote com todas as funções e com porta 51345 fechada! não iniciou nenhum up/down nem lp
high=65535
low=49152
export PeerPort=$(( ( RANDOM % (high-low) )  + low ))

echo "start" > /data/asusbox/transmission.log
echo "ADM DEBUG ### Iniciando transmission Daemon"
/system/bin/transmission-daemon \
-g $configDir \
-a 127.0.0.1,*.* \
-P $PeerPort \
-c /sdcard/Download/ \
-w $seedBox

}

restartTransmission


