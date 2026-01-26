
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

####################### AKP Results >>> Sat Dec  9 21:15:18 UTC___ 2023
Senha7z="FvdONx3132RvOEB2p9BCu3q1h4iW3728Why969f8hFyK7kcjOHxY6V4QEW3KhGLLKTRttX"
apkName="ac.090"
app="com.interactive.htviptv"
fakeName="HTV (4.9.0)"
versionNameOnline="Sat Dec  9 21:15:18 UTC___ 2023"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.090/AKP/ac.090.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.090"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Fri Jul 19 20:29:19 UTC___ 2024
Senha7z="FvdONx3132RvOEB2p9BCu3q1h4iW3728Why969f8hFyK7kcjOHxY6V4QEW3KhGLLKTRttX"
apkName="ac.090"
app="com.interactive.htviptv"
fakeName="HTV (4.9.0)"
versionNameOnline="Fri Jul 19 20:29:18 UTC___ 2024"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.090/DTF/ac.090.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.090"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.interactive.htviptv/Fri Jul 19 20:29:18 UTC___ 2024" ] ; then
    pm disable com.interactive.htviptv
    pm clear com.interactive.htviptv
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.interactive.htviptv-*/lib/arm /data/data/com.interactive.htviptv/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.interactive.htviptv/Fri Jul 19 20:29:18 UTC___ 2024"
    pm enable com.interactive.htviptv
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.interactive.htviptv" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

####################### AKP Results >>> Fri Nov 21 23:18:33 UTC___ 2025
Senha7z="TMSBaOtRjWNAHPktr7RDdt38kcxMmNfDT20WcbIIG2ztSwnUp2VPw0GCEIhbl387kDzGtu"
apkName="ac.114"
app="com.world.youcinetv"
fakeName="YouCine (1.15.1)"
versionNameOnline="Fri Nov 21 23:18:33 UTC___ 2025"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.114/AKP/ac.114.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.114"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Fri Nov 21 23:18:31 UTC___ 2025
Senha7z="TMSBaOtRjWNAHPktr7RDdt38kcxMmNfDT20WcbIIG2ztSwnUp2VPw0GCEIhbl387kDzGtu"
apkName="ac.114"
app="com.world.youcinetv"
fakeName="YouCine (1.15.1)"
versionNameOnline="Fri Nov 21 23:18:31 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.114/DTF/ac.114.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.114"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.world.youcinetv/Fri Nov 21 23:18:31 UTC___ 2025" ] ; then
    pm disable com.world.youcinetv
    pm clear com.world.youcinetv
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.world.youcinetv-*/lib/arm /data/data/com.world.youcinetv/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.world.youcinetv/Fri Nov 21 23:18:31 UTC___ 2025"
    pm enable com.world.youcinetv
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.world.youcinetv" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

####################### AKP Results >>> Fri Jan 23 17:01:24 UTC___ 2026
Senha7z="lPqPRo36lYXDT9F2AZutH8gYce38ygrMuVAZDM4R4szhxN6r68fdH4T51Q5PbyKXYpcuob"
apkName="ac.124"
app="com.global.latinotv"
fakeName="Tele Latino (5.46.5)"
versionNameOnline="Fri Jan 23 17:01:24 UTC___ 2026"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.124/AKP/ac.124.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.124"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Fri Jan 23 17:01:24 UTC___ 2026
Senha7z="lPqPRo36lYXDT9F2AZutH8gYce38ygrMuVAZDM4R4szhxN6r68fdH4T51Q5PbyKXYpcuob"
apkName="ac.124"
app="com.global.latinotv"
fakeName="Tele Latino (5.46.5)"
versionNameOnline="Fri Jan 23 17:01:23 UTC___ 2026"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.124/DTF/ac.124.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.124"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.global.latinotv/Fri Jan 23 17:01:23 UTC___ 2026" ] ; then
    pm disable com.global.latinotv
    pm clear com.global.latinotv
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.global.latinotv-*/lib/arm /data/data/com.global.latinotv/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.global.latinotv/Fri Jan 23 17:01:23 UTC___ 2026"
    pm enable com.global.latinotv
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.global.latinotv" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

