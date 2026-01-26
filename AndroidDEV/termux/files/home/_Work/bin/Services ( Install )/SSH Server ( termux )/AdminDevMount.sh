#!/system/bin/sh
export TZ=UTC−03:00

Log="/data/trueDT/peer/TMP/init.SshServer.LOG"
if [ ! -d "/data/trueDT/peer/TMP" ]; then
	mkdir -p "/data/trueDT/peer/TMP"
fi

export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin

echo "ADM DEBUG ##########################################################################################" > "$Log"
echo "ADM DEBUG ### $(busybox date +%s) => $(busybox date +"%d/%m/%Y %H:%M:%S") | cat uptime $(busybox cat /proc/uptime | busybox cut -d " " -f 2 | busybox cut -d "." -f 1)" >> "$Log"
echo "ADM DEBUG ### Boot Script > SSH Server Dev" >> "$Log"

checkUptime=`busybox cat /proc/uptime | busybox cut -d " " -f 2 | busybox cut -d "." -f 1`
if [ "$checkUptime" -le "100" ]; then
	echo "ADM DEBUG ### sleep 60 uptime => $(busybox date +"%d/%m/%Y %H:%M:%S") | cat uptime $(busybox cat /proc/uptime | busybox cut -d " " -f 2 | busybox cut -d "." -f 1)" >> "$Log"
	sleep 60
fi

# Wait for qlq pendrive com este rotulo
echo "ADM DEBUG ########################################################" >> "$Log"
echo "ADM DEBUG ### Wait ThumbDriveDEV. uptime: $(busybox cat /proc/uptime | busybox cut -d " " -f 2 | busybox cut -d "." -f 1)" >> "$Log"
while true; do
    check=`busybox blkid | busybox grep "ThumbDriveDEV" | busybox head -n 1 | busybox cut -d "=" -f 2 | busybox cut -d '"' -f 2`
    if [ "$check" == "ThumbDriveDEV" ]; then
		echo "ADM DEBUG ### ThumbDriveDEV Conectado. uptime: $(busybox cat /proc/uptime | busybox cut -d " " -f 2 | busybox cut -d "." -f 1)" >> "$Log"
        break
    fi
    sleep 1
done

