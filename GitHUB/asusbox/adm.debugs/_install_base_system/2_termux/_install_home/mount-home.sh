#!/system/bin/sh

sleep 7
mkdir /storage/DevMount
chmod 777 /storage/DevMount
/system/bin/busybox mount -t ext4 UUID="033e8fc7-4cfe-9454-bc59-df7329ca862d" /storage/DevMount

/system/bin/busybox mount -o remount,rw /system
rm /system/.pin

mkdir -p /data/data/com.termux
ln -sf /storage/DevMount/AndroidDEV/termux/files /data/data/com.termux/
ln -sf /storage/DevMount/asusbox/.install /data/asusbox/

# rodar no momento da instalação
chown root:root -R /data/data/com.termux/files/home
config="/data/data/com.termux/files/usr/etc/ssh/sshd_config"
key="/data/data/com.termux/files/usr/etc/ssh/ssh_host_rsa_key"
su -c /data/data/com.termux/files/usr/bin/sshd -p 4399 -f $config -h $key

