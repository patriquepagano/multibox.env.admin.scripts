#!/system/bin/sh



# desativando apps
apps="
dxidev.toptvlauncher2
ott.i5.mw.client.tv.launcher
appinventor.ai_asusboxus.asusboxQR
com.aplicativox.hdlivetv
com.asusbox.asusboxiptvbox
com.asusplay.asusplaysmartersplayer
com.cetusplay.remoteservice
com.google.android.apps.youtube.music
com.google.android.youtube.tv
com.netflix.mediaclient
"
for loop in $apps; do
am force-stop $loop
pm disable $loop
#echo $loop
done

