#!/system/bin/sh

# ID da pasta é o mesmo syncthing ID do tvbox client
# J66LYFR-ZQN4IGE-OPH2VB4-2WMXRUU-DCFIURD-HLOSP3K-MR4QRCN-PRBLJQU

# extraindo a config
path=$( cd "${0%/*}" && pwd -P )
API="30610-11492-1385-4082"
folderID="J66LYFR-ZQN4IGE-OPH2VB4-2WMXRUU-DCFIURD-HLOSP3K-MR4QRCN-PRBLJQU"

# funciona mas acho que esta falando globalmente
#curl -X GET -H "X-API-Key: $API" http://127.0.0.1:4442/rest/db/completion


# informa status da pasta que esta RECEBENDO AS NOVIDADES
# https://docs.syncthing.net/rest/db-completion-get.html
for i in $(seq 1 2000); do
    curl -X GET -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/db/completion?folder=$folderID"
    sleep 1
    clear
done


read bah
cd "$path"
x
exit
