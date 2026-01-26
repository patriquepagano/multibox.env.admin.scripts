#!/system/bin/sh

# ID da pasta é o mesmo syncthing ID do tvbox client
# J66LYFR-ZQN4IGE-OPH2VB4-2WMXRUU-DCFIURD-HLOSP3K-MR4QRCN-PRBLJQU

# extraindo a config
path=$( cd "${0%/*}" && pwd -P )
API="30610-11492-1385-4082"
folderID="J66LYFR-ZQN4IGE-OPH2VB4-2WMXRUU-DCFIURD-HLOSP3K-MR4QRCN-PRBLJQU"
MasterServer001="MGADARQ-5FB6F6H-VZDHT74-2T7D76S-PI2W5JH-JZ2JWS4-MUTDKEK-MBNS6QE"
Json="$path/Trial data.json"


echo "da start no syncthing"

echo "a box remove o server"
DevicesPairing="\
MGADARQ-5FB6F6H-VZDHT74-2T7D76S-PI2W5JH-JZ2JWS4-MUTDKEK-MBNS6QE;MasterServer001\
"
echo "$DevicesPairing" | while read line; do
    DeviceID=`echo $line | cut -d ";" -f 1`
    DeviceN=`echo $line | cut -d ";" -f 2`
    echo "******* deletado o server > $DeviceN"
curl -X DELETE -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/config/devices/$DeviceID"
done

echo "deletado a pasta do device"
curl -X DELETE -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/config/folders/$folderID"
################################################################################################################



################################################################################################################



echo "a box resume a conexão com o servidor"
DevicesPairing="\
MGADARQ-5FB6F6H-VZDHT74-2T7D76S-PI2W5JH-JZ2JWS4-MUTDKEK-MBNS6QE;MasterServer001\
"
echo "$DevicesPairing" | while read line; do
    DeviceID=`echo $line | cut -d ";" -f 1`
    DeviceN=`echo $line | cut -d ";" -f 2`
    echo "******* Adicionando novo usuário > $DeviceID"
    curl -X POST -H "X-API-Key: $API" http://127.0.0.1:4442/rest/config/devices \
        -H 'Content-Type: application/json' \
        -d "{\"deviceID\":\"$DeviceID\",\"name\":\"$DeviceN $DeviceID\",\"autoAcceptFolders\":false,\"paused\":false}"
done

echo "Adicionado a pasta do device
obs. na ficha do Json foi customizado para conter apenas os servers.
A propria ID o sistema se encarrega de botar"
curl -X POST -H "X-API-Key: $API" http://127.0.0.1:4442/rest/config/folders -d "@$Json"


echo "a box cliente pausa o server"
curl -X POST -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/system/pause?device=$MasterServer001"
################################################################################################################

echo "no final ao gerar todos os logs solicita um scan na pasta"
for i in $(seq 1 5); do
echo "$(date)" > "/data/trueDT/peer/Sync/sh.uniq/zipTMP/$(date)"
echo "wait to create all file junk"
done

echo "no final ao gerar todos os logs solicita um scan na pasta"
curl -X POST -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/db/scan?folder=$folderID"

# utilizar um marcador de db/completion?folder não funciona desiste da ideia
cat << EOF > /data/trueDT/peer/Sync/cfg.uniq/FileUpdateChanges.txt
$(date)
EOF

################################################################################################################



echo "a box resume a conexão com o servidor"
curl -X POST -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/system/resume?device=$MasterServer001"
################################################################################################################








################################################################################################################
# requestsync data from master server

DevicesPairing="\
MGADARQ-5FB6F6H-VZDHT74-2T7D76S-PI2W5JH-JZ2JWS4-MUTDKEK-MBNS6QE;MasterServer001\
"
echo "$DevicesPairing" | while read line; do
    DeviceID=`echo $line | cut -d ";" -f 1`
    DeviceN=`echo $line | cut -d ";" -f 2`
    
    # /rest/db/completion?device=I6KAH76-...-3PSROAU
    for i in $(seq 1 2000); do
        data=`curl -X GET -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/db/completion?device=$DeviceID"` > /dev/null 2>&1
        completion=`echo "$data" | grep "completion" | cut -d "," -f 1 | cut -d " " -f 4`
        globalBytes=`echo "$data" | grep "globalBytes" | cut -d "," -f 1 | cut -d " " -f 4`
        globalItems=`echo "$data" | grep "globalItems" | cut -d "," -f 1 | cut -d " " -f 4`
        echo "******* status da sincronização > $DeviceN"
        echo "completion  = $completion"
        echo "globalBytes = $globalBytes"
        echo "globalItems = $globalItems"        
        echo ""
        echo ""
        echo "$data"

        if [ "$completion" == "100" ]; then
            echo "sincronizado com sucesso o servidor"
echo "a box remove o server"
DevicesPairing="\
MGADARQ-5FB6F6H-VZDHT74-2T7D76S-PI2W5JH-JZ2JWS4-MUTDKEK-MBNS6QE;MasterServer001\
"
echo "$DevicesPairing" | while read line; do
    DeviceID=`echo $line | cut -d ";" -f 1`
    DeviceN=`echo $line | cut -d ";" -f 2`
    echo "******* deletado o server > $DeviceN"
curl -X DELETE -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/config/devices/$DeviceID"
done

echo "deletado a pasta do device"
curl -X DELETE -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/config/folders/$folderID"
            exit
        fi

        sleep 1
        clear
    done
done
################################################################################################################



read bah
cd "$path"
x
exit











