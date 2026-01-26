#!/bin/bash
path=$( cd "${0%/*}" && pwd -P )


# # desliga o servidor web
sudo systemctl stop nginx.service
sudo systemctl stop php8.1-fpm



# pasta /devices é onde fica os logs sendo gerados na api do php
sudo rsync --progress \
-avz \
--exclude="devices" \
--delete \
--recursive \
"$path/piratebox/www/" \
"/www/piratebox/"


echo "### Rsync no personaltecnico.net"
sudo rsync --progress \
-avz \
--exclude="devices" \
--delete \
--recursive \
"$path/personaltecnico.net/" \
"/www/personaltecnico.net/"


sudo chown -R www-data:www-data "/www"



sudo systemctl enable php8.1-fpm
sudo systemctl enable nginx.service
sudo systemctl start nginx.service
sudo systemctl start php8.1-fpm






# cria os symlinks da box antiga do personaltecnico.net
# liga o server novamente