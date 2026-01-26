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
export PATH=$APPFolder/bin:$APPFolder/bin/applets:$PATH
$APPFolder/sc/0_support/Wpath.sh
export Wpath=`cat "$APPFolder/Wpath.TXT"`
export logao="$Wpath/debug.log"
export busybox="$APPFolder/bin/busybox"

DUser=`stat -c "%u" "$APPFolder"`
$busybox chown -R $DUser:$DUser "$APPFolder"
find $APPFolder/sc -type d -exec chmod 700 {} \; 
find $APPFolder/sc -name "*\.sh" -exec chmod 755 {} \;


