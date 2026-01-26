#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )


export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib
clear

stop bootstat80900x

# tem que derrubar o script mesmo /system/bin/bootstat80900x.sh 
busybox kill -9 $(busybox ps aux | grep "/system/bin/bootstat80900x" | busybox grep -v grep | busybox awk '{print $1}')

php=`busybox ps aux | grep "php-cgi" | busybox grep -v grep | busybox awk '{print $1}'`
for port in $php; do
	busybox kill -9 $port
done

lighttpd=`busybox ps aux | grep "lighttpd" | busybox grep -v grep | busybox awk '{print $1}'`
for port in $lighttpd; do
	busybox kill -9 $port
done

netstat -ntlup

/system/bin/busybox mount -o remount,rw /system
rm /system/etc/init/bootstat80900x.rc
rm /system/bin/bootstat80900x

read bah

