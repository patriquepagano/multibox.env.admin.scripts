
# checkup do script para saber se é nosso para rodar
if [ "$1" == "675asd765da4s567f4asd4f765ads4f675a4ds6f754ads6754fa657ds4f675ads467f5ads" ]; then
    echo "Certified.BOOT"
    exit
fi


function CheckIPLocal () {
WlanIP=`/system/bin/busybox ip addr show wlan0 \
| /system/bin/busybox grep "inet " \
| /system/bin/busybox awk '{print $2}' \
| /system/bin/busybox cut -d "/" -f 1 \
| /system/bin/busybox head -1`

LanIP=`/system/bin/busybox ip addr show eth0 \
| /system/bin/busybox grep "inet " \
| /system/bin/busybox awk '{print $2}' \
| /system/bin/busybox cut -d "/" -f 1 \
| /system/bin/busybox head -1`

# echo "Lista de IPs
# Se o IP da wlan não estiver disponivel pega o da lan
# WlanIP  $WlanIP
# LanIP   $LanIP
# "
if [ "$LanIP" == "" ]; then
    export IPLocal="$WlanIP"
else
    export IPLocal="$LanIP"
fi
}


# IPLocal=`/system/bin/busybox ifconfig \
# | /system/bin/busybox grep -v 'P-t-P' \
# | /system/bin/busybox grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' \
# | /system/bin/busybox grep -Eo '([0-9]*\.){3}[0-9]*' \
# | /system/bin/busybox grep -v '127.0.0.1' \
# | /system/bin/busybox head -3`

echo "ADM DEBUG ###########################################################"
echo "ADM DEBUG ### aguardando receber algum ip para interface"
while [ 1 ]; do
    CheckIPLocal
    if [ ! "$IPLocal" = "" ]; then break; fi;
    sleep 1;
done;


echo "primeiro try IPlocal"
CheckIPLocal

