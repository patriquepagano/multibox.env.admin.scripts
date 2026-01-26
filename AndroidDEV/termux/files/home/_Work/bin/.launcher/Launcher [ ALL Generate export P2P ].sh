#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )


ConfigPath="/data/trueDT/peer/config/config.xml"
APIKEY=$(cat "$ConfigPath" | grep "<apikey>" | cut -d ">" -f 2 | cut -d "<" -f 1)
syncPort=$(cat "$ConfigPath" | grep "<localAnnounceMCAddr>" | cut -d ":" -f 3 | cut -d "]" -f 1)    
# mostra versão
echo "API=$APIKEY Port=$syncPort"
curl -X GET -H "X-API-Key: $APIKEY" http://127.0.0.1:$syncPort/qr/?text="IP_da_sua_box" --output /storage/emulated/0/Download/QR.IPLocal.png
curl -X GET -H "X-API-Key: $APIKEY" http://127.0.0.1:$syncPort/qr/?text="IP_da_sua_box" --output /data/data/dxidev.toptvlauncher2/launcher-03-full/QR.IPLocal.png
chmod 777 /data/data/dxidev.toptvlauncher2/launcher-03-full/QR.IPLocal.png

"$path/launcher-03-full [A] Backup Config.sh"
"$path/launcher-03-full [B] WIP export + restore.sh"
"$path/launcher-03-full [C] export P2P Pack.sh"





