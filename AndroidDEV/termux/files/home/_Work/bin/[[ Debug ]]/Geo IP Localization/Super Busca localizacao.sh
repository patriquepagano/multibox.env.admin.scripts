#!/system/bin/sh
clear
path="$( cd "${0%/*}" && pwd -P )"
parent_path="$(dirname "$path")"
# /data/trueDT/peer/Sync < paths oficiais

function CurlWithRetry () {
    url="$1"
    attempt=1
    while [ $attempt -le 3 ]; do
        CheckCurl=`/system/bin/curl -sS --cacert "/data/Curl_cacert.pem" -m 11 -w "\n%{http_code}" "$url" -L`
        httpCode=`echo "$CheckCurl" | busybox tail -n 1`
        if [ "$httpCode" = "200" ]; then
            return 0
        fi
        attempt=$((attempt + 1))
    done
    return 1
}

function FetchIpinfo () {
    ServiceGeoIP="ipinfo"
    link='https://ipinfo.io'
    if ! CurlWithRetry "$link"; then return 1; fi
    CheckBody=`echo "$CheckCurl" | busybox sed '$d'`
    IPExterno=`echo -n "$CheckBody" | busybox sed -n 's/.*"ip"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    country=`echo -n "$CheckBody" | busybox sed -n 's/.*"country"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    region=`echo -n "$CheckBody" | busybox sed -n 's/.*"region"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    city=`echo -n "$CheckBody" | busybox sed -n 's/.*"city"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    Operadora=`echo -n "$CheckBody" | busybox sed -n 's/.*"org"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    if [ "$httpCode" = "200" ] && [ ! "$IPExterno" == "" ]; then return 0; fi
    return 1
}

function FetchIpwhois () {
    ServiceGeoIP="ipwhois"
    link='https://ipwho.is'
    if ! CurlWithRetry "$link"; then return 1; fi
    CheckBody=`echo "$CheckCurl" | busybox sed '$d'`
    IPExterno=`echo -n "$CheckBody" | busybox sed -n 's/.*"ip"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    country=`echo -n "$CheckBody" | busybox sed -n 's/.*"country_code"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    region=`echo -n "$CheckBody" | busybox sed -n 's/.*"region"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    city=`echo -n "$CheckBody" | busybox sed -n 's/.*"city"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    Operadora=`echo -n "$CheckBody" | busybox sed -n 's/.*"connection":{[^}]*"org"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    if [ "$httpCode" = "200" ] && [ ! "$IPExterno" == "" ]; then return 0; fi
    return 1
}

function FetchIpapi () {
    ServiceGeoIP="ipapi"
    link='https://ipapi.co/json'
    if ! CurlWithRetry "$link"; then return 1; fi
    CheckBody=`echo "$CheckCurl" | busybox sed '$d'`
    IPExterno=`echo -n "$CheckBody" | busybox sed -n 's/.*"ip"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    country=`echo -n "$CheckBody" | busybox sed -n 's/.*"country"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    region=`echo -n "$CheckBody" | busybox sed -n 's/.*"region"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    city=`echo -n "$CheckBody" | busybox sed -n 's/.*"city"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    Operadora=`echo -n "$CheckBody" | busybox sed -n 's/.*"org"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    if [ "$httpCode" = "200" ] && [ ! "$IPExterno" == "" ]; then return 0; fi
    return 1
}

function FetchIpApi () {
    ServiceGeoIP="ip-api"
    link='http://ip-api.com/json'
    if ! CurlWithRetry "$link"; then return 1; fi
    CheckBody=`echo "$CheckCurl" | busybox sed '$d'`
    IPExterno=`echo -n "$CheckBody" | busybox sed -n 's/.*"query"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    country=`echo -n "$CheckBody" | busybox sed -n 's/.*"countryCode"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    region=`echo -n "$CheckBody" | busybox sed -n 's/.*"regionName"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    city=`echo -n "$CheckBody" | busybox sed -n 's/.*"city"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    Operadora=`echo -n "$CheckBody" | busybox sed -n 's/.*"org"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'`
    if [ "$httpCode" = "200" ] && [ ! "$IPExterno" == "" ]; then return 0; fi
    return 1
}

function EchoResult () {
    busybox printf "%-12s %s\n" "Servico:" "$ServiceGeoIP"
    busybox printf "%-12s %s\n" "HTTPCode:" "$httpCode"
    busybox printf "%-12s %s\n" "IP:" "$IPExterno"
    busybox printf "%-12s %s\n" "Pais:" "$country"
    busybox printf "%-12s %s\n" "Regiao:" "$region"
    busybox printf "%-12s %s\n" "Cidade:" "$city"
    busybox printf "%-12s %s\n" "Operadora:" "$Operadora"
}

ok=0
if FetchIpinfo; then ok=1; else
    if FetchIpwhois; then ok=1; else
        if FetchIpapi; then ok=1; else
            if FetchIpApi; then ok=1; fi
        fi
    fi
fi

EchoResult

if [ ! "$1" == "skip" ]; then
    echo "Press any key to exit."
    read bah
fi
