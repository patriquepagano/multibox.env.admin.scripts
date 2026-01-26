#!/system/bin/sh
# extraindo a config
path=$( cd "${0%/*}" && pwd -P )
ServerConfigPath="/data/trueDT/peer/config/config.xml"
API=$(cat "$ServerConfigPath" | grep "<apikey>" | cut -d ">" -f 2 | cut -d "<" -f 1)
WebPort=$(cat "$ServerConfigPath" | grep "127.0.0.1" | cut -d ":" -f 2 | cut -d "<" -f 1)
User=$(cat "$ServerConfigPath" | grep "<user>" | cut -d ">" -f 2 | cut -d "<" -f 1)

ClientList="\
# DEVTEAM
QGGZTXD-L2DTVNF-N3TISZA-O5Z4CO2-ZSR3BXD-7SJEQLU-VN4VYDV-NRTZBQ2;A dev team;LenovoS145
U5LZ5OD-RG6GIMP-KQESAXN-GOT5Y4F-4UFTZR7-HTW4UAB-7TKJACU-NOO6CQQ;A dev team;PCDEV

# end Loop\
"

# mkdir -p "$FolderLOG/Analize home users [rw access]"
# find "$FolderLOG/Analize home users [rw access]/" -type f -name '*.code-workspace' -delete

clear
echo "$ClientList" | sed 's/\s*#.*$//' | sed '/^\s*$/d' | while read line; do 
  DeviceID=`echo $line | cut -d ";" -f 1`
  Category=`echo $line | cut -d ";" -f 2`
  UserName=`echo $line | cut -d ";" -f 3`
  echo "$DeviceID > $Category > $UserName"

echo "******* Adicionando novo usuário > $DeviceID | $unit"
curl -u "$User":"$User" -X POST -H "X-API-Key: $API" http://127.0.0.1:$WebPort/rest/config/devices \
-H 'Content-Type: application/json' \
-d "{\"deviceID\":\"$DeviceID\",\"name\":\"$Category $UserName\",\"autoAcceptFolders\":false,\"paused\":false}"

done


mkdir -p "/storage/DevMount/4Android/.stfolder"

cat << EOF > "/data/local/tmp/Simport.json"
{
  "id": "5hctg-zr6yw",
  "label": "4Android",
  "filesystemType": "basic",
  "path": "/storage/DevMount/4Android",
  "type": "sendreceive",
  "devices": [
EOF

echo "$ClientList" | sed 's/\s*#.*$//' | sed '/^\s*$/d' | while read line; do 
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
sed -ie '$s/    },/    }/' "/data/local/tmp/Simport.json"

cat << EOF >> "/data/local/tmp/Simport.json"
  ],
  "rescanIntervalS": 3600,
  "fsWatcherEnabled": true,
  "fsWatcherDelayS": 10,
  "ignorePerms": false,
  "autoNormalize": true,
  "minDiskFree": {
    "value": 1,
    "unit": "%"
  },
  "versioning": {
    "type": "",
    "params": {},
    "cleanupIntervalS": 0,
    "fsPath": "",
    "fsType": "basic"
  },
  "copiers": 0,
  "pullerMaxPendingKiB": 0,
  "hashers": 0,
  "order": "random",
  "ignoreDelete": false,
  "scanProgressIntervalS": 0,
  "pullerPauseS": 0,
  "maxConflicts": 10,
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

curl -u "$User":"$User" -X POST -H "X-API-Key: $API" http://127.0.0.1:$WebPort/rest/config/folders -d "@/data/local/tmp/Simport.json"
rm "/data/local/tmp/Simport.json"


read bah
cd "$path"
x
exit



