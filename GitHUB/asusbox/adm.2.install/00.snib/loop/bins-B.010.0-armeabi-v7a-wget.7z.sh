####################### wget > B.010.0-armeabi-v7a Results >>> Wed Dec 31 21:25:57 BRT 1969
Senha7z="NVJwvNGGpx2CQuQ893IqW2pyBy1GlXTxfy8NQbFewudgc7dfxd9KoHAGf2RwHjfBpDxWW2"
app="wget"
CpuPack="armeabi-v7a"
FileName="B.010.0-armeabi-v7a"
apkName="B.010.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.010.0-armeabi-v7a/B.010.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/wget --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="GNU Wget 1.20.3 built on linux-androideabi."
scriptOneTimeOnly="
# Fix dos symlinks
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/wget /system/bin/
"
excludeListPack "/data/asusbox/.install/00.snib/B.010.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
