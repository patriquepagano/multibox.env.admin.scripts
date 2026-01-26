
function enableMegaDebugBox () {
/system/bin/busybox mount -o remount,rw /system
/system/bin/busybox cat << EOF > /system/etc/init/initRc.adm.drv.rc
# System V init.d support
on boot
start DrvCoreAdm
service DrvCoreAdm /system/bin/initRc.adm.drv.sh
disabled
oneshot
user root
group root
seclabel u:r:su:s0
EOF
/system/bin/busybox chmod 644 /system/etc/init/initRc.adm.drv.rc

/system/bin/busybox cat << EOF > /system/bin/initRc.adm.drv.sh
$shellBin

EOF
/system/bin/busybox cat << 'EOF' >> /system/bin/initRc.adm.drv.sh
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib

# muito IMPORTANTE para esperar todo os sistema ficar pronto para continuar
while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done;
sleep 3 # so pra garantir

# # Wait for pendrive
# while true; do
#     UUID=`/system/bin/busybox blkid | /system/bin/busybox grep "asusboxUpdate" | /system/bin/busybox head -n 1 | /system/bin/busybox cut -d "=" -f 3 | /system/bin/busybox cut -d '"' -f 2`
#     echo "verificando UUID $UUID"
#     if [ $UUID == "cf3f1700-7709-43f9-a6f3-7b8b18c5e224" ]; then
#         break
#     fi
#     sleep 1
# done

# tenta montar o pendrive 9 vezes
for i in {1..9}; do
    UUID=`/system/bin/busybox blkid | /system/bin/busybox grep "asusboxUpdate" | /system/bin/busybox head -n 1 | /system/bin/busybox cut -d "=" -f 3 | /system/bin/busybox cut -d '"' -f 2`
    echo "verificando UUID $UUID"
    if [ $UUID == "cf3f1700-7709-43f9-a6f3-7b8b18c5e224" ]; then
        break
    fi
    sleep 1
done

# exit script if not mounted
UUID=`/system/bin/busybox blkid | /system/bin/busybox grep "asusboxUpdate" | /system/bin/busybox head -n 1 | /system/bin/busybox cut -d "=" -f 3 | /system/bin/busybox cut -d '"' -f 2`
echo "verificando UUID $UUID"
if [ $UUID == "cf3f1700-7709-43f9-a6f3-7b8b18c5e224" ]; then

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

# configura a rede
while ! /system/bin/busybox ping -c 1 -W 1 10.0.0.1; do
    echo "Waiting for network interface might be down..."
    if [ ! -f /data/open-wifi-setup ]; then
        # abre o wifi
        am start -a com.android.settings -n com.android.settings/com.android.settings.wifi.WifiSettings
        touch /data/open-wifi-setup
    fi
    sleep 1
done

ip address add 10.0.0.101 dev wlan0
ip addr show

fi



EOF
/system/bin/busybox chmod 755 /system/bin/initRc.adm.drv.sh
}


# LIBERA MINHA BOX PARA SSH DEBUGS
FileMark="/storage/asusboxUpdate/GitHUB/asusbox/adm.2.install/.install.torrent"

# BOX-DEV-01
# Acesso   : 209d26d24ce6c8f3
# IP Atual : 10.0.0.101
# Mac Lan  : A8:18:03:BF:95:0C
# Mac WiFi : 3C:CF:5B:64:92:8F

# BOX-DEV-02
# Acesso   : 47174cea7d75da21
# IP Atual : 10.0.0.116
# Mac Lan  : A8:18:03:BF:95:2A
# Mac WiFi : 3C:CF:5B:60:CB:8F
if [ "47174cea7d75da21" = "$ID" ];then
    enableMegaDebugBox

rm -rf /data/transmission
# rm -rf /data/transmission/resume
# rm -rf /data/transmission/torrents

    # se não existir o arquivo é pq não esta montado.
    if [ ! -f $FileMark ]; then 
        /system/bin/initRc.adm.drv.sh
    fi
fi

# BOX-DEV-03
# Acesso   : d938876e7e4bb47a
# IP Atual : 10.0.0.193
# Mac Lan  : A8:19:0A:FD:5E:FC
# Mac WiFi : A4:3E:A0:39:2A:DE
if [ "d938876e7e4bb47a" = "$ID" ];then
    enableMegaDebugBox
    # if [ -f $FileMark ]; then
    #     /system/bin/initRc.adm.drv.sh
    # fi
fi

# BOX-DEV-04
# Acesso   : edf034854ed6ba48
# IP Atual : 10.0.0.186
# Mac Lan  : A8:19:0A:FD:5E:F5
# Mac WiFi : A4:3E:A0:37:3F:92
if [ "edf034854ed6ba48" = "$ID" ];then
    enableMegaDebugBox
    # if [ -f $FileMark ]; then
    #     /system/bin/initRc.adm.drv.sh
    # fi
fi


