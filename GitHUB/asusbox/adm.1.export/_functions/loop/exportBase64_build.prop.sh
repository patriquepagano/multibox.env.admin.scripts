function exportBase64_build.prop () {
# mudar o lugar do export
# source     > /data/asusbox/adm.1.export/03.akp.base
# quero isto > /data/asusbox/adm.2.install/03.akp.base
admExport=`echo $admExport | sed "s|adm.1.export|adm.2.install|g"`
# log resultado
if [ ! -d "$admExport/loop" ];then
    mkdir -p "$admExport/loop"
fi
varDataLinks="$admExport/loop/$apkSection$FileName.sh"
rm "$varDataLinks" > /dev/null 2>&1

datebuild=`date`

echo "####################### $app > $FileName Results >>> $datebuild" >> "$varDataLinks"
echo "app=\"$app\"" >> "$varDataLinks"
echo "FileName=\"$FileName\"" >> "$varDataLinks"
echo "FilePerms=\"$FilePerms\"" >> "$varDataLinks"
echo "FileCmd=\"$FileCmd\"" >> "$varDataLinks"
echo "NeedReboot=\"$NeedReboot\"" >> "$varDataLinks"
echo "pathToInstall=\"$pathToInstall\"" >> "$varDataLinks"
echo "cmdCheck='$cmdCheck'" >> "$varDataLinks"
echo "versionBinOnline=\"$versionBinOnline\"" >> "$varDataLinks"


cat <<'EOF' >> "$varDataLinks"

if [ -f "/system/$app" ];then
    echo "ADM DEBUG ###########################################################################################"
    echo "ADM DEBUG ### verificando build.prop compativel > $app"
    # chama a função e entra em looping até gravar direito.
    CheckBase64
fi

EOF

chmod 755 "$varDataLinks"
}




