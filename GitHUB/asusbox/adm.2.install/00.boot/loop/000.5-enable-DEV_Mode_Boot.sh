

# start do ssh server build Box master dev dos russos magneticos
# verifica o rotulo do pendrive
check=`busybox blkid | busybox grep "ThumbDriveDEV" | busybox head -n 1 | busybox cut -d "=" -f 2 | busybox cut -d '"' -f 2`
if [ "$check" == "ThumbDriveDEV" ]; then
	FolderPath="/storage/DevMount"
	if [ ! -d "$FolderPath" ] ; then
		mkdir -p "$FolderPath"
		chmod 700 "$FolderPath"
	fi
	# montando o device
	#busybox umount "$FolderPath" > /dev/null 2>&1
	check=`busybox mount | busybox grep "$FolderPath"`
	if [ "$check" == "" ]; then
		echo "ADM DEBUG ########################################################"
		echo "ADM DEBUG ### $FolderPath MONTANDO como pasta DEV Scripts GitHub"
		busybox mount -t ext4 LABEL="ThumbDriveDEV" "$FolderPath"
	fi
	# verificando se tem o arquivo para chamar o instalado
	key="/storage/DevMount/AndroidDEV/termux/files/usr/etc/ssh/ssh_host_rsa_key"
	check=`md5sum $key | busybox cut -d ' ' -f1`
	if [ "$check" == "a76e7b8ccf1edd37f618b720c322a784" ]; then
		sh "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/Services ( Install )/SSH Server ( termux )/Install.sh"
		while [ 1 ]; do
			instance=`busybox ps aux | busybox grep "AdminDevMount.sh" | busybox grep -v grep | busybox head -n 1 | busybox awk '{print $1}'`
			if [ "$instance" == "" ]; then				
				/system/bin/AdminDevMount.sh &
				echo "ADM DEBUG ### ssh server Iniciado"
				break
			else
				echo "ADM DEBUG ### fechando o processo $instance"
				busybox kill -9 $instance
			fi
		done
	fi
fi







