#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear
TMP_DIR="/data/trueDT/peer/TMP"

BB=/system/bin/busybox


SyncID=$(< "$TMP_DIR/init.21027.ID")
CfgXML="/data/trueDT/peer/config/config.xml"
APIKEY=$($BB awk -F '[><]' '/<apikey>/ {print $3}' "$CfgXML")

APIURL="http://127.0.0.1:8384/rest"
FOLDERS_URL="$APIURL/config/folders"
DEVICES_URL="$APIURL/config/devices"
CONN_URL="$APIURL/system/connections"
cleaned=""

# pasta de log
LOG="$path/lastseen.log"



SyncthingServersMirrors='
Z5ITMCU-XQD2YN4-3AWJ6IU-GHQ3CBH-LUUJSB7-EVIYGYK-KCBIRZZ-NS2KNA7;datacenter;free-mirror.1
XMGJDYA-5YEALCS-57T3BV5-R2TUX7L-GUZX3EK-T3VNZNC-OVJ2F6A-YLQDOAL;datacenter;free-mirror.2
GY2SB4F-3VBKXVP-CKIBMMS-7CZGZEZ-5IQUGBD-SIFHGWP-FHDVQAG-6F45YAA;datacenter;free-mirror.3
FV44NCY-BJLGYVF-MGMXJVT-VGQRWUC-PC557GO-U7VSXM4-4DIEJBZ-V44XOAX;datacenter;free-mirror.4
APH5XO4-ZTCRBIM-HONXXAG-7GWUSOL-DJE54OQ-OG4QOEZ-IZJC3UB-RVVFDAF;datacenter;free-mirror.5
'

# no tvbox utilizando busybox faz um loop nesta lista de mirrors do syncthing
# para verificar o status do lastseen de cada um


# no topo do seu script, já tendo definido:
# BB, APIURL, APIKEY, LOG, SyncthingServersMirrors

echo "=== $(date) – checando lastSeen dos mirrors ===" > "$LOG"


curl -s -H "X-API-Key:$APIKEY" "$APIURL/stats/device" >> "$LOG"



# itera cada linha “DeviceID;location;mirrorName”
echo "$SyncthingServersMirrors" \
| while IFS=';' read -r deviceID location mirror; do

  # pega o JSON de stats e extrai o lastSeen daquele device
  lastSeen=$(curl -s -H "X-API-Key:$APIKEY" \
    "$APIURL/stats/device" \
    | $BB grep -A2 "\"$deviceID\"" \
    | $BB grep '"lastSeen"' \
    | $BB awk -F'"' '{print $4}')


  # converte pra epoch
  lastTs=$(date -d "$lastSeen" +%s 2>/dev/null || echo 0)
  now=$(date +%s)
  offline=$((now - lastTs))

  echo "$(date +'%F %T') → Mirror $mirror ($deviceID) off há ${offline}s" >> "$LOG"

  # se passou de 10 minutos (600s), toma ação
  if [ "$offline" -gt 600 ]; then
    echo "→ Mirror $mirror desconectado há mais de 10 minutos" >> "$LOG"
    # aqui você pode, por exemplo:
    #  curl -s -X DELETE -H "X-API-Key:$APIKEY" "$DEVICES_URL/$deviceID"
  fi
done







