#!/system/bin/sh

export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib
clear

php=`busybox ps aux | grep "php-cgi" | busybox grep -v grep | busybox awk '{print $1}'`
for port in $php; do
	busybox kill -9 $port
done

lighttpd=`busybox ps aux | grep "lighttpd" | busybox grep -v grep | busybox awk '{print $1}'`
for port in $lighttpd; do
	busybox kill -9 $port
done

# /system/bin/busybox mount -o remount,rw /system
# ln -sf /system/usr/lib/libz.so.1.2.11 /system/lib/libz.so.1

# /system/usr/bin/php-cgi


# exit


#     # verifica se for um symlink apaga
#     CheckSymlink=`/system/bin/busybox readlink -fn /system/lib/libz.so.1`
#     if [ ! "$CheckSymlink" == "/system/usr/lib/libz.so.1.2.11" ] ; then
#         /system/bin/busybox mount -o remount,rw /system
#         /system/bin/busybox ln -sf /system/usr/lib/libz.so.1.2.11 /system/lib/libz.so.1
#     fi



# /system/bin/lighttpd -f /storage/DevMount/GitHUB/asusbox/adm.build/OnLine/.w.conf/lighttpd.conf -m /system/usr/lib


netstat -ntlup


