#!/system/bin/sh
function HashFolder () {
rm $fileChanges/tmp.hash > /dev/null 2>&1
$find $1 -type f \( -iname \*.webp -o -iname \*.jpg -o -iname \*.png -o -iname \*.php -o -iname \*.html -o -iname \*.js -o -iname \*.css \) | $sort | while read fname; do
$md5sum "$fname" | $cut -d ' ' -f1 >> $fileChanges/tmp.hash 2>&1
done
export HashResult=`cat $fileChanges/tmp.hash`
rm $fileChanges/tmp.hash > /dev/null 2>&1
}
function FechaAria () {
$kill -9 $($pgrep aria2c) > /dev/null 2>&1
}
$rm -rf $wwwup
package=".img.launcher"
while [ 1 ]; do
$wget -N --no-check-certificate -P $fileChanges http://personaltecnico.net/Android/AsusBOX/A1/system/asusbox/share/$package.changes.txt > $wgetLog 2>&1
if [ $? = 0 ]; then break; fi;
sleep 1;
done;
HashFolder "$www/$package"
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
$mkdir -p $wwwup
echo "extraindo o arquivo"
while [ 1 ]; do
cd $wwwup
$Zip x -y -p$Senha7z $SystemShare/$package.7z > /dev/null 2>&1
if [ $? = 0 ]; then break; fi;
$sleep 1;
done;
echo "rsync files"
while [ 1 ]; do
$rsync --progress -hv --delete --recursive --force $wwwup/$package/ $www/$package/
if [ $? = 0 ]; then break; fi;
$sleep 1;
done;
$rm -rf $wwwup
fi
package=".index.static"
while [ 1 ]; do
$wget -N --no-check-certificate -P $fileChanges http://personaltecnico.net/Android/AsusBOX/A1/system/asusbox/share/$package.changes.txt > $wgetLog 2>&1
if [ $? = 0 ]; then break; fi;
sleep 1;
done;
HashFolder "$www/$package"
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
$mkdir -p $wwwup
echo "extraindo o arquivo"
while [ 1 ]; do
cd $wwwup
$Zip x -y -p$Senha7z $SystemShare/$package.7z > /dev/null 2>&1
if [ $? = 0 ]; then break; fi;
$sleep 1;
done;
echo "rsync files"
while [ 1 ]; do
$rsync --progress -hv --delete --recursive --force $wwwup/$package/ $www/$package/
if [ $? = 0 ]; then break; fi;
$sleep 1;
done;
$rm -rf $wwwup
fi
package=".code"
while [ 1 ]; do
$wget -N --no-check-certificate -P $fileChanges http://personaltecnico.net/Android/AsusBOX/A1/system/asusbox/share/$package.changes.txt > $wgetLog 2>&1
if [ $? = 0 ]; then break; fi;
sleep 1;
done;
HashFolder "$www/$package"
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
$mkdir -p $wwwup
echo "extraindo o arquivo"
while [ 1 ]; do
cd $wwwup
$Zip x -y -p$Senha7z $SystemShare/$package.7z > /dev/null 2>&1
if [ $? = 0 ]; then break; fi;
$sleep 1;
done;
echo "rsync files"
while [ 1 ]; do
$rsync --progress -hv --delete --recursive --force $wwwup/$package/ $www/$package/
if [ $? = 0 ]; then break; fi;
$sleep 1;
done;
$rm -rf $wwwup
fi
rm $wgetLog
