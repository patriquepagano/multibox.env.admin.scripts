####################### curl > B.004.0-armeabi-v7a Results >>> Wed Dec 31 21:24:19 BRT 1969
Senha7z="zTlHBfxdeVzs9upefed4oGrExxpHAzdzZoj3G0jmce6NEqJs46c4CUoFtp4B9YwW44rJOz"
app="curl"
CpuPack="armeabi-v7a"
FileName="B.004.0-armeabi-v7a"
apkName="B.004.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.004.0-armeabi-v7a/B.004.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/curl --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="curl 7.73.0 (arm-unknown-linux-androideabi) libcurl/7.73.0 OpenSSL/1.1.1h zlib/1.2.11 libssh2/1.9.0 nghttp2/1.42.0"
scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/curl /system/bin/curl
"
excludeListPack "/data/asusbox/.install/00.snib/B.004.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
