#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )

echo "off" > /data/trueDT/peer/TMP/init.21027.DISABLED


echo "KILL by init" > "/data/trueDT/peer/TMP/init.21027.LOG"

toolx="/system/bin/busybox"

cat "/data/trueDT/peer/config/config.xml" | grep "127.0.0.1" | cut -d ":" -f 2 | cut -d "<" -f 1

$toolx ps aux | grep "initRc.drv.05" | $toolx grep -v grep

#if [ ! "$($toolx ps aux | grep "initRc.drv.05" | $toolx grep -v grep)" == "" ]; then
if [ "$($toolx busybox netstat -ntlup | grep 4442)" == "" ]; then
    echo "esta rodando"
else
    echo "não esta rodando"
fi

while [ 1 ]; do
	instance=`$toolx ps aux | $toolx grep "init.21027.sh" | $toolx grep -v grep | $toolx head -n 1 | $toolx awk '{print $1}'`
	if [ ! "$instance" == "" ]; then
		echo "ADM DEBUG ### fechando o processo $instance"
		$toolx kill -9 $instance
	else
		break
	fi
done




