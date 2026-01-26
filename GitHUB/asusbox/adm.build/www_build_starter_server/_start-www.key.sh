#!/system/bin/sh

#unset PATH
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin
#unset LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib

Dir=$(dirname $0)

/system/bin/busybox chmod 660 /data/asusbox/.sc/boot/.w.conf/*.conf
/system/bin/busybox chmod 660 /data/asusbox/.sc/boot/.w.conf/*.ini

/system/bin/busybox kill -9 $(/system/bin/busybox pgrep lighttpd) > /dev/null 2>&1
/system/bin/busybox kill -9 $(/system/bin/busybox pgrep php-cgi) > /dev/null 2>&1


/system/bin/lighttpd -f \
$Dir/_start-www.key.conf \
-m /system/usr/lib




netstat -ntlup


echo -n "bah dev" >/storage/DevMount/GitHUB/asusbox/adm.build/www_key/version
echo -n "bah dev" >/storage/DevMount/GitHUB/asusbox/adm.build/www_key/boot.log



