#!/system/bin/sh

DIR=$( cd "${0%/*}" && pwd -P )

#unset PATH
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin
#unset LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib


/system/bin/busybox chmod 660 $DIR/*.conf
/system/bin/busybox chmod 660 $DIR/*.ini

/system/bin/busybox kill -9 $(/system/bin/busybox pgrep lighttpd) > /dev/null 2>&1
/system/bin/busybox kill -9 $(/system/bin/busybox pgrep php-cgi) > /dev/null 2>&1

/system/bin/lighttpd -f $DIR/OnlineVersion.conf -m /system/usr/lib

echo "debug" > /storage/DevMount/GitHUB/asusbox/adm.build/www/boot.log
echo "version debug" > /storage/DevMount/GitHUB/asusbox/adm.build/www/version

netstat -ntlup

exit
# HOME=/data/asusbox
# # fecha uma sessão em aberto
# screen -X -S phpfpm quit
# screen -wipe
# screen -ls
# # rodar um comando
# screen -dmS phpfpm bash -c '/storage/DevMount/GitHUB/asusbox/adm.build/boot/.w.conf/.fcgi.sh'


# netstat -ntlup
# exit


# while [ ! -f $DIR/fcgiserver.log ]
#     do
#     echo "Aguardando o log ser criado"
#     sleep 1
# done
# rm $DIR/fcgiserver.log

/system/bin/lighttpd -f /storage/DevMount/GitHUB/asusbox/adm.build/OnLine/.w.conf/lighttpd.conf -m /system/usr/lib

#netstat -ntlup



