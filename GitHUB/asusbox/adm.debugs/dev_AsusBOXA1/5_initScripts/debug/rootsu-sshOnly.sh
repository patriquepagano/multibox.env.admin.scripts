
# Ativar direto no boot
/system/bin/busybox mount -o remount,rw /system
file="/system/bin/rootsudaemon.sh"
/system/bin/busybox cat <<'EOF' > $file
#!/system/bin/sh
/system/xbin/daemonsu --auto-daemon &

sleep 7
mkdir /storage/DevMount
chmod 777 /storage/DevMount
/system/bin/busybox mount -t ext4 UUID="033e8fc7-4cfe-9454-bc59-df7329ca862d" /storage/DevMount

/system/bin/busybox mount -o remount,rw /system
rm /system/.pin

mkdir -p /data/data/com.termux
ln -sf /storage/DevMount/AndroidDEV/termux/files /data/data/com.termux/
ln -sf /storage/DevMount/asusbox/.install /data/asusbox/


# SSH Server
export PWD="/storage/DevMount/GitHUB/asusbox/"
export HOME="/storage/DevMount/GitHUB/asusbox/"
export SHELL=/system/bin/sh
export TERM=xterm
chown root:root -R /data/data/com.termux/files/home
config="/data/data/com.termux/files/usr/etc/ssh/sshd_config"
key="/data/data/com.termux/files/usr/etc/ssh/ssh_host_rsa_key"
su -c /data/data/com.termux/files/usr/bin/sshd -p 4399 -f $config -h $key
EOF
chmod 755 $file
clear
cat $file



