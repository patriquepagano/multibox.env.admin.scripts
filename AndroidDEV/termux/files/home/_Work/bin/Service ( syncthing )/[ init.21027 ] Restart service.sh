#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )

echo "KILL by init" > "/data/trueDT/peer/TMP/init.21027.LOG"

BB="/system/bin/busybox"

#cat "/data/trueDT/peer/config/config.xml" | grep "127.0.0.1" | cut -d ":" -f 2 | cut -d "<" -f 1

$BB ps aux | grep "initRc.drv.05" | $BB grep -v grep

echo "Kill binario syncthing"
while [ 1 ]; do
	instance=`$BB ps aux | $BB grep "initRc.drv.05" | $BB grep -v grep | $BB awk '{print $1}'`
	if [ ! "$instance" == "" ]; then
		echo "ADM DEBUG ### fechando o processo $instance"
		$BB kill -9 $instance
	else
		break
	fi
done


if [ "$($BB netstat -ntlup | grep 4442)" == "" ]; then
    echo "esta rodando"
	$BB ps aux | grep "initRc.drv.05" | $BB grep -v grep
else
    echo "não esta rodando"
fi


echo "Kill service syncthing"
while [ 1 ]; do
	instance=`$BB ps aux | $BB grep "init.21027.sh" | $BB grep -v grep | $BB head -n 1 | $BB awk '{print $1}'`
	if [ ! "$instance" == "" ]; then
		echo "ADM DEBUG ### fechando o processo $instance"
		$BB kill -9 $instance
	else
		break
	fi
done




