function exportVarsBINs () {
admExport=`echo $admExport | sed "s|adm.1.export|adm.2.install|g"`
# log resultado
if [ ! -d "$admExport/loop" ];then
    mkdir -p "$admExport/loop"
fi
varDataLinks="$admExport/loop/$apkSection-$FileName-$app.$FileExtension.sh"
rm $varDataLinks > /dev/null 2>&1
# vars fixas para todos os packs
datebuild=`date`

# upload files
echo "####################### $app > $FileName Results >>> $datebuild" >> $varDataLinks
echo "Senha7z=\"$Senha7z\"" >> $varDataLinks
echo "app=\"$app\"" >> $varDataLinks
echo "CpuPack=\"$CpuPack\"" >> $varDataLinks
echo "FileName=\"$FileName\"" >> $varDataLinks
echo "apkName=\"$apkName\"" >> $varDataLinks
echo "SourcePack=\"$path/$FileName/$FileName\"" >> $varDataLinks
echo "FileExtension=\"$FileExtension\"" >> $varDataLinks
echo "cmdCheck='$cmdCheck'" >> $varDataLinks
echo "versionBinOnline=\"$versionBinOnline\"" >> $varDataLinks
echo "scriptOneTimeOnly=\"$scriptOneTimeOnly\"" >> $varDataLinks
echo "excludeListPack \"$path/$FileName\"" >> $varDataLinks


# configs do binario na instalação
cat <<'EOF' >> $varDataLinks
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
EOF

chmod 755 $varDataLinks
}


