function exportAKP () {
# mudar o lugar do export
# source     > /data/asusbox/adm.1.export/03.akp.base
# quero isto > /data/asusbox/adm.2.install/03.akp.base
admExport=`echo "$admExport" | sed "s|adm.1.export|adm.2.install|g"`
# log resultado
if [ ! -d "$admExport/loop" ];then
    mkdir -p "$admExport/loop"
fi
varDataLinks="$admExport/loop/$apkSection-$apkName-$fakeName.AKP.sh"
rm "$varDataLinks" > /dev/null 2>&1
datebuild=`date`

# sistema antigo de versionamento dos apks via dumpsys / não serve!
# clean de instalações antigas
rm $path/$apkName/AKP/version > /dev/null 2>&1

# novo sistema de versionamento usando crc32
# version=`/system/bin/busybox cksum /data/app/$app*/base.apk | /system/bin/busybox cut -d "/" -f 1`


# novo sistema de marcador de app ( Thu Jun  3 16:06:36 BRT 2021 )
# version="Thu Jun  3 16:06:36 BRT 2021" # marcador forçado para consertar todas as fichas técnicas
version="$datebuild" # CUIDADO ESCREVER NOVOS APKS FORÇA OS TVBOX A INSTALAREM NOVAMENTE

echo "####################### AKP Results >>> $datebuild" >> "$varDataLinks"
echo "Senha7z=\"$Senha7z\"" >> $varDataLinks
echo "apkName=\"$apkName\"" >> "$varDataLinks"
echo "app=\"$app\"" >> "$varDataLinks"

aapt="/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.bin's/aapt"
/system/bin/busybox find "/data/app/" -type d -name "$app*" \
| while read fname; do
    echo $fname
    echo "ADM DEBUG ########################################################"    
    requestData=`$aapt dump badging "$fname/base.apk"`
    FakeName=`echo "$requestData" | grep "application-label:" | cut -d "'" -f 2 | cut -d "'" -f 1`
    PackageVersion=`echo "$requestData" | grep 'versionName=' | cut -d "'" -f 6 | cut -d "'" -f 1`
    #echo "$FakeName ($PackageVersion)"
    echo "fakeName=\"$FakeName ($PackageVersion)\"" >> "$varDataLinks"
    # alterando fakeName da ficha técnica
    /system/bin/busybox sed -i -e "s/fakeName=.*/fakeName=\"$FakeName ($PackageVersion)\"/g" "$SCRIPT"
done


echo "versionNameOnline=\"$version\"" >> "$varDataLinks"
echo "AppGrantLoop=\"$AppGrantLoop\"" >> "$varDataLinks"
echo "SourcePack=\"$path/$apkName/AKP/$apkName.AKP\"" >> "$varDataLinks"
echo "AKPouDTF=\"AKP\"" >> "$varDataLinks"

cat <<EOF >> "$varDataLinks"
LauncherIntegrated="$LauncherIntegrated"
EOF

echo "excludeListAPP" >> "$varDataLinks"
echo "excludeListPack \"$path/$apkName\"" >> "$varDataLinks"

echo "CheckAKPinstallP2P" >> "$varDataLinks"
echo "LauncherList" >> "$varDataLinks"

cat <<EOF >> "$varDataLinks"
### Manual AKP Config *******
$manualAKPfix

EOF




chmod 755 "$varDataLinks"
}


