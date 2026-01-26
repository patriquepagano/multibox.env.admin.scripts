####################### aria2c > B.013.0-armeabi-v7a Results >>> Wed Dec 31 21:26:19 BRT 1969
Senha7z="gkCm8vjOViYaJ4dbvlSxsbuL2LUutmij7NfdCbZihRBVnT2UsZHVDoqc9pyLNcsGxutAs9"
app="aria2c"
CpuPack="armeabi-v7a"
FileName="B.013.0-armeabi-v7a"
apkName="B.013.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.013.0-armeabi-v7a/B.013.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/aria2c -v > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="aria2 version 1.35.0"
scriptOneTimeOnly=""
excludeListPack "/data/asusbox/.install/00.snib/B.013.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
