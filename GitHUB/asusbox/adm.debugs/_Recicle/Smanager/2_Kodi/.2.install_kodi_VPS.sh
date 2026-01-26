#!/system/bin/sh

export APPFolder=/data/data/os.tools.scriptmanager
export TheAPP=os.tools.scriptmanager
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
export baseapps="$Wpath/.0/2_Kodi"
export CPU=`getprop ro.product.cpu.abi`

export DeviceAPI=`getprop ro.build.version.sdk`

if [ ! -e "$baseapps" ] ; then
mkdir -p $baseapps/apk
fi

am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV -e b_noicon "1" -e b_notime "1" -e int_id 3 -e str_title "Download apps" -e hex_tcolor "FF0000" -e float_tsize 27 -e float_csize 16 -e str_content "Kodi por favor aguarde..."
cmd statusbar collapse
cmd statusbar expand-notifications

# download do apk
if [ $DeviceAPI -gt '19' ] ; then
           DownloadFiles="https://www.dropbox.com/s/0009rbt38d3y74d/21_org.xbmc.kodi_17.6_1760000.apk"
    else
           DownloadFiles="
				https://www.dropbox.com/s/ml4aea84q7rqfpt/17_org.xbmc.kodi_16.1_161001.apk
				https://www.dropbox.com/s/c2e3dzuvgusttyb/main.161001.org.xbmc.kodi.obb
				"
fi
#echo $DownloadFiles
cd $baseapps/apk
for link in $DownloadFiles; do
while [ 1 ]; do
    /system/bin/wget --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue $link
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
done

# obb kodi 16.1
obbKodi="$baseapps/apk/main.161001.org.xbmc.kodi.obb"
if [ -e "$obbKodi" ] ; then
mkdir -p $EXTERNAL_STORAGE/Android/obb/org.xbmc.kodi
mv $obbKodi $EXTERNAL_STORAGE/Android/obb/org.xbmc.kodi/  >> $logao 2>&1
fi

if [ -e /data/data/org.xbmc.kodi ] ; then
	pm clear org.xbmc.kodi
fi


am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV -e b_noicon "1" -e b_notime "1" -e int_id 3 -e str_title "Instalando Kodi" -e hex_tcolor "FF0000" -e float_tsize 27 -e float_csize 16 -e str_content "Por favor aguarde"
cmd statusbar collapse
cmd statusbar expand-notifications

if [ $DeviceAPI -gt '19' ] ; then
		echo "Instalando kodi por favor aguarde..."
		while [ 1 ]; do
			pm install -r $baseapps/apk/21_org.xbmc.kodi_17.6_1760000.apk > /dev/null 2>&1
			if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
			sleep 1;
		done;
	else
		echo "Instalando kodi por favor aguarde..."
		while [ 1 ]; do
			pm install -r $baseapps/apk/17_org.xbmc.kodi_16.1_161001.apk > /dev/null 2>&1
			if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
			sleep 1;
		done;
fi
pm grant org.xbmc.kodi android.permission.READ_EXTERNAL_STORAGE > /dev/null 2>&1
pm grant org.xbmc.kodi android.permission.WRITE_EXTERNAL_STORAGE > /dev/null 2>&1



# config padrão
link="https://www.dropbox.com/s/jnknz2pmc091gye/kodi_16.1_v2.1.tar.gz?dl=1"
cd $EXTERNAL_STORAGE
while [ 1 ]; do
    /system/bin/wget --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue $link -O tmp.tar.gz
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
# configs kodi
rm -rf $EXTERNAL_STORAGE/Android/data/org.xbmc.kodi
mkdir -p $EXTERNAL_STORAGE/Android/data/org.xbmc.kodi
cd $EXTERNAL_STORAGE/Android/data/org.xbmc.kodi
tar -mzxvf $EXTERNAL_STORAGE/tmp.tar.gz  >> $logao 2>&1
# clean junk
rm -rf $EXTERNAL_STORAGE/Android/data/org.xbmc.kodi/files/.kodi/addons/plugin.video.FLIXPLAY  >> $logao 2>&1
rm $EXTERNAL_STORAGE/tmp.tar.gz  >> $logao 2>&1





