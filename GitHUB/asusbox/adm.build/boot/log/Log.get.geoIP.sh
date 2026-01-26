
function CheckIPLocal () {
WlanIP=`/system/bin/busybox ip addr show wlan0 \
| /system/bin/busybox grep "inet " \
| /system/bin/busybox awk '{print $2}' \
| /system/bin/busybox cut -d "/" -f 1 \
| /system/bin/busybox head -1`

LanIP=`/system/bin/busybox ip addr show eth0 \
| /system/bin/busybox grep "inet " \
| /system/bin/busybox awk '{print $2}' \
| /system/bin/busybox cut -d "/" -f 1 \
| /system/bin/busybox head -1`

if [ "$LanIP" == "" ]; then
    export IPLocal="$WlanIP"
else
    export IPLocal="$LanIP"
fi
}


function GetGeoLocalization () {
    # add estas infos dentro do sistema do melhor ao pior todos tem cota e requests é uma média de mil por dia
    # o correto seria rodar sem travar em uma chave apikey minha
    # https://ipinfo.io/
    # https://iplocality.com/
    # https://ipapi.co/#pricing
    # https://ipregistry.co/

    # https://api.freegeoip.app bloqueou meu acesso mensal
    # link='https://api.freegeoip.app/json/?apikey=69032740-a582-11ec-a49d-b105dbc7486e'
    # CheckCurl=`/system/bin/curl --silent -w "%{http_code}" -k $link -L`
    # # {"ip":"132.255.147.107","country_code":"BR","country_name":"Brazil","region_code":null,"region_name":"Rio Grande do Sul","city":"Pelotas","zip_code":"96020-000","time_zone":"America\/Sao_Paulo","latitude":-31.763229370117188,"longitude":-52.34141159057617,"metro_code":0}
    # export httpCode=`echo "$CheckCurl" | busybox cut -d "}" -f 2`
    # export ip=`echo -n "$CheckCurl" | busybox cut -d '"' -f 4 | busybox head -1`
    # export country=`echo -n "$CheckCurl" | busybox cut -d '"' -f 12 | busybox head -1`
    # export region=`echo -n "$CheckCurl" | busybox cut -d '"' -f 18 | busybox head -1`
    # export city=`echo -n "$CheckCurl" | busybox cut -d '"' -f 22 | busybox head -1`

    link='https://ipinfo.io'
    # funciona e baixa a pagina inteira mas não tem os dados de geolocation
    # CheckCurl=`/system/bin/curl --silent -w "%{http_code}" -k -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36" "$link" -L`
    CheckCurl=`/system/bin/curl --silent -w "%{http_code}" -k $link -L`
    export httpCode=`echo "$CheckCurl" | busybox grep "}" | busybox cut -d "}" -f 2`
    export ip=`echo -n "$CheckCurl" | busybox grep "ip" | busybox cut -d '"' -f 4 | busybox head -1`
    export country=`echo -n "$CheckCurl" | busybox grep "country" | busybox cut -d '"' -f 4 | busybox head -1`
    export region=`echo -n "$CheckCurl" | busybox grep "region" | busybox cut -d '"' -f 4 | busybox head -1`
    export city=`echo -n "$CheckCurl" | busybox grep "city" | busybox cut -d '"' -f 4 | busybox head -1`
    export hostname=`echo -n "$CheckCurl" | busybox grep "hostname" | busybox cut -d '"' -f 4 | busybox head -1`
    export org=`echo -n "$CheckCurl" | busybox grep "org" | busybox cut -d '"' -f 4 | busybox head -1`

    if [ ! -d /data/trueDT/peer/Sync ]; then
        mkdir -p /data/trueDT/peer/Sync
    fi
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### IP GetGeoLocalization"
    echo "ADM DEBUG ### httpCode = $httpCode" 
    echo "ADM DEBUG ### $ip" 
    echo "ADM DEBUG ### $country"
    echo "ADM DEBUG ### $region"
    echo "ADM DEBUG ### $city"
    echo "ADM DEBUG ### $hostname"
    echo "ADM DEBUG ### $org"    
}



