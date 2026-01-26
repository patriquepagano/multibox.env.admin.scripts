#!/system/bin/sh

export DIR=`dirname $(dirname $0)`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

FileName="build.prop"
FilePerms="644"
FileCmd=""
NeedReboot="echo -n 'ok' > /data/asusbox/reboot"
pathToInstall="/system/build.prop"
admExport=$(dirname $0)

cmdCheck='versionBinLocal=`/system/bin/busybox cat "/system/build.prop" | /system/bin/busybox base64`'

# loop nas fichas técnicas disponiveis
/system/bin/busybox find "/storage/DevMount/GitHUB/asusbox/adm.build/boot-files/build/" -maxdepth 1 -type f -name "*.prop"| sort | while read fname; do
    echo $fname
    FirmwareMark=`/system/bin/busybox basename "$fname" .prop`
    app="$FirmwareMark"
    apkSection="004.0-#######-$FirmwareMark-"
    versionBinLocal=`/system/bin/busybox cat "$fname" | /system/bin/busybox base64`
    versionBinOnline="$versionBinLocal"
    ### Tasks ###############################################################################
    exportBase64_build.prop
done




