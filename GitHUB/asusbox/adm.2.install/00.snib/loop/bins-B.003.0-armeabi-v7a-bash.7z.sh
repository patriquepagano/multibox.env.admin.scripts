####################### bash > B.003.0-armeabi-v7a Results >>> Wed Dec 31 21:24:14 BRT 1969
Senha7z="1Z5K1egIUI0UbiVI3QaaDMzgM0uzd5K2T8PeOW9j9cV36LhrghsRSHbisl2h1bVjhHM3Qk"
app="bash"
CpuPack="armeabi-v7a"
FileName="B.003.0-armeabi-v7a"
apkName="B.003.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.003.0-armeabi-v7a/B.003.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/bash -version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="GNU bash, version 5.1.0(1)-release (arm-unknown-linux-androideabi)"
scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/bash /system/bin/bash
"
excludeListPack "/data/asusbox/.install/00.snib/B.003.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
