#!/system/bin/sh


# /system/bin/busybox find /data/asusbox/.install -type f \
# | /system/bin/busybox xargs /system/bin/busybox stat -c "%a %n" \
# | /system/bin/busybox awk '{print "chmod "$1" "$2}' > ./filesPermissions.sh



/data/data/com.termux/files/usr/bin/getfacl 

# não salva timestamp