function acr.browser.barebones.set.config () {
FileXML="/data/data/acr.browser.barebones/shared_prefs/acr.browser.barebones_preferences.xml"
if [ ! -f "$FileXML"  ]; then
mkdir -p /data/data/acr.browser.barebones/shared_prefs
/system/bin/busybox cat <<EOF > "$FileXML"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="fullScreenOption" value="true" />
    <boolean name="cb_images" value="false" />
    <boolean name="cb_javascript" value="true" />
    <boolean name="clear_webstorage_exit" value="true" />
    <boolean name="password" value="true" />
    <boolean name="cb_drawertabs" value="true" />
    <boolean name="remove_identifying_headers" value="false" />
    <boolean name="clear_cookies_exit" value="false" />
    <boolean name="allow_cookies" value="true" />
    <boolean name="cb_ads" value="false" />
    <boolean name="allow_new_window" value="true" />
    <boolean name="third_party" value="false" />
    <boolean name="clear_history_exit" value="false" />
    <boolean name="restore_tabs" value="false" />
    <boolean name="cb_swapdrawers" value="false" />
    <boolean name="do_not_track" value="false" />
    <boolean name="location" value="false" />
    <boolean name="cb_flash" value="false" />
    <boolean name="incognito_cookies" value="false" />
    <boolean name="black_status_bar" value="true" />
    <boolean name="fullscreen" value="true" />
    <boolean name="clear_cache_exit" value="true" />
    <boolean name="text_reflow" value="false" />
    <boolean name="wideViewPort" value="true" />
    <boolean name="overViewMode" value="true" />
    <boolean name="cb_colormode" value="true" />
</map>

EOF
fi

FileXML="/data/data/acr.browser.barebones/shared_prefs/settings.xml"
if [ -z "$(cat $FileXML | grep 9091)" ]; then
/system/bin/busybox cat <<EOF > "$FileXML"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="blackStatusBar" value="true" />
    <int name="enableflash" value="0" />
    <boolean name="cache" value="true" />
    <boolean name="restoreclosed" value="false" />
    <boolean name="clearWebStorageExit" value="true" />
    <boolean name="hidestatus" value="true" />
    <int name="Theme" value="1" />
    <string name="home">http://127.0.0.1:9091</string>
</map>

EOF
fi

/system/bin/busybox chmod 660 /data/data/acr.browser.barebones/shared_prefs/*.xml
app="acr.browser.barebones"
FixPerms
# echo "ADM DEBUG ########################################################"
# echo "ADM DEBUG ### abre o navegador pela primeira vez"
# monkey -p $app -c android.intent.category.LAUNCHER 1


}





function acr.browser.barebones.launch () {
    while [ 1 ]; do
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### abrindo navegador exibir log instalação"
        am start --user 0 \
        -n acr.browser.barebones/acr.browser.lightning.MainActivity \
        -a android.intent.action.VIEW -d "$ACRURL" > /dev/null 2>&1
        if [ $? = 0 ]; then break; fi;
        sleep 1
    done;

}

function z_acr.browser.barebones.change.URL () {
    while [ 1 ]; do        
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### fechando o acr.browser.barebones"
        am force-stop acr.browser.barebones
        if [ $? = 0 ]; then break; fi;
        sleep 1
    done;

FileXML="/data/data/acr.browser.barebones/shared_prefs/settings.xml"
/system/bin/busybox cat <<EOF > "$FileXML"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="blackStatusBar" value="true" />
    <int name="enableflash" value="0" />
    <boolean name="cache" value="true" />
    <boolean name="restoreclosed" value="false" />
    <boolean name="clearWebStorageExit" value="true" />
    <boolean name="hidestatus" value="true" />
    <int name="Theme" value="1" />
    <string name="home">http://127.0.0.1:9091</string>
</map>

EOF
/system/bin/busybox sed -i -e "s;<string name=\"home\">.*</string>;<string name=\"home\">$ACRURL</string>;g" $FileXML

/system/bin/busybox chmod 660 /data/data/acr.browser.barebones/shared_prefs/*.xml
app="acr.browser.barebones"
FixPerms

}






SECONDS=0

#export bootLog="/dev/null"
export LogRealtime="/data/trueDT/peer/Sync/LogRealtime.live"

#unset PATH
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin

export Senha7z="6ads5876f45a9sdf7as975a87"
export Produto="asusbox"
export PHome="/data/$Produto"
export HOME="/data/$Produto"

if [ ! -d $PHome ] ; then
 mkdir -p $PHome
fi

if [ ! -d /data/trueDT/peer/chat ] ; then
mkdir -p /data/trueDT/peer/chat
fi

# # sempre escreve no boot o android id
# GetID=`settings get secure android_id` # puxa o ultimo id do android
# export ID=`cat /data/$Produto/android_id` # id variavel que muda no hard reset
# # compara para escrever apenas se mudou
# if [ ! "$GetID" = "$ID" ];then
# 	echo "novo id instalado"
# 	echo -n $GetID > /data/$Produto/android_id # escreve novo id
# 	export ID=`cat /data/$Produto/android_id` # carrega o novo id
# fi

# antigo id em uso = dc9c52898d8bcc99
# + box az original = 3573F9431ACC9AB1

# sempre escreve no boot o android id
GetID=`settings get secure android_id` # puxa o ultimo id do android
#export ID=`cat /data/$Produto/android_id` # id variavel que muda no hard reset
export ID="3573F9431ACC9AB1"
# compara para escrever apenas se mudou
if [ ! "$GetID" == "$ID" ]; then
	#echo "novo id instalado"
    settings put --user 0 secure android_id 3573F9431ACC9AB1
    echo -n $GetID > /data/$Produto/android_id_OLD # escreve novo id
	echo -n $ID > /data/$Produto/android_id # escreve novo id
	# export ID=`cat /data/$Produto/android_id` # carrega o novo id
fi

IDCheck=`cat /data/$Produto/android_id`
if [ ! "$IDCheck" == "$ID" ]; then
echo -n $ID > /data/$Produto/android_id # escreve novo id temporariamente
fi

# descontinuado isto não serve mais
# export UUID=`cat /system/UUID`
# if [ "$UUID" = "" ] ; then
# while [ 1 ]; do
#     echo "Baixando novo UUID"
# 	while [ 1 ]; do
# 		UUID=`/system/bin/curl "http://personaltecnico.net/Android/RebuildRoms/keyaccess.php"`
# 		if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
# 		sleep 1;
# 	done;
# 	/system/bin/busybox mount -o remount,rw /system
# 	echo -n $UUID > /system/UUID
#     export UUID=`cat /system/UUID`
#      echo "Verificando UUID > $UUID"   
#     if [  "$UUID" = "" ];then
#         $?="1"	
#     fi
#     if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
#     sleep 1;
# done;
# fi
# export UUID=`/system/bin/busybox cat /system/UUID`


export ID=`/system/bin/busybox cat /data/$Produto/android_id`
export CPU=`getprop ro.product.cpu.abi | sed -e 's/ /_/g'`
export Modelo=`getprop ro.product.model`
export RomBuild=`getprop ro.build.description | sed -e 's/ /_/g'`

# informação variavel
export FirmwareVer=`busybox blkid | busybox sed -n '/system/s/.*UUID=\"\([^\"]*\)\".*/\1/p'`

export shellBin=`echo IyEvc3lzdGVtL2Jpbi9zaA== | /system/bin/busybox base64 -d`
export onLauncher="pm enable dxidev.toptvlauncher2"
export conf="/data/$Produto/.conf"
export www="$EXTERNAL_STORAGE/Android/data/$Produto/.www"
export systemLog="$www/system.log"
export wgetLog="$www/wget.log"

export wwwup="$EXTERNAL_STORAGE/Android/data/$Produto/.updates"
export fileUpdates="/data/$Produto/.updates"

# ver oque eu faço com estas variaveis
#export bootLog="/data/$Produto/boot.log"
export userLog="/data/$Produto/user.log"

export bootLog="/data/data/jackpal.androidterm/app_HOME/log.txt"


export PathSerial="/system/Serial"
export PathPin="/system/Pin"

export SupportLOG="$EXTERNAL_STORAGE/Adata.log"

# UNIQ DEVICE IDENTIFICATION
Placa=$(getprop ro.product.board)
CpuSerial=`busybox cat /proc/cpuinfo | busybox grep Serial | busybox awk '{ print $3 }'`
MacLanReal=`/system/bin/busybox cat /data/macLan.hardware | busybox sed 's;:;;g'`
DeviceName="$Placa=$CpuSerial=$MacLanReal"



function AppGrant () {
    if [ ! "$AppGrantLoop" == "" ]; then
        for lgrant in $AppGrantLoop; do
            echo "ADM DEBUG ### aplicando o direito $lgrant ao $app"
            pm grant $app $lgrant
        done
    fi
}

function FixPerms () {
    # permissao do user da pasta
    DUser=`dumpsys package $app | /system/bin/busybox grep userId | /system/bin/busybox cut -d "=" -f 2 | /system/bin/busybox head -n 1`
    echo $DUser
    chown -R $DUser:$DUser /data/data/$app
    restorecon -FR /data/data/$app
}

function excludeListAPP () {
# echo "ADM DEBUG ###########################################################"
# echo "ADM DEBUG ### adicionado a lista de aplicativos em uso"
echo "$app" >> /data/local/tmp/APPList

}

function excludeListPack () {
# echo "ADM DEBUG ###########################################################"
# echo "ADM DEBUG ### adicionado a lista de pacotes em uso"
echo "$1" >> /data/local/tmp/PackList

}


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

function LauncherList () {
if [ "$LauncherIntegrated" == "yes" ]; then
    echo "ADM DEBUG ###########################################################"
    echo "ADM DEBUG ### adicionado a lista de aplicativos com launcher"
    #pm hide $app # não é necessário para os apps launcher atual
    if [ ! -f /data/asusbox/LauncherLock ]; then
        # nova politica de não desativar mais a launcher online official
        if [ ! "$app" == "dxidev.toptvlauncher2" ]; then
            pm disable $app
        fi
    fi
    echo "$app" >> /data/asusbox/LauncherList
fi
}

####################### AKP Results >>> Thu Jun  3 17:03:57 BRT 2021
Senha7z="a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da"
apkName="ao.05"
app="acr.browser.barebones"
versionNameOnline="Thu Jun  3 16:06:36 BRT 2021"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/04.akp.oem/ao.05/AKP/ao.05.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/04.akp.oem/ao.05"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Wed Dec 31 21:41:29 BRT 1969
apkName="ao.05"
app="acr.browser.barebones"
versionNameOnline="Tue Dec  1 13:23:48 BRST 2020"
SourcePack="/data/asusbox/.install/04.akp.oem/ao.05/DTF/ao.05.DTF"
excludeListPack "/data/asusbox/.install/04.akp.oem/ao.05"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/acr.browser.barebones/Tue Dec  1 13:23:48 BRST 2020" ] ; then
    pm clear acr.browser.barebones
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/acr.browser.barebones-*/lib/arm /data/data/acr.browser.barebones/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/acr.browser.barebones/Tue Dec  1 13:23:48 BRST 2020"
fi
###################################################################################
# config forçada para rodar sempre no boot



if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then

    CheckIPLocal
    ACRURL="http://$IPLocal/log.php"
    # reconfigura a config caso seja necessario
    acr.browser.barebones.set.config
    # abre o navegador no link setado acima
    if [ ! -f /data/asusbox/fullInstall ]; then
        acr.browser.barebones.launch
    fi

fi
####################### AKP Results >>> Thu Sep 30 17:01:17 BRT 2021
Senha7z="a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da"
apkName="ao.06"
app="com.mixplorer"
versionNameOnline="Thu Sep 30 17:01:17 BRT 2021"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/04.akp.oem/ao.06/AKP/ao.06.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/04.akp.oem/ao.06"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Thu Sep 30 17:01:17 BRT 2021
Senha7z="a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da"
apkName="ao.06"
app="com.mixplorer"
versionNameOnline="Tue Nov 24 22:16:05 BRST 2020"
SourcePack="/data/asusbox/.install/04.akp.oem/ao.06/DTF/ao.06.DTF"
excludeListPack "/data/asusbox/.install/04.akp.oem/ao.06"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.mixplorer/Tue Nov 24 22:16:05 BRST 2020" ] ; then
    pm clear com.mixplorer
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.mixplorer-*/lib/arm /data/data/com.mixplorer/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.mixplorer/Tue Nov 24 22:16:05 BRST 2020"
fi
###################################################################################
# config forçada para rodar sempre no boot


# se a box tiver privilégios de BoxListBetaInstallers vai liberar o acesso ao Mixplorer
checkUserAcess=`echo "$BoxListBetaInstallers" | grep "$Placa=$CpuSerial=$MacLanReal"`
if [ "$checkUserAcess" == "" ]; then
    pm disable com.mixplorer
else
    pm enable com.mixplorer
fi


####################### AKP Results >>> Fri Aug 20 21:30:35 BRT 2021
Senha7z="11J2skLJS3bUEvr5ZOabq49CW2H4Evu7lw1nYr9343IH5VySJtBCosGeUF1XTkeelUmBLf"
apkName="ao.10"
app="tv.pluto.android"
versionNameOnline="Fri Aug 20 21:30:35 BRT 2021"
AppGrantLoop=""
SourcePack="/data/asusbox/.install/04.akp.oem/ao.10/AKP/ao.10.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/04.akp.oem/ao.10"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### AKP Results >>> Mon Mar 14 15:39:38 BRT 2022
Senha7z="QYnjbpxnC01oaEeQn1aNSujr92lgKvjk4She815JHMCT9g21E4UoQ6fWCiu2PV540ueZvi"
apkName="ao.19"
app="com.google.android.youtube.tv"
versionNameOnline="Mon Mar 14 15:39:38 BRT 2022"
AppGrantLoop=""
SourcePack="/data/asusbox/.install/04.akp.oem/ao.19/AKP/ao.19.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/04.akp.oem/ao.19"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### AKP Results >>> Wed Feb  5 16:01:58 UTC___ 2025
Senha7z="Qzh5LTWj9ZxLjBrbEuJf7jhvfoeqisPTsGrvngTkdrsEyPsjFkfxVfr1luj5zu2pQukVhP"
apkName="ao.22"
app="com.netflix.mediaclient"
fakeName="Netflix (7.120.6 build 63 35594)"
versionNameOnline="Wed Feb  5 16:01:58 UTC___ 2025"
AppGrantLoop=""
SourcePack="/data/asusbox/.install/04.akp.oem/ao.22/AKP/ao.22.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/04.akp.oem/ao.22"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### AKP Results >>> Fri Sep 26 20:11:51 UTC___ 2025
Senha7z="kDYVBKspWUmbqTfLGlQWIsNKVANQgeYBNAmAuUiDVltGOoaxib1YPGyM6YeGgCV24ttRmO"
apkName="ao.23"
app="com.disney.disneyplus"
fakeName="Disney+ (4.15.0+rc3-2025.09.04)"
versionNameOnline="Fri Sep 26 20:11:51 UTC___ 2025"
AppGrantLoop=""
SourcePack="/data/asusbox/.install/04.akp.oem/ao.23/AKP/ao.23.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/04.akp.oem/ao.23"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### AKP Results >>> Fri Sep 26 20:14:08 UTC___ 2025
Senha7z="rR3XU99p089AQbre43naEuVYBNfrdIhgndyquV7n0CXoRK0PWL2w4HFcUoVAEtYMbnGHLF"
apkName="ao.24"
app="com.amazon.amazonvideo.livingroom"
fakeName="Prime Video (6.17.0+v15.1.0.291-armv7a)"
versionNameOnline="Fri Sep 26 20:14:08 UTC___ 2025"
AppGrantLoop=""
SourcePack="/data/asusbox/.install/04.akp.oem/ao.24/AKP/ao.24.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/04.akp.oem/ao.24"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


