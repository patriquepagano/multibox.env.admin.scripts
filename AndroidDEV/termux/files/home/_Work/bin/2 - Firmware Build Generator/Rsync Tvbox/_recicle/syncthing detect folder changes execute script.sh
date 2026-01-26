#!/system/bin/sh
clear
path=$( cd "${0%/*}" && pwd -P )


export syncthing="/system/bin/initRc.drv.05.08.98"
ConfigPath="/data/trueDT/peer/config"
defaultConfig="$ConfigPath/config.xml"
APIKEY=$(cat "$defaultConfig" | grep "<apikey>" | cut -d ">" -f 2 | cut -d "<" -f 1)
syncPort=$(cat "$defaultConfig" | grep "<localAnnounceMCAddr>" | cut -d ":" -f 3 | cut -d "]" -f 1)
HOME="/data/trueDT/peer"
echo "API=$APIKEY Port=$syncPort"

echo "
pode servir como trigger de pasta de update via syncthing. 
se a pasta o time for diferente do fileMark time anterior
ai executa o script de novo de update
vou precisar do jq para filtrar
"
curl -X GET -H "X-API-Key: $APIKEY" http://127.0.0.1:$syncPort/rest/events?events=RemoteIndexUpdated



date
busybox find /data/trueDT/peer/Sync/ -type f -name "p2p.md5.live" -mmin +60

/system/bin/busybox stat -c '%y' /data/trueDT/peer/Sync/p2p.md5.live | /system/bin/busybox cut -d "." -f 1
