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
FullAccessFile="$TMP_DIR/init.21027.fullAccess"


mkdir -p "/data/trueDT/peer/data/SyncOK/.stfolder"
mkdir -p "/data/trueDT/peer/data/server/.stfolder"

SyncthingServersMirrors='
Z5ITMCU-XQD2YN4-3AWJ6IU-GHQ3CBH-LUUJSB7-EVIYGYK-KCBIRZZ-NS2KNA7;datacenter;free-mirror.1
XMGJDYA-5YEALCS-57T3BV5-R2TUX7L-GUZX3EK-T3VNZNC-OVJ2F6A-YLQDOAL;datacenter;free-mirror.2
GY2SB4F-3VBKXVP-CKIBMMS-7CZGZEZ-5IQUGBD-SIFHGWP-FHDVQAG-6F45YAA;datacenter;free-mirror.3
FV44NCY-BJLGYVF-MGMXJVT-VGQRWUC-PC557GO-U7VSXM4-4DIEJBZ-V44XOAX;datacenter;free-mirror.4
APH5XO4-ZTCRBIM-HONXXAG-7GWUSOL-DJE54OQ-OG4QOEZ-IZJC3UB-RVVFDAF;datacenter;free-mirror.5
'


DevURL="http://127.0.0.1:8384/rest/config/folders"



date > "/data/trueDT/peer/data/SyncOK/Z_post-Update.log"




if ! $BB grep -q "id=\"$DeviceName-SyncOK\"" "$CfgXML"; then
  echo "ADM DEBUG ### Importando profile sendonly Client ($DeviceName-SyncOK)"

# monta entries sem vírgula final
DeviceEntries=$(
  echo "$SyncthingServersMirrors" | $BB sed '/^\s*$/d' | while IFS=';' read -r id cat name; do
    printf '    {"deviceID":"%s","introducedBy":"","encryptionPassword":""},\n' "$id"
  done | $BB sed '$s/,$//'
)

# envia JSON direto ao curl, sem arquivo temporário
curl -X POST -H "X-API-Key: $API" -H "Content-Type: application/json" "$DevURL" -d @- <<EOF
{
  "id": "$DeviceName-SyncOK",
  "label": "$DeviceName-SyncOK",
  "filesystemType": "basic",
  "path": "/data/trueDT/peer/data/SyncOK",
  "type": "sendonly",
  "devices": [
$DeviceEntries
  ],
  "rescanIntervalS": 3600,
  "fsWatcherEnabled": true,
  "fsWatcherDelayS": 10,
  "ignorePerms": false,
  "autoNormalize": true,
  "minDiskFree": { "value": 0, "unit": "" },
  "versioning": { "type": "", "params": {}, "cleanupIntervalS": 0, "fsPath": "", "fsType": "basic" },
  "copiers": 1,
  "pullerMaxPendingKiB": 0,
  "hashers": 0,
  "order": "random",
  "ignoreDelete": false,
  "scanProgressIntervalS": 0,
  "pullerPauseS": 0,
  "maxConflicts": 0,
  "disableSparseFiles": false,
  "disableTempIndexes": false,
  "paused": false,
  "weakHashThresholdPct": 25,
  "markerName": ".stfolder",
  "copyOwnershipFromParent": false,
  "modTimeWindowS": 0,
  "maxConcurrentWrites": 2,
  "disableFsync": false,
  "blockPullOrder": "standard",
  "copyRangeMethod": "standard",
  "caseSensitiveFS": false,
  "junctionsAsDirs": false
}
EOF
fi

read bah


