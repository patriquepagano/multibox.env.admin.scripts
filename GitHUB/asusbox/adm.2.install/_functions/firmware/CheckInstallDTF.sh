function CheckInstallDTF () {
# senha dos arquivos compactados
Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
crclocal=`HashFile /data/asusbox/$apkName.DTF`
if [ ! "$crclocal" == "$crcOnline" ]; then
    echo "<h1>$(date)</h1>" >> $bootLog 2>&1
    echo "<h3>Grande atualização, por favor aguarde.</h3>" >> $bootLog 2>&1
    echo "<h3>Arquivo grande pode demorar.</h3>" >> $bootLog 2>&1
### DOWNLOAD COM SISTEMA MULTI-LINKS
for LinkUpdate in $multilinks; do
    echo "loop download > $LinkUpdate"
    if [ ! "$crclocal" == "$crcOnline" ]; then
            echo "Iniciando download $apkName por favor espere." > $bootLog 2>&1
            echo -n $LinkUpdate > /data/local/tmp/url.list
            cat /data/local/tmp/url.list
            DownloadDTF
            crclocal=`HashFile /data/asusbox/$apkName.akp`       
            if [ "$crclocal" == "$crcOnline" ]; then break; fi; # check return value, break if successful (0)
            sleep 1;
    fi
done
    echo "Download concluido $apkName" > $bootLog 2>&1
fi
}

