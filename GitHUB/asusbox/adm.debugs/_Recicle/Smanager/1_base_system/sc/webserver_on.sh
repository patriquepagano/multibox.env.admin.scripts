#!/system/bin/sh

LDFIX=`echo "$LD_LIBRARY_PATH" | cut -c1-1`
if [ "$LDFIX" == ":" ] ; then
	export LD_LIBRARY_PATH=`echo "$LD_LIBRARY_PATH" | cut -c 2-`
fi

if [ -e /data/data/os.tools.scriptmanagerpro ] ; then
		export APPFolder=/data/data/os.tools.scriptmanagerpro
		export TheAPP=os.tools.scriptmanagerpro
	else
		export APPFolder=/data/data/os.tools.scriptmanager
		export TheAPP=os.tools.scriptmanager
fi
export TMPDIR="$APPFolder"
export PATH=$APPFolder/bin/applets:$PATH
export busybox="$APPFolder/bin/busybox"
# path removivel
$APPFolder/sc/0_support/Wpath.sh
export Wpath=`cat "$APPFolder/Wpath.TXT"`
export logao="$Wpath/debug.log"
# webserver
export lighttpd="$APPFolder/bin/lighttpd"
export php="$APPFolder/bin/php-cgi"
# rsync
export rsync="$APPFolder/bin/rsync"

share="$EXTERNAL_STORAGE/Download/Compartilhar.sh"
if [ ! -e "$share" ] ; then
echo "Criando arquivo compartilhar."
cat <<'EOF' > $share
#!/system/bin/sh
LDFIX=`echo "$LD_LIBRARY_PATH" | cut -c1-1`
if [ "$LDFIX" == ":" ] ; then
	export LD_LIBRARY_PATH=`echo "$LD_LIBRARY_PATH" | cut -c 2-`
fi
clear
if [ -e /data/data/os.tools.scriptmanagerpro ] ; then
		export APPFolder=/data/data/os.tools.scriptmanagerpro
		export TheAPP=os.tools.scriptmanagerpro
	else
		export APPFolder=/data/data/os.tools.scriptmanager
		export TheAPP=os.tools.scriptmanager
fi
export TMPDIR="$APPFolder"
export PATH=$APPFolder/bin/applets:$PATH
$APPFolder/sc/1_base_system/update.sh
$APPFolder/sc/1_base_system/webserver_on.sh
EOF
fi

# cria pasta para compartilhar
FolderShare="$EXTERNAL_STORAGE/Download/_A_Compartilhar"
if [ ! -e "$FolderShare" ] ; then
mkdir -p "$FolderShare"
fi
# verificar se tem arquivos para compartilhar
if [ -z "$(ls -A $FolderShare)" ]; then
   echo "Adicione arquivos a pasta $FolderShare"
   echo "Para compartilhar em sua rede local"
else
	$rsync --remove-source-files --force -ah --progress -rptv $FolderShare/ $Wpath/_A_Compartilhar/
	rm -rf $FolderShare/*
fi

#----------------------------------------------------------------------------------------------------------------------------------------
# IP do server
ipfile="$Wpath/IPSERVER.TXT"
export IPSERVER=`ip addr show eth0 | grep global | cut -d ' ' -f 6 | cut -d '/' -f 1`
if [ "$IPSERVER" == "" ] ; then
		export IPSERVER=`ip addr show wlan0 | grep global | cut -d ' ' -f 6 | cut -d '/' -f 1`
fi
# se o IPSERVER.TXT não existir..
if [ ! -e "$ipfile" ] ; then
	echo -n "$IPSERVER" > $ipfile 2>&1
	files=`find $Wpath -type f -name '*.sh'`
	for L in $files; do
		sed -i -e 's/export IPSERVER=".*"/export IPSERVER="'$IPSERVER'"/g' $L
		cat $L | grep 'export IPSERVER="*"'
	done
fi

iplog=`cat "$ipfile"`
# se o arquivo foi modificado...
if [ "$IPSERVER" == "$iplog" ] ; then
	echo "IP não necessita alteração"
else
	echo -n "$IPSERVER" > $ipfile 2>&1
	files=`find $Wpath -type f -name '*.sh'`
		for L in $files; do
			sed -i -e 's/export IPSERVER=".*"/export IPSERVER="'$IPSERVER'"/g' $L
			cat $L | grep 'export IPSERVER="*"'
		done
fi
echo "IP para acessar o webserver > $IPSERVER"
#----------------------------------------------------------------------------------------------------------------------------------------
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
	# $cat $file | grep "server.document-root"
	restorecon -FR $APPFolder/bin > /dev/null 2>&1
fi
#----------------------------------------------------------------------------------------------------------------------------------------
# start server
echo "Iniciando webserver"
kill -9 $(pgrep lighttpd) > /dev/null 2>&1
kill -9 $(pgrep php-cgi) > /dev/null 2>&1

# php server
/data/data/$TheAPP/bin/fcgiserver &
sleep 2

# lighttpd
$lighttpd -f /data/data/$TheAPP/bin/lighttpd.conf

#ps | grep fpm
#netstat -ntlup

# open localhost
AppL=`pm list packages -f | grep -e '/data/app/' | sed -e 's,package:/data/app/,,g' | cut -d "=" -f 2`


# CheckRoot
for p in /system/xbin/su /system/bin/su /su/bin/su /sbin/su /magisk/.core/bin/su
do
	if [ -x $p ]; then
			CheckRoot="0"
	fi
done

linkLocal="http://localhost:8080/welcome.php"

if [ "$CheckRoot" == "0" ] ; then
	iApp=`echo "$AppL" | grep "de.ozerov.fully"`
	if [ "$iApp" == "de.ozerov.fully" ] ; then	
		am start --user 0 \
			-n de.ozerov.fully/.MainActivity \
			-a android.intent.action.VIEW -d "$linkLocal" > /dev/null 2>&1
		sleep 30
		am start --user 0 -a android.intent.action.MAIN -c android.intent.category.HOME > /dev/null 2>&1
		exit
	fi
fi

iApp=`echo "$AppL" | grep "com.xyz.fullscreenbrowser"`
if [ "$iApp" == "com.xyz.fullscreenbrowser" ] ; then
	am start --user 0 \
	-n com.xyz.fullscreenbrowser/.BrowserActivity \
	-a android.intent.action.VIEW -d "$linkLocal" > /dev/null 2>&1
	sleep 30
	am start --user 0 -a android.intent.action.MAIN -c android.intent.category.HOME > /dev/null 2>&1
	exit
fi

iApp=`echo "$AppL" | grep "acr.browser.barebones"`
if [ "$iApp" == "acr.browser.barebones" ] ; then
	am start --user 0 \
	-n acr.browser.barebones/acr.browser.lightning.MainActivity \
	-a android.intent.action.VIEW -d "$linkLocal" > /dev/null 2>&1
	sleep 30
	am start --user 0 -a android.intent.action.MAIN -c android.intent.category.HOME > /dev/null 2>&1
	exit
fi

am start --user 0 -a android.intent.action.VIEW -d "$linkLocal" > /dev/null 2>&1
sleep 30
am start --user 0 -a android.intent.action.MAIN -c android.intent.category.HOME > /dev/null 2>&1
exit



# funcionaaaa
am force-stop com.android.chrome
am start --user 0 \
-n com.android.chrome/com.google.android.apps.chrome.IntentDispatcher \
-a android.intent.action.VIEW \
-d "http://personaltecnico.net"






