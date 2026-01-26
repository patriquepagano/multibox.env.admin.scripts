####################### transmission > B.009.0-armeabi-v7a Results >>> Wed Dec 31 21:25:52 BRT 1969
Senha7z="Fhwa9h9Pf2f6290lhPrVrptLjl5QrhHFqZlNAfPHUIUaAzYj3VzvoaU1M37FR4r1gv4h4h"
app="transmission"
CpuPack="armeabi-v7a"
FileName="B.009.0-armeabi-v7a"
apkName="B.009.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.009.0-armeabi-v7a/B.009.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/transmission-remote -V > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="transmission-remote 3.00 (bb6b5a062e)"
scriptOneTimeOnly="
# Fix dos symlinks
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/transmission-create /system/bin/
ln -sf /system/usr/bin/transmission-remote /system/bin/
ln -sf /system/usr/bin/transmission-edit /system/bin/
ln -sf /system/usr/bin/transmission-show /system/bin/
ln -sf /system/usr/bin/transmission-daemon /system/bin/
"
excludeListPack "/data/asusbox/.install/00.snib/B.009.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
