#!/system/bin/sh

# ID da pasta é o mesmo syncthing ID do tvbox client
# J66LYFR-ZQN4IGE-OPH2VB4-2WMXRUU-DCFIURD-HLOSP3K-MR4QRCN-PRBLJQU

# extraindo a config
path=$( cd "${0%/*}" && pwd -P )
API="30610-11492-1385-4082"
folderID="J66LYFR-ZQN4IGE-OPH2VB4-2WMXRUU-DCFIURD-HLOSP3K-MR4QRCN-PRBLJQU"


for i in $(seq 1 2000); do
    curl -X GET -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/db/status?folder=$folderID"
    sleep 1
    clear
done


read bah
cd "$path"
x
exit

# GET /rest/db/status
# Returns information about the current status of a folder.
# Parameters: folder, the ID of a folder.

1) todos os devices precisam estar na mesma versão do syncthing
2) cruzamento de informações iguais em ambos os lados: globalBytes
3) se tentar usar o globalBytes como um marcadorse gravar na pasta compartilhada vai altera-lo criando um paradoxo sem fim







