#!/system/bin/sh
# extraindo a config
path=$( cd "${0%/*}" && pwd -P )
ServerConfigPath="/data/trueDT/peer/config/config.xml"
API=$(cat "$ServerConfigPath" | grep "<apikey>" | cut -d ">" -f 2 | cut -d "<" -f 1)
WebPort=$(cat "$ServerConfigPath" | grep "127.0.0.1" | cut -d ":" -f 2 | cut -d "<" -f 1)
User=$(cat "$ServerConfigPath" | grep "<user>" | cut -d ">" -f 2 | cut -d "<" -f 1)


Pass=""

curl -u "$User":"$User" -X PATCH -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/config/gui" \
-H 'Content-Type: application/json' \
-d "{\"enabled\":true,\"user\":\"$Pass\",\"password\":\"$Pass\"}"


