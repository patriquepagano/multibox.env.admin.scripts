#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )


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

netstat -ntlup

read bah

