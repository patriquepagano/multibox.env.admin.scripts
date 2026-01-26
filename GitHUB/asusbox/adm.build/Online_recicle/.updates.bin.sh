#!/system/bin/sh
function HashFile () {
rm $fileChanges/tmp.hash > /dev/null 2>&1
$md5sum "$1" | $cut -d ' ' -f1 >> $fileChanges/tmp.hash 2>&1
export HashResult=`cat $fileChanges/tmp.hash`
rm $fileChanges/tmp.hash > /dev/null 2>&1
}
function FechaAria () {
$kill -9 $($pgrep aria2c) > /dev/null 2>&1
}
package="aria"
while [ 1 ]; do
$wget -N --no-check-certificate -P $fileChanges http://personaltecnico.net/Android/AsusBOX/A1/system/asusbox/share/$package.changes.txt > $wgetLog 2>&1
if [ $? = 0 ]; then break; fi;
sleep 1;
done;
HashFile "/system/bin/aria2c"
checkNew=`$cat $fileChanges/$package.changes.txt`
if [ ! "$HashResult" = "$checkNew" ];then
echo "Atualização online disponível"
while [ 1 ]; do
/system/bin/busybox mount -o remount,rw /system
echo $HOME
FechaAria
$aria2c --allow-overwrite=true --show-console-readout=false --summary-interval=2147483647 --console-log-level=error --file-allocation=none http://45.79.48.215/asusbox/$package.7z -d $SystemShare | sed -e 's/FILE:.*//g' >> $bootLog 2>&1
if [ $? = 0 ]; then break; fi;
$sleep 1;
done;
echo "Download concluido" > $bootLog 2>&1
echo "extraindo o arquivo"
while [ 1 ]; do
cd $SystemShare
/system/bin/busybox mount -o remount,rw /system
$Zip x -y -p$Senha7z $SystemShare/$package.7z > /dev/null 2>&1
if [ $? = 0 ]; then break; fi;
$sleep 1;
done;
$chmod 755 $SystemShare/aria2c
export version=`$SystemShare/aria2c -v | head -n 1`
if [ ! "$version" = "aria2 version 1.35.0" ];then
echo "arquivo corrompido"
exit 113
fi
while [ 1 ]; do
/system/bin/busybox mount -o remount,rw /system
mv $SystemShare/aria2c /system/bin/aria2c
if [ $? = 0 ]; then break; fi;
$sleep 1;
done;
echo "Aria2c atualizado!"
fi
package="lighttpd"
while [ 1 ]; do
$wget -N --no-check-certificate -P $fileChanges http://personaltecnico.net/Android/AsusBOX/A1/system/asusbox/share/$package.changes.txt > $wgetLog 2>&1
if [ $? = 0 ]; then break; fi;
sleep 1;
done;
HashFile "/system/bin/$package"
checkNew=`$cat $fileChanges/$package.changes.txt`
if [ ! "$HashResult" = "$checkNew" ];then
echo "Atualização online disponível"
while [ 1 ]; do
/system/bin/busybox mount -o remount,rw /system
echo $HOME
FechaAria
$aria2c --allow-overwrite=true --show-console-readout=false --summary-interval=2147483647 --console-log-level=error --file-allocation=none http://45.79.48.215/asusbox/$package.7z -d $SystemShare | sed -e 's/FILE:.*//g' >> $bootLog 2>&1
if [ $? = 0 ]; then break; fi;
$sleep 1;
done;
echo "Download concluido" > $bootLog 2>&1
echo "extraindo o arquivo"
while [ 1 ]; do
cd $SystemShare
/system/bin/busybox mount -o remount,rw /system
$Zip x -y -p$Senha7z $SystemShare/$package.7z > /dev/null 2>&1
if [ $? = 0 ]; then break; fi;
$sleep 1;
done;
$chmod 755 $SystemShare/$package
export version=`$SystemShare/$package -v | head -n 1`
if [ ! "$version" = "lighttpd/1.4.29 - a light and fast webserver" ];then
echo "arquivo corrompido"
exit 113
fi
while [ 1 ]; do
$kill -9 $($pgrep lighttpd) > /dev/null 2>&1
/system/bin/busybox mount -o remount,rw /system
mv $SystemShare/lighttpd /system/bin/lighttpd
if [ $? = 0 ]; then break; fi;
$sleep 1;
done;
echo "lighttpd atualizado!"
fi
package="php-cgi"
while [ 1 ]; do
$wget -N --no-check-certificate -P $fileChanges http://personaltecnico.net/Android/AsusBOX/A1/system/asusbox/share/$package.changes.txt > $wgetLog 2>&1
if [ $? = 0 ]; then break; fi;
sleep 1;
done;
HashFile "/system/bin/$package"
checkNew=`$cat $fileChanges/$package.changes.txt`
if [ ! "$HashResult" = "$checkNew" ];then
echo "Atualização online disponível"
while [ 1 ]; do
/system/bin/busybox mount -o remount,rw /system
echo $HOME
FechaAria
$aria2c --allow-overwrite=true --show-console-readout=false --summary-interval=2147483647 --console-log-level=error --file-allocation=none http://45.79.48.215/asusbox/$package.7z -d $SystemShare | sed -e 's/FILE:.*//g' >> $bootLog 2>&1
if [ $? = 0 ]; then break; fi;
$sleep 1;
done;
echo "Download concluido" > $bootLog 2>&1
echo "extraindo o arquivo"
while [ 1 ]; do
cd $SystemShare
/system/bin/busybox mount -o remount,rw /system
$Zip x -y -p$Senha7z $SystemShare/$package.7z > /dev/null 2>&1
if [ $? = 0 ]; then break; fi;
$sleep 1;
done;
$chmod 755 $SystemShare/$package
export version=`$SystemShare/php-cgi -v | head -n 1`
if [ ! "$version" = "PHP 5.4.2 (cgi-fcgi) (built: May  7 2012 23:21:15)" ];then
echo "arquivo corrompido"
exit 113
fi
while [ 1 ]; do
$kill -9 $($pgrep php-cgi) > /dev/null 2>&1
/system/bin/busybox mount -o remount,rw /system
mv $SystemShare/$package /system/bin/$package
if [ $? = 0 ]; then break; fi;
$sleep 1;
done;
echo "$package atualizado!"
fi
rm $wgetLog
