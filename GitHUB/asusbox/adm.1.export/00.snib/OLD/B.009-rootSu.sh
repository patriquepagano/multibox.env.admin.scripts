#!/system/bin/sh

export DIR=`dirname $(dirname $0)`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
# Binário
app="rootSu"
apkSection="000.snib-"
FileName="B.009"
FileExtension="7z"
path="/data/asusbox/.install/00.snib"
admExport=$(dirname $0)

cmdCheck='/system/xbin/su -v > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
#cmdCheck='versionBinLocal=`/system/bin/busybox md5sum "/system/xbin/su"`'
eval $cmdCheck
versionBinOnline=$versionBinLocal
echo $versionBinLocal

FileList="/system/bin/.ext/.su
/system/bin/install-recovery.sh
/system/bin/app_process_init
/system/etc/install-recovery.sh
/system/etc/.installed_su_daemon
/system/lib/libsupol.so
/system/xbin/daemonsu
/system/xbin/su
/system/xbin/supolicy
/system/xbin/.tmpsu
/system/xbin/daemonsu_old"

scriptOneTimeOnly="
/system/bin/busybox mount -o remount,rw /system
echo -n 'FSgfdgkjhç8790d5sdf85sd867f5gs876df5g876sdf5g78s6df5g78s6df5gs87df6g576sfd' > /system/.pin
chmod 644 /system/.pin
"

scriptAtBoot=""

### Tasks ###############################################################################
# compressTarget

rcloneUploadFileList



# removidos agora esta funcionando o su mesmo com a mensagem que precisa atualizar
# /system/bin/app_process
# /system/bin/app_process32







