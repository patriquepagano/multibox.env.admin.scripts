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
export busybox="$APPFolder/bin/busybox"
export aria2c="$APPFolder/bin/aria2c"
export curl="$APPFolder/bin/curl"
clear
#----------------------------------------------------------------------------------------------------------------------------------------
# check internet
export gateway=`$curl -4 ipv4.icanhazip.com`
if [ "$gateway" == "" ] ; then
	exit
else
	echo -n "Atualizando o sistema"
	link="https://www.dropbox.com/s/t16l7oxqh6xvz7z/.update_code.sh?dl=1"
	$aria2c -x 10 --check-certificate=false --allow-overwrite=true --file-allocation=none $link --dir=$APPFolder -o tmp.sh > /dev/null 2>&1
	chmod 755 $APPFolder/tmp.sh > /dev/null 2>&1
	$APPFolder/tmp.sh
	rm $APPFolder/tmp.sh
	$APPFolder/sc/0_support/smanager_shortcuts.sh	
fi
