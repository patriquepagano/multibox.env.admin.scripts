####################### openssl > B.016.0-armeabi-v7a Results >>> Sun Nov  3 20:23:53 UTC___ 2024
Senha7z="tQaiSAQPhgAkQ7wB20ulZpHnC1EZZvb4aOGsG7m13JnhLc2ikEejmlWADKNp4fUrIBZpzk"
app="openssl"
CpuPack="armeabi-v7a"
FileName="B.016.0-armeabi-v7a"
apkName="B.016.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.016.0-armeabi-v7a/B.016.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/openssl version | cut -d " " -f 2 > /data/local/tmp/swap && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="1.1.1h"
scriptOneTimeOnly=""
excludeListPack "/data/asusbox/.install/00.snib/B.016.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
