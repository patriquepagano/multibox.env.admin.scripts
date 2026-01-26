#!/system/bin/sh
clear
path=$( cd "${0%/*}" && pwd -P )

function GetWanIP () {
urlList="
checkip.amazonaws.com
icanhazip.com
"
for loop in $urlList; do
	echo $loop
	CheckCurl=`curl -w "%{http_code}" -k $loop`
	export WANIP=`echo -n $CheckCurl | busybox cut -d ' ' -f 1`
	export httpCode=`echo -n $CheckCurl | busybox cut -d ' ' -f 2`
	if [ "$httpCode" == "200" ]; then break; fi;
	busybox sleep 3
done
}

# entra em loop de espera para ver se o vps recebeu as vars
while [ 1 ]; do
	echo "GetWanIP"
	GetWanIP
	if [ "$httpCode" == "200" ]; then break; fi; # se for igual a 200 sai deste loop
	# tempo para a box tentar enviar as vars novamente
	busybox sleep 3 
done;

function GeoProxycheckIO () {
link="https://proxycheck.io/v2/$WANIP?vpn=1&asn=1"
CheckCurl=`curl -w "%{http_code}" -H "user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36" $link`
# extract vars
export httpCode=`echo -n "$CheckCurl" | busybox tail -n1 | busybox cut -d "}" -f 2 | busybox sed 's/\r$//'`
export country=`echo -n "$CheckCurl" | grep '"country":' | busybox cut -d '"' -f 4`
export region=`echo -n "$CheckCurl" | grep '"region":' | busybox cut -d '"' -f 4`
export city=`echo -n "$CheckCurl" | grep '"city":' | busybox cut -d '"' -f 4`
latitude=`echo -n "$CheckCurl" | grep '"latitude":' | busybox cut -d '-' -f 2`
longitude=`echo -n "$CheckCurl" | grep '"longitude":' | busybox cut -d '-' -f 2`
export loc="-$latitude-$longitude"
export org=`echo -n "$CheckCurl" | grep '"provider":' | busybox cut -d '"' -f 4`
# echo "
# $CheckCurl
# "
echo "ADM DEBUG ### httpCode : $httpCode"
echo "ADM DEBUG ### country : $country"
echo "ADM DEBUG ### region : $region"
echo "ADM DEBUG ### city : $city"
echo "ADM DEBUG ### loc : $loc"
echo "ADM DEBUG ### org : $org"

exit

}

# entra em loop de espera para ver se o vps recebeu as vars
while [ 1 ]; do
	echo "GeoProxycheckIO"
	GeoProxycheckIO
	if [ "$httpCode" == "200" ]; then break; fi; # se for igual a 200 sai deste loop
	# tempo para a box tentar enviar as vars novamente
	busybox sleep 3 
done;






