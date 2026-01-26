#!/system/bin/sh

# ID da pasta é o mesmo syncthing ID do tvbox client
# J66LYFR-ZQN4IGE-OPH2VB4-2WMXRUU-DCFIURD-HLOSP3K-MR4QRCN-PRBLJQU

# extraindo a config
path=$( cd "${0%/*}" && pwd -P )
API="30610-11492-1385-4082"
TVBOXID="J66LYFR-ZQN4IGE-OPH2VB4-2WMXRUU-DCFIURD-HLOSP3K-MR4QRCN-PRBLJQU"
MasterServer001="MGADARQ-5FB6F6H-VZDHT74-2T7D76S-PI2W5JH-JZ2JWS4-MUTDKEK-MBNS6QE"


for i in $(seq 1 2000); do

# echo "TVBOXID = rodando este comando em local, vai mostrar o nivel  
# da sincronia com todos os devices e suas pastas em comum"
# curl -X GET -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/db/completion?device=$TVBOXID"

echo "MasterServer001"
curl -X GET -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/db/completion?device=$MasterServer001"

echo "resultado do folder share em comum"
folderID="J66LYFR-ZQN4IGE-OPH2VB4-2WMXRUU-DCFIURD-HLOSP3K-MR4QRCN-PRBLJQU"
curl -X GET -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/db/completion?folder=$folderID"

sleep 1
clear
done

read bah
cd "$path"
x
exit
