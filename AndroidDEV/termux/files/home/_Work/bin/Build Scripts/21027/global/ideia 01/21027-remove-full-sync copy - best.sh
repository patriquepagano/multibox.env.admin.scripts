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
    # extrai dispositivos configurados na pasta
    devs=$(curl -s -H "X-API-Key: $API" "$FOLDERS_URL/$folder" \
             | $BB awk -F '"' '/"deviceID":/ {print $4}')

echo "$devs"

    # seleciona dispositivo remoto (não é o próprio TV-Box)
    remoteDev=""
    for d in $devs; do
      [ "$d" = "$SyncID" ] && continue
      remoteDev=$d
      break
    done
    # consulta status por dispositivo remoto
    st=$(curl -s -H "X-API-Key: $API" \
         "$APIURL/db/status?folder=$folder&device=$remoteDev")



    # extrai tipo da pasta
    type=$(curl -s -H "X-API-Key: $API" "$FOLDERS_URL/$folder" \
             | $BB awk -F '"' '/"type":/ {print $4}')

echo "
$st
status do dispositivo removo
---------
type = $type
"



# ready=0
# if [ "$type" = "sendonly" ]; then
#   needBytes=$(echo "$st" | $BB awk -F': ' '/needBytes/      {gsub(/,/,"");print $2}')
#   needDeletes=$(echo "$st" | $BB awk -F': ' '/needDeletes/    {gsub(/,/,"");print $2}')
#   [ "$needBytes" -eq 0 ] && [ "$needDeletes" -eq 0 ] && ready=1

# elif [ "$type" = "receiveonly" ]; then
#   recvFiles=$(echo "$st" | $BB awk -F': ' '/receiveOnlyChangedFiles/   {gsub(/,/,"");print $2}')
#   recvBytes=$(echo "$st" | $BB awk -F': ' '/receiveOnlyChangedBytes/   {gsub(/,/,"");print $2}')
#   [ "$recvFiles" -eq 0 ] && [ "$recvBytes" -eq 0 ] && ready=1
# fi

ready=0
if [ "$type" = sendonly ]; then
  # usa needBytes e needDeletes
  ready=$(( needBytes==0 && needDeletes==0 ? 1:0 ))
elif [ "$type" = receiveonly ]; then
  # usa os campos de receiveOnlyChanged*
  ready=$(( receiveOnlyChangedFiles==0 && receiveOnlyChangedBytes==0 ? 1:0 ))
fi





    if [ "$ready" -eq 1 ]; then
      echo "→ REMOVENDO pasta $folder"
      curl -s -X DELETE -H "X-API-Key: $API" "$FOLDERS_URL/$folder"
      $BB sleep 3
      # remove devices órfãos desta pasta
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

# 2) remove devices órfãos após 10min conectados
curl -s -H "X-API-Key: $API" "$DEVICES_URL" \
  | $BB awk -F '"' '/"deviceID":/ {print $4}' \
  | while read -r dev; do
    [ "$dev" = "$SyncID" ] && continue
    case " $cleaned " in *" $dev "*) continue;; esac
    if ! curl -s -H "X-API-Key: $API" "$FOLDERS_URL" \
         | $BB grep -q "\"deviceID\":\"$dev\""; then
      started=$(curl -s -H "X-API-Key: $API" "$CONN_URL" \
        | $BB sed -n '/"'$dev'": {/,/^ *}/{/startedAt/p;}' \
        | $BB head -n1 \
        | $BB sed -E 's/.*"startedAt": *"([^"]+)".*/\1/')
      ts=$(date -d "$started" +%s 2>/dev/null || echo 0)
      now=$(date +%s)
      if [ $((now - ts)) -gt 600 ]; then
        echo "→ REMOVENDO device $dev (conectado há $((now - ts))s)"
        curl -s -X DELETE -H "X-API-Key: $API" "$DEVICES_URL/$dev"
        $BB sleep 3
      fi
    fi
  done






read bah