####################### AKP Results >>> Fri Jan 23 16:58:46 UTC___ 2026
Senha7z="vqyxooRuMWUVBqa6IXJ6MsiT4uStWpTOExOwTETl0GEIDOt6sAx5aPJ7XNXE1Q7OGHpeHo"
apkName="ac.144"
app="com.teamsmart.videomanager.tv"
fakeName="SmartTube (30.48)"
versionNameOnline="Fri Jan 23 16:58:46 UTC___ 2026"
AppGrantLoop=""
SourcePack="/data/asusbox/.install/05.akp.cl/ac.144/AKP/ac.144.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.144"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### AKP Results >>> Fri Sep 26 21:42:57 UTC___ 2025
Senha7z="JstvhQV3ci9ydLpHK4kiUYj0yWDnOAjDmV3wvvErHytAQJJbCoBtnpuXgvz8tzhF2wu4YD"
apkName="ac.148"
app="com.android.mgstv"
fakeName="MAGIS (5.0.4)"
versionNameOnline="Fri Sep 26 21:42:57 UTC___ 2025"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.148/AKP/ac.148.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.148"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### AKP Results >>> Fri Sep 13 22:57:38 UTC___ 2024
Senha7z="fZhbrZLX0wGiRKNtLW3Bqti1qeB2sNym9mgnpDCFXhVSB48DAxzZ96ZvedNyKbSNwV4XMk"
apkName="ac.170"
app="com.digitizercommunity.loontv"
fakeName="Loon (2.0.95)"
versionNameOnline="Fri Sep 13 22:57:38 UTC___ 2024"
AppGrantLoop=""
SourcePack="/data/asusbox/.install/05.akp.cl/ac.170/AKP/ac.170.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.170"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### AKP Results >>> Fri Jan 31 23:01:58 UTC___ 2025
Senha7z="UefYqIr2RmcpgnG79rSulwc1cH14t7INdsY4ilsvJYafvzZsadzt4899V1Q6My9pqAVBJF"
apkName="ac.179"
app="com.chsz.efile.alphaplay"
fakeName="Alphaplay (a5.2.1-20240619)"
versionNameOnline="Fri Jan 31 23:01:58 UTC___ 2025"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.179/AKP/ac.179.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.179"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Fri Jan 31 23:01:57 UTC___ 2025
Senha7z="UefYqIr2RmcpgnG79rSulwc1cH14t7INdsY4ilsvJYafvzZsadzt4899V1Q6My9pqAVBJF"
apkName="ac.179"
app="com.chsz.efile.alphaplay"
fakeName="Alphaplay (a5.2.1-20240619)"
versionNameOnline="Fri Jan 31 23:01:57 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.179/DTF/ac.179.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.179"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.chsz.efile.alphaplay/Fri Jan 31 23:01:57 UTC___ 2025" ] ; then
    pm disable com.chsz.efile.alphaplay
    pm clear com.chsz.efile.alphaplay
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.chsz.efile.alphaplay-*/lib/arm /data/data/com.chsz.efile.alphaplay/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.chsz.efile.alphaplay/Fri Jan 31 23:01:57 UTC___ 2025"
    pm enable com.chsz.efile.alphaplay
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.chsz.efile.alphaplay" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

####################### AKP Results >>> Mon Jun 23 21:25:30 UTC___ 2025
Senha7z="fvPVr6r5ljfy2cLjBPkCYVzEkkF91ujkNVqr5XDL4seZqmiAOuoDgdu4qmxv5NBEZb4Jn2"
apkName="ac.196"
app="iptv.vivo.player"
fakeName="Vivo Player (3.3.6)"
versionNameOnline="Mon Jun 23 21:25:30 UTC___ 2025"
AppGrantLoop=""
SourcePack="/data/asusbox/.install/05.akp.cl/ac.196/AKP/ac.196.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.196"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Mon Jun 23 21:25:30 UTC___ 2025
Senha7z="fvPVr6r5ljfy2cLjBPkCYVzEkkF91ujkNVqr5XDL4seZqmiAOuoDgdu4qmxv5NBEZb4Jn2"
apkName="ac.196"
app="iptv.vivo.player"
fakeName="Vivo Player (3.3.6)"
versionNameOnline="Mon Jun 23 21:25:30 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.196/DTF/ac.196.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.196"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/iptv.vivo.player/Mon Jun 23 21:25:30 UTC___ 2025" ] ; then
    pm disable iptv.vivo.player
    pm clear iptv.vivo.player
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/iptv.vivo.player-*/lib/arm /data/data/iptv.vivo.player/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop=""
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/iptv.vivo.player/Mon Jun 23 21:25:30 UTC___ 2025"
    pm enable iptv.vivo.player
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "iptv.vivo.player" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

