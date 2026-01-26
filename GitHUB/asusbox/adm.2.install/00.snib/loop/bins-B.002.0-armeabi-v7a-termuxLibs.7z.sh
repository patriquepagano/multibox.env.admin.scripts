####################### termuxLibs > B.002.0-armeabi-v7a Results >>> Wed Dec 31 21:24:09 BRT 1969
Senha7z="3fxgglKD03BDLwhyNOQa5uVqOIcfaAMJCXl6nAppeglwIxUW86XGt3oFvyIRq1xvypOeNz"
app="termuxLibs"
CpuPack="armeabi-v7a"
FileName="B.002.0-armeabi-v7a"
apkName="B.002.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.002.0-armeabi-v7a/B.002.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/7z -h > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 2p` && rm /data/local/tmp/swap'
versionBinOnline="7-Zip (a) [32] 17.02 : Copyright (c) 1999-2020 Igor Pavlov : 2017-08-28"
scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/lib/p7zip/7za /system/bin/7z
ln -sf /system/usr/lib/p7zip/7za /system/bin/7z.so
# esta é a lib para o firmware antigo
ln -sf /system/usr/lib/libz.so.1.2.11 /system/lib/libz.so.1
"
excludeListPack "/data/asusbox/.install/00.snib/B.002.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
