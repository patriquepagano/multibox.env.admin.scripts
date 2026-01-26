####################### busybox > B.001.0-armeabi-v7a Results >>> Wed Dec 31 21:23:53 BRT 1969
Senha7z="D2XL1wPhGR1Sb0dtJDkdGo18wHGQcbiIOGLo5SbL9Gjaar2HqQC0coypPRRdiyrtg131vS"
app="busybox"
CpuPack="armeabi-v7a"
FileName="B.001.0-armeabi-v7a"
apkName="B.001.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.001.0-armeabi-v7a/B.001.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/busybox > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="BusyBox v1.31.1-meefik (2019-12-29 23:43:11 MSK) multi-call binary."
scriptOneTimeOnly=""
excludeListPack "/data/asusbox/.install/00.snib/B.001.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