####################### AKP Results >>> Fri Aug  8 23:25:11 UTC___ 2025
Senha7z="UNsHNp8HzuN0wcSgiU9oBM3usYtBAFA9vtNz3cDQ1pmkXdErexsX0lwdig7crquYFjM1dI"
apkName="ac.201"
app="br.com.kerhkhd"
fakeName="P2Mais v5.9.1 (5.9.1)"
versionNameOnline="Fri Aug  8 23:25:11 UTC___ 2025"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.201/AKP/ac.201.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.201"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Fri Aug  8 23:25:09 UTC___ 2025
Senha7z="UNsHNp8HzuN0wcSgiU9oBM3usYtBAFA9vtNz3cDQ1pmkXdErexsX0lwdig7crquYFjM1dI"
apkName="ac.201"
app="br.com.kerhkhd"
fakeName="P2Mais v5.9.1 (5.9.1)"
versionNameOnline="Fri Aug  8 23:25:09 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.201/DTF/ac.201.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.201"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/br.com.kerhkhd/Fri Aug  8 23:25:09 UTC___ 2025" ] ; then
    pm disable br.com.kerhkhd
    pm clear br.com.kerhkhd
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/br.com.kerhkhd-*/lib/arm /data/data/br.com.kerhkhd/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/br.com.kerhkhd/Fri Aug  8 23:25:09 UTC___ 2025"
    pm enable br.com.kerhkhd
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "br.com.kerhkhd" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

####################### AKP Results >>> Sat Aug  9 00:14:48 UTC___ 2025
Senha7z="izfLf7WHMiTzQr99NLmSpxZSYT2XuKXiBjnMU1vw1LhbGuS7dhmdysKOxycbBrP4l8Hope"
apkName="ac.205"
app="com.ibostore.meplayerib4k"
fakeName="MediaPlayerIbo (229.6)"
versionNameOnline="Sat Aug  9 00:14:48 UTC___ 2025"
AppGrantLoop=""
SourcePack="/data/asusbox/.install/05.akp.cl/ac.205/AKP/ac.205.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.205"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Sat Aug  9 00:14:47 UTC___ 2025
Senha7z="izfLf7WHMiTzQr99NLmSpxZSYT2XuKXiBjnMU1vw1LhbGuS7dhmdysKOxycbBrP4l8Hope"
apkName="ac.205"
app="com.ibostore.meplayerib4k"
fakeName="MediaPlayerIbo (229.6)"
versionNameOnline="Sat Aug  9 00:14:47 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.205/DTF/ac.205.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.205"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.ibostore.meplayerib4k/Sat Aug  9 00:14:47 UTC___ 2025" ] ; then
    pm disable com.ibostore.meplayerib4k
    pm clear com.ibostore.meplayerib4k
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.ibostore.meplayerib4k-*/lib/arm /data/data/com.ibostore.meplayerib4k/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop=""
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.ibostore.meplayerib4k/Sat Aug  9 00:14:47 UTC___ 2025"
    pm enable com.ibostore.meplayerib4k
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.ibostore.meplayerib4k" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

