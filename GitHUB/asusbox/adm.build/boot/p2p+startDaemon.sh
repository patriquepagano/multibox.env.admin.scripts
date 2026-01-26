#!/system/bin/sh

function StartDaemonTransmission () {
configDir="/data/transmission"
seedBox="/storage/emulated/0/Download"

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
-c /storage/emulated/0/Download/ \
-w $seedBox

sleep 1
# verificação apos iniciar o daemon
checkPort=`/system/bin/busybox netstat -ntlup | /system/bin/busybox grep "9091" | /system/bin/busybox cut -d ":" -f 2 | /system/bin/busybox awk '{print $1}'`
}

# verificação do primeiro loop
checkPort=`/system/bin/busybox netstat -ntlup | /system/bin/busybox grep "9091" | /system/bin/busybox cut -d ":" -f 2 | /system/bin/busybox awk '{print $1}'`

while true; do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### verificando se daemon esta ativo"    
	if [ ! "$checkPort" == "9091" ]; then
        echo "ADM DEBUG ### Ligando transmission torrent downloader"
        StartDaemonTransmission 
    else
        break
    fi
done


