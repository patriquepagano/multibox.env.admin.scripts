#!/system/bin/sh
clear
path=$( cd "${0%/*}" && pwd -P )

echo "
Este microserviço é melhor pq:
1) mais rapido
2) não precisa procurar por wanIP
3) tem clientes de peso!
"

function GeoIPinfo () {
CheckCurl=`curl -w "%{http_code}" -k "https://ipinfo.io"`
# extract vars
export httpCode=`echo -n $CheckCurl | busybox cut -d "}" -f 2 | busybox sed 's/\r$//'`
export country=`echo -n "$CheckCurl" | grep '"country":' | busybox cut -d '"' -f 4`
export region=`echo -n "$CheckCurl" | grep '"region":' | busybox cut -d '"' -f 4`
export city=`echo -n "$CheckCurl" | grep '"city":' | busybox cut -d '"' -f 4`
export loc=`echo -n "$CheckCurl" | grep '"loc":' | busybox cut -d '"' -f 4`
#export postal=`echo -n "$CheckCurl" | grep '"postal":' | busybox cut -d '"' -f 4`		  	# funciona mas não vejo sentido em usar e precisa padronizar com o proxycheck.io que não tem esta info
export org=`echo -n "$CheckCurl" | grep '"org":' | busybox cut -d '"' -f 4`
#export hostname=`echo -n "$CheckCurl" | grep '"hostname":' | busybox cut -d '"' -f 4`		# funciona mas não vejo sentido em usar e precisa padronizar com o proxycheck.io que não tem esta info
# echo "
# $CheckCurl
# "
echo "ADM DEBUG ### httpCode : $httpCode"
echo "ADM DEBUG ### country : $country"
echo "ADM DEBUG ### region : $region"
echo "ADM DEBUG ### city : $city"
echo "ADM DEBUG ### loc : $loc"
#echo "ADM DEBUG ### postal : $postal"		# funciona mas não vejo sentido em usar e precisa padronizar com o proxycheck.io que não tem esta info
echo "ADM DEBUG ### org : $org"
#echo "ADM DEBUG ### hostname : $hostname"	# funciona mas não vejo sentido em usar e precisa padronizar com o proxycheck.io que não tem esta info
}

# entra em loop de espera para ver se o vps recebeu as vars
while [ 1 ]; do
	echo "GeoIPinfo"
	GeoIPinfo
	if [ "$httpCode" == "200" ]; then break; fi; # se for igual a 200 sai deste loop
	# tempo para a box tentar enviar as vars novamente
	busybox sleep 3 
done;






# exit

# # extrair o IP gateway   entry.888911116
# export geo=`cat /system/$Produto/geo`
# if [ "$geo" = "" ] ; then
# while [ 1 ]; do
#     echo "Baixando novo geo"
# 	while [ 1 ]; do
# 		geo=`/system/bin/curl -k https://ipinfo.io`
# 		if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
# 		sleep 1;
# 	done;
# 	/system/bin/busybox mount -o remount,rw /system
# 	echo "$geo" > /system/$Produto/geo
#     export geo=`cat /system/$Produto/geo`
#      echo "Verificando geo > $geo"   
#     if [  "$geo" = "" ];then
#         $?="1"	
#     fi
#     if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
#     sleep 1;
# done;
# fi

# # upload registro box
# if [ ! -e /system/asusbox/register ] ; then
# 	country=`cat /system/asusbox/geo | grep '"country":'`
# 	region=`cat /system/asusbox/geo | grep '"region":'`
# 	city=`cat /system/asusbox/geo | grep '"city":'`
# 	loc=`cat /system/asusbox/geo | grep '"loc":'`
# 	postal=`cat /system/asusbox/geo | grep '"postal":'`
# 	org=`cat /system/asusbox/geo | grep '"org":'`
# 	hostname=`cat /system/asusbox/geo | grep '"hostname":'`
# 	Gform=1xv3jd_OkKglHljQ2hU_WI562fyv78SpqOLK-LFugXoo
# 	while [ 1 ]; do
# 		/system/bin/curl -k https://docs.google.com/forms/d/$Gform/formResponse -d ifq -d entry.888911116="$country $region $city $loc $postal $org $hostname" -d entry.729880858=$ID -d entry.1968457322=$UUID -d submit=Submit
# 		if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
# 		sleep 1;
# 	done;
# 	/system/bin/busybox mount -o remount,rw /system
# 	echo -n $UUID > /system/$Produto/register	
# fi

# fi # if [ ! "$cronRunning" == "yes" ]; then

