#!/system/bin/sh

# ID da pasta é o mesmo syncthing ID do tvbox client
# J66LYFR-ZQN4IGE-OPH2VB4-2WMXRUU-DCFIURD-HLOSP3K-MR4QRCN-PRBLJQU

# extraindo a config
path=$( cd "${0%/*}" && pwd -P )
API="30610-11492-1385-4082"
folderID="J66LYFR-ZQN4IGE-OPH2VB4-2WMXRUU-DCFIURD-HLOSP3K-MR4QRCN-PRBLJQU"
Json="$path/Trial data.json"


echo "List connections"
curl -X GET -H "X-API-Key: $API" http://127.0.0.1:4442/rest/system/connections


read bah
cd "$path"
x
exit
