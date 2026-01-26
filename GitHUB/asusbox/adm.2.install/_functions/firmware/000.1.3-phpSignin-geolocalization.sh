function GetGeoLocalization () {
    # https://ipinfo.io/
    # https://iplocality.com/
    # https://ipapi.co/#pricing
    # https://ipregistry.co/
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

function WriteGeoLocalization () {
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
	CheckIPLocal
    if [ ! "$ip$country$region$city$org$hostname" == "" ]; then
        echo "$IPLocal | $ip | $country | $region | $city | $org | $hostname" > "/data/trueDT/peer/Sync/LocationGeoIP.v6.atual"
    fi
fi
}

ExternalipLogged=$(busybox cat "/data/trueDT/peer/Sync/LocationGeoIP.v6.atual" | busybox awk -F'|' '{print $2}' | busybox tr -d '[:space:]')
GETipExternal=$(/system/bin/curl --silent http://canhazip.com)
if [ ! "$ExternalipLogged" == "$GETipExternal" ]; then
	WriteGeoLocalization
fi

