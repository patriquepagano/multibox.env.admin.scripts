
BB=/system/bin/busybox


Limpa_apks_del () {
$BB find "/data/local/tmp/" -type f -name "*.apk" | while read fname ; do
    echo "$fname"
    rm "$fname"
done
}

# 🔧 Função: enfileira todos os APKs encontrados na pasta
enfileira_apks_install () {
    $BB find "/data/local/tmp" -type f -name "*.apk" | while read apk ; do
        pm install-write $SESSION "$(basename "$apk")" "$apk"
    done
}

# 🔧 Função: cria sessão, enfileira e tenta instalar
Processa_install_apks () {
    SESSION=$(pm install-create -r | $BB awk -F'[' '{print $2}' | $BB tr -d ']')
    enfileira_apks_install 
    pm install-commit $SESSION
    return $?
}

function CheckAKPinstallP2P () {
# senha dos arquivos compactados

if [ "$Senha7z" == "" ]; then
    Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
fi

# sistema antigo
# versionLocal=`dumpsys package $app | $BB grep versionName | $BB cut -d "=" -f 2 | $BB head -n 1`

# novo sistema baseado em crc32 dos apk's
# versionLocal=`$BB cksum /data/app/$app*/base.apk | $BB cut -d "/" -f 1`


# novo sistema de comparação por data instalação, se existir o marcador ele NÃO FAZ downgrade do app
# este fix é para marcar todos os apps instalados no momento do dia que criei este novo check up
# Thu Jun  3 16:06:36 BRT 2021

if [ ! -d /data/asusbox/AppLog ]; then 
    busybox mkdir -p /data/asusbox/AppLog 
fi

if [ -d "/data/data/$app" ]; then # se a pasta data do apk existe, considero que já tem o ultimo apk lançado
    MarcadorInicial="Thu Jun  3 16:06:36 BRT 2021"
    if [ ! -f "/data/asusbox/AppLog/$app=$MarcadorInicial.log" ];then
        echo "ADM DEBUG ###########################################################"
        echo "ADM DEBUG ### pasta do $app existe! criando o marcador"
        touch "/data/asusbox/AppLog/$app=$MarcadorInicial.log"
    fi
else
    echo "ADM DEBUG ###########################################################"
    echo "ADM DEBUG ### cliente desistalou o $app removendo os logs marcadores"
    $BB find "/data/asusbox/AppLog/" -type f -name "$app=*" | while read fname; do
        busybox rm "$fname"
    done
fi

echo "ADM DEBUG ###########################################################"
echo "ADM DEBUG ### $apkName >>>>>>> $app"
# echo "ADM DEBUG ### versao local  > $versionLocal"
# echo "ADM DEBUG ### versao online > $versionNameOnline"
echo "ADM DEBUG ### Ultima versão p2p pack = $versionNameOnline"

#if [ ! "$versionLocal" == "$versionNameOnline" ]; then # NOVA TAREFA SE O CLIENTE ATUALIZAR O APP VAI SOBREESCREVER O INSTALL NO BOOT

if [ ! -f "/data/asusbox/AppLog/$app=$versionNameOnline.log" ];then
    echo "ADM DEBUG ######################################################"
    echo "ADM DEBUG ### arquivos $app são diferentes"
    echo "$(date)" > $bootLog 2>&1
    echo "ADM DEBUG ######################################################"
    echo "ADM DEBUG ### é AKP ou DTF ? = $AKPouDTF"
    echo "ADM DEBUG ### Arquivo já esta baixado e verificado CRC p2p"
    if [ "$AKPouDTF" == "AKP" ]; then
        Limpa_apks_del
        echo "Instalando o aplicativo > $apkName $fakeName" >> $bootLog 2>&1
        echo "Por favor aguarde..." >> $bootLog 2>&1
        # extract 7z splitted
        echo "ADM DEBUG ### extraindo 7Z $app"
        /system/bin/7z e -aoa -y -p$Senha7z "$SourcePack*.001" -oc:/data/local/tmp #> /dev/null 2>&1

        echo "ADM DEBUG ### tentando instalar por cima o app $app"
        #pm install -r /data/local/tmp/base.apk
        Processa_install_apks

        # downgrade forçado nos apps, se o cliente atualizar por sua conta
        # desistala o app novo! para instalar o do pack torrent em CIMA
        # se check crc for diferente ele vai entrar aqui descompactar apk
        if [ ! $? = 0 ]; then
            echo "ADM DEBUG ### Uninstall old app version"
            if [ -d /data/data/$app ]; then
                pm uninstall $app
            fi
            echo "ADM DEBUG ### primeira instalação do $app"
            Processa_install_apks
            #pm install /data/local/tmp/base.apk
        fi
        
        echo "ADM DEBUG ### clean install file"
        Limpa_apks_del
        #rm /data/local/tmp/base.apk > /dev/null 2>&1
        echo "ADM DEBUG ### verificando se precisa liberar permissão para o $app"
        AppGrant

        echo "ADM DEBUG ### gravando o marcador"
        touch "/data/asusbox/AppLog/$app=$versionNameOnline.log"

    fi
else
    echo "$(date)" > $bootLog 2>&1
    echo "Aplicativo > $apkName $fakeName" >> $bootLog 2>&1
    echo "Esta atualizado." >> $bootLog 2>&1
fi
# zerando a variavel fakename por causa que não tem em todas as fichas tecnicas
fakeName=""
}




