function CheckAKPinstall () {
# senha dos arquivos compactados
Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
versionLocal=`dumpsys package $app | grep versionName | cut -d "=" -f 2`
            echo "ADM DEBUG ###########################################################"
            echo "ADM DEBUG ### $apkName >>>>>>> $app"
            echo "ADM DEBUG ### versao local  > $versionLocal"
            echo "ADM DEBUG ### versao online > $versionNameOnline"
            # echo "ADM DEBUG ### bah parai tche"
            # sleep 300
# se versão do app não estiver instalado baixa o akp
if [ ! "$versionLocal" == "$versionNameOnline" ]; then # NOVA TAREFA SE O CLIENTE ATUALIZAR O APP VAI SOBREESCREVER O INSTALL NO BOOT
    echo "ADM DEBUG ######################################################"
    echo "ADM DEBUG ### arquivos $app são diferentes"
    echo "<h1>$(date)</h1>" >> $bootLog 2>&1
    echo "<h2>ASUSbox Informa</h2>" >> $bootLog 2>&1
    echo "<h3>Grande atualização, por favor aguarde.</h3>" >> $bootLog 2>&1
    echo "<h3>Arquivo grande pode demorar.</h3>" >> $bootLog 2>&1
CheckDownloadFiles
#echo "versões diferentes do $AKPouDTF"
    echo "ADM DEBUG ######################################################"
    echo "ADM DEBUG ### é AKP ou DTF ? = $AKPouDTF"
    if [ "$AKPouDTF" == "AKP" ]; then
        echo "<h2>Instalando o aplicativo > $apkName</h2>" >> $bootLog 2>&1
        echo "<h3>Por favor aguarde...</h3>" >> $bootLog 2>&1
        # extract 7z splitted
        echo "ADM DEBUG ### extraindo 7Z $app"
        /system/bin/7z e -aoa -y -p$Senha7z "$InstallDir*.001" -oc:/data/local/tmp > /dev/null 2>&1
        # instalando o app
        if [ -d /data/data/$app ];then
            echo "ADM DEBUG ### Uninstall old app version"
            pm uninstall $app
        fi
        echo "ADM DEBUG ### instalando $app por favor aguarde"
        pm install /data/local/tmp/base.apk
        rm /data/local/tmp/base.apk > /dev/null 2>&1
        echo "ADM DEBUG ### verificando se precisa liberar permissão para o $app"
        AppGrant
    fi
    if [ "$LauncherIntegrated" == "yes" ]; then
        echo "ADM DEBUG ### ativando launcher official"
        cmd package set-home-activity "dxidev.toptvlauncher2/.HomeActivity"
    fi
fi
}




