#!/system/bin/sh

if [ -e /data/data/os.tools.scriptmanagerpro ] ; then
		export APPFolder=/data/data/os.tools.scriptmanagerpro
		export TheAPP=os.tools.scriptmanagerpro
	else
		export APPFolder=/data/data/os.tools.scriptmanager
		export TheAPP=os.tools.scriptmanager
fi
export TMPDIR="$APPFolder"
if [ -e "$APPFolder/bin/busyboxTMP" ] ; then
	export busybox="$APPFolder/bin/busyboxTMP"
elif [ -e "$APPFolder/bin/busybox" ] ; then
	export busybox="$APPFolder/bin/busybox"
fi

# Diretório removivel 
export Wpath=`$busybox find /*/*/Android/data/$TheAPP -name 'files'`/www
if [ ! -e "$Wpath" ] ; then
	export Wpath="$EXTERNAL_STORAGE/Android/data/$TheAPP/files/www"
	echo 'a pasta de compartilhamento é :'
	echo "$Wpath"
	echo ""
else
	echo 'a pasta de compartilhamento é :'
	echo "$Wpath"
	echo ""
fi

file="$APPFolder/Wpath.TXT"
# se o Wpath.TXT não existir..
if [ ! -e "$file" ] ; then
	echo -n "$Wpath" > $file 2>&1
fi

filelog=`cat "$file"`
# se o arquivo foi modificado...
if [ "$Wpath" == "$filelog" ] ; then
	echo "Wpath não necessita alteração"
else
	echo -n "$Wpath" > $file 2>&1
fi
