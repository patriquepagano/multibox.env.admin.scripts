#!/system/bin/sh
#não funcionou bem.. continua forçando a home na pasta do termux, não vale o esforço


# conseguir o numero do pid
pidClose=`netstat -ntlup | grep "sshd" | cut -d '/' -f 1 | head -1 | tail -c 5`
kill $pidClose
netstat -ntlup


mkdir -p /data/root

# /system/bin/rsync --progress \
# -avz \
# --delete \
# --recursive \
#  /data/data/com.termux/files/home/ /data/root/

# /system/bin/busybox mount -o remount,rw /system
# /system/bin/rsync --progress \
# -avz \
# --delete \
# --recursive \
#  /data/data/com.termux/files/usr/etc/ssh/ /system/usr/etc/ssh/

export HOME=/data/root
chown root:root -R /data/root/

config="/system/usr/etc/ssh/sshd_config"
key="/system/usr/etc/ssh/ssh_host_rsa_key"
su -c /system/usr/bin/sshd -p 4399 -f $config -h $key #-E /storage/emulated/0/Download/sshport
netstat -ntlup #>> /storage/emulated/0/Download/sshport






