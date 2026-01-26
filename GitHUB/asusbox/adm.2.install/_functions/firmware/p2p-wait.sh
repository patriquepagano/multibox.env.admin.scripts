function p2pWait () {
#if [ ! -f "/data/asusbox/FullInstall" ];then
	# script fica aguardando pelo arquivo para prosseguir
	FileWaitingP2P="/data/transmission/$torFile"
	/system/bin/busybox rm $FileWaitingP2P > /dev/null 2>&1
	while [ 1 ]; do
		if [ -e $FileWaitingP2P ];then break; fi;
		echo "Wait for update $torFile"
		# ShellResult=`/system/bin/transmission-remote --list`
		# echo "ADM DEBUG ### escrevendo no log web progresso do torrent"
		# echo "<h2>$ShellResult</h2>" > $bootLog 2>&1
		sleep 5;    
	done;
	echo "ADM DEBUG ### arquivo $FileWaitingP2P apagado!"
	/system/bin/busybox rm $FileWaitingP2P
#fi
}


