#!/system/bin/sh
# extraindo a config
path=$( cd "${0%/*}" && pwd -P )
ServerConfigPath="/data/trueDT/peer/config/config.xml"
API=$(cat "$ServerConfigPath" | grep "<apikey>" | cut -d ">" -f 2 | cut -d "<" -f 1)
WebPort=$(cat "$ServerConfigPath" | grep "127.0.0.1" | cut -d ":" -f 2 | cut -d "<" -f 1)
User=$(cat "$ServerConfigPath" | grep "<user>" | cut -d ">" -f 2 | cut -d "<" -f 1)


Placa=$(getprop ro.product.board)
CpuSerial=`busybox cat /proc/cpuinfo | busybox grep Serial | busybox awk '{ print $3 }'`
MacLanReal=`/system/bin/busybox cat /data/macLan.hardware | busybox sed 's;:;;g'`
DeviceName="$Placa=$CpuSerial=$MacLanReal"


SyncID=`cat /data/trueDT/peer/Sync/serial.live`

ClientList="\
♥ Raid Servers
4W74FHY-6B2IOVI-RTE2BDJ-67C4I6V-6O7LADH-2TIOHZX-N7HRKTN-F7UK2A3;datacenter;Master Server 4W74FHY

♥ end Loop\
"



echo "$ClientList" | /system/bin/busybox sed 's/\s*♥.*$//' | /system/bin/busybox sed '/^\s*$/d' | while read line; do 
  DeviceID=`echo $line | cut -d ";" -f 1`
  Category=`echo $line | cut -d ";" -f 2`
  UserName=`echo $line | cut -d ";" -f 3`
  echo "$DeviceID > $Category > $UserName"

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### Adicionando novo usuário > $DeviceID | $unit"
curl -u "$User":"$User" -X POST -H "X-API-Key: $API" "http://127.0.0.1:$WebPort/rest/config/devices" \
-H 'Content-Type: application/json' \
-d "{\"deviceID\":\"$DeviceID\",\"name\":\"$Category $UserName\",\"autoAcceptFolders\":false,\"paused\":false}"


done

mkdir -p "/data/trueDT/peer/Sync/.stfolder"
# os profiles dos dois lados são sendreceive
# ao ser add o profile é feito um MERGE entre os dois pares
# arquivos que forem apagados no tvbox e estiverem no server vão ser repetidos
/system/bin/busybox find "/data/trueDT/peer/Sync/" -type f -name "*-conflict-*" -delete


cat << EOF > "/data/local/tmp/Simport.json"
{
  "id": "log_$DeviceName",
  "label": "Master Server 001 [ LOG ]",
  "filesystemType": "basic",
  "path": "/data/trueDT/peer/Sync",
  "type": "sendonly",
  "devices": [
EOF

# em tvbox por conta do script de limpeza e shc o sed funciona diferente aqui
echo "$ClientList" | sed 's/\s*♥.*$//' | sed '/^\s*$/d' | while read line; do 
DeviceID=`echo $line | cut -d ";" -f 1`
cat << EOF >> "/data/local/tmp/Simport.json"
    {
      "deviceID": "$DeviceID",
      "introducedBy": "",
      "encryptionPassword": ""
    },
EOF
done
# remove da ultima linha a virgula
#sed -ie '$s/    },/    }/' "/data/local/tmp/Simport.json"
#sed -i '$s/    },/    }/' "/data/local/tmp/Simport.json"
# em tvbox tem q remover o espaço
sed -i '$s/},/}/' "/data/local/tmp/Simport.json"

cat << EOF >> "/data/local/tmp/Simport.json"
  ],
  "rescanIntervalS": 3600,
  "fsWatcherEnabled": true,
  "fsWatcherDelayS": 10,
  "ignorePerms": false,
  "autoNormalize": true,
  "minDiskFree": {
    "value": 0,
    "unit": ""
  },
  "versioning": {
    "type": "",
    "params": {},
    "cleanupIntervalS": 0,
    "fsPath": "",
    "fsType": "basic"
  },
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

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### Importando o profile sendonly"
curl -u "$User":"$User" -X POST -H "X-API-Key: $API" "http://127.0.0.1:$WebPort/rest/config/folders" -d "@/data/local/tmp/Simport.json"
rm "/data/local/tmp/Simport.json"



echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### override sendonly profile"
curl -u "$User":"$User" -X POST -H "X-API-Key: $API" "http://127.0.0.1:$WebPort/rest/db/override?folder=log_$DeviceName"



