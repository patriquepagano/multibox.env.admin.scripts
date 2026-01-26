#!/system/bin/sh

# NÃO PODE APAGAR ESTE ARQUIVO POIS AINDA PODE TER BOXES LIGADAS A ESTE SERVER

# extraindo a config
path=$( cd "${0%/*}" && pwd -P )
ServerConfigPath="/data/trueDT/peer/config/config.xml"
API=$(cat "$ServerConfigPath" | grep "<apikey>" | cut -d ">" -f 2 | cut -d "<" -f 1)
WebPort=$(cat "$ServerConfigPath" | grep "127.0.0.1" | cut -d ":" -f 2 | cut -d "<" -f 1)
User=$(cat "$ServerConfigPath" | grep "<user>" | cut -d ">" -f 2 | cut -d "<" -f 1)

SyncID=`cat /data/trueDT/peer/Sync/serial.live`


DevicesPairing="\
MGADARQ-5FB6F6H-VZDHT74-2T7D76S-PI2W5JH-JZ2JWS4-MUTDKEK-MBNS6QE;MasterServer001\
"
echo "$DevicesPairing" | while read line; do
    DeviceID=`echo $line | cut -d ";" -f 1`
    DeviceN=`echo $line | cut -d ";" -f 2`
    echo "******* deletado o server > $DeviceN"
curl -u "$User":"$User" -X DELETE -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/config/devices/$DeviceID"

echo "deletado a pasta do device"
curl -u "$User":"$User" -X DELETE -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/config/folders/log_$SyncID"

done




# regras :



# estudo de caso:
# 1 = starto o server com todos em --paused
# 2 = existe processamento mesmo assim > Connection from 3CFOJJI-DB7LEAE-PQOTDFC-3R6JYBM-YV4RZNG-RUNRBSP-EIJW5GB-E2GWQAH at 143.106.12.16:22067 (relay-server) rejected: device is paused
# 3 = libero apenas as box beta testers
# 4 = os peers se conectam aparentemente normal
# 5 = peers ficam out of sync qlq novidade feita em ambos os lados não sincam
# 6 = removo o share e device server
# 7 = add folder share and device
# 8 = peers mostram como se estivessem sincronizados. mas não estão!
# 9 = crio arquivos em ambos os lados mas não sincronizam.

# quando eu reiniciei o server a box conseguiu sincronizar dos dois lados
# Device MGADARQ folder "Master Server 001" (J66LYFR-ZQN4IGE-OPH2VB4-2WMXRUU-DCFIURD-HLOSP3K-MR4QRCN-PRBLJQU)
# has mismatching index ID for us (0x2ECE369A9937203B != 0xA8A64B9EED41163C)
