####################### lighttpd > B.005.0-armeabi-v7a Results >>> Wed Dec 31 21:24:24 BRT 1969
Senha7z="M9rkBR4Et5Zh37gYyghXQE4p0AQtwW0PAm5Xshy4vufdV9qwb9QTSqgXn5UQcj4i092Yrj"
app="lighttpd"
CpuPack="armeabi-v7a"
FileName="B.005.0-armeabi-v7a"
apkName="B.005.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.005.0-armeabi-v7a/B.005.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/lighttpd -h > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="lighttpd/1.4.56 (ssl) - a light and fast webserver"
scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/lighttpd /system/bin/lighttpd
"
excludeListPack "/data/asusbox/.install/00.snib/B.005.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
