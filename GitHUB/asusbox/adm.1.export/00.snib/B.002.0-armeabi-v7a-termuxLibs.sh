#!/system/bin/sh

export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="3fxgglKD03BDLwhyNOQa5uVqOIcfaAMJCXl6nAppeglwIxUW86XGt3oFvyIRq1xvypOeNz"
# Binário
app="termuxLibs"
apkSection="bins"
CpuPack="armeabi-v7a"
FileName="B.002.0-$CpuPack"
apkName="$FileName"
FileExtension="7z"
path="/data/asusbox/.install/00.snib"
admExport=$(dirname "$0")

cmdCheck='/system/bin/7z -h > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 2p` && rm /data/local/tmp/swap'

eval $cmdCheck
versionBinOnline=$versionBinLocal
echo $versionBinLocal

FileList="/system/usr/lib/p7zip/Codecs/Rar.so
/system/usr/lib/p7zip/7z
/system/usr/lib/p7zip/7z.so
/system/usr/lib/p7zip/7za
/system/usr/lib/libc++_shared.so
/system/usr/lib/libandroid-support.so
/system/usr/lib/libreadline.so.8
/system/usr/lib/libreadline.so.8.1
/system/usr/lib/libncursesw.so.6
/system/usr/lib/libncursesw.so.6.2
/system/usr/lib/libcurl.so
/system/usr/lib/libz.so.1
/system/usr/lib/libz.so.1.2.11
/system/usr/lib/libnghttp2.so
/system/usr/lib/libssh2.so
/system/usr/lib/libssl.so.1.1
/system/usr/lib/libcrypto.so.1.1
/system/usr/lib/libandroid-glob.so
/system/usr/lib/libpopt.so
/system/usr/lib/liblz4.so.1
/system/usr/lib/liblz4.so.1.9.3
/system/usr/lib/libzstd.so
/system/usr/lib/libzstd.so.1
/system/usr/lib/libzstd.so.1.4.5
/system/usr/lib/libcrypt.so
/system/usr/lib/libminiupnpc.so
/system/usr/lib/libevent-2.1.so
/system/usr/lib/libpcre2-8.so
/system/usr/lib/libuuid.so.1
/system/usr/lib/libuuid.so.1.0.0"

scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/lib/p7zip/7za /system/bin/7z
ln -sf /system/usr/lib/p7zip/7za /system/bin/7z.so
# esta é a lib para o firmware antigo
ln -sf /system/usr/lib/libz.so.1.2.11 /system/lib/libz.so.1
"

scriptAtBoot=''
SCRIPT=`realpath "$0"`
### Tasks ###############################################################################
compressTarget

exportVarsBINs









