#!/system/bin/sh

logao="$EXTERNAL_STORAGE/Download/PersonalTecnico.net/debug.log"

if [ -e /data/data/org.xbmc.kodi ] ; then
	pm clear org.xbmc.kodi
fi

pm install -r $EXTERNAL_STORAGE/Download/PersonalTecnico.net/Kodi_17.6.apk
pm grant org.xbmc.kodi android.permission.READ_EXTERNAL_STORAGE
pm grant org.xbmc.kodi android.permission.WRITE_EXTERNAL_STORAGE
rm $EXTERNAL_STORAGE/Download/PersonalTecnico.net/Kodi_17.6.apk
