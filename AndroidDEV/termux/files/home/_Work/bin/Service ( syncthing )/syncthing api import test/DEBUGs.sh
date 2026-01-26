#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )
ServerConfigPath="/data/trueDT/peer/config/config.xml"
API=$(cat "$ServerConfigPath" | grep "<apikey>" | cut -d ">" -f 2 | cut -d "<" -f 1)
WebPort=$(cat "$ServerConfigPath" | grep "127.0.0.1" | cut -d ":" -f 2 | cut -d "<" -f 1)
User=$(cat "$ServerConfigPath" | grep "<user>" | cut -d ">" -f 2 | cut -d "<" -f 1)





SyncID=`cat /data/trueDT/peer/Sync/serial.live`


echo "
$ServerConfigPath
$API
$WebPort
$User
"



echo "

$Pass"
read bah
exit




echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### setup config do device name e desativar auto folders"
UserName=`cat /data/trueDT/peer/Sync/data/email`
if [ "$UserName" == "" ]; then
    UserName="$SyncID"
fi
curl -u "$User":"$User" -X POST -H "X-API-Key: $API" http://127.0.0.1:$WebPort/rest/config/devices \
-H 'Content-Type: application/json' \
-d "{\"deviceID\":\"$SyncID\",\"name\":\"$UserName\",\"autoAcceptFolders\":false,\"paused\":false}"


#



echo "

$Pass"




