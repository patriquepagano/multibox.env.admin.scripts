function extractDTF () {
echo "<h1>$(date)</h1>" >> $bootLog 2>&1
echo "<h2>Configurando o aplicativo > $apkName $fakeName</h2>" >> $bootLog 2>&1
echo "<h3>Por favor aguarde...</h3>" >> $bootLog 2>&1
am force-stop $app
# extract 7z
/system/bin/7z e -aoa -y -p$Senha7z "/data/asusbox/$apkName.DTF" -oc:/data/local/tmp
# extract tar
cd /
/system/bin/busybox tar -mxvf /data/local/tmp/$apkName.DT.tar.gz
rm /data/local/tmp/$apkName.DT.tar.gz
# zerando a variavel fakename por causa que não tem em todas as fichas tecnicas
fakeName=""
}


