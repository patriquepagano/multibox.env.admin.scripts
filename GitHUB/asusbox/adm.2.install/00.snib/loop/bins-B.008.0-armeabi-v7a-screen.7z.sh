####################### screen > B.008.0-armeabi-v7a Results >>> Wed Dec 31 21:25:36 BRT 1969
Senha7z="Qfl5U522d4fVAktW6IWii7GhTUadyyQlWrPhfF4Dp4tCmeFK4QXODAdnvqMFmhOhEUZpFL"
app="screen"
CpuPack="armeabi-v7a"
FileName="B.008.0-armeabi-v7a"
apkName="B.008.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.008.0-armeabi-v7a/B.008.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/screen --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="Screen version 4.08.00 (GNU) 05-Feb-20"
scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/screen /system/bin/screen
"
excludeListPack "/data/asusbox/.install/00.snib/B.008.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