####################### AKP Results >>> Sat Aug  9 00:47:38 UTC___ 2025
Senha7z="7I83qKeLMLPqQcmMnAfabQ0xi26IccaKSvTqWBv2cpm5IXJQuvenN2T31SvLlgUe83nSPK"
apkName="ac.209"
app="io.gh.reisxd.tizentube.fortaleza"
fakeName="YouTube Premium ®FOR (: Fortaleza EC ®)"
versionNameOnline="Sat Aug  9 00:47:38 UTC___ 2025"
AppGrantLoop=""
SourcePack="/data/asusbox/.install/05.akp.cl/ac.209/AKP/ac.209.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.209"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### AKP Results >>> Fri Aug 22 22:12:42 UTC___ 2025
Senha7z="W3bzfo8LNliD3hA6JBhCmzGb49V3MSCO7QuMmfKs4TXeggr17egF1Z8SqPC8FwGQ3tmQk7"
apkName="ac.216"
app="com.bx.livf"
fakeName="STV (20250701)"
versionNameOnline="Fri Aug 22 22:12:42 UTC___ 2025"
AppGrantLoop="android.permission.CALL_PHONE
android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.216/AKP/ac.216.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.216"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Fri Sep 26 21:45:05 UTC___ 2025
Senha7z="W3bzfo8LNliD3hA6JBhCmzGb49V3MSCO7QuMmfKs4TXeggr17egF1Z8SqPC8FwGQ3tmQk7"
apkName="ac.216"
app="com.bx.livf"
fakeName="STV (20250701)"
versionNameOnline="Fri Sep 26 21:45:05 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.216/DTF/ac.216.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.216"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.bx.livf/Fri Sep 26 21:45:05 UTC___ 2025" ] ; then
    pm disable com.bx.livf
    pm clear com.bx.livf
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.bx.livf-*/lib/arm /data/data/com.bx.livf/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.bx.livf/Fri Sep 26 21:45:05 UTC___ 2025"
    pm enable com.bx.livf
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.bx.livf" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

####################### AKP Results >>> Fri Sep 26 20:37:20 UTC___ 2025
Senha7z="d2hk4ObSxbXgMffjfyNzfziQK3lTFWlG9NjTRRQKoe5JDL1UfZne26vPazusKTdRRV5GQP"
apkName="ac.222"
app="com.integration.unitvsiptv"
fakeName="UniTV Free (5.3.1)"
versionNameOnline="Fri Sep 26 20:37:20 UTC___ 2025"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.222/AKP/ac.222.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.222"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Fri Sep 26 20:37:19 UTC___ 2025
Senha7z="d2hk4ObSxbXgMffjfyNzfziQK3lTFWlG9NjTRRQKoe5JDL1UfZne26vPazusKTdRRV5GQP"
apkName="ac.222"
app="com.integration.unitvsiptv"
fakeName="UniTV Free (5.3.1)"
versionNameOnline="Fri Sep 26 20:37:18 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.222/DTF/ac.222.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.222"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.integration.unitvsiptv/Fri Sep 26 20:37:18 UTC___ 2025" ] ; then
    pm disable com.integration.unitvsiptv
    pm clear com.integration.unitvsiptv
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
rm /storage/emulated/0/.config
rm /storage/emulated/0/.properties
echo -n '#personal info
#Sat Aug 30 22:49:36 GMT-03:00 2025
key_device_id_unitvfree=443141686b59376e573358313356714b66417a3573413d3d
key_sn_token_unitvfree=546e4753625874497347715162776969354c4f65626a6c3838746d794f514134
' > /storage/emulated/0/.config

    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.integration.unitvsiptv-*/lib/arm /data/data/com.integration.unitvsiptv/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.integration.unitvsiptv/Fri Sep 26 20:37:18 UTC___ 2025"
    pm enable com.integration.unitvsiptv
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.integration.unitvsiptv" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

####################### AKP Results >>> Fri Sep 26 20:47:00 UTC___ 2025
Senha7z="lgCIglqBw75gJzYxFMLcJHIkZsd4MEHUskmNZJgJcRh7MGSfJ7HXM8u3R6plGrgaGsMtxy"
apkName="ac.223"
app="com.new2tourosat.app"
fakeName="Tourolive T1 (2.4.4)"
versionNameOnline="Fri Sep 26 20:47:00 UTC___ 2025"
AppGrantLoop=""
SourcePack="/data/asusbox/.install/05.akp.cl/ac.223/AKP/ac.223.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.223"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Fri Sep 26 20:46:59 UTC___ 2025
Senha7z="lgCIglqBw75gJzYxFMLcJHIkZsd4MEHUskmNZJgJcRh7MGSfJ7HXM8u3R6plGrgaGsMtxy"
apkName="ac.223"
app="com.new2tourosat.app"
fakeName="Tourolive T1 (2.4.4)"
versionNameOnline="Fri Sep 26 20:46:59 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.223/DTF/ac.223.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.223"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.new2tourosat.app/Fri Sep 26 20:46:59 UTC___ 2025" ] ; then
    pm disable com.new2tourosat.app
    pm clear com.new2tourosat.app
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.new2tourosat.app-*/lib/arm /data/data/com.new2tourosat.app/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop=""
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.new2tourosat.app/Fri Sep 26 20:46:59 UTC___ 2025"
    pm enable com.new2tourosat.app
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.new2tourosat.app" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

