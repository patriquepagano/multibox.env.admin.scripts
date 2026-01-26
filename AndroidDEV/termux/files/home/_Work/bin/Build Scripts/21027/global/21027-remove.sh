#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear
TMP_DIR="/data/trueDT/peer/TMP"

BB=/system/bin/busybox


SyncID=$(< "$TMP_DIR/init.21027.ID")
CfgXML="/data/trueDT/peer/config/config.xml"
API=$($BB awk -F '[><]' '/<apikey>/ {print $3}' "$CfgXML")

SyncthingServersMirrors='
Z5ITMCU-XQD2YN4-3AWJ6IU-GHQ3CBH-LUUJSB7-EVIYGYK-KCBIRZZ-NS2KNA7;datacenter;free-mirror.1
XMGJDYA-5YEALCS-57T3BV5-R2TUX7L-GUZX3EK-T3VNZNC-OVJ2F6A-YLQDOAL;datacenter;free-mirror.2
GY2SB4F-3VBKXVP-CKIBMMS-7CZGZEZ-5IQUGBD-SIFHGWP-FHDVQAG-6F45YAA;datacenter;free-mirror.3
FV44NCY-BJLGYVF-MGMXJVT-VGQRWUC-PC557GO-U7VSXM4-4DIEJBZ-V44XOAX;datacenter;free-mirror.4
APH5XO4-ZTCRBIM-HONXXAG-7GWUSOL-DJE54OQ-OG4QOEZ-IZJC3UB-RVVFDAF;datacenter;free-mirror.5
'

DevURL="http://127.0.0.1:8384/rest/config/folders"
Headers='Content-Type: application/json'

# pega todos os folder IDs configurados localmente
Folders=$(curl -s -H "X-API-Key: $API" "$DevURL" | $BB awk -F'"' '/"id":/ { print $4 }')
for folder in $Folders; do
  # remove se o ID contiver TVBox-*-Client ou TVBox-*-Server
  if echo "$folder" | $BB grep -Eq '^TVBox-.*-(Client|Server|SyncOK)$'; then
    echo "REMOVENDO compartilhamento: $folder"
    curl -s -X DELETE -H "X-API-Key: $API" "$DevURL/$folder"
  fi
done

IDs=$(echo "$SyncthingServersMirrors" | $BB awk -F';' '{print $1}')
DeviceURL="http://127.0.0.1:8384/rest/config/devices"
# para cada device do SyncthingServersMirrors
for id in $IDs; do
  [ "$id" = "$SyncID" ] && continue
  echo "REMOVENDO device $id"
  curl -s -X DELETE -H "X-API-Key: $API" "$DeviceURL/$id"
done





