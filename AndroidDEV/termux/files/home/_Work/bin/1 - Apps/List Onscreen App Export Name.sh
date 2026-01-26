#!/system/bin/sh
clear

OnScreenNow=`dumpsys window windows | grep mCurrentFocus | cut -d " " -f 5 | cut -d "/" -f 1`
aapt="/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.bin's/aapt"
/system/bin/busybox find "/data/app/" -type d -name "$OnScreenNow*" \
| while read Folder; do
    echo "ADM DEBUG ########################################################"    
    echo "ADM DEBUG ### $Folder " 
    requestData=`$aapt dump badging "$Folder/base.apk"`
    echo -n "$requestData" > /data/local/tmp/aapt.txt
done

requestData=`busybox cat /data/local/tmp/aapt.txt`
FakeName=`echo "$requestData" | grep "application-label:" | cut -d "'" -f 2 | cut -d "'" -f 1`
PackageName=`echo "$requestData" | grep 'package: name=' | cut -d "'" -f 2 | cut -d "'" -f 1`
PackageVersion=`echo "$requestData" | grep 'versionName=' | cut -d "'" -f 6 | cut -d "'" -f 1`
echo "ADM DEBUG ### Copie a informação abaixo para copiar ou apagar a ficha tecnica"
echo ""
echo "ADM DEBUG ### InFO  = > \"{$FakeName} [$PackageName] ($PackageVersion)\""
echo "Copie e cole para fechar"
echo "am force-stop $PackageName"



# # gerar um exporte deste jeito
# app="com.new2tourosat.app"
# fakeName="Touro box1"
# apkSection="clones"
# apkName="ac.100"


read bah