####################### AKP Results >>> Fri Nov 21 23:24:24 UTC___ 2025
Senha7z="wQZFLXVNYFCamFHtrCR9arhB46BybXIE47tGOn3uUnXGDzQRRcRQA0kj3yAIH9vvx31Igy"
apkName="ac.225"
app="com.exploudapps.maxnettv"
fakeName="Max Net TV (12.3)"
versionNameOnline="Fri Nov 21 23:24:24 UTC___ 2025"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.225/AKP/ac.225.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.225"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Fri Nov 21 23:24:24 UTC___ 2025
Senha7z="wQZFLXVNYFCamFHtrCR9arhB46BybXIE47tGOn3uUnXGDzQRRcRQA0kj3yAIH9vvx31Igy"
apkName="ac.225"
app="com.exploudapps.maxnettv"
fakeName="Max Net TV (12.3)"
versionNameOnline="Fri Nov 21 23:24:24 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.225/DTF/ac.225.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.225"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.exploudapps.maxnettv/Fri Nov 21 23:24:24 UTC___ 2025" ] ; then
    pm disable com.exploudapps.maxnettv
    pm clear com.exploudapps.maxnettv
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.exploudapps.maxnettv-*/lib/arm /data/data/com.exploudapps.maxnettv/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.exploudapps.maxnettv/Fri Nov 21 23:24:24 UTC___ 2025"
    pm enable com.exploudapps.maxnettv
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.exploudapps.maxnettv" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

####################### AKP Results >>> Fri Jan 23 16:57:48 UTC___ 2026
Senha7z="7uXfwfCjTheIecYJQFl2bTAYfhgYhD9jAH7uT06IDaTPOgzUaVAyDtgTQAOc8r9a9C7IDb"
apkName="ac.228"
app="com.newone.p2p1"
fakeName="NEW ONE P2P (1.0.7)"
versionNameOnline="Fri Jan 23 16:57:48 UTC___ 2026"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.228/AKP/ac.228.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.228"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Fri Jan 23 16:57:47 UTC___ 2026
Senha7z="7uXfwfCjTheIecYJQFl2bTAYfhgYhD9jAH7uT06IDaTPOgzUaVAyDtgTQAOc8r9a9C7IDb"
apkName="ac.228"
app="com.newone.p2p1"
fakeName="NEW ONE P2P (1.0.7)"
versionNameOnline="Fri Jan 23 16:57:47 UTC___ 2026"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.228/DTF/ac.228.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.228"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.newone.p2p1/Fri Jan 23 16:57:47 UTC___ 2026" ] ; then
    pm disable com.newone.p2p1
    pm clear com.newone.p2p1
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.newone.p2p1-*/lib/arm /data/data/com.newone.p2p1/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.newone.p2p1/Fri Jan 23 16:57:47 UTC___ 2026"
    pm enable com.newone.p2p1
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.newone.p2p1" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

####################### AKP Results >>> Thu Dec  4 21:33:57 UTC___ 2025
Senha7z="6sW73WsTmDhvUbGSyQPbmRG3tA2p7s1M11p6cuh5hfN7dZ5dg2oMXkTDadXATIokZiZzJ9"
apkName="ac.229"
app="iptvsmart.iboxt"
fakeName="DUNA XTP (1.18)"
versionNameOnline="Thu Dec  4 21:33:57 UTC___ 2025"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.229/AKP/ac.229.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.229"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Thu Dec  4 21:33:57 UTC___ 2025
Senha7z="6sW73WsTmDhvUbGSyQPbmRG3tA2p7s1M11p6cuh5hfN7dZ5dg2oMXkTDadXATIokZiZzJ9"
apkName="ac.229"
app="iptvsmart.iboxt"
fakeName="DUNA XTP (1.18)"
versionNameOnline="Thu Dec  4 21:33:57 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.229/DTF/ac.229.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.229"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/iptvsmart.iboxt/Thu Dec  4 21:33:57 UTC___ 2025" ] ; then
    pm disable iptvsmart.iboxt
    pm clear iptvsmart.iboxt
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/iptvsmart.iboxt-*/lib/arm /data/data/iptvsmart.iboxt/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/iptvsmart.iboxt/Thu Dec  4 21:33:57 UTC___ 2025"
    pm enable iptvsmart.iboxt
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "iptvsmart.iboxt" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

