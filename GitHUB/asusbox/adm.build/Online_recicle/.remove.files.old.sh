#!/system/bin/sh
rm /data/local/tmp/*
rm /data/asusbox/com.szdq.elinksmart.vtv.tar.gz
rm /data/asusbox/env.updates.*.sh
rm /data/asusbox/crontab/*.log
rm /data/asusbox/ott.i5.mw.client.tv.launcher*
/system/bin/busybox mount -o remount,rw /system
rm /system/asusbox/share/*.torrent
rm /system/asusbox/share/.*.torrent
rm /sdcard/Android/UPDATE.torrent
rm -rf /sdcard/Android/UPDATE
