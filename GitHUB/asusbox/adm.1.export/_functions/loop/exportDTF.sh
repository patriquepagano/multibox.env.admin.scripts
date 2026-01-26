function exportDTF () {
# mudar o lugar do export
# source     > /data/asusbox/adm.1.export/03.akp.base
# quero isto > /data/asusbox/adm.2.install/03.akp.base
admExport=`echo "$admExport" | sed "s|adm.1.export|adm.2.install|g"`
# log resultado
if [ ! -d "$admExport/loop" ];then
    mkdir -p "$admExport/loop"
fi
varDataLinks="$admExport/loop/$apkSection-$apkName-$fakeName.DTF.sh"
rm "$varDataLinks" > /dev/null 2>&1

if [ ! -f "$path/$apkName/DTF/version" ];then
    date > "$path/$apkName/DTF/version"
fi
version=`cat $path/$apkName/DTF/version`
datebuild=`date`

echo "####################### DTF Results >>> $datebuild" >> "$varDataLinks"
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
echo "SourcePack=\"$path/$apkName/DTF/$apkName.DTF\"" >> "$varDataLinks"

echo "excludeListPack \"$path/$apkName\"" >> "$varDataLinks"

# final da ficha técnica
cat <<EOF >> "$varDataLinks"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
EOF
#clearAppDataOnBoot="$clearAppDataOnBoot"
if [ "$clearAppDataOnBoot" == "yes" ]; then
    echo "# Condição variavel do app para limpar o data no boot" >> "$varDataLinks"
    echo "pm clear $app" >> "$varDataLinks"
fi

cat <<EOF >> "$varDataLinks"
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/$app/$version" ] ; then
    pm disable $app
    pm clear $app
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    $manualDTFfix
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/$app-*/lib/arm /data/data/$app/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="$AppGrantLoop"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    $manualDTFposPerms
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/$app/$version"
    pm enable $app
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "$app" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot
$manualDTFfixForced
EOF

chmod 755 "$varDataLinks"
}