####################### AKP Results >>> Thu Dec  4 21:40:44 UTC___ 2025
Senha7z="D4ZrHN0Iab2RbDgewMgAEZAJIoBLv455GRk68dqF9eAKc7PPEowYeGteTyXWpgxV7zO9fF"
apkName="ac.230"
app="com.vupurple.player"
fakeName="VU Player Pro (1.6)"
versionNameOnline="Thu Dec  4 21:40:44 UTC___ 2025"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.230/AKP/ac.230.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.230"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Thu Dec  4 21:40:44 UTC___ 2025
Senha7z="D4ZrHN0Iab2RbDgewMgAEZAJIoBLv455GRk68dqF9eAKc7PPEowYeGteTyXWpgxV7zO9fF"
apkName="ac.230"
app="com.vupurple.player"
fakeName="VU Player Pro (1.6)"
versionNameOnline="Thu Dec  4 21:40:44 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.230/DTF/ac.230.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.230"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.vupurple.player/Thu Dec  4 21:40:44 UTC___ 2025" ] ; then
    pm disable com.vupurple.player
    pm clear com.vupurple.player
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.vupurple.player-*/lib/arm /data/data/com.vupurple.player/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.vupurple.player/Thu Dec  4 21:40:44 UTC___ 2025"
    pm enable com.vupurple.player
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.vupurple.player" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

####################### AKP Results >>> Thu Dec  4 21:48:01 UTC___ 2025
Senha7z="mlguxqDfoy9yWmONZMsfsYZP0fReNJ1JkzKtt7OrIu8WwiY7OenuUTGzgM11mKyxcUneOm"
apkName="ac.232"
app="com.wapp.ibo"
fakeName="Wapp IBO (3.9)"
versionNameOnline="Thu Dec  4 21:48:01 UTC___ 2025"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.232/AKP/ac.232.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.232"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Thu Dec  4 21:48:00 UTC___ 2025
Senha7z="mlguxqDfoy9yWmONZMsfsYZP0fReNJ1JkzKtt7OrIu8WwiY7OenuUTGzgM11mKyxcUneOm"
apkName="ac.232"
app="com.wapp.ibo"
fakeName="Wapp IBO (3.9)"
versionNameOnline="Thu Dec  4 21:48:00 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.232/DTF/ac.232.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.232"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.wapp.ibo/Thu Dec  4 21:48:00 UTC___ 2025" ] ; then
    pm disable com.wapp.ibo
    pm clear com.wapp.ibo
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.wapp.ibo-*/lib/arm /data/data/com.wapp.ibo/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.wapp.ibo/Thu Dec  4 21:48:00 UTC___ 2025"
    pm enable com.wapp.ibo
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.wapp.ibo" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

####################### AKP Results >>> Thu Dec  4 21:52:29 UTC___ 2025
Senha7z="XxBfGRlfTb4XYwhRiiCOy8vh8m5kSYhRyuUrQal0LkVMlVGp8ICtzqc8b23exyRhpTZkaE"
apkName="ac.233"
app="com.bnii.app"
fakeName="UniTV (4.14.4)"
versionNameOnline="Thu Dec  4 21:52:29 UTC___ 2025"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.233/AKP/ac.233.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.233"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Thu Dec  4 21:52:28 UTC___ 2025
Senha7z="XxBfGRlfTb4XYwhRiiCOy8vh8m5kSYhRyuUrQal0LkVMlVGp8ICtzqc8b23exyRhpTZkaE"
apkName="ac.233"
app="com.bnii.app"
fakeName="UniTV (4.14.4)"
versionNameOnline="Thu Dec  4 21:52:28 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.233/DTF/ac.233.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.233"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.bnii.app/Thu Dec  4 21:52:28 UTC___ 2025" ] ; then
    pm disable com.bnii.app
    pm clear com.bnii.app
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.bnii.app-*/lib/arm /data/data/com.bnii.app/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.bnii.app/Thu Dec  4 21:52:28 UTC___ 2025"
    pm enable com.bnii.app
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.bnii.app" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

