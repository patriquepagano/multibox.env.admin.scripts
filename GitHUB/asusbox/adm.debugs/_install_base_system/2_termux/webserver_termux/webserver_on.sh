#!/system/bin/sh

unset LD_LIBRARY_PATH > /dev/null 2>&1
export APPFolder=/data/data/os.tools.scriptmanager
export CPU=`getprop ro.product.cpu.abi`
export logao="$APPFolder/debug.log"
lighttpd="$APPFolder/bin/lighttpd"
php="$APPFolder/bin/php-fpm"

if [ "$CPU" == "x86" ] ; then
		echo "Lib x86 detectado"
		export LD_LIBRARY_PATH=/data/app/os.tools.scriptmanager-1/lib/$CPU:/data/user/0/os.tools.scriptmanager/files	
	else
		echo "Lib arm detectado"
		export LD_LIBRARY_PATH=/data/app/os.tools.scriptmanager-1/lib/arm:/data/user/0/os.tools.scriptmanager/files
fi

share="$EXTERNAL_STORAGE/Download/Compartilhar.sh"
if [ ! -e $share ] ; then
echo "Criando arquivo compartilhar."
cat <<EOF > $share
#!/system/bin/sh
unset LD_LIBRARY_PATH
$APPFolder/bin/webserver_on.sh
EOF
fi

# path removivel ------------------------------------------------------------------------------------------------
# # primeira pasta padrão a procurar..
# www=`find /*/Android/data/os.tools.scriptmanager -type d -name 'www'`
# # pasta em dispositivos removiveis..
# if [ "$www" == "" ] ; then
# echo "procurando o path em"
# www=`find /storage/*/Android/data/os.tools.scriptmanager -type d -name 'www'`
# #echo 'a pasta é >   ' $www
# fi
# #echo 'a pasta é >   ' $www

# # configs webserver
# file="$APPFolder/bin/lighttpd.conf"
# wwwAtual=`cat $file | grep "/files/www" | cut -d '"' -f 2`
# if [ "$www" == "$wwwAtual" ] ; then
	# echo "Diretório das paginas não necessita alteração"
# else
	# echo "Alterando o diretório para > $www"
	# sed -i -e 's;.*/files/www";server.document-root = "'$www'";g' $file
	# #cat $file | grep "server.document-root"
	# restorecon -FR $APPFolder/bin > /dev/null 2>&1
# fi


Wpath=`$busybox find /storage/*/Android/data/os.tools.scriptmanager -type d -name 'files'`/www
if [ ! -e $Wpath ] ; then
	Wpath="$EXTERNAL_STORAGE/Android/data/os.tools.scriptmanager/files/www"
	echo 'a pasta de compartilhamento é :'
	echo "$Wpath"
	echo ""
else
	echo 'a pasta de compartilhamento é :'
	echo "$Wpath"
	echo ""
fi

# configs webserver
file="$APPFolder/bin/lighttpd.conf"
wwwAtual=`cat $file | grep "/files/www" | cut -d '"' -f 2`
if [ "$Wpath" == "$wwwAtual" ] ; then
	echo "Diretório das paginas não necessita alteração"
else
	echo "Alterando o diretório para:"
	echo "$Wpath"
	echo ""	
	sed -i -e 's;.*/files/www";server.document-root = "'$Wpath'";g' $file
	#cat $file | grep "server.document-root"
	restorecon -FR $APPFolder/bin > /dev/null 2>&1
fi

#------------------------------------------------------------------------------------------------------------------

echo "Iniciando webserver"
killall lighttpd >> $logao 2>&1
sleep 1
$lighttpd -f $APPFolder/bin/lighttpd.conf -m $APPFolder/files > $logao 2>&1


# kill o php-fpm
pidFile="$APPFolder/php-pid"
if [ -e $pidFile ] ; then
PID=`cat $pidFile`
kill $PID >> $logao 2>&1
fi
#echo $PID
#ps | grep fpm | grep "php-fpm.conf"

echo "Iniciando php server"
$php -g $pidFile -c $APPFolder/bin/php.ini -y $APPFolder/bin/php-fpm.conf  >> $logao 2>&1

#ps | grep fpm
#netstat -ntlup

unset LD_LIBRARY_PATH
# open localhost
am start --user 0 -a android.intent.action.VIEW -d 'http://localhost:8080' >> $logao 2>&1
