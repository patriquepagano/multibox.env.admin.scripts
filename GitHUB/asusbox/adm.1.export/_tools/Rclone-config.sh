#!/data/data/com.termux/files/usr/bin/env /data/data/com.termux/files/usr/bin/bash
#
clear

config=/data/asusbox/adm.1.export/_tools/rclone.conf

# perms 600
chmod 600 $config

# configurar
rclone --config=$config config


