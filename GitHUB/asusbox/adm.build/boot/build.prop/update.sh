#!/system/bin/sh

initPath="/system/build.prop"

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
        echo "ADM DEBUG ### $pathToInstall esta atualizado!"
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
versionBinOnline=`/system/bin/busybox base64 "${0%/*}/build.prop"`
FilePerms=644
pathToInstall=$initPath
NeedReboot="echo -n 'ok' > /data/asusbox/reboot"

CheckBase64


# ✔ build.prop aceita ser instalado em qlq placa da mesma arch? @done(20-12-21 09:50)
#     + sim!
#     + animação do video se tornou lenta apos aplicar o build.prop do rtx (mesmo sintoma da placa antiga)

# ✔ build.prop roda em versoes diferentes de android ? @done(20-12-21 09:53)
#     + sim
#     + build.prop do rtx no android 9