function ThumbDriveDEV () {
# testar se esta montado
FolderPath="/storage/DevMount"
check=`busybox mount | busybox grep "$FolderPath"`
if [ "$check" == "" ]; then
	if [ ! -d $FolderPath ] ; then
		mkdir -p $FolderPath
		chmod 700 $FolderPath
	fi
	echo "ADM DEBUG ########################################################" >> "$Log"
	echo "ADM DEBUG ### umount $FolderPath" >> "$Log"
	busybox umount $FolderPath > /dev/null 2>&1

	echo "ADM DEBUG ### mount -t ext4 LABEL="ThumbDriveDEV" $FolderPath" >> "$Log"
	busybox mount -t ext4 LABEL="ThumbDriveDEV" $FolderPath
fi

# verifica se o dono dos arquivos é o root
check="$(ls -l "/storage/DevMount/AndroidDEV/termux/files" | busybox grep "root" | busybox head -n 1 | busybox awk '{print $4}' | busybox tr -d '\n')"
if [ ! "$check" == "root" ]; then
	echo "ADM DEBUG ### ssh kill server" >> "$Log"
	while [ 1 ]; do
		instance=`/system/bin/busybox ps aux | busybox grep "4399" | busybox grep -v grep | busybox head -n 1 | busybox awk '{print $1}'`
		if [ ! "$instance" == "" ]; then
			echo "ADM DEBUG ### fechando o processo $instance"
			busybox kill -9 $instance
		else
			break
		fi
	done

	echo "ADM DEBUG ### Fix permission 1023 to root [ chown root:root -R /storage/DevMount/ ]" >> "$Log"
	busybox chown root:root -R "/storage/DevMount/"
fi

if [ -f /system/.pin ];then
	echo "ADM DEBUG ### Remove o bloqueio root" >> "$Log"
	busybox mount -o remount,rw /system
	rm /system/.pin
fi

# testar se symlink ta correto
if [ ! -f /data/data/com.termux/files/usr/bin/sshd ]; then
	# maneira mais facil de manter funcionando com sincronia descomplicada
	# para funcionar a aba lateral sftp no mobaxterm a pasta HOME não pode ser symlink
	echo "ADM DEBUG ### Termux Symlinks" >> "$Log"
	rm -rf /data/data/com.termux
	mkdir -p /data/data/com.termux/files
	ln -sf "/storage/DevMount/AndroidDEV/termux/files/home" "/data/data/com.termux/files/home"
	ln -sf "/storage/DevMount/AndroidDEV/termux/files/usr" "/data/data/com.termux/files/usr"

	echo "ADM DEBUG ### git" >> "$Log"
	ln -sf /data/data/com.termux/files/usr/bin/git /system/bin/git
	echo "ADM DEBUG ### SHC" >> "$Log"
	ln -sf /data/data/com.termux/files/usr/bin/shc /system/bin/shc
	ln -sf /data/data/com.termux/files/usr/bin/clang-10 /system/bin/cc
	ln -sf /data/data/com.termux/files/usr/bin/strip /system/bin/strip
	# SSH Server ( todas as envs apareceram sem precisar fixar aqui abaixo )
	# novas variaveis fixar dentro do .bashrc
	echo "ADM DEBUG ########################################################" >> "$Log"
	echo "ADM DEBUG ### Ativando symlink folder pack P2P" >> "$Log"
	rm /data/asusbox/.install > /dev/null 2>&1    
	busybox ln -sf $FolderPath/asusbox/.install /data/asusbox/
fi

}

function startSSHserver () {	
	echo "ADM DEBUG ########################################################" >> "$Log"
	echo "ADM DEBUG ### FN startSSHserver" >> "$Log"
	config="/data/data/com.termux/files/usr/etc/ssh/sshd_config"
	key="/data/data/com.termux/files/usr/etc/ssh/ssh_host_rsa_key"
	#su -c /data/data/com.termux/files/usr/bin/sshd -p 4399 -f "$config" -h "$key"
	/data/data/com.termux/files/usr/bin/sshd -p 4399 -f "$config" -h "$key"
	echo "ADM DEBUG ### $(busybox date +%s) => $(busybox date +"%d/%m/%Y %H:%M:%S") | cat uptime $(busybox cat /proc/uptime | busybox cut -d " " -f 2 | busybox cut -d "." -f 1)" >> "$Log"
	echo "ADM DEBUG ### SSH server started!" >> "$Log"
}

echo "ADM DEBUG ########################################################" >> "$Log"
echo "ADM DEBUG ### Infinite while loop check ssh service. uptime: $(busybox cat /proc/uptime | busybox cut -d " " -f 2 | busybox cut -d "." -f 1)" >> "$Log"
while [ 1 ]; do
	ThumbDriveDEV
	Pids=$(busybox ps aux | busybox grep "4399" | busybox grep -v grep | busybox awk '{print $1}' | busybox head -n 1)
	if [ "$Pids" == "" ]; then
		# chama a função start do ssh server		
		startSSHserver
		echo "ADM DEBUG ### End Loop Pid $(busybox date +"%d/%m/%Y %H:%M:%S") | cat uptime $(busybox cat /proc/uptime | busybox cut -d " " -f 2 | busybox cut -d "." -f 1)" >> "$Log"
		sleep 7
	fi
	# echo "ADM DEBUG ### While loop check PID $(busybox date +"%d/%m/%Y %H:%M:%S") | cat uptime $(busybox cat /proc/uptime | busybox cut -d " " -f 2 | busybox cut -d "." -f 1)" >> "$Log"
	# echo "ADM DEBUG ### $Pids" >> "$Log"
	Pids=""
	sleep 60
done

