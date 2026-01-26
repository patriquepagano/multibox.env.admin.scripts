#!/system/bin/sh
if [ ! -e "/data/data/com.asusbox.asusboxiptvbox" ] ; then
echo "<h1>$(date)</h1>" > $bootLog 2>&1
echo "<h2>Player de vídeo AsusBox Iptv</h2>" >> $bootLog 2>&1
echo "<h3>Instalando, por favor aguarde.</h3>" >> $bootLog 2>&1
echo "<h3>- - -</h3>" >> $bootLog 2>&1
pm install -r /system/asusbox/Apps/asusbox/com.asusbox.asusboxiptvbox_1.6.9.3.apk
app=com.asusbox.asusboxiptvbox
pm grant $app android.permission.READ_EXTERNAL_STORAGE
pm grant $app android.permission.WRITE_EXTERNAL_STORAGE
fi
if [ ! -e "/data/data/com.asusplay.asusplaysmartersplayer" ] ; then
echo "<h1>$(date)</h1>" > $bootLog 2>&1
echo "<h2>Player AsusBox smartplayer</h2>" >> $bootLog 2>&1
echo "<h3>Instalando, por favor aguarde.</h3>" >> $bootLog 2>&1
echo "<h3>- - -</h3>" >> $bootLog 2>&1
pm install -r /system/asusbox/Apps/asusbox/com.asusplay.asusplaysmartersplayer_4.5.3.apk
app=com.asusplay.asusplaysmartersplayer
pm grant $app android.permission.READ_EXTERNAL_STORAGE
pm grant $app android.permission.WRITE_EXTERNAL_STORAGE
fi
