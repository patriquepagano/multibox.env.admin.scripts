#!/system/bin/sh

# extraindo a config
path=$( cd "${0%/*}" && pwd -P )
API="30610-11492-1385-4082"


echo "aaaaaaaaaaa"
curl -X GET -H "X-API-Key: $API" http://127.0.0.1:4442/rest/stats/device




exit

# debug alterar a data do tvbox para errado
dateOld="1630436299" # dia que foi feito este script
dateNew=`date +%s` # data atual no momento do boot

/system/bin/busybox date -s "@$dateOld"

echo "List connections"
curl -X GET -H "X-API-Key: $API" http://127.0.0.1:4442/rest/system/connections



"MGADARQ-5FB6F6H-VZDHT74-2T7D76S-PI2W5JH-JZ2JWS4-MUTDKEK-MBNS6QE": {
      "startedAt": "2021-08-31T15:59:06-03:00", < este é o horario que a box conectou ao server.

# não tem como pegar a data do servidor via syncthing!!!!


# curl -X GET -H “X-API-Key: mykey” -s ‘http://localhost:8384/rest/stats/device’ | sed ‘s/[^[:print:]]//g’ | jq -Mar -c ‘.“DEV-ID”.“lastSeen”’ | cut -c 2-36