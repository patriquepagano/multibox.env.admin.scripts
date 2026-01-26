#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear
TMP_DIR="/data/trueDT/peer/TMP"

BB=/system/bin/busybox


SyncID=$(< "$TMP_DIR/init.21027.ID")
CfgXML="/data/trueDT/peer/config/config.xml"
API=$($BB awk -F '[><]' '/<apikey>/ {print $3}' "$CfgXML")
APIURL="http://127.0.0.1:8384/rest"


FOLDERS_URL="$APIURL/config/folders"
DEVICES_URL="$APIURL/config/devices"
CONN_URL="$APIURL/system/connections"
cleaned=""


SearchFolder="Client"
# pasta de log
LOG="$path/${SearchFolder}.log"


date > "$LOG"
echo "=== $(date) ==="   >>"$LOG"


# 1) pega ID da pasta Client
folder=$(
  curl -s -H "X-API-Key: $API" "$FOLDERS_URL" |
    $BB awk -F '"' '/"id":/ {print $4}' |
    $BB grep -E '^TVBox-.*Client$'
)
[ -z "$folder" ] && exit 0
echo "DEBUG folder=$folder" >> "$LOG"

# 2) força um rescan e espera o DB atualizar
curl -s -X POST -H "X-API-Key: $API" "$RESCAN_URL?folder=$folder" >> "$LOG"
$BB sleep 2

# 3) checa status atualizado
st=$(
  curl -s -H "X-API-Key: $API" \
    "$APIURL/db/status?folder=$folder&device=$SyncID"
)
state=$($BB awk -F'"'            '/"state":/          {print $4}' <<<"$st")
needBytes=$($BB awk -F': '         '/needBytes/         {gsub(/,/,"");print $2}' <<<"$st")
globalBytes=$($BB awk -F': '        '/globalBytes/        {gsub(/,/,"");print $2}' <<<"$st")
inSyncBytes=$($BB awk -F': '       '/inSyncBytes/       {gsub(/,/,"");print $2}' <<<"$st")

echo "DEBUG state=$state needBytes=$needBytes globalBytes=$globalBytes inSyncBytes=$inSyncBytes" \
  >> "$LOG"

# 4) Phase 1: aguarda idle + needBytes=0
if [ "$state" != "idle" ] || [ "$needBytes" -ne 0 ]; then
  echo "PHASE1: aguardando idle+needBytes=0" >> "$LOG"
  exit 0
fi

# 5) Phase 2: aguarda inSyncBytes >= globalBytes
if [ "$inSyncBytes" -lt "$globalBytes" ]; then
  echo "PHASE2: aguardando inSyncBytes ($inSyncBytes) >= globalBytes ($globalBytes)" \
    >> "$LOG"
  exit 0
fi

# 6) Phase 3: sync completo → remove a pasta
echo "PHASE3: sync 100% OK → removendo $folder" >> "$LOG"
curl -s -X DELETE -H "X-API-Key: $API" "$FOLDERS_URL/$folder"





read bah