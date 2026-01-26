#!/system/bin/sh

/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/bash /system/bin/bash
ln -sf /system/usr/bin/curl /system/bin/curl
ln -sf /system/usr/bin/lighttpd /system/bin/lighttpd
ln -sf /system/usr/bin/rsync /system/bin/rsync
ln -sf /system/usr/bin/rsync-ssl /system/bin/rsync-ssl
ln -sf /system/usr/bin/screen-4.8.0 /system/bin/screen
ln -sf /system/usr/bin/transmission-create /system/bin/transmission-create
ln -sf /system/usr/bin/transmission-daemon /system/bin/transmission-daemon
ln -sf /system/usr/bin/transmission-edit /system/bin/transmission-edit
ln -sf /system/usr/bin/transmission-remote /system/bin/transmission-remote
ln -sf /system/usr/bin/transmission-show /system/bin/transmission-show
ln -sf /system/usr/bin/wget /system/bin/wget