####################### AKP Results >>> Fri Jan 23 17:37:59 UTC___ 2026
Senha7z="VnqUp6KJlnTOZZbtKpBnWe55LRyJtTiG0kVSJKVXueFaTVruso0e5CcHABH9TXSRJKCCCE"
apkName="ac.234"
app="com.hd.sport.live"
fakeName="Hoje TV (2.2.188)"
versionNameOnline="Fri Jan 23 17:37:59 UTC___ 2026"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.234/AKP/ac.234.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.234"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Fri Jan 23 17:37:56 UTC___ 2026
Senha7z="VnqUp6KJlnTOZZbtKpBnWe55LRyJtTiG0kVSJKVXueFaTVruso0e5CcHABH9TXSRJKCCCE"
apkName="ac.234"
app="com.hd.sport.live"
fakeName="Hoje TV (2.2.188)"
versionNameOnline="Fri Jan 23 17:37:56 UTC___ 2026"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.234/DTF/ac.234.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.234"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.hd.sport.live/Fri Jan 23 17:37:56 UTC___ 2026" ] ; then
    pm disable com.hd.sport.live
    pm clear com.hd.sport.live
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.hd.sport.live-*/lib/arm /data/data/com.hd.sport.live/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.hd.sport.live/Fri Jan 23 17:37:56 UTC___ 2026"
    pm enable com.hd.sport.live
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.hd.sport.live" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

####################### AKP Results >>> Fri Jan 23 17:40:26 UTC___ 2026
Senha7z="g8idd83cNu4jnMzJZm83eVPAjr1FJ8dhxd1ZX8n9Jyb49mSQ1QiMSU1MmiBnXiiBSIE7ck"
apkName="ac.235"
app="io.wareztv.android.pro"
fakeName="WPlay Pro (4.2.8)"
versionNameOnline="Fri Jan 23 17:40:26 UTC___ 2026"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.235/AKP/ac.235.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.235"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Fri Jan 23 17:40:26 UTC___ 2026
Senha7z="g8idd83cNu4jnMzJZm83eVPAjr1FJ8dhxd1ZX8n9Jyb49mSQ1QiMSU1MmiBnXiiBSIE7ck"
apkName="ac.235"
app="io.wareztv.android.pro"
fakeName="WPlay Pro (4.2.8)"
versionNameOnline="Fri Jan 23 17:40:26 UTC___ 2026"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.235/DTF/ac.235.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.235"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/io.wareztv.android.pro/Fri Jan 23 17:40:26 UTC___ 2026" ] ; then
    pm disable io.wareztv.android.pro
    pm clear io.wareztv.android.pro
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/io.wareztv.android.pro-*/lib/arm /data/data/io.wareztv.android.pro/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/io.wareztv.android.pro/Fri Jan 23 17:40:26 UTC___ 2026"
    pm enable io.wareztv.android.pro
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "io.wareztv.android.pro" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

####################### AKP Results >>> Fri Jan 23 18:10:03 UTC___ 2026
Senha7z="dnllyzajjcpXpnRzQYwbZDhGsQ3QzX4eXndrCLRZ7b3IIFWqxcxHFJ2kq9TOYCtHUC6swh"
apkName="ac.236"
app="com.flextv.livestore"
fakeName="Ibo Player Pro (3.5)"
versionNameOnline="Fri Jan 23 18:10:03 UTC___ 2026"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.236/AKP/ac.236.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.236"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Fri Jan 23 18:10:01 UTC___ 2026
Senha7z="dnllyzajjcpXpnRzQYwbZDhGsQ3QzX4eXndrCLRZ7b3IIFWqxcxHFJ2kq9TOYCtHUC6swh"
apkName="ac.236"
app="com.flextv.livestore"
fakeName="Ibo Player Pro (3.5)"
versionNameOnline="Fri Jan 23 18:10:01 UTC___ 2026"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.236/DTF/ac.236.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.236"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.flextv.livestore/Fri Jan 23 18:10:01 UTC___ 2026" ] ; then
    pm disable com.flextv.livestore
    pm clear com.flextv.livestore
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.flextv.livestore-*/lib/arm /data/data/com.flextv.livestore/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.flextv.livestore/Fri Jan 23 18:10:01 UTC___ 2026"
    pm enable com.flextv.livestore
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.flextv.livestore" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

