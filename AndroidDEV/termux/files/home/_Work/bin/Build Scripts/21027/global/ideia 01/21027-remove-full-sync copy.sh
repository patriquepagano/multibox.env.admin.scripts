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


# 1) remove pastas sincronizadas e devices órfãos iniciais
curl -s -H "X-API-Key: $API" "$FOLDERS_URL" \
  | $BB awk -F '"' '/"id":/ {print $4}' \
  | $BB grep -E '^TVBox-.*-(Client|Server)$' \
  | while read -r folder; do
    devs=$(curl -s -H "X-API-Key: $API" "$FOLDERS_URL/$folder" \
             | $BB awk -F '"' '/"deviceID":/ {print $4}')

    # escolhe servidor remoto
    remoteDev=""
    for d in $devs; do
      [ "$d" = "$SyncID" ] && continue
      remoteDev=$d; break
    done
    [ -z "$remoteDev" ] && continue

    # pega status só entre este TVBox e o servidor
    st=$(curl -s -H "X-API-Key: $API" \
         "$APIURL/db/status?folder=$folder&device=$remoteDev")

    # checa tipo
    type=$(curl -s -H "X-API-Key: $API" "$FOLDERS_URL/$folder" \
           | $BB awk -F '"' '/"type":/ {print $4}')

    # extrai counters antes de montar ready
    needBytes=$(echo "$st" | $BB awk -F': ' '/needBytes/   {gsub(/,/, ""); print $2}')
    needDeletes=$(echo "$st" | $BB awk -F': ' '/needDeletes/ {gsub(/,/, ""); print $2}')
    recvFiles=$(echo "$st"   | $BB awk -F': ' '/receiveOnlyChangedFiles/ {gsub(/,/, ""); print $2}')
    recvBytes=$(echo "$st"   | $BB awk -F': ' '/receiveOnlyChangedBytes/ {gsub(/,/, ""); print $2}')

    # só remove quando 100% sync
    ready=0
    if [ "$type" = "sendonly" ]; then
      [ "$needBytes" -eq 0 ] && [ "$needDeletes" -eq 0 ] && ready=1
    elif [ "$type" = "receiveonly" ]; then
      [ "$recvFiles" -eq 0 ] && [ "$recvBytes" -eq 0 ] && ready=1
    fi

    if [ "$ready" -eq 1 ]; then
      echo "→ REMOVENDO pasta $folder"
      curl -s -X DELETE -H "X-API-Key: $API" "$FOLDERS_URL/$folder"
      $BB sleep 3
      # clean up devices órfãos desta pasta
      for dev in $devs; do
        [ "$dev" = "$SyncID" ] && continue
        if ! curl -s -H "X-API-Key: $API" "$FOLDERS_URL" \
             | $BB grep -q "\"deviceID\":\"$dev\""; then
          echo "   ↳ REMOVENDO device $dev"
          curl -s -X DELETE -H "X-API-Key: $API" "$DEVICES_URL/$dev"
          $BB sleep 3
          cleaned="$cleaned $dev"
        fi
      done
    fi
done








read bah