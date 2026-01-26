#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )


if [ ! -d /data/trueDT/peer/TMP ]; then
    mkdir -p /data/trueDT/peer/TMP
fi

# limpar configurações bugadas de shares e devices
#rm "/data/trueDT/peer/TMP/FixBug.initRC.drv_v2" # uncomment for debug
if [ ! -f "/data/trueDT/peer/TMP/FixBug.initRC.drv_v2" ] ; then
    "$path/[STOP].sh"
    rm -rf /data/trueDT/peer/config > /dev/null 2>&1
    date +"%d/%m/%Y %H:%M:%S" > "/data/trueDT/peer/TMP/FixBug.initRC.drv_v2"
fi

checkPort=`netstat -ntlup | grep 4442 | cut -d ":" -f 2 | cut -d " " -f 1`
if [ "$checkPort" == "4442" ]; then
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### service is online at port = $checkPort"
    logcat -c 
else
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### start screen | syncthing instance"
    HOME="/data/trueDT/peer"
    # necessário criar a pasta para o screen funcionar
    mkdir -p $HOME
    #chmod 755 "$path/loadService.sh"
    screen -dmS Syncthing "$path/loadService.sh"
    screen -wipe
    screen -ls
fi