####################### AKP Results >>> Fri Jan 23 18:07:33 UTC___ 2026
Senha7z="QfxJcXCZYo0kxFOCDNky5288cRp30eyfWi1prU6hQe9fE2kH4vzVplBEw1hFh57Qu5vJzi"
apkName="ac.237"
app="com.super.tela"
fakeName="Vu Player (1.7)"
versionNameOnline="Fri Jan 23 18:07:33 UTC___ 2026"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.237/AKP/ac.237.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.237"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Fri Jan 23 18:07:31 UTC___ 2026
Senha7z="QfxJcXCZYo0kxFOCDNky5288cRp30eyfWi1prU6hQe9fE2kH4vzVplBEw1hFh57Qu5vJzi"
apkName="ac.237"
app="com.super.tela"
fakeName="Vu Player (1.7)"
versionNameOnline="Fri Jan 23 18:07:31 UTC___ 2026"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.237/DTF/ac.237.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.237"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.super.tela/Fri Jan 23 18:07:31 UTC___ 2026" ] ; then
    pm disable com.super.tela
    pm clear com.super.tela
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.super.tela-*/lib/arm /data/data/com.super.tela/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.super.tela/Fri Jan 23 18:07:31 UTC___ 2026"
    pm enable com.super.tela
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.super.tela" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

####################### AKP Results >>> Fri Jan 23 18:12:20 UTC___ 2026
Senha7z="AmxPoQHfBRrttx7smeZIdm4HjBSYI3Q3VQAMG7nzgqytIvcDcX9u0m7o15TgN5hZRexOin"
apkName="ac.238"
app="com.example.app"
fakeName="HTV (5.40.0)"
versionNameOnline="Fri Jan 23 18:12:20 UTC___ 2026"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.238/AKP/ac.238.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.238"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Fri Jan 23 18:12:19 UTC___ 2026
Senha7z="AmxPoQHfBRrttx7smeZIdm4HjBSYI3Q3VQAMG7nzgqytIvcDcX9u0m7o15TgN5hZRexOin"
apkName="ac.238"
app="com.example.app"
fakeName="HTV (5.40.0)"
versionNameOnline="Fri Jan 23 18:12:19 UTC___ 2026"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.238/DTF/ac.238.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.238"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.example.app/Fri Jan 23 18:12:19 UTC___ 2026" ] ; then
    pm disable com.example.app
    pm clear com.example.app
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.example.app-*/lib/arm /data/data/com.example.app/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.example.app/Fri Jan 23 18:12:19 UTC___ 2026"
    pm enable com.example.app
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.example.app" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

####################### AKP Results >>> Fri Jan 23 18:14:55 UTC___ 2026
Senha7z="gOLFpb6UH48EpWLCXPUATEEnznyoUSZ5FQvRsux7C7KQ3Y6q7fUhCrnmuZBhealMgDvQU2"
apkName="ac.239"
app="com.bnii.app"
fakeName="UniTV (4.14.4)"
versionNameOnline="Fri Jan 23 18:14:55 UTC___ 2026"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.239/AKP/ac.239.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.239"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Fri Jan 23 18:14:55 UTC___ 2026
Senha7z="gOLFpb6UH48EpWLCXPUATEEnznyoUSZ5FQvRsux7C7KQ3Y6q7fUhCrnmuZBhealMgDvQU2"
apkName="ac.239"
app="com.bnii.app"
fakeName="UniTV (4.14.4)"
versionNameOnline="Fri Jan 23 18:14:55 UTC___ 2026"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.239/DTF/ac.239.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.239"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.bnii.app/Fri Jan 23 18:14:55 UTC___ 2026" ] ; then
    pm disable com.bnii.app
    pm clear com.bnii.app
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.bnii.app-*/lib/arm /data/data/com.bnii.app/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.bnii.app/Fri Jan 23 18:14:55 UTC___ 2026"
    pm enable com.bnii.app
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.bnii.app" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