# se não existir requisita ao servidor o micro serviço
FileLog="/data/trueDT/peer/Sync/LocationGeoIP.v6.atual"
checkFileInfo=$(busybox cat $FileLog | busybox tr -d '\n')
if [ "$checkFileInfo" == "" ]; then
    # apaga para forçar um proximo request na proxima hora
    rm $FileLog
fi
if [ ! -f "$FileLog" ]; then
    for i in $(seq 1 7); do
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### call function > GetGeoLocalization"
        GetGeoLocalization
        if [ "$httpCode" = "200" ]; then break; fi;
        sleep 3;
    done;
    # fora do looping se não tiver sucesso encerra o script
    if [ ! "$httpCode" = "200" ]; then exit; fi;    
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### grava GeoLocalização"
    #echo "$httpCode | $country | $region | $city | $loc | $org " > "/data/trueDT/peer/Sync/LocationGeoIP.v6.atual"
    if [ ! "$ip$country$region$city$org$hostname" == "" ]; then
        echo "$ip | $country | $region | $city | $org | $hostname" > "/data/trueDT/peer/Sync/LocationGeoIP.v6.atual"
    fi
fi


# verifica o IP a cada uma hora
GETipExternal=$(/system/bin/curl --silent http://canhazip.com)
FileLog="/data/trueDT/peer/Sync/LocationIP"
ExternalipLogged=$(busybox cat $FileLog.atual | busybox tr -d '\n')
if [ ! "$ExternalipLogged" == "$GETipExternal" ]; then
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### mudança de external IP detectado."
    echo "ADM DEBUG ###  write IP e location "
    echo $GETipExternal > "$FileLog.atual"
    for i in $(seq 1 7); do
        GetGeoLocalization
        if [ "$httpCode" = "200" ]; then break; fi;
        sleep 3;
    done;
    # fora do looping se não tiver sucesso encerra o script
    if [ ! "$httpCode" = "200" ]; then exit; fi; 
    echo "$ip | $country | $region | $city" > "/data/trueDT/peer/Sync/LocationGeoIP.v6.atual"
    #echo "$country | $region | $city" > "/data/trueDT/peer/Sync/Location.atual"
else
    logcat -c
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### IP inalterado = $ExternalipLogged"
fi


CheckIPLocal
# verifica o IPLocalAtual a cada uma hora
FileLog="/data/trueDT/peer/Sync/LocationIPlocal"
IPLocalLogged=$(busybox cat $FileLog.atual | busybox tr -d '\n')
if [ ! "$IPLocalLogged" == "$IPLocal" ]; then
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### mudança de IPLocal detectado."
    echo "ADM DEBUG ###  write IPLocal e qrCode"    
    echo -n $IPLocal > "$FileLog.atual"
    echo "ADM DEBUG ########################################################"
    # ConfigPath="/data/trueDT/peer/config/config.xml"
    # APIKEY=$(busybox cat "$ConfigPath" | busybox grep "<apikey>" | busybox cut -d ">" -f 2 | busybox cut -d "<" -f 1)
    # syncPort=$(busybox cat "$ConfigPath" | busybox grep "<localAnnounceMCAddr>" | busybox cut -d ":" -f 3 | busybox cut -d "]" -f 1) 
    # # encodar texto com espaço > curl http://localhost:8384/qr/?text=Hello%2C%20world%21
    # echo "ADM DEBUG ###  API=$APIKEY Port=$syncPort"
    # curl -X GET -H "X-API-Key: $APIKEY" http://127.0.0.1:$syncPort/qr/?text="http://$IPLocal" --output /data/data/dxidev.toptvlauncher2/launcher-03-full/QR.IPLocal.png
    # chmod 777 /data/data/dxidev.toptvlauncher2/launcher-03-full/QR.IPLocal.png
else
    logcat -c
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### IP inalterado = $IPLocalLogged"
fi


