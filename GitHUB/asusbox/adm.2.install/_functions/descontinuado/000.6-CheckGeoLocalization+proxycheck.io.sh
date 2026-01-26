function GeoProxycheckIO () {
WANIP=$(/system/bin/curl http://canhazip.com)
link="https://proxycheck.io/v2/$WANIP?vpn=1&asn=1"
CheckCurl=`curl -w "%{http_code}" -H "user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36" $link`
# extract vars
export httpCode=`echo -n "$CheckCurl" | busybox tail -n1 | busybox cut -d "}" -f 2 | busybox sed 's/\r$//'`
export country=`echo -n "$CheckCurl" | grep '"country":' | busybox cut -d '"' -f 4`
export region=`echo -n "$CheckCurl" | grep '"region":' | busybox cut -d '"' -f 4`
export city=`echo -n "$CheckCurl" | grep '"city":' | busybox cut -d '"' -f 4`
export latitude=`echo -n "$CheckCurl" | grep '"latitude":' | busybox cut -d '-' -f 2`
export longitude=`echo -n "$CheckCurl" | grep '"longitude":' | busybox cut -d '-' -f 2`
export loc="-$latitude-$longitude"
export org=`echo -n "$CheckCurl" | grep '"provider":' | busybox cut -d '"' -f 4`
if [ ! -d /data/trueDT/peer/Sync ]; then
    mkdir -p /data/trueDT/peer/Sync
fi
}

# # colar este loop para chamar a função
# # entra em loop de espera para ver se o vps recebeu as vars
# while [ 1 ]; do
# 	echo "GeoProxycheckIO"
# 	GeoProxycheckIO
# 	if [ "$httpCode" == "200" ]; then break; fi; # se for igual a 200 sai deste loop
# 	# tempo para a box tentar enviar as vars novamente
# 	busybox sleep 3 
# done;

