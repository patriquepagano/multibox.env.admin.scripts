function extractDTFSplitted () {
    echo "$(date)" > $bootLog 2>&1
    echo "Configurando o aplicativo > $apkName $fakeName" >> $bootLog 2>&1
    echo "Por favor aguarde..." >> $bootLog 2>&1
    am force-stop $app
    # extract 7z
    echo "ADM DEBUG ###########################################################"
    echo "ADM DEBUG ### entrando na função extractDTFSplitted"
    echo "ADM DEBUG ### extraindo 7Z $apkName"
    rm /data/local/tmp/*tar.gz > /dev/null 2>&1
    /system/bin/7z e -aoa -y -p$Senha7z "$SourcePack*.001" -oc:/data/local/tmp > /dev/null 2>&1

    # echo "ADM DEBUG ### bah"
    # sleep 3000

    # extract tar
    echo "ADM DEBUG ### extraindo tar $apkName.DT.tar.gz"
    cd /
    /system/bin/busybox tar -mxvf /data/local/tmp/$apkName.DT.tar.gz > /dev/null 2>&1
    rm /data/local/tmp/$apkName.DT.tar.gz > /dev/null 2>&1
    # zerando a variavel fakename por causa que não tem em todas as fichas tecnicas
    fakeName=""
}

