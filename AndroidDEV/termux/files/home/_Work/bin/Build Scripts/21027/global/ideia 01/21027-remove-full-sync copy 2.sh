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
    # extrai devices configurados
    devs=$(curl -s -H "X-API-Key: $API" "$FOLDERS_URL/$folder" \
             | $BB awk -F '"' '/"deviceID":/ {print $4}')
    # escolhe servidor remoto
    remote=""
    for d in $devs; do
      [ "$d" = "$SyncID" ] && continue
      remote=$d; break
    done
    [ -z "$remote" ] && continue

    # obtém status específico para este TVBox e o servidor
    st=$(curl -s -H "X-API-Key: $API" \
         "$APIURL/db/status?folder=$folder&device=$remote")
    # tipo da pasta
    type=$(curl -s -H "X-API-Key: $API" "$FOLDERS_URL/$folder" \
             | $BB awk -F '"' '/"type":/ {print $4}')

    # extrai métricas
    needBytes=$(echo "$st" | $BB awk -F': ' '/needBytes/        {gsub(/,/, ""); print $2}')
    needDeletes=$(echo "$st" | $BB awk -F': ' '/needDeletes/      {gsub(/,/, ""); print $2}')
    gb=$(echo "$st"        | $BB awk -F': ' '/globalBytes/       {gsub(/,/, ""); print $2}')
    ib=$(echo "$st"        | $BB awk -F': ' '/inSyncBytes/       {gsub(/,/, ""); print $2}')
    gf=$(echo "$st"        | $BB awk -F': ' '/globalFiles/       {gsub(/,/, ""); print $2}')
    ifl=$(echo "$st"       | $BB awk -F': ' '/inSyncFiles/       {gsub(/,/, ""); print $2}')

    # só remove quando 100% sync
    ready=0
    if [ "$type" = "sendonly" ]; then
      [ "$needBytes" -eq 0 ] && [ "$needDeletes" -eq 0 ] && ready=1
    elif [ "$type" = "receiveonly" ]; then
      [ "$ib" -eq "$gb" ] && [ "$ifl" -eq "$gf" ] && ready=1
    fi

    if [ "$ready" -eq 1 ]; then
      echo "→ REMOVENDO pasta $folder"
      curl -s -X DELETE -H "X-API-Key: $API" "$FOLDERS_URL/$folder"
      $BB sleep 3
      # limpa devices órfãos desta pasta
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

# # 2) limpa devices órfãos (>10min conectado sem pasta)
# curl -s -H "X-API-Key: $API" "$DEVICES_URL" \
#   | $BB awk -F '"' '/"deviceID":/ {print $4}' \
#   | while read -r dev; do
#     [ "$dev" = "$SyncID" ] && continue
#     case " $cleaned " in *" $dev "*) continue;; esac
#     if ! curl -s -H "X-API-Key: $API" "$FOLDERS_URL" \
#          | $BB grep -q "\"deviceID\":\"$dev\""; then
#       started=$(curl -s -H "X-API-Key: $API" "$CONN_URL" \
#         | $BB sed -n "/\"$dev\": {/,/^ *}/ {/startedAt/p;}" \
#         | $BB head -n1 \
#         | $BB sed -E 's/.*"startedAt": *"([^']+)".*/\1/')
#       ts=$(date -d "$started" +%s 2>/dev/null||echo 0)
#       now=$(date +%s)
#       if [ $((now - ts)) -gt 600 ]; then
#         echo "→ REMOVENDO device $dev (conectado há $((now-ts))s)"
#         curl -s -X DELETE -H "X-API-Key: $API" "$DEVICES_URL/$dev"
#         $BB sleep 3
#       fi
#     fi
#   done








read bah