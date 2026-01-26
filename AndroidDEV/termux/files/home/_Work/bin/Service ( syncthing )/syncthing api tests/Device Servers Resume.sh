#!/system/bin/sh

# ID da pasta é o mesmo syncthing ID do tvbox client
# J66LYFR-ZQN4IGE-OPH2VB4-2WMXRUU-DCFIURD-HLOSP3K-MR4QRCN-PRBLJQU

# extraindo a config
path=$( cd "${0%/*}" && pwd -P )
API="30610-11492-1385-4082"
folderID="J66LYFR-ZQN4IGE-OPH2VB4-2WMXRUU-DCFIURD-HLOSP3K-MR4QRCN-PRBLJQU"
Json="$path/Trial data.json"



# POST /rest/system/resume
# Resume the given device or all devices.
# Takes the optional parameter device (device ID). 
# When omitted, resumes all devices.
#  Returns status 200 and no content upon success, 
#  or status 500 and a plain text error on failure.




DevicesPairing="\
MGADARQ-5FB6F6H-VZDHT74-2T7D76S-PI2W5JH-JZ2JWS4-MUTDKEK-MBNS6QE;MasterServer001\
"
echo "$DevicesPairing" | while read line; do
    DeviceID=`echo $line | cut -d ";" -f 1`
    DeviceN=`echo $line | cut -d ";" -f 2`
    echo "******* Retomando a sincronização > $DeviceN"
    # /rest/db/completion?device=I6KAH76-...-3PSROAU
    curl -X POST -H "X-API-Key: $API" "http://127.0.0.1:4442/rest/system/resume?device=$DeviceID"
done


read bah
cd "$path"
x
exit

