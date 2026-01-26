#!/system/bin/sh

ServerConfigPath="/data/trueDT/peer/config/config.xml"
API=$(cat "$ServerConfigPath" | grep "<apikey>" | cut -d ">" -f 2 | cut -d "<" -f 1)
WebPort=$(cat "$ServerConfigPath" | grep "127.0.0.1" | cut -d ":" -f 2 | cut -d "<" -f 1)
User=$(cat "$ServerConfigPath" | grep "<user>" | cut -d ">" -f 2 | cut -d "<" -f 1)



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
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### API=$API Port=$WebPort"
    sync
    curl -u "$User":"$User" -X POST -H "X-API-Key: $API" http://127.0.0.1:$WebPort/rest/system/shutdown
    sync
    HOME="/data/trueDT/peer"
    screenPort=$(screen -ls | grep Syncthing | /system/bin/busybox awk '{print $1}' | cut -d '.' -f 1)
    screen -X -S $screenPort.Syncthing quit
    killall initRc.drv.05.08.98
}


checksyncthing

# while [ 1 ]; do
#     checksyncthing
#     if [ ! "$checkPort" = "4442" ]; then
#         echo "ADM DEBUG ###########################################################"
#         echo "ADM DEBUG ### travando loop ate fechar o syncthing"
#         break; 
#     fi;
#     sleep 2;
# done;

# se não fechar por bem vai moda bicho! em caso de estar na porta 8384
killall initRc.drv.05.08.98
killall initRc.drv.05.08.98
killall initRc.drv.05.08.98
netstat -ntlup | grep initRc

