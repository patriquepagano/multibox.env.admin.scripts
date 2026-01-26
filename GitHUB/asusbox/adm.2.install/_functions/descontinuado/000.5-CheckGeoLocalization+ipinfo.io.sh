
function GeoIPinfo () {
CheckCurl=`curl -w "%{http_code}" -k "https://ipinfo.io"`
# extract vars
export httpCode=`echo -n $CheckCurl | busybox cut -d "}" -f 2 | busybox sed 's/\r$//'`
export country=`echo -n "$CheckCurl" | grep '"country":' | busybox cut -d '"' -f 4`
export region=`echo -n "$CheckCurl" | grep '"region":' | busybox cut -d '"' -f 4`
export city=`echo -n "$CheckCurl" | grep '"city":' | busybox cut -d '"' -f 4`
export loc=`echo -n "$CheckCurl" | grep '"loc":' | busybox cut -d '"' -f 4`
export org=`echo -n "$CheckCurl" | grep '"org":' | busybox cut -d '"' -f 4`
}

# # usar este looping onde for necessário
# # entra em loop de espera para ver se o vps recebeu as vars
# while [ 1 ]; do
# 	echo "GeoIPinfo"
# 	GeoIPinfo
# 	if [ "$httpCode" == "200" ]; then break; fi; # se for igual a 200 sai deste loop
# 	# tempo para a box tentar enviar as vars novamente
# 	busybox sleep 3 
# done;








