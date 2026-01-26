#!/system/bin/sh

# ID da pasta é o mesmo syncthing ID do tvbox client
# J66LYFR-ZQN4IGE-OPH2VB4-2WMXRUU-DCFIURD-HLOSP3K-MR4QRCN-PRBLJQU

# extraindo a config
path=$( cd "${0%/*}" && pwd -P )
API="30610-11492-1385-4082"
Json="$path/import json debug test.json"


# echo "List connections"
# curl -X GET -H "X-API-Key: $API" http://127.0.0.1:4442/rest/system/connections

DeviceID="WQ5F4PG-BIX5SI7-UJIQG2X-YX5PMSD-4GUQB7U-SXV57DJ-JAB76M7-B6LXGQZ"

echo "******* Adicionando novo usuário > $DeviceID | $unit"
curl -X POST -H "X-API-Key: $API" http://127.0.0.1:4442/rest/config/devices \
-H 'Content-Type: application/json' \
-d "{\"deviceID\":\"$DeviceID\",\"name\":\"Client876asd5a78 $DeviceID\",\"autoAcceptFolders\":true,\"paused\":false}"




echo "Adicionado a pasta do device
obs. na ficha do Json foi customizado para conter apenas os servers.
A propria ID o sistema se encarrega de botar"

mkdir -p "/storage/emulated/0/Download/A.Trial.test"

curl -X POST -H "X-API-Key: $API" http://127.0.0.1:4442/rest/config/folders -d "@$Json"





read bah
cd "$path"
x
exit



