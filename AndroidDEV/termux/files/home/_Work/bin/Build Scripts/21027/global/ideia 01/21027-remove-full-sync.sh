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
    # lista devices configurados
    devs=$(curl -s -H "X-API-Key: $API" "$FOLDERS_URL/$folder" \
             | $BB awk -F '"' '/"deviceID":/ {print $4}')
    # filtra remotes (exclui este TVBox)
    remotes=""
    for d in $devs; do
      [ "$d" = "$SyncID" ] && continue
      remotes="$remotes $d"
    done
    [ -z "$remotes" ] && continue

    # pega tipo da pasta
    type=$(curl -s -H "X-API-Key: $API" "$FOLDERS_URL/$folder" \
             | $BB awk -F '"' '/"type":/ {print $4}')

    # checa sync com todos os remotes
    all_ready=1
    for remote in $remotes; do
      st=$(curl -s -H "X-API-Key: $API" \
           "$APIURL/db/status?folder=$folder&device=$remote")
      # extrai estado e contadores
      state=$(echo "$st" | $BB awk -F '"' '/"state":/ {print $4}')
      needBytes=$(echo "$st" | $BB awk -F ': ' '/needBytes/              {gsub(/,/,"");print $2}')
      needDeletes=$(echo "$st" | $BB awk -F ': ' '/needDeletes/            {gsub(/,/,"");print $2}')
      recvFiles=$(echo "$st"   | $BB awk -F ': ' '/receiveOnlyChangedFiles/ {gsub(/,/,"");print $2}')
      recvBytes=$(echo "$st"   | $BB awk -F ': ' '/receiveOnlyChangedBytes/ {gsub(/,/,"");print $2}')

      if [ "$type" = "sendonly" ]; then
        if [ "$needBytes" -ne 0 ] || [ "$needDeletes" -ne 0 ] || [ "$state" != "idle" ]; then
          all_ready=0; break
        fi
      elif [ "$type" = "receiveonly" ]; then
        if [ "$recvFiles" -ne 0 ] || [ "$recvBytes" -ne 0 ] || [ "$state" != "idle" ]; then
          all_ready=0; break
        fi
      else
        all_ready=0; break
      fi
    done

    if [ "$all_ready" -eq 1 ]; then
      echo "→ REMOVENDO pasta $folder"
      curl -s -X DELETE -H "X-API-Key: $API" "$FOLDERS_URL/$folder"
      $BB sleep 3
      # aqui estava o problema removia um device que estava compartilhando arquivos no momento
    fi
  done

# # 2) remove devices órfãos após 10min conectados
# # aqui tem o problema que remove um device que estava sincronizando em uso
# curl -s -H "X-API-Key: $API" "$DEVICES_URL" \
#   | $BB awk -F '"' '/"deviceID":/ {print $4}' \
#   | while read -r dev; do
#     [ "$dev" = "$SyncID" ] && continue
#     case " $cleaned " in *" $dev "*) continue;; esac
#     if ! curl -s -H "X-API-Key: $API" "$FOLDERS_URL" \
#          | $BB grep -q "\"deviceID\":\"$dev\""; then
#     started=$(curl -s -H "X-API-Key: $API" "$CONN_URL" \
#       | $BB sed -n "/\"$dev\": {/,/^ *}/{/startedAt/p;}" \
#       | $BB head -n1 \
#       | $BB sed -E 's/.*"startedAt": *"([^"]+)".*/\1/')
#       ts=$(date -d "$started" +%s 2>/dev/null||echo 0)
#       now=$(date +%s)
#       if [ $((now - ts)) -gt 600 ]; then
#         echo "→ REMOVENDO device $dev (conectado há $((now-ts))s)"
#         curl -s -X DELETE -H "X-API-Key: $API" "$DEVICES_URL/$dev"
#         $BB sleep 3
#       fi
#     fi
#   done

# 2) remove devices órfãos só se sem tráfego e idle >10min
curl -s -H "X-API-Key: $API" "$DEVICES_URL" \
  | $BB awk -F'"' '/"deviceID":/ {print $4}' \
  | while read -r dev; do
    [ "$dev" = "$SyncID" ] && continue

    # se ainda referenciado por alguma pasta, pula
    if curl -s -H "X-API-Key: $API" "$FOLDERS_URL" \
         | $BB grep -q "\"deviceID\":\"$dev\""; then
      continue
    fi

    # pega dados de conexão
    conn=$(curl -s -H "X-API-Key: $API" "$CONN_URL")
    block=$(echo "$conn" | $BB sed -n "/\"$dev\": {/,/}/p")

    # extrai taxas de entrada/saída
    inRate=$(echo "$block" | $BB awk -F': ' '/currentInRate/  {gsub(/,/,\"\");print $2}')
    outRate=$(echo "$block" | $BB awk -F': ' '/currentOutRate/ {gsub(/,/,\"\");print $2}')

    # se estiver trafegando, pula
    if [ "$inRate" -ne 0 ] || [ "$outRate" -ne 0 ]; then
      echo "↳ device $dev ativo (in=$inRate B/s out=$outRate B/s), pulando"
      continue
    fi

    # verifica tempo conectado
    started=$(echo "$block" | $BB awk -F'"' '/startedAt/ {print $4}')
    ts=$(date -d "$started" +%s 2>/dev/null||echo 0)
    now=$(date +%s)
    if [ $((now - ts)) -gt 600 ]; then
      echo "→ REMOVENDO device órfão $dev (idle >10m)"
      curl -s -X DELETE -H "X-API-Key: $API" "$DEVICES_URL/$dev"
      $BB sleep 3
    else
      echo "↳ device $dev conectado há $((now-ts))s, ainda ñ remove"
    fi
  done


# read bah