#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )
ServerConfigPath="/data/trueDT/peer/config/config.xml"
API=$(cat "$ServerConfigPath" | grep "<apikey>" | cut -d ">" -f 2 | cut -d "<" -f 1)
WebPort=$(cat "$ServerConfigPath" | grep "127.0.0.1" | cut -d ":" -f 2 | cut -d "<" -f 1)
User=$(cat "$ServerConfigPath" | grep "<user>" | cut -d ">" -f 2 | cut -d "<" -f 1)

echo "
$ServerConfigPath
$API
$WebPort
$User
"


curl -u "$User":"$User" -X GET -H "X-API-Key: $API" http://127.0.0.1:$WebPort/rest/config/gui


curl -u "$User":"$User" -X GET -H "X-API-Key: $API" http://127.0.0.1:$WebPort/rest/config/options

echo "

$Pass"

