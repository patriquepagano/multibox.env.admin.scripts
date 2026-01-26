#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear
TMP_DIR="/data/trueDT/peer/TMP"
ClientHardware="/data/trueDT/peer/Sync/Upload/ClientHardware"
Placa=$(< "$ClientHardware/MB")
CpuSerial=$(< "$ClientHardware/CPU")
MacLanReal=$(< "$ClientHardware/macLan")
DeviceName="$Placa=$CpuSerial=$MacLanReal"
SyncID=$(< "$TMP_DIR/init.21027.ID")
CfgXML="/data/trueDT/peer/config/config.xml"
API=$($BB awk -F '[><]' '/<apikey>/ {print $3}' "$CfgXML")
Headers="Content-Type: application/json"
FullAccessFile="$TMP_DIR/init.21027.fullAccess"
WebPort=8384



APIURL="http://127.0.0.1:$WebPort/rest"
FOLDER="boot_$DeviceName"


curl -s -H "X-API-Key:$API" "$APIURL/db/status?folder=$FOLDER" \
   > "$path/Folder boot status.log" 


APIURL="http://127.0.0.1:$WebPort/rest"
for FOLDER in "boot_$DeviceName" "log_$DeviceName"; do
  st=$(curl -s -H "X-API-Key:$API" "$APIURL/db/status?folder=$FOLDER")
  changedFiles=$(busybox printf '%s' "$st" \
    | busybox grep -o '"receiveOnlyChangedFiles":[[:space:]]*[0-9]*' \
    | busybox tr -cd '0-9')
  changedDirs=$(busybox printf '%s' "$st" \
    | busybox grep -o '"receiveOnlyChangedDirectories":[[:space:]]*[0-9]*' \
    | busybox tr -cd '0-9')
  # se vazio, assume zero
  changedFiles=${changedFiles:-0}
  changedDirs=${changedDirs:-0}
  #echo "$FOLDER → files=$changedFiles, dirs=$changedDirs"
  if [ "$changedFiles" -gt 0 ] || [ "$changedDirs" -gt 0 ]; then
    curl -s -X POST -H "X-API-Key:$API" "$APIURL/db/revert?folder=$FOLDER"
  fi
done






# "receiveOnlyChangedFiles": 6,
# "receiveOnlyChangedDirectories": 1,
# "receiveOnlyChangedBytes": 1759,
# "receiveOnlyTotalItems": 7

#   "errors": 1,
#   "pullErrors": 1,







# date

# OverrideURL="http://127.0.0.1:8384/rest/db/revert?folder=boot_$DeviceName"
# curl -X POST -H "X-API-Key: $API" "$OverrideURL"

# OverrideURL="http://127.0.0.1:8384/rest/db/revert?folder=log_$DeviceName"
# curl -X POST -H "X-API-Key: $API" "$OverrideURL"

# date


echo uau

read bah




# Melhor deixar como está (vários TXT) ou, no máximo, agrupar num único arquivo de log “append-only” (sem compressão).
# Por quê?
# Syncthing faz delta‐sync em nível de bloco: se você mudar um TXT ele só envia os blocos alterados.
# Um .7z binário muda o arquivo inteiro a cada compactação e acaba mandando quase tudo de novo 
# (e ainda gasta CPU em cada 7z).
# Ter dezenas de arquivos pequenos não vai “pesar” o FS nem o Syncthing, a não ser que seja milhares de 
# arquivos o tempo todo.
# Se quiser reduzir número de inodes, use rotação simples: logs-YYYY-MM-DD.txt e vá appendando ali—sempre 
# só o bloco final muda, sem overhead de CPU ou reupload total.



