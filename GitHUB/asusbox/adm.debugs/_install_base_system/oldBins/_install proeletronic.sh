#!/system/bin/sh

DIR=$( cd "${0%/*}" && pwd -P )

echo "depois de instalar via app busybox mefik"

/system/xbin/busybox mount -o remount,rw /
cp /system/xbin/busybox /system/bin/busybox 
cp /system/xbin/ssl_helper /system/bin/ssl_helper 
chmod 755 /system/bin/busybox
chmod 755 /system/bin/ssl_helper


/system/bin/busybox mount -o remount,rw /system


cp $DIR/7z /system/bin/
cp $DIR/7z.so /system/bin/
cp $DIR/aria2c /system/bin/



cp $DIR/curl /system/bin/
cp $DIR/rsync /system/bin/
cp $DIR/ssl_helper /system/bin/
cp $DIR/wget /system/bin/



chmod 755 /system/bin/7z
chmod 755 /system/bin/7z.so
chmod 755 /system/bin/aria2c
chmod 755 /system/bin/busybox
chmod 755 /system/bin/curl
chmod 755 /system/bin/rsync
chmod 755 /system/bin/ssl_helper
chmod 755 /system/bin/wget


# cp $DIR/org.cosinus.launchertv_1.5.3.apk /system/app/
# cp $DIR/acr.browser.barebones_4.5.1.apk /system/app/

# chmod 644 /system/app/org.cosinus.launchertv_1.5.3.apk
# chmod 644 /system/app/acr.browser.barebones_4.5.1.apk



# rm /data/busybox


