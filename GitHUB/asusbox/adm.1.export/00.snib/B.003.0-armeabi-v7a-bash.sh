#!/system/bin/sh

export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="1Z5K1egIUI0UbiVI3QaaDMzgM0uzd5K2T8PeOW9j9cV36LhrghsRSHbisl2h1bVjhHM3Qk"
# Binário
app="bash"
apkSection="bins"
CpuPack="armeabi-v7a"
FileName="B.003.0-$CpuPack"
apkName="$FileName"
FileExtension="7z"
path="/data/asusbox/.install/00.snib"
admExport=$(dirname "$0")

cmdCheck='/system/usr/bin/bash -version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'

eval $cmdCheck
versionBinOnline=$versionBinLocal
echo $versionBinLocal

FileList="/system/usr/lib/bash/head
/system/usr/lib/bash/logname
/system/usr/lib/bash/tee
/system/usr/lib/bash/unlink
/system/usr/lib/bash/Makefile.inc
/system/usr/lib/bash/basename
/system/usr/lib/bash/tty
/system/usr/lib/bash/realpath
/system/usr/lib/bash/pathchk
/system/usr/lib/bash/truefalse
/system/usr/lib/bash/strftime
/system/usr/lib/bash/uname
/system/usr/lib/bash/sync
/system/usr/lib/bash/fdflags
/system/usr/lib/bash/whoami
/system/usr/lib/bash/mypid
/system/usr/lib/bash/finfo
/system/usr/lib/bash/rmdir
/system/usr/lib/bash/ln
/system/usr/lib/bash/setpgid
/system/usr/lib/bash/seq
/system/usr/lib/bash/push
/system/usr/lib/bash/sleep
/system/usr/lib/bash/printenv
/system/usr/lib/bash/id
/system/usr/lib/bash/mkdir
/system/usr/lib/bash/print
/system/usr/lib/bash/loadables.h
/system/usr/lib/bash/dirname
/system/usr/lib/pkgconfig/bash.pc
/system/usr/bin/bash
/system/usr/etc/profile
/system/usr/etc/bash.bashrc"

scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/bash /system/bin/bash
"

scriptAtBoot=''
SCRIPT=`realpath "$0"`
### Tasks ###############################################################################
compressTarget

exportVarsBINs









