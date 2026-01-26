#!/system/bin/sh
#
source /data/.vars
source "/data/asusbox/adm.1.export/_functions/generate.sh"
source "/data/asusbox/adm.1.export/_functions/allFunctions.sh"

# comprimir
Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
# app vars
app="com.xyz.fullscreenbrowser"
apkSection="007.0-#######-$app-"
apkName="01-viewer"
path="/system/vendor/lib/.install"
admExport=$(dirname $0)
# app configs
LauncherIntegrated="no"
manualAKPfix=""
# data configs
clearAppDataOnBoot="no"
ConfigDataVersion="1.0.0"
manualDTFfix=""
manualDTFfixForced="
if [ ! -d /data/data/$app/shared_prefs ];then
    mkdir -p /data/data/$app/shared_prefs
fi
# config
cat <<EOF > /data/data/$app/shared_prefs/browser.xml
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <string name=\"homepage\">http://localhost</string>
    <boolean name=\"introdone\" value=\"true\" />
    <boolean name=\"bottomtabs\" value=\"false\" />
    <boolean name=\"desktopversion\" value=\"false\" />
    <boolean name=\"nonetwork\" value=\"false\" />
    <boolean name=\"noimages\" value=\"false\" />
    <boolean name=\"nojavascript\" value=\"false\" />
</map>
EOF
# seta as permissões de user da pasta
FixPerms
"
AppGrantLoop=""
### Tasks ####################################################################################
# o cache install deste app vai vir nos firmwares novos. no antigo vai ser enviado via gDrive
#
# pm clear $app
# compressAPKDataFull
# compressAPK

AKPouDTF="DTF"
rcloneUpload

AKPouDTF="AKP"
rcloneUpload


