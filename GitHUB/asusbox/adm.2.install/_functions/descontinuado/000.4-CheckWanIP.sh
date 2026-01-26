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

# # colar este loop para chamar a função
# # entra em loop de espera para ver se o vps recebeu as vars
# while [ 1 ]; do
# 	echo "GetWanIP"
# 	GetWanIP
# 	if [ "$httpCode" == "200" ]; then break; fi; # se for igual a 200 sai deste loop
# 	# tempo para a box tentar enviar as vars novamente
# 	busybox sleep 3 
# done;




