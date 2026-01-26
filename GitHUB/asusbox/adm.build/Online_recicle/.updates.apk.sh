#!/system/bin/sh
if [ ! -e "/data/data/com.google.android.apps.youtube.music" ] ; then
echo "<h1>$(date)</h1>" > $bootLog 2>&1
echo "<h2>Player de música youtube</h2>" >> $bootLog 2>&1
echo "<h3>Instalando, por favor aguarde.</h3>" >> $bootLog 2>&1
echo "<h3>- - -</h3>" >> $bootLog 2>&1
pm install -r /system/asusbox/Apps/gplay/com.google.android.apps.youtube.music_3.27.54.apk
app=com.google.android.apps.youtube.music
pm grant $app android.permission.READ_EXTERNAL_STORAGE
pm grant $app android.permission.WRITE_EXTERNAL_STORAGE
fi
if [ ! -e "/data/data/com.cetusplay.remoteservice" ] ; then
echo "<h1>$(date)</h1>" > $bootLog 2>&1
echo "<h2>Controle Remoto CetusPlay</h2>" >> $bootLog 2>&1
echo "<h3>Instalando, por favor aguarde.</h3>" >> $bootLog 2>&1
echo "<h3>- - -</h3>" >> $bootLog 2>&1
pm install -r /system/asusbox/Apps/gplay/com.cetusplay.remoteservice_4.7.8.0For_TV.apk
app=com.cetusplay.remoteservice
pm grant $app android.permission.READ_EXTERNAL_STORAGE
pm grant $app android.permission.WRITE_EXTERNAL_STORAGE
fi
if [ ! -e "/data/data/com.netflix.mediaclient" ] ; then
echo "<h1>$(date)</h1>" > $bootLog 2>&1
echo "<h2>Player de vídeo Netflix</h2>" >> $bootLog 2>&1
echo "<h3>Instalando, por favor aguarde.</h3>" >> $bootLog 2>&1
echo "<h3>- - -</h3>" >> $bootLog 2>&1
pm install -r /system/asusbox/Apps/others/com.netflix.mediaclient_4.16.4_build_200217.apk
app=com.netflix.mediaclient
pm grant $app android.permission.READ_EXTERNAL_STORAGE
pm grant $app android.permission.WRITE_EXTERNAL_STORAGE
fi
if [ ! -e "/data/data/com.google.android.youtube.tv" ] ; then
echo "<h1>$(date)</h1>" > $bootLog 2>&1
echo "<h2>Player de vídeo Youtube</h2>" >> $bootLog 2>&1
echo "<h3>Instalando, por favor aguarde.</h3>" >> $bootLog 2>&1
echo "<h3>- - -</h3>" >> $bootLog 2>&1
pm install -r /system/asusbox/Apps/others/com.google.android.youtube.tv_2.07.02.apk
app=com.google.android.youtube.tv
fi
