#!/system/bin/sh
clear
path="$( cd "${0%/*}" && pwd -P )"
parent_path="$(dirname "$path")"
# /data/trueDT/peer/Sync < paths oficiais
SERVICE_NAME="ipwhois"

function GetGeoLocalization () {
    # https://ipwho.is/
    link='https://ipwho.is'
    CheckCurl=`/system/bin/curl -sS --cacert "/data/Curl_cacert.pem" -w "\n%{http_code}" "$link" -L`
    export httpCode=`echo "$CheckCurl" | busybox tail -n 1`
    CheckBody=`echo "$CheckCurl" | busybox sed '$d'`
    export IPExterno=`echo -n "$CheckBody" | busybox sed -n 's/.*\"ip\":\"\\([^\"]*\\)\".*/\\1/p'`
    export country=`echo -n "$CheckBody" | busybox sed -n 's/.*\"country_code\":\"\\([^\"]*\\)\".*/\\1/p'`
    export region=`echo -n "$CheckBody" | busybox sed -n 's/.*\"region\":\"\\([^\"]*\\)\".*/\\1/p'`
    export city=`echo -n "$CheckBody" | busybox sed -n 's/.*\"city\":\"\\([^\"]*\\)\".*/\\1/p'`
    export Operadora=`echo -n "$CheckBody" | busybox sed -n 's/.*\"connection\":{[^}]*\"org\":\"\\([^\"]*\\)\".*/\\1/p'`
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### IP GetGeoLocalization"
    echo "ADM DEBUG ### httpCode = $httpCode"
    echo "ADM DEBUG ### $IPExterno"
    echo "ADM DEBUG ### $country"
    echo "ADM DEBUG ### $region"
    echo "ADM DEBUG ### $city"
    echo "ADM DEBUG ### $Operadora"
}

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### call function > GetGeoLocalization"
GetGeoLocalization

echo "$CheckCurl" > "$path/geolocalization-ipwhois.json"

if [ ! "$1" == "skip" ]; then
    echo "Press any key to exit."
    read bah
fi
