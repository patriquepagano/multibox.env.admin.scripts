####################### syncthing > B.015.0-armeabi-v7a Results >>> Sun Nov  3 20:19:31 UTC___ 2024
Senha7z="Bm4jxlld4c1zWPfoxKc3cgQex5edz1JgYoumdpcoEwTFwYIKZoI6pK0WHjPTntiThHYADW"
app="aapt"
CpuPack="armeabi-v7a"
FileName="B.015.0-armeabi-v7a"
apkName="B.015.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.015.0-armeabi-v7a/B.015.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/aapt version | cut -d " " -f 5 > /data/local/tmp/swap && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="v0.2-eng.zhengzhongming.20180802.165542"
scriptOneTimeOnly=""
excludeListPack "/data/asusbox/.install/00.snib/B.015.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
