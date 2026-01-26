
if [ ! "$cronRunning" == "yes" ]; then
##########################################################################################################################
##########################################################################################################################
# sistema de registro da box

# este android ID vai ser o chaveador que vai trabalhar junto com a cdkey casando os dois juntos
# este sera a "chave de atualização"
export Produto="asusbox"

# sempre escreve no boot o android id
GetID=`settings get secure android_id` # puxa o ultimo id do android
export ID=`cat /data/$Produto/android_id` # id variavel que muda no hard reset
# compara para escrever apenas se mudou
if [ ! "$GetID" = "$ID" ];then
	echo "novo id instalado"
	echo -n $GetID > /data/$Produto/android_id # escreve novo id
	export ID=`cat /data/$Produto/android_id` # carrega o novo id
fi

# novo sistema que trava em loop até conseguir baixar o uuid
export UUID=`cat /system/$Produto/UUID`
if [ "$UUID" = "" ] ; then
while [ 1 ]; do
    echo "Baixando novo UUID"
	while [ 1 ]; do
		UUID=`/system/bin/curl "http://personaltecnico.net/Android/RebuildRoms/keyaccess.php"`
		if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
		sleep 1;
	done;
	/system/bin/busybox mount -o remount,rw /system
	echo -n $UUID > /system/$Produto/UUID
    export UUID=`cat /system/$Produto/UUID`
     echo "Verificando UUID > $UUID"   
    if [  "$UUID" = "" ];then
        $?="1"	
    fi
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
fi

# extrair o IP gateway   entry.888911116
export geo=`cat /system/$Produto/geo`
if [ "$geo" = "" ] ; then
while [ 1 ]; do
    echo "Baixando novo geo"
	while [ 1 ]; do
		geo=`/system/bin/curl -k https://ipinfo.io`
		if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
		sleep 1;
	done;
	/system/bin/busybox mount -o remount,rw /system
	echo "$geo" > /system/$Produto/geo
    export geo=`cat /system/$Produto/geo`
     echo "Verificando geo > $geo"   
    if [  "$geo" = "" ];then
        $?="1"	
    fi
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
fi

# upload registro box
if [ ! -e /system/asusbox/register ] ; then
	country=`cat /system/asusbox/geo | grep '"country":'`
	region=`cat /system/asusbox/geo | grep '"region":'`
	city=`cat /system/asusbox/geo | grep '"city":'`
	loc=`cat /system/asusbox/geo | grep '"loc":'`
	postal=`cat /system/asusbox/geo | grep '"postal":'`
	org=`cat /system/asusbox/geo | grep '"org":'`
	hostname=`cat /system/asusbox/geo | grep '"hostname":'`
	Gform=1xv3jd_OkKglHljQ2hU_WI562fyv78SpqOLK-LFugXoo
	while [ 1 ]; do
		/system/bin/curl -k https://docs.google.com/forms/d/$Gform/formResponse -d ifq -d entry.888911116="$country $region $city $loc $postal $org $hostname" -d entry.729880858=$ID -d entry.1968457322=$UUID -d submit=Submit
		if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
		sleep 1;
	done;
	/system/bin/busybox mount -o remount,rw /system
	echo -n $UUID > /system/$Produto/register	
fi

fi # if [ ! "$cronRunning" == "yes" ]; then

