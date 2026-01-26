#!/system/bin/sh

export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin
#unset LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib

# muito IMPORTANTE para esperar todo os sistema ficar pronto para continuar
while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done;
sleep 3 # so pra garantir

# Wait for pendrive
while true; do
    UUID=`/system/bin/busybox blkid | /system/bin/busybox grep "asusboxUpdate" | /system/bin/busybox head -n 1 | /system/bin/busybox cut -d "=" -f 3 | /system/bin/busybox cut -d '"' -f 2`
    echo "verificando UUID $UUID"
    if [ $UUID == "cf3f1700-7709-43f9-a6f3-7b8b18c5e224" ]; then
        break
    fi
    sleep 1
done

mkdir /storage/DevMount
chmod 777 /storage/DevMount
/system/bin/busybox mount -t ext4 UUID="cf3f1700-7709-43f9-a6f3-7b8b18c5e224" /storage/DevMount

mkdir /storage/asusboxUpdate
chmod 777 /storage/asusboxUpdate
/system/bin/busybox mount -t ext4 LABEL="asusboxUpdate" /storage/asusboxUpdate


    FolderPath="/storage/asusboxUpdate"
    UUID=`/system/bin/busybox blkid | /system/bin/busybox grep "asusboxUpdate" | /system/bin/busybox head -n 1 | /system/bin/busybox cut -d "=" -f 3 | /system/bin/busybox cut -d '"' -f 2`
    if [ ! $UUID == "" ]; then    
        if [ ! -d $FolderPath ] ; then
            mkdir $FolderPath
            chmod 700 $FolderPath
        fi
        # montando o device
        /system/bin/busybox umount $FolderPath > /dev/null 2>&1  
        /system/bin/busybox mount -t ext4 LABEL="asusboxUpdate" $FolderPath
        # Symlink
        rm /data/asusbox/.install > /dev/null 2>&1    
        /system/bin/busybox ln -sf $FolderPath/asusbox/.install /data/asusbox/
        InstallFolder="ENABLED"
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### $FolderPath ativado como pasta .install" 
    fi


mkdir -p /data/data/com.termux
ln -sf /storage/DevMount/AndroidDEV/termux/files /data/data/com.termux/


/system/bin/busybox mount -o remount,rw /system
rm /system/.pin

ln -sf /data/data/com.termux/files/usr/bin/git /system/bin/git

# SHC
ln -sf /data/data/com.termux/files/usr/bin/shc /system/bin/shc
ln -sf /data/data/com.termux/files/usr/bin/clang-10 /system/bin/cc
ln -sf /data/data/com.termux/files/usr/bin/strip /system/bin/strip

# SSH Server
export PWD="/storage/DevMount/GitHUB/asusbox/"
export HOME="/storage/DevMount/GitHUB/asusbox/"
export SHELL=/system/bin/sh
export TERM=xterm
chown root:root -R /data/data/com.termux/files/home
config="/data/data/com.termux/files/usr/etc/ssh/sshd_config"
key="/data/data/com.termux/files/usr/etc/ssh/ssh_host_rsa_key"
su -c /data/data/com.termux/files/usr/bin/sshd -p 4399 -f $config -h $key



# # configura a rede
# while ! /system/bin/busybox ping -c 1 -W 1 10.0.0.1; do
#     echo "Waiting for network interface might be down..."
#     if [ ! -f /data/open-wifi-setup ]; then
#         # abre o wifi
#         am start -a com.android.settings -n com.android.settings/com.android.settings.wifi.WifiSettings
#         touch /data/open-wifi-setup
#     fi
#     sleep 1
# done

# ip address add 10.0.0.101 dev wlan0
# ip addr show






