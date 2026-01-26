#!/system/bin/sh
clear

# limpando arquivo temporario
/system/bin/busybox find "/storage/DevMount/AndroidDEV/termux/files/usr/tmp/" -maxdepth 1 \
-type f -name "tr_session_id_*" \
| sort | while read fname; do
echo "del > $fname"
rm "$fname"
done

ssh="/data/data/com.termux/files/usr/bin/ssh"
sshpass="/data/data/com.termux/files/usr/bin/sshpass"
rsync="/data/data/com.termux/files/usr/bin/rsync"
IP="10.0.0.113"
user="root"
pass="admin"

# copia os apks para minha vm linux
$sshpass -p $pass \
$rsync --progress \
-avz \
--delete \
--recursive \
--exclude 'lost+found' \
--exclude 'Android' \
--exclude 'TWRP' \
-e "$ssh -o 'StrictHostKeyChecking no' -oKexAlgorithms=+diffie-hellman-group1-sha1" \
"/storage/DevMount/" \
$user@$IP:"/storage/DevMount/"



exit





rm -rf /data/data/com.termux/files
mkdir -p /data/data/com.termux/files
ln -sf "/storage/DevMount/AndroidDEV/termux/files/home" "/data/data/com.termux/files/home"
ln -sf "/storage/DevMount/AndroidDEV/termux/files/usr" "/data/data/com.termux/files/usr"


# para sincronizar primeiro precisa montar com o sshdroid para todos arquivos estarem desmontados ex. ~/.ssh
mkdir /storage/DevMount
chmod 777 /storage/DevMount
/system/bin/busybox mount -t ext4 LABEL="ThumbDriveDEV" /storage/DevMount












# start do ssh server build Box master dev dos russos magneticos
# verifica o rotulo do pendrive
check=`/system/bin/busybox blkid | /system/bin/busybox grep "ThumbDriveDEV" | /system/bin/busybox head -n 1 | /system/bin/busybox cut -d "=" -f 2 | /system/bin/busybox cut -d '"' -f 2`
if [ "$check" == "ThumbDriveDEV" ]; then
	FolderPath="/storage/DevMount"
	if [ ! -d "$FolderPath" ] ; then
		mkdir -p "$FolderPath"
		chmod 700 "$FolderPath"
	fi
	# montando o device
	/system/bin/busybox umount "$FolderPath" > /dev/null 2>&1  
	/system/bin/busybox mount -t ext4 LABEL="ThumbDriveDEV" "$FolderPath"
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












