#!/system/bin/sh
export syncthing="/system/bin/initRc.drv.05.08.98"
ConfigPath="/data/trueDT/peer/config"
defaultConfig="$ConfigPath/config.xml"

function checksyncthing () {
export checkPort=`netstat -ntlup | grep 4442 | cut -d ":" -f 2 | cut -d " " -f 1`
echo $checkPort
    if [ "$checkPort" == "4442" ]; then
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### Desligando serviço syncthing"
        echo "ADM DEBUG ### syncthing rodando na porta $checkPort"
        killsyncthing
    fi
}

function killsyncthing () {
    APIKEY=$(cat "$defaultConfig" | grep "<apikey>" | cut -d ">" -f 2 | cut -d "<" -f 1)
    syncPort=$(cat "$defaultConfig" | grep "<localAnnounceMCAddr>" | cut -d ":" -f 3 | cut -d "]" -f 1)
    HOME="/data/trueDT/peer"
    echo "API=$APIKEY Port=$syncPort"
    sync
    curl -X POST -H "X-API-Key: $APIKEY" http://127.0.0.1:$syncPort/rest/system/shutdown
    sync
    screenPort=$(screen -ls | grep Syncthing | /system/bin/busybox awk '{print $1}' | cut -d '.' -f 1)
    screen -X -S $screenPort.Syncthing quit
}

while [ 1 ]; do
    checksyncthing
    if [ ! "$checkPort" = "4442" ]; then
        echo "ADM DEBUG ###########################################################"
        echo "ADM DEBUG ### travando loop ate fechar o syncthing"
        break; 
    fi;
    sleep 1;
done;





# # funciona para fechar o binario mas é forçado!
# processes=`/system/bin/busybox ps \
# | /system/bin/busybox grep "$syncthing" \
# | /system/bin/busybox grep -v "grep" \
# | /system/bin/busybox awk '{print $1}'`

# for killer in $processes; do
# echo "Rodando na porta $killer"
# /system/bin/busybox kill -9 $killer
# done

