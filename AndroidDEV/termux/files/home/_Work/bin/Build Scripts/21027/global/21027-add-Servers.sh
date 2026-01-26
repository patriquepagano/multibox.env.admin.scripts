#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear
BB=/system/bin/busybox
TMP_DIR="/data/trueDT/peer/TMP"
ClientHardware="/data/trueDT/peer/data/client/ClientHardware"
Placa=$(< "$ClientHardware/MB")
CpuSerial=$(< "$ClientHardware/CPU")
MacLanReal=$(< "$ClientHardware/macLan")
DeviceName=$(< "$ClientHardware/UniqID")


SyncID=$(< "$TMP_DIR/init.21027.ID")
CfgXML="/data/trueDT/peer/config/config.xml"
API=$($BB awk -F '[><]' '/<apikey>/ {print $3}' "$CfgXML")
Headers="Content-Type: application/json"

mkdir -p "/data/trueDT/peer/data/client/.stfolder"
mkdir -p "/data/trueDT/peer/data/server/.stfolder"

SyncthingServersMirrors='
Z5ITMCU-XQD2YN4-3AWJ6IU-GHQ3CBH-LUUJSB7-EVIYGYK-KCBIRZZ-NS2KNA7;datacenter;free-mirror.1
XMGJDYA-5YEALCS-57T3BV5-R2TUX7L-GUZX3EK-T3VNZNC-OVJ2F6A-YLQDOAL;datacenter;free-mirror.2
GY2SB4F-3VBKXVP-CKIBMMS-7CZGZEZ-5IQUGBD-SIFHGWP-FHDVQAG-6F45YAA;datacenter;free-mirror.3
FV44NCY-BJLGYVF-MGMXJVT-VGQRWUC-PC557GO-U7VSXM4-4DIEJBZ-V44XOAX;datacenter;free-mirror.4
APH5XO4-ZTCRBIM-HONXXAG-7GWUSOL-DJE54OQ-OG4QOEZ-IZJC3UB-RVVFDAF;datacenter;free-mirror.5
'
DevURL="http://127.0.0.1:8384/rest/config/devices"
Headers='Content-Type: application/json'

while IFS=';' read -r DeviceID Category UserName; do
  [ -z "$DeviceID" ] && continue
  if ! $BB grep -q "$DeviceID" "$CfgXML"; then
    echo "ADM DEBUG ### Adicionando device: $DeviceID"
    Data="{\"deviceID\":\"$DeviceID\",\"name\":\"$Category $UserName\",\"autoAcceptFolders\":false,\"paused\":false}"
    curl -s -X POST -H "X-API-Key: $API" -H "$Headers" "$DevURL" -d "$Data"
  else
    echo "ADM DEBUG ### server já existe: $DeviceID"
  fi
done <<< "$SyncthingServersMirrors"

read bah

