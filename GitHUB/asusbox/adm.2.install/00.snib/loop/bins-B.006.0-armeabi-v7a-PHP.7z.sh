####################### PHP > B.006.0-armeabi-v7a Results >>> Wed Dec 31 21:25:26 BRT 1969
Senha7z="6jH058EnMppKHbWvUB7nbNMxtAYigIKr7Xv9XWA7oi0AotUcY3SWJqRP1dZlsbUno7a4CB"
app="PHP"
CpuPack="armeabi-v7a"
FileName="B.006.0-armeabi-v7a"
apkName="B.006.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.006.0-armeabi-v7a/B.006.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/php-cgi --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="PHP 8.0.0 (cgi-fcgi) (built: Dec  6 2020 20:57:33)"
scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/php-cgi /system/bin/php-cgi
"
excludeListPack "/data/asusbox/.install/00.snib/B.006.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
