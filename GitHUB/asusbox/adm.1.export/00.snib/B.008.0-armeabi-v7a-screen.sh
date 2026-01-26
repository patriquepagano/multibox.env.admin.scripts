#!/system/bin/sh

export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="Qfl5U522d4fVAktW6IWii7GhTUadyyQlWrPhfF4Dp4tCmeFK4QXODAdnvqMFmhOhEUZpFL"
# Binário
app="screen"
apkSection="bins"
CpuPack="armeabi-v7a"
FileName="B.008.0-$CpuPack"
apkName="$FileName"
FileExtension="7z"
path="/data/asusbox/.install/00.snib"
admExport=$(dirname "$0")

cmdCheck='/system/usr/bin/screen --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'

eval $cmdCheck
versionBinOnline=$versionBinLocal
echo $versionBinLocal

FileList="/system/usr/bin/screen-4.8.0
/system/usr/etc/screenrc
/system/usr/share/screen/utf8encodings/c4
/system/usr/share/screen/utf8encodings/01
/system/usr/share/screen/utf8encodings/02
/system/usr/share/screen/utf8encodings/c3
/system/usr/share/screen/utf8encodings/cc
/system/usr/share/screen/utf8encodings/04
/system/usr/share/screen/utf8encodings/cd
/system/usr/share/screen/utf8encodings/a1
/system/usr/share/screen/utf8encodings/c8
/system/usr/share/screen/utf8encodings/03
/system/usr/share/screen/utf8encodings/c2
/system/usr/share/screen/utf8encodings/bf
/system/usr/share/screen/utf8encodings/18
/system/usr/share/screen/utf8encodings/c6
/system/usr/share/screen/utf8encodings/c7
/system/usr/share/screen/utf8encodings/19
/system/usr/share/screen/utf8encodings/d6
/system/usr/bin/screen"

scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/screen /system/bin/screen
"

scriptAtBoot=''
SCRIPT=`realpath "$0"`
### Tasks ###############################################################################
compressTarget

exportVarsBINs









