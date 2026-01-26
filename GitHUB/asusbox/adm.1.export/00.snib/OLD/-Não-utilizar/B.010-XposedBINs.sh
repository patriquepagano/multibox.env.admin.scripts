#!/system/bin/sh

source /data/.vars
source "/data/asusbox/adm.1.export/_functions/generate.sh"
source "/data/asusbox/adm.1.export/_functions/allFunctions.sh"

# comprimir
Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
# Binário
app="XposedBins"
apkSection="000.snib-"
FileName="B.010"
FileExtension="7z"
path="/data/asusbox/.install/00.snib"
admExport=$(dirname $0)


cmdCheck='cat /system/xposed.prop | grep version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
eval $cmdCheck
versionBinOnline=$versionBinLocal
echo $versionBinLocal

FileList="/system/bin/app_process32
/system/bin/dex2oat
/system/bin/oatdump
/system/bin/patchoat
/system/bin/app_process32_xposed
/system/bin/dex2oat.orig.gz
/system/bin/oatdump.orig.gz
/system/bin/patchoat.orig.gz
/system/framework/XposedBridge.jar
/system/lib/libart-compiler.so
/system/lib/libart-disassembler.so
/system/lib/libart.so
/system/lib/libsigchain.so
/system/lib/libxposed_art.so
/system/lib/libart.so.orig.gz
/system/lib/libart-compiler.so.orig.gz
/system/lib/libsigchain.so.orig.gz
/system/lib/libart-disassembler.so.orig.gz
/system/xposed.prop"

scriptOneTimeOnly=""

scriptAtBoot=""

### Tasks ###############################################################################
# compressTarget

rcloneUploadFileList


