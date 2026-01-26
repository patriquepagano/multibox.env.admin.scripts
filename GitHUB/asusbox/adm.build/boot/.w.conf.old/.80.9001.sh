#!/system/bin/sh

#unset PATH
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin
#unset LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib


/system/bin/busybox chmod 660 /data/asusbox/.sc/boot/.w.conf/*.conf
/system/bin/busybox chmod 660 /data/asusbox/.sc/boot/.w.conf/*.ini

/system/bin/busybox kill -9 $(/system/bin/busybox pgrep lighttpd) > /dev/null 2>&1
/system/bin/busybox kill -9 $(/system/bin/busybox pgrep php-cgi) > /dev/null 2>&1


# HOME=/data/asusbox
# # fecha uma sessão em aberto
# screen -X -S phpfpm quit
# screen -wipe
# screen -ls
# # rodar um comando
# screen -dmS phpfpm bash -c '/storage/DevMount/GitHUB/asusbox/adm.build/boot/.w.conf/.fcgi.sh'


# netstat -ntlup
# exit


# while [ ! -f /data/asusbox/.sc/boot/.w.conf/fcgiserver.log ]
#     do
#     echo "Aguardando o log ser criado"
#     sleep 1
# done
# rm /data/asusbox/.sc/boot/.w.conf/fcgiserver.log

/system/bin/lighttpd -f /storage/DevMount/GitHUB/asusbox/adm.build/boot/.w.conf/lighttpd.conf -m /system/usr/lib


# Debug arm 64 tanix t95z
#   /system/bin/lighttpd -f /data/asusbox/.sc/boot/.w.conf/lighttpd.conf -m /system/usr/lib


#  opening errorlog '/data/asusbox/.sc/www/lighttpd.log' failed: No such file or directory
# mkdir -p /data/asusbox/.sc/www


#netstat -ntlup



