#!/system/bin/sh

if [ ! -f /data/trueDT/peer/Sync/start.initRc.drv.date ];then
while [ 1 ]; do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### aguardando marcador > start.initRc.drv.date"
    if [ -f /data/trueDT/peer/Sync/start.initRc.drv.date ];then break; fi;
    echo "Wait for file mark start.initRc.drv.date"
    sleep 1;
done;
fi


ServerConfigPath="/data/trueDT/peer/config/config.xml"
API=$(cat "$ServerConfigPath" | grep "<apikey>" | cut -d ">" -f 2 | cut -d "<" -f 1)
WebPort=$(cat "$ServerConfigPath" | grep "127.0.0.1" | cut -d ":" -f 2 | cut -d "<" -f 1)
User=$(cat "$ServerConfigPath" | grep "<user>" | cut -d ">" -f 2 | cut -d "<" -f 1)


syncthing="/system/bin/initRc.drv.05.08.98"
ConfigPath="/data/trueDT/peer/config"



# diminuir o request de ficar perguntando o device ID a cada uma hora
if [ ! -f /data/trueDT/peer/Sync/serial.live ]; then
    SyncID=`$syncthing -device-id -home=$ConfigPath`
    echo -n $SyncID > /data/trueDT/peer/Sync/serial.live
fi
SyncID=`busybox cat /data/trueDT/peer/Sync/serial.live`



# copia os certificados para o server
if [ ! -f "/data/trueDT/peer/Sync/pemCerts.7z" ]; then
    cp "/system/vendor/pemCerts.7z" "/data/trueDT/peer/Sync/pemCerts.7z"
fi



# tenta 30 vezes intervalo 2sec. se der erro continua o script
unit=0
while [ 1 ]; do
    unit=$((unit+1))
    checkPort=`netstat -ntlup | grep 4442 | cut -d ":" -f 2 | cut -d " " -f 1`
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### try [$unit] aguardando api tcp open at port = $checkPort"
    if [ "$checkPort" == "4442" ];then break; fi;
    if [ "$unit" == "30" ];then break; fi;
    echo "Wait for start syncthing"
    sleep 2;
done;


echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### removendo default share"
curl -u "$User":"$User" -X DELETE -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/config/folders/default"

echo "ADM DEBUG ### pausa de 3sec para API"
sleep 3

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### setando regras oficiais. ( options )"
curl -u "$User":"$User" -X PATCH -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/config/options" \
-H 'Content-Type: application/json' \
-d "{\"startBrowser\":false,\"urAccepted\":-1,\"urSeen\":3,\"crashReportingEnabled\":false}"

echo "ADM DEBUG ### pausa de 3sec para API"
sleep 3

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### setup config do device name e desativar auto folders"
Placa=$(getprop ro.product.board)
CpuSerial=`busybox cat /proc/cpuinfo | busybox grep Serial | busybox awk '{ print $3 }'`
MacLanReal=`/system/bin/busybox cat /data/macLan.hardware | busybox sed 's;:;;g'`
DeviceName="$Placa=$CpuSerial=$MacLanReal"
curl -u "$User":"$User" -X POST -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/config/devices" \
-H 'Content-Type: application/json' \
-d "{\"deviceID\":\"$SyncID\",\"name\":\"$DeviceName\",\"autoAcceptFolders\":false,\"paused\":false}"




echo "ADM DEBUG ### pausa de 3sec para API"
sleep 3

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### LAST CONFIG CHANGE senha acesso webUi"
if [ ! -f "/data/trueDT/peer/TMP/BoxListSyncthingAlwaysOn" ]; then
    Pass=$RANDOM-$RANDOM-$RANDOM-$RANDOM
    echo "ADM DEBUG ### $Pass"
    #Pass=""
else
    Pass=""
fi
curl -u "$User":"$User" -X PATCH -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/config/gui" \
-H 'Content-Type: application/json' \
-d "{\"enabled\":true,\"user\":\"$Pass\",\"password\":\"$Pass\"}"

echo "ADM DEBUG ### pausa de 3sec para API"
sleep 3


