#!/system/bin/sh
export TZ=UTC−03:00
export toolx="/system/bin/busybox"
Log="/data/trueDT/peer/TMP/init.80.900x.LOG"
if [ ! -d "/data/trueDT/peer/TMP" ]; then
	mkdir -p "/data/trueDT/peer/TMP"
fi

function .ClearLog () {
	# adicionar aqui o codigo se o arquivo de log crescer muito para apagar..
	checkSize=`$toolx du "$Log" | $toolx awk '{print $1}'`
	if [ "$checkSize" -gt "50" ]; then
		echo "User Warn = Log Cleanner" > "$Log"
	fi
}

export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin

echo "ADM DEBUG ##########################################################################################" > "$Log"
echo "ADM DEBUG ### $(busybox date +%s) => $(busybox date +"%d/%m/%Y %H:%M:%S") | cat uptime $(busybox cat /proc/uptime | busybox cut -d " " -f 2 | busybox cut -d "." -f 1)" >> "$Log"
echo "ADM DEBUG ### Starting > init.80.900x" >> "$Log"

while [ 1 ]; do
	.ClearLog
	# loop do bloqueio do serviço
	while [ 1 ]; do
		if [ -f /data/trueDT/peer/TMP/init.80.900x.DISABLED ]; then
			.ClearLog
			php=`$toolx ps aux | $toolx grep "php-cgi" | $toolx grep -v grep | $toolx awk '{print $1}'`
			for port in $php; do
				$toolx kill -9 $port
			done
			lighttpd=`$toolx ps aux | $toolx grep "lighttpd" | $toolx grep -v grep | $toolx awk '{print $1}'`
			for port in $lighttpd; do
				$toolx kill -9 $port
			done
			echo "ADM DEBUG ########################################################" >> "$Log"
			echo "ADM DEBUG ### webserver desativado" >> "$Log"
			echo "ADM DEBUG ### $($toolx date +%s) => $($toolx date +"%d/%m/%Y %H:%M:%S") | cat uptime $($toolx cat /proc/uptime | $toolx cut -d " " -f 2 | $toolx cut -d "." -f 1)" >> "$Log"
			sleep 7
		else
			break
		fi
	done
	while [ 1 ]; do
		if [ -f "/data/asusbox/.sc/OnLine/.w.conf/.80.9001.sh" ];then break; fi;
		echo "ADM DEBUG ##########################################################################################" >> "$Log"
		echo "ADM DEBUG ### $(busybox date +%s) => $(busybox date +"%d/%m/%Y %H:%M:%S") | cat uptime $(busybox cat /proc/uptime | busybox cut -d " " -f 2 | busybox cut -d "." -f 1)" >> "$Log"
		echo "ADM DEBUG ### Wait install Webserver components" >> "$Log"
		sleep 5;    
	done;
	lighttpd=`busybox ps aux | grep "lighttpd" | busybox grep -v grep | busybox head -n 1 | busybox awk '{print $1}'`
	if [ "$lighttpd" == "" ]; then
		echo "ADM DEBUG ##########################################################################################" >> "$Log"
		echo "ADM DEBUG ### lighttpd service is offline" >> "$Log"
		ResetWebService="YES"
	fi
	php=`busybox ps aux | grep "php-cgi" | busybox grep -v grep | busybox head -n 1 | busybox awk '{print $1}'`
	if [ "$php" == "" ]; then
		echo "ADM DEBUG ##########################################################################################" >> "$Log"
		echo "ADM DEBUG ### php service is offline" >> "$Log"
		ResetWebService="YES"
	fi
	if [ "$ResetWebService" == "YES" ]; then
		ResetWebService="NO"
		echo "ADM DEBUG ##########################################################################################" >> "$Log"
		echo "ADM DEBUG ### $(busybox date +%s) => $(busybox date +"%d/%m/%Y %H:%M:%S") | cat uptime $(busybox cat /proc/uptime | busybox cut -d " " -f 2 | busybox cut -d "." -f 1)" >> "$Log"
		echo "ADM DEBUG ### Starting Webserver" >> "$Log"		
		while [ 1 ]; do
			instance=`$toolx ps aux | $toolx grep "php-cgi" | $toolx grep -v grep | $toolx awk '{print $1}'`
			if [ ! "$instance" == "" ]; then
				echo "ADM DEBUG ### fechando o processo $instance"
				$toolx kill -9 $instance
			else
				break
			fi
		done
		while [ 1 ]; do
			instance=`$toolx ps aux | $toolx grep "lighttpd" | $toolx grep -v grep | $toolx awk '{print $1}'`
			if [ ! "$instance" == "" ]; then
				echo "ADM DEBUG ### fechando o processo $instance"
				$toolx kill -9 $instance
			else
				break
			fi
		done
		/data/asusbox/.sc/OnLine/.w.conf/.80.9001.sh
	fi
	sleep 60
done



