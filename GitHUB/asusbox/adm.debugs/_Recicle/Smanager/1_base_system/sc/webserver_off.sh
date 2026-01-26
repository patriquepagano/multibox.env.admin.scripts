#!/system/bin/sh

LDFIX=`echo "$LD_LIBRARY_PATH" | cut -c1-1`
if [ "$LDFIX" == ":" ] ; then
	export LD_LIBRARY_PATH=`echo "$LD_LIBRARY_PATH" | cut -c 2-`
fi

echo "desligando webserver"
kill -9 $(pgrep lighttpd) > /dev/null 2>&1

echo "desligando php"
kill -9 $(pgrep php-cgi) > /dev/null 2>&1