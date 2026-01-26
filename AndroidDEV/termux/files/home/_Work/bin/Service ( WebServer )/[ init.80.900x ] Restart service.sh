#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )
toolx="/system/bin/busybox"

echo "KILL by init" > "/data/trueDT/peer/TMP/init.80.900x.LOG"

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

sleep 3
ports

while [ 1 ]; do
	instance=`$toolx ps aux | $toolx grep "init.80.900x.sh" | $toolx grep -v grep | $toolx head -n 1 | $toolx awk '{print $1}'`
	if [ ! "$instance" == "" ]; then
		echo "ADM DEBUG ### fechando o processo $instance"
		$toolx kill -9 $instance
	else
		break
	fi
done




