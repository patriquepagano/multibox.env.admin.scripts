#!/system/bin/sh

export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="6jH058EnMppKHbWvUB7nbNMxtAYigIKr7Xv9XWA7oi0AotUcY3SWJqRP1dZlsbUno7a4CB"
# Binário
app="PHP"
apkSection="bins"
CpuPack="armeabi-v7a"
FileName="B.006.0-$CpuPack"
apkName="$FileName"
FileExtension="7z"
path="/data/asusbox/.install/00.snib"
admExport=$(dirname "$0")

cmdCheck='/system/usr/bin/php-cgi --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'

eval $cmdCheck
versionBinOnline=$versionBinLocal
echo $versionBinLocal

FileList="/system/usr/bin/php-cgi
/system/usr/lib/libtidy.so
/system/usr/lib/libgmp.so
/system/usr/lib/libbz2.so
/system/usr/lib/libbz2.so.1.0
/system/usr/lib/libbz2.so.1.0.8
/system/usr/lib/libxml2.so
/system/usr/lib/libsqlite3.so
/system/usr/lib/libffi.so
/system/usr/lib/libgd.so
/system/usr/lib/libicuio.so.67
/system/usr/lib/libicuio.so.67.1
/system/usr/lib/libicui18n.so.67
/system/usr/lib/libicui18n.so.67.1
/system/usr/lib/libicuuc.so.67
/system/usr/lib/libicuuc.so.67.1
/system/usr/lib/libonig.so
/system/usr/lib/libxslt.so
/system/usr/lib/libexslt.so
/system/usr/lib/libzip.so
/system/usr/lib/liblzma.so.5
/system/usr/lib/liblzma.so.5.2.5
/system/usr/lib/libpng16.so
/system/usr/lib/libfontconfig.so
/system/usr/lib/libfreetype.so
/system/usr/lib/libtiff.so
/system/usr/lib/libwebp.so
/system/usr/lib/libicudata.so.67
/system/usr/lib/libicudata.so.67.1
/system/usr/lib/libcrypt.so
/system/usr/lib/libgcrypt.so
/system/usr/lib/libgpg-error.so"

scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/php-cgi /system/bin/php-cgi
"

scriptAtBoot=''
SCRIPT=`realpath "$0"`
### Tasks ###############################################################################
compressTarget

exportVarsBINs









