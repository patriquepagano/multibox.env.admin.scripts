
/system/bin/busybox




/system/xbin/busybox mount -o remount,rw /system
cp /system/xbin/busybox /system/bin/busybox




#   /system/bin/busybox tune2fs -L ThumbDriveDEV /dev/block/sda1



# start do ssh server build Box master dev dos russos magneticos
# verifica o rotulo do pendrive
check=`/system/bin/busybox blkid | /system/bin/busybox grep "ThumbDriveDEV" | /system/bin/busybox head -n 1 | /system/bin/busybox cut -d "=" -f 2 | /system/bin/busybox cut -d '"' -f 2`
if [ "$check" == "ThumbDriveDEV" ]; then
	if [ ! -d "/storage/DevMount" ] ; then
		mkdir -p "/storage/DevMount"
		chmod 700 "/storage/DevMount"
	fi
	# montando o device
	/system/bin/busybox umount "/storage/DevMount" > /dev/null 2>&1  
	/system/bin/busybox mount -t ext4 LABEL="ThumbDriveDEV" "/storage/DevMount"
	/system/bin/busybox chown root:root -R "/storage/DevMount/"
	# verificando se tem o arquivo para chamar o instalado
	key="/storage/DevMount/AndroidDEV/termux/files/usr/etc/ssh/ssh_host_rsa_key"
	check=`md5sum $key | /system/bin/busybox cut -d ' ' -f1`
	if [ "$check" == "a76e7b8ccf1edd37f618b720c322a784" ]; then
		sh "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.install/Install Termux Openssh Git.sh"
		check=`netstat -ntlup | grep 0.0.0.0:4399`
		if [ "$check" == "" ]; then
			/system/bin/AdminDevMount.sh
		fi
	fi
fi













# Ativar direto no boot
/system/bin/busybox mount -o remount,rw /system


mkdir /storage/DevMount
chmod 777 /storage/DevMount
/system/bin/busybox mount -t ext4 UUID="f3d594de-da82-584b-8757-44cbb3744182" /storage/DevMount

mkdir -p /data/data/com.termux
ln -sf /storage/DevMount/AndroidDEV/termux/files /data/data/com.termux/

mkdir -p /data/asusbox
ln -sf /storage/DevMount/asusbox/.install /data/asusbox/




# SSH Server
export PWD="/storage/DevMount/GitHUB/asusbox/"
export HOME="/storage/DevMount/GitHUB/asusbox/"

export PWD="/storage/DevMount/AndroidDEV/termux/files/home"
export HOME="/data/data/com.termux/files/home"
export SHELL=/system/bin/sh
export TERM=xterm
chown root:root -R /data/data/com.termux/files/home
config="/data/data/com.termux/files/usr/etc/ssh/sshd_config"
key="/data/data/com.termux/files/usr/etc/ssh/ssh_host_rsa_key"
su -c /data/data/com.termux/files/usr/bin/sshd -p 4399 -f $config -h $key





PWD=/storage/DevMount/AndroidDEV/termux/files/home
HOME=/data/data/com.termux/files/home




