####################### syncthing > B.014.0-armeabi-v7a Results >>> Thu Mar 10 22:20:29 BRT 2022
Senha7z="QUA9qeNYo5VaNKSGbMK3nR6sWqIWon9lNmowLxf8uSpJUWu4TrMHvyzMInhK2yFL2PR48T"
app="syncthing"
CpuPack="armeabi-v7a"
FileName="B.014.0-armeabi-v7a"
apkName="B.014.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.014.0-armeabi-v7a/B.014.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/initRc.drv.05.08.98 -version | cut -d " " -f 2 > /data/local/tmp/swap && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="v1.19.1"
scriptOneTimeOnly=""
excludeListPack "/data/asusbox/.install/00.snib/B.014.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
