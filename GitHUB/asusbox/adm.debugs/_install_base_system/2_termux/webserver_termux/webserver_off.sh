#!/system/bin/sh

export LD_LIBRARY_PATH=`echo $LD_LIBRARY_PATH | cut -c 2-`

echo "desligando webserver"
killall lighttpd

echo "desligando php"
pidFile="/data/data/os.tools.scriptmanager/php-pid"
if [ -e $pidFile ] ; then
PID=`cat $pidFile`
kill $PID
fi
#echo $PID
#ps | grep fpm | grep "php-fpm.conf"

