#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear
Log="/data/trueDT/peer/TMP/init.p2p.LOG"
toolx="/system/bin/busybox"

$toolx ps aux | $toolx grep "init.p2p.sh" | $toolx grep -v grep | $toolx head -n 1 | $toolx awk '{print $1}'

rm -rf /data/trueDT/Torrents
rm /data/trueDT/peer/TMP/init.p2p.DISABLED
touch /data/trueDT/peer/TMP/init.p2p.DISABLED


while [ 1 ]; do
    # /system/bin/transmission-remote --exit
    # killall transmission-daemon
	instance=`$toolx ps aux | $toolx grep "transmission" | $toolx grep -v grep | $toolx head -n 1 | $toolx awk '{print $1}'`
	if [ ! "$instance" == "" ]; then
		echo "ADM DEBUG ### fechando o binario $instance"
		$toolx kill -9 $instance
	else
		break
	fi
done

while [ 1 ]; do
	instance=`$toolx ps aux | $toolx grep "init.p2p.sh" | $toolx grep -v grep | $toolx head -n 1 | $toolx awk '{print $1}'`
	if [ ! "$instance" == "" ]; then
		echo "ADM DEBUG ### fechando o init script $instance"
		$toolx kill -9 $instance
	else
		break
	fi
done


