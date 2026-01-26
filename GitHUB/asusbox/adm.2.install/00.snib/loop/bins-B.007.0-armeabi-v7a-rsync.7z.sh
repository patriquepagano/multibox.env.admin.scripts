####################### rsync > B.007.0-armeabi-v7a Results >>> Wed Dec 31 21:25:31 BRT 1969
Senha7z="53F7cWQEUJx1zfRoAhjjoj5XmXePcJqM8RdwOqfu1ldjvxIW6PzBe6wRNcAYC0p71d3OG2"
app="rsync"
CpuPack="armeabi-v7a"
FileName="B.007.0-armeabi-v7a"
apkName="B.007.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.007.0-armeabi-v7a/B.007.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/rsync --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="rsync  version 3.2.3  protocol version 31"
scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/rsync /system/bin/rsync
ln -sf /system/usr/bin/rsync-ssl /system/bin/rsync-ssl
"
excludeListPack "/data/asusbox/.install/00.snib/B.007.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
