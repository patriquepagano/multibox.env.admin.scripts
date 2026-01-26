function exportWwwAssets () {
# mudar o lugar do export
# source     > /data/asusbox/adm.1.export/03.akp.base
# quero isto > /data/asusbox/adm.2.install/03.akp.base
admExport=`echo $admExport | sed "s|adm.1.export|adm.2.install|g"`
# log resultado
if [ ! -d "$admExport/loop" ];then
    mkdir -p "$admExport/loop"
fi
varDataLinks="$admExport/loop/$apkSection$FileName.$FileExtension.sh"
rm $varDataLinks > /dev/null 2>&1

datebuild=`date`

versionBinOnline=`cat /data/local/tmp/GenPack/version`

echo "####################### $app > $FileName Results >>> $datebuild" >> $varDataLinks
echo "Senha7z=\"$Senha7z\"" >> $varDataLinks
echo "app=\"$app\"" >> $varDataLinks
echo "FileName=\"$FileName\"" >> $varDataLinks
echo "FileExtension=\"$FileExtension\"" >> $varDataLinks
echo "cmdCheck='$cmdCheck'" >> $varDataLinks
echo "versionBinOnline=\"$versionBinOnline\"" >> $varDataLinks
echo "pathToInstall=\"$pathToInstall\"" >> $varDataLinks
echo "SourcePack=\"$path/$FileName/$FileName\"" >> $varDataLinks
echo "ExcludeItens='$ExcludeItens'" >> $varDataLinks

echo "excludeListPack \"$path/$FileName\"" >> $varDataLinks

cat <<EOF >> $varDataLinks
# verifica e instala 
7ZextractDir
# rsync folder
RsyncUpdateWWW

EOF

chmod 755 $varDataLinks
}



