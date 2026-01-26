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
    echo "$pathToInstall" esta atualizado!
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








