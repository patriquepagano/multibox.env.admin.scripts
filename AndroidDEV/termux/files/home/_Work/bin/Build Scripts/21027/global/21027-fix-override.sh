#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear


BB=/system/bin/busybox
LogFolder="/data/trueDT/peer/data/client/LOG/services"
Log="$LogFolder/init.update.boot.LOG"

getHDateNow () {
$BB date +"%d/%m/%Y %H:%M:%S"
}


CfgXML="/data/trueDT/peer/config/config.xml"
API=$($BB awk -F '[><]' '/<apikey>/ {print $3}' "$CfgXML")

APIURL="http://127.0.0.1:8384/rest"
BaseURL="http://127.0.0.1:8384"
Headers="Content-Type: application/json"

# pega todos os folder IDs
Folders=$(curl -s -H "X-API-Key: $API" "$BaseURL/rest/config/folders" \
  | $BB awk -F'"' '/"id":/ { print $4 }')

for folder in $Folders; do
  # busca config da pasta
  FolderInfo=$(curl -s -H "X-API-Key: $API" \
    "$BaseURL/rest/config/folders/$folder")
  Label=$(echo "$FolderInfo" | $BB awk -F'"' '/"label":/ { print $4 }')
  Type=$(echo "$FolderInfo" | $BB awk -F'"' '/"type":/ { print $4 }')
  StatusURL="$BaseURL/rest/db/status?folder=$folder"
  StatusJSON=$(curl -s -H "X-API-Key:$API" "$StatusURL")

echo "$folder"




  # filtro para sendonly (TVBox-*-Client)
  if echo "$Label" | $BB grep -Eq '^TVBox-.*-Client$' && [ "$Type" = "sendonly" ]; then
    sendFiles=$($BB awk -F': ' '/needFiles/ {gsub(/,/, ""); print $2}' <<<"$StatusJSON")
    if [ "${sendFiles:-0}" -gt 0 ]; then
        echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
        echo "USER INFO @@@ $(getHDateNow) [service 21017] OVERRIDE sendonly: " >> "$Log"
        echo "USER INFO @@@ $folder ($sendFiles aguardando envio)" >> "$Log"
        curl -s -X POST -H "X-API-Key:$API" "$APIURL/system/rescan?folder=$folder"
        curl -s -X POST -H "X-API-Key:$API" "$BaseURL/rest/db/override?folder=$folder"
        
    fi
  fi

  # filtro para receiveonly (TVBox-*-Server)
  if echo "$Label" | $BB grep -Eq '^TVBox-.*-Server$' && [ "$Type" = "receiveonly" ]; then
    recvFiles=$($BB awk -F': ' '/receiveOnlyChangedFiles/ {gsub(/,/, ""); print $2}' <<<"$StatusJSON")
    if [ "${recvFiles:-0}" -gt 0 ]; then
        echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
        echo "USER INFO @@@ $(getHDateNow) [service 21017] REVERT receiveonly: " >> "$Log"
        echo "USER INFO @@@ $folder ($recvFiles alterações locais)" >> "$Log"
        curl -s -X POST -H "X-API-Key:$API" "$APIURL/system/rescan?folder=$folder"
        curl -s -X POST -H "X-API-Key:$API" "$BaseURL/rest/db/revert?folder=$folder"

    fi
  fi
done


read bah
