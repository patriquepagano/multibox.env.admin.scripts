#!/system/bin/sh

CONFIG="/storage/DevMount/GitHUB/asusbox/adm.build/boot/.w.conf/php-fpm.conf"
exec php-fpm -F -y $CONFIG -c "/storage/DevMount/GitHUB/asusbox/adm.build/boot/.w.conf/php.ini" 2>&1

