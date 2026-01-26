#!/system/bin/sh

# ID da pasta é o mesmo syncthing ID do tvbox client
# J66LYFR-ZQN4IGE-OPH2VB4-2WMXRUU-DCFIURD-HLOSP3K-MR4QRCN-PRBLJQU

# extraindo a config
path=$( cd "${0%/*}" && pwd -P )
API="30610-11492-1385-4082"
folderID="J66LYFR-ZQN4IGE-OPH2VB4-2WMXRUU-DCFIURD-HLOSP3K-MR4QRCN-PRBLJQU"
RemoteServer="MGADARQ-5FB6F6H-VZDHT74-2T7D76S-PI2W5JH-JZ2JWS4-MUTDKEK-MBNS6QE"


# 4Android
folderID="5hctg-zr6yw"
# PCDEV
RemoteServer="U5LZ5OD-RG6GIMP-KQESAXN-GOT5Y4F-4UFTZR7-HTW4UAB-7TKJACU-NOO6CQQ"



for i in $(seq 1 2000); do
    curl -X GET -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/db/remoteneed?folder=$folderID?device=$RemoteServer"
    sleep 1
    clear
done


read bah
cd "$path"
x
exit




GET /rest/db/remoteneed

New in version 0.14.43.

Takes the mandatory parameters folder and device, 
and returns the list of files which are needed by that 
remote device in order for it to become in sync with the shared folder.


# não deu
    curl -X GET -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/db/remoteneed" \
        -H 'Content-Type: application/json' \
        -d "{\"folder\":\"$folderID\",\"device\":\"$DeviceID\"}"

    curl -X POST -H "X-API-Key: $API" http://127.0.0.1:4442/rest/config/devices \
        -H 'Content-Type: application/json' \
        -d "{\"deviceID\":\"$DeviceID\",\"name\":\"$DeviceN $DeviceID\",\"autoAcceptFolders\":false,\"paused\":false}"
