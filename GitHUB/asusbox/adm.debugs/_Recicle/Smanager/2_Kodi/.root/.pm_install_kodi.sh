#!/system/bin/sh

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
export Szip="$APPFolder/bin/7z"
# path removivel
$APPFolder/sc/0_support/Wpath.sh
export Wpath=`cat "$APPFolder/Wpath.TXT"`
export logao="$Wpath/debug.log"
# webserver
#export IPSERVER="1.0.0.2"
export IPSERVER=""
export baseapps="$Wpath/.0/2_Kodi"
export CPU=`getprop ro.product.cpu.abi`

export DeviceAPI=`getprop ro.build.version.sdk`

if [ -e /data/data/org.xbmc.kodi ] ; then
	pm clear org.xbmc.kodi
fi

if [ $DeviceAPI -gt '19' ] ; then
		echo "Instalando kodi por favor aguarde..."
		pm install -r $baseapps/apk/21_org.xbmc.kodi_17.6_1760000.apk > /dev/null 2>&1
	else
		echo "Instalando kodi por favor aguarde..."
		pm install -r $baseapps/apk/17_org.xbmc.kodi_16.1_161001.apk > /dev/null 2>&1
fi
pm grant org.xbmc.kodi android.permission.READ_EXTERNAL_STORAGE > /dev/null 2>&1
pm grant org.xbmc.kodi android.permission.WRITE_EXTERNAL_STORAGE > /dev/null 2>&1
