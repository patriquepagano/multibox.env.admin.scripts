#!/system/bin/sh
SECONDS=0

export bootLog="/dev/null"

#unset PATH
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin
#unset LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib


export Senha7z="6ads5876f45a9sdf7as975a87"
export Produto="asusbox"
export PHome="/data/$Produto"
export HOME="/data/$Produto"

if [ ! -d $PHome ] ; then
 mkdir -p $PHome
fi

# sempre escreve no boot o android id
GetID=`settings get secure android_id` # puxa o ultimo id do android
export ID=`cat /data/$Produto/android_id` # id variavel que muda no hard reset
# compara para escrever apenas se mudou
if [ ! "$GetID" = "$ID" ];then
	echo "novo id instalado"
	echo -n $GetID > /data/$Produto/android_id # escreve novo id
	export ID=`cat /data/$Produto/android_id` # carrega o novo id
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

export CpuSerial=`busybox cat /proc/cpuinfo | busybox grep Serial | busybox awk '{ print $3 }'`
# informação variavel
export FirmwareVer=`busybox blkid | busybox sed -n '/system/s/.*UUID=\"\([^\"]*\)\".*/\1/p'`

export shellBin=`echo IyEvc3lzdGVtL2Jpbi9zaA== | /system/bin/busybox base64 -d`
export onLauncher="pm enable dxidev.toptvlauncher2"
export conf="/data/$Produto/.conf"
export www="$EXTERNAL_STORAGE/Android/data/$Produto/.www"
export systemLog="$www/system.log"
export wgetLog="$www/wget.log"

# export bootLog="$www/boot.log"
# export userLog="$www/user.log"

export wwwup="$EXTERNAL_STORAGE/Android/data/$Produto/.updates"
export fileUpdates="/data/$Produto/.updates"

# ver oque eu faço com estas variaveis
export bootLog="/data/$Produto/boot.log"
export userLog="/data/$Produto/user.log"


export PathSerial="/system/Serial"
export PathPin="/system/Pin"



# ☐ portabilizando a pasta install Show!!!!
#     - deixar o setup para o inicio não da! pq não tem interface para explicações
#     - gravar na /system/.install é uma péssima ideia! em menos de 3 messes todos os packs serão totalmente obsoletos e vai regravar tudo
#         * allwinner e varias box com uma partição system com mais de 2GB!!
#         * restore apos um hard-reset é muito rapido e atualizado!
#         + SEEDERS NA MARRA não tem como os clientes removerem o pendrive e parar de semear
#         + /system/.install inicia no firmware VAZIO! no primeiro connect com a rede baixa e enche o diretorio
#     + criar uma função para gerir a decisão do cache externo
#         - vai dar gente removendo o pendrive e o seed vai parar
#     + velocidade na gravação dos bin,libs e apps
#     + libera o data para apps
#     + criar um container dentro da /system/drive deixando 20% livre para uso do cliente, filmes ou jogos usar a memoria interna dele
#     + criar um if se a pasta existe $Drive/.install ele faz o symlink
#     ☐ definir quais etapas e funções
#         + is /data/asusbox/.install is monted ?
#         + check DevMount is present, mount .install
#         + check space target
#         + mount


function .installAsusBOX-PC () {
    FolderPath="/storage/asusboxUpdate"
    UUID=`/system/bin/busybox blkid | /system/bin/busybox grep "asusboxUpdate" | /system/bin/busybox head -n 1 | /system/bin/busybox cut -d "=" -f 3 | /system/bin/busybox cut -d '"' -f 2`
    if [ ! $UUID == "" ]; then    
        if [ ! -d $FolderPath ] ; then
            mkdir $FolderPath
            chmod 700 $FolderPath
        fi
        # montando o device
        /system/bin/busybox umount $FolderPath > /dev/null 2>&1  
        /system/bin/busybox mount -t ext4 LABEL="asusboxUpdate" $FolderPath
        # Symlink
        rm /data/asusbox/.install > /dev/null 2>&1    
        /system/bin/busybox ln -sf $FolderPath/asusbox/.install /data/asusbox/
        InstallFolder="ENABLED"
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### $FolderPath ativado como pasta .install" 
    fi
}

function .installSystem () {
    FolderPath="/system/.install"
    ### tamanho atual da pasta .install = 697512
    #/system/bin/busybox du -s /storage/AsusBOX-PC/asusbox/.install | /system/bin/busybox cut -f1
    SystemSpace=`/system/bin/busybox df | grep "/system" | /system/bin/busybox awk '/[0-9]%/{print $(NF-2)}'`
    #if [ "$SystemSpace" -ge "75000000000000000000000" ];then # debug para não utilizar a system
    if [ "$SystemSpace" -ge "750000" ];then        
        if [ ! -d $FolderPath ] ; then
            /system/bin/busybox mount -o remount,rw /system
            # montando o device
            mkdir $FolderPath
            chmod 700 $FolderPath
        fi
        # Symlink
        rm /data/asusbox/.install > /dev/null 2>&1    
        /system/bin/busybox ln -sf $FolderPath /data/asusbox/
        InstallFolder="ENABLED"
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### $FolderPath ativado como pasta .install"   
    fi
}

function .installSDcard () {
        FolderPath="/storage/emulated/0/Download/AsusBOX-UPDATE"
        if [ ! -d $FolderPath ] ; then
            mkdir $FolderPath
        fi
        # Symlink
        rm /data/asusbox/.install > /dev/null 2>&1    
        /system/bin/busybox ln -sf $FolderPath /data/asusbox/.install
        InstallFolder="ENABLED"
}



function Check.installFolder () {
    Clink=`/system/bin/busybox readlink -v "/data/asusbox/.install"` > /dev/null 2>&1    
    # test if symlink is broken (by seeing if it links to an existing file)
    if [ ! -e "$Clink" ] ; then
        InstallFolder="DISABLED"
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### Symlink /data/.install esta desativado"
        logcat -c
        if [ ! $InstallFolder == "ENABLED" ]; then
            echo "ADM DEBUG ########################################################"
            echo "ADM DEBUG ### verificando se existe storage ext4 AsusBOX-PC"    
            .installAsusBOX-PC
        fi
        # desativado pq esta dando problemas
        # if [ ! $InstallFolder == "ENABLED" ]; then
        #     echo "ADM DEBUG ########################################################"
        #     echo "ADM DEBUG ### verificando se existe espaço na /system/.install" 
        #     .installSystem
        # fi
        if [ ! $InstallFolder == "ENABLED" ]; then
            echo "ADM DEBUG ########################################################"
            echo "ADM DEBUG ### ativando a pasta install no SDCard" 
            .installSDcard
        fi
        Check.installFolder
    else
        InstallFolder="ENABLED"
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### $InstallFolder = $Clink" 
    fi    
}




### Precisa apagar o symlink sempre no boot pois se tiver um usb storage vai puxar do mesmo
# verifica sem um pendrive AsusBOX-PC esta conectado e o utiliza como .install
# verifica se tem espaço na system e seta o diretorio como .install
# instala no sdcard em ultimo caso > /storage/emulated/0/Download/AsusBOX-UPDATE (assim o cliente pode apagar no futuro)
rm -rf /data/asusbox/.install
Check.installFolder





function 7ZextractDir () {

if [ "$Senha7z" == "" ]; then
    Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
fi

eval $cmdCheck
rm /data/local/tmp/swap > /dev/null 2>&1
tmpUpdateF=/data/local/tmp/UpdateF

echo "ADM DEBUG #################################################################################"
echo "ADM DEBUG ########### $app | $FileName | $FileExtension ###################################"
echo "ADM DEBUG ########### Entrando na função 7ZextractDir #####################################"
echo "ADM DEBUG ########### versão Local  > $versionBinLocal"
echo "ADM DEBUG ########### versão online > $versionBinOnline"

if [ "$versionBinLocal" == "$versionBinOnline" ]; then # if do install
    echo "ADM DEBUG ########### $app esta atualizado! > $versionBinOnline"
    logcat -c
else

echo "$(date)" > $bootLog 2>&1
echo "Instalando o componente > $apkName" >> $bootLog 2>&1
echo "Por favor aguarde..." >> $bootLog 2>&1

    echo "ADM DEBUG ### Atualizando $app"    
    rm -rf $tmpUpdateF > /dev/null 2>&1
    mkdir -p $tmpUpdateF
    mkdir -p $pathToInstall
    # extract 7z splitted
    echo "ADM DEBUG ### Aguarde extraindo atualização. $app"
    /system/bin/7z x -aoa -y -p$Senha7z "$SourcePack.*" -oc:$tmpUpdateF > /dev/null 2>&1
fi
}

# batalha antiga usando binario do termux
# Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
# SourcePack="/data/asusbox/.install/01.sc.base/002.0/002.0"
# tmpUpdateF=/data/local/tmp/UpdateF
# /data/data/com.termux/files/usr/lib/p7zip/7za \
# x -aoa -y -p$Senha7z \
# "$SourcePack.*" -oc:$tmpUpdateF 






function AppGrant () {
    if [ ! "$AppGrantLoop" == "" ]; then
        for lgrant in $AppGrantLoop; do
            echo "ADM DEBUG ### aplicando o direito $lgrant ao $app"
            pm grant $app $lgrant
        done
    fi
}



function CheckImgLauncher () {
# regra! o trigger das mudanças ocorrem apenas quando for apagado ou modificado algo no tvbox para reflitir sempre o clone do vps
#####################################################################################################
# www .img.launcher
package=".img.launcher"

# # baixa o hash que contem o ultimo crc md5
# while [ 1 ]; do
#     $wget -N --no-check-certificate -P $fileChanges http://personaltecnico.net/Android/AsusBOX/A1/system/asusbox/share/$package.changes.txt > $wgetLog 2>&1
#     if [ $? = 0 ]; then break; fi;
#     sleep 1;
# done;

# chama a função para analizar a pasta do cliente se não foi modificada
HashFolder "$www/$package"
echo "$HashResult"
echo "Online"
checkNew=`$cat $fileChanges/$package.changes.txt`
echo "$checkNew"


sleep 500


if [ ! "$HashResult" = "$checkNew" ];then
    echo "Atualização online disponível"
    # download do pack
    while [ 1 ]; do
        /system/bin/busybox mount -o remount,rw /system
		echo $HOME
        FechaAria
        # --summary-interval=2147483647 --console-log-level=error
        $aria2c \
        --allow-overwrite=true \
		--show-console-readout=false \
		--summary-interval=2147483647 \
		--console-log-level=error \
		--file-allocation=none \
		http://45.79.48.215/asusbox/$package.7z \
		-d $SystemShare | sed -e 's/FILE:.*//g' >> $bootLog 2>&1
        if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
        $sleep 1;        
    done;
    echo "Download concluido" > $bootLog 2>&1
    
    $mkdir -p $wwwup
    echo "extraindo o arquivo"
    while [ 1 ]; do
        cd $wwwup
        $Zip x -y -p$Senha7z $SystemShare/$package.7z > /dev/null 2>&1
        if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
        $sleep 1;
    done;
    echo "rsync files"
    while [ 1 ]; do
        $rsync --progress -hv --delete --recursive --force $wwwup/$package/ $www/$package/ #> /dev/null 2>&1
        if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
        $sleep 1;
    done;
    $rm -rf $wwwup
fi
}


function CheckAKPinstallP2P () {
# senha dos arquivos compactados

if [ "$Senha7z" == "" ]; then
    Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
fi

# sistema antigo
# versionLocal=`dumpsys package $app | /system/bin/busybox grep versionName | /system/bin/busybox cut -d "=" -f 2 | /system/bin/busybox head -n 1`

# novo sistema baseado em crc32 dos apk's
# versionLocal=`/system/bin/busybox cksum /data/app/$app*/base.apk | /system/bin/busybox cut -d "/" -f 1`


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
    /system/bin/busybox find "/data/asusbox/AppLog/" -type f -name "$app=*" | while read fname; do
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
    echo "<h1>$(date)</h1>" > $bootLog 2>&1
    # echo "<h2>ASUSbox Informa</h2>" >> $bootLog 2>&1
    # echo "<h3>Grande atualização, por favor aguarde.</h3>" >> $bootLog 2>&1
    # echo "<h3>Arquivo grande pode demorar.</h3>" >> $bootLog 2>&1
    echo "ADM DEBUG ######################################################"
    echo "ADM DEBUG ### é AKP ou DTF ? = $AKPouDTF"
    echo "ADM DEBUG ### Arquivo já esta baixado e verificado CRC p2p"
    if [ "$AKPouDTF" == "AKP" ]; then
        echo "<h2>Instalando o aplicativo > $apkName</h2>" >> $bootLog 2>&1
        echo "<h3>Por favor aguarde...</h3>" >> $bootLog 2>&1
        # extract 7z splitted
        echo "ADM DEBUG ### extraindo 7Z $app"
        /system/bin/7z e -aoa -y -p$Senha7z "$SourcePack*.001" -oc:/data/local/tmp #> /dev/null 2>&1

# bug do arquivo corrompido falha aqui neste ponto
# echo "/system/bin/7z e -aoa -y -p$Senha7z \"$SourcePack*.001\" -oc:/data/local/tmp"
# exit

# # binario do termux dando problema mesmo apontando arquivo direto não trabalha com split files
# /system/bin/7z e -aoa -y -p$Senha7z "/data/asusbox/.install/04.akp.oem/ao.05/AKP/ao.05.AKP.001" -oc:/data/local/tmp

        echo "ADM DEBUG ### tentando instalar por cima o app $app"
        pm install -r /data/local/tmp/base.apk

        # downgrade forçado nos apps, se o cliente atualizar por sua conta
        # desistala o app novo! para instalar o do pack torrent em CIMA
        # se check crc for diferente ele vai entrar aqui descompactar apk
        if [ ! $? = 0 ]; then
            echo "ADM DEBUG ### Uninstall old app version"
            if [ -d /data/data/$app ]; then
                pm uninstall $app
            fi
            echo "ADM DEBUG ### primeira instalação do $app"
            pm install /data/local/tmp/base.apk
        fi
        
        echo "ADM DEBUG ### clean install file"
        rm /data/local/tmp/base.apk > /dev/null 2>&1
        echo "ADM DEBUG ### verificando se precisa liberar permissão para o $app"
        AppGrant

        echo "ADM DEBUG ### gravando o marcador"
        touch "/data/asusbox/AppLog/$app=$versionNameOnline.log"

    fi
    if [ "$LauncherIntegrated" == "yes" ]; then
        echo "ADM DEBUG ### ativando launcher official"
        #cmd package set-home-activity "dxidev.toptvlauncher2/.HomeActivity" # antiga launcher com botoes aparecendo
        cmd package set-home-activity "launcher.offline/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
}




function CheckBase64 () {
# versionBinLocal=`date` # para simular um erro nas versoes e gravar infinito
eval $cmdCheck
if [ ! "$versionBinOnline" == "$versionBinLocal" ]; then
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### função CheckBase64 #################################"
    echo "ADM DEBUG ### arquivo precisa ser atualizado > $pathToInstall"
    WriteBase64
else
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### $pathToInstall" esta atualizado!
    logcat -c
fi

}


function WriteBase64 () {
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### função WriteBase64 #################################"
    echo "ADM DEBUG ### gravando arquivo  > $pathToInstall"
    /system/bin/busybox mount -o remount,rw /system
    echo "$versionBinOnline" | /system/bin/busybox base64 -d > "$pathToInstall"
    /system/bin/busybox chmod $FilePerms $pathToInstall
    eval $NeedReboot
    echo "ADM DEBUG ### chama função CheckBase64 > $pathToInstall"
    CheckBase64
}








function CheckIPLocal () {
WlanIP=`/system/bin/busybox ip addr show wlan0 | /system/bin/busybox grep "inet " | /system/bin/busybox awk '{print $2}' | /system/bin/busybox cut -d "/" -f 1 | /system/bin/busybox head -1`
LanIP=`/system/bin/busybox ip addr show eth0 | /system/bin/busybox grep "inet " | /system/bin/busybox awk '{print $2}' | /system/bin/busybox cut -d "/" -f 1 | /system/bin/busybox head -1`

echo "Lista de IPs
Se o IP da wlan não estiver disponivel pega o da lan
WlanIP  $WlanIP
LanIP   $LanIP
"
if [ "$WlanIP" == "" ]; then
    export IPLocal="$LanIP"
else
    export IPLocal="$WlanIP"
fi

# IPLocal=`/system/bin/busybox ifconfig \
# | /system/bin/busybox grep -v 'P-t-P' \
# | /system/bin/busybox grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' \
# | /system/bin/busybox grep -Eo '([0-9]*\.){3}[0-9]*' \
# | /system/bin/busybox grep -v '127.0.0.1' \
# | /system/bin/busybox head -3`

}





function CheckInstallAKP () {
# senha dos arquivos compactados
Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
versionLocal=`dumpsys package $app | grep versionName | cut -d "=" -f 2`
crclocal=`HashFile /data/asusbox/$apkName.akp`
# se o app não estiver instalado baixa o akp
if [ ! "$versionLocal" == "$versionNameOnline" ]; then # NOVA TAREFA SE O CLIENTE ATUALIZAR O APP VAI SOBREESCREVER O INSTALL NO BOOT
    echo "<h1>$(date)</h1>" >> $bootLog 2>&1
    echo "<h2>ASUSbox Informa</h2>" >> $bootLog 2>&1
    echo "<h3>Grande atualização, por favor aguarde.</h3>" >> $bootLog 2>&1
    echo "<h3>Arquivo grande pode demorar.</h3>" >> $bootLog 2>&1
### DOWNLOAD COM SISTEMA MULTI-LINKS
for LinkUpdate in $multilinks; do
    echo "loop download > $LinkUpdate"
    if [ ! "$crclocal" == "$crcOnline" ]; then
            echo "Download akp"
            echo "<h2>Iniciando download $apkName por favor espere.</h2>" > $bootLog 2>&1
            echo -n $LinkUpdate > /data/local/tmp/url.list
            cat /data/local/tmp/url.list
            DownloadAKP
            crclocal=`HashFile /data/asusbox/$apkName.akp`       
            if [ "$crclocal" == "$crcOnline" ]; then break; fi; # check return value, break if successful (0)
            sleep 1;
    fi
echo "Download concluido $apkName" > $bootLog 2>&1
done
echo "<h2>Instalando o aplicativo > $apkName</h2>" >> $bootLog 2>&1
echo "<h3>Por favor aguarde...</h3>" >> $bootLog 2>&1
    # extract 7z
    /system/bin/7z e -aoa -y -p$Senha7z "/data/asusbox/$apkName.akp" -oc:/data/local/tmp
    # instalando o app
	pm install -r /data/local/tmp/base.apk
    rm /data/local/tmp/base.apk
    # Fix Launcher
    cmd package set-home-activity "dxidev.toptvlauncher2/.HomeActivity"
fi
}


function CheckInstallDTF () {
# senha dos arquivos compactados
Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
crclocal=`HashFile /data/asusbox/$apkName.DTF`
if [ ! "$crclocal" == "$crcOnline" ]; then
    echo "<h1>$(date)</h1>" >> $bootLog 2>&1
    echo "<h2>ASUSbox Informa</h2>" >> $bootLog 2>&1
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

function CheckUser {
UserPass=`/system/bin/busybox cat /data/data/com.asusbox.asusboxiptvbox/shared_prefs/loginPrefs.xml | /system/bin/busybox grep password | /system/bin/busybox cut -d '>' -f 2 | /system/bin/busybox cut -d '<' -f 1`
}


function DownloadAKP () {
echo "Iniciando download $apkName "> $bootLog 2>&1
FechaAria
$aria2c \
--check-certificate=false \
--show-console-readout=false \
--always-resume=true \
--allow-overwrite=true \
--summary-interval=10 \
--console-log-level=error \
--file-allocation=none \
--input-file=/data/local/tmp/url.list \
-d /data/asusbox | sed -e 's/FILE:.*//g' >> $bootLog 2>&1
}

function DownloadDTF () {
echo "Iniciando download $apkName "> $bootLog 2>&1
FechaAria
$aria2c \
--check-certificate=false \
--show-console-readout=false \
--always-resume=true \
--allow-overwrite=true \
--summary-interval=10 \
--console-log-level=error \
--file-allocation=none \
--input-file=/data/local/tmp/url.list \
-d /data/asusbox | sed -e 's/FILE:.*//g' >> $bootLog 2>&1
}

function DownloadSplitted () {
echo "Iniciando download $apkName "> $bootLog 2>&1
FechaAria
/system/bin/aria2c \
--check-certificate=false \
--show-console-readout=false \
--always-resume=true \
--allow-overwrite=true \
--summary-interval=10 \
--console-log-level=error \
--file-allocation=none \
--input-file=/data/local/tmp/url.list \
-d $InstallDir | sed -e 's/FILE:.*//g' >> $bootLog 2>&1
echo "Download Concluido!" > $bootLog 2>&1
}


#####################################################################################################
# Funções de download
function FechaAria () {
/system/bin/busybox kill -9 $(/system/bin/busybox pgrep aria2c) > /dev/null 2>&1
}

function FileListInstall () {

# verifica se esta instalado e funcionando
eval $cmdCheck
rm /data/local/tmp/swap > /dev/null 2>&1
echo "ADM DEBUG #############################################################"
echo "ADM DEBUG ### $app | $FileName | $FileExtension"
echo "ADM DEBUG ### versão local $versionBinLocal"
echo "ADM DEBUG ### versão online $versionBinOnline"


echo "$(date)" > $bootLog 2>&1
echo "Instalando o componente > $apkName" >> $bootLog 2>&1
echo "Por favor aguarde..." >> $bootLog 2>&1


if [ "$versionBinOnline" == "$versionBinLocal" ]; then # if do install
    echo "ADM DEBUG ### Componente $FileName Atualizado"
    logcat -c
else
# não existe mais comparação de arquivos online vs local em vista q download é via torrent.
    if [ "$FileExtension" == "SC" ]; then
        echo "ADM DEBUG ### extraindo ScriptPack $app"
        # extract 7z splitted
        echo "ADM DEBUG ### nome do path arquivo >>>> $SourcePack"
        echo "ADM DEBUG ### onde vai instalar $pathToInstall"
        /system/bin/7z e -aoa -y -p$Senha7z "$SourcePack" -oc:/data/local/tmp > /dev/null 2>&1
        # extract tar
        rm -rf /data/local/tmp/$FileName > /dev/null 2>&1
        mkdir -p /data/local/tmp/$FileName
        cd /data/local/tmp/$FileName
        /system/bin/busybox tar -mxvf /data/local/tmp/$FileName.tar.gz > /dev/null 2>&1
        # botar um if aqui se a var estiver vazia
        if [ "$pathToInstall" == "" ]; then
            echo "ADM DEBUG ### Cuidado! debugger se a variavel $pathToInstall estiver vazia! brica o TVbox"
            sleep 3
            break
        else          
            # rsync
            echo "ADM DEBUG ### rsync > /data/local/tmp/$FileName/ $pathToInstall/"
            mkdir -p $pathToInstall > /dev/null 2>&1
            cd $pathToInstall
            /system/bin/rsync --progress -avz --delete --recursive --force /data/local/tmp/$FileName/ $pathToInstall/ > /dev/null 2>&1
            # clean
            rm /data/local/tmp/$FileName.tar.gz > /dev/null 2>&1
            rm -rf /data/local/tmp/$FileName > /dev/null 2>&1
        fi
    fi 
    # extraindo os binarios para instalação
    if [ "$FileExtension" == "tar.gz" ]; then
        echo "ADM DEBUG ### extraindo tar.gz $app"
        # extract tar
        cd /
        /system/bin/busybox mount -o remount,rw /system
        /system/bin/busybox tar -mxvf $InstallDir/$FileName.tar.gz > /dev/null 2>&1
    fi
    if [ "$FileExtension" == "7z" ]; then
        echo "ADM DEBUG ### extraindo 7z $app"
        # extract 7z splitted
        /system/bin/7z e -aoa -y -p$Senha7z "$SourcePack.*" -oc:/data/local/tmp > /dev/null 2>&1
        # extract tar
        cd /
        /system/bin/busybox mount -o remount,rw /system
        /system/bin/busybox tar -mxvf /data/local/tmp/$FileName.tar.gz > /dev/null 2>&1
        rm /data/local/tmp/$FileName.tar.gz > /dev/null 2>&1
    fi
    if [ "$FileExtension" == "WebPack" ]; then
        # verifica e instala 
        7ZextractDir
        # rsync folder
        RsyncUpdateWWW
    fi
    # roda o script para concluir a instalação do binário em questão
    eval "$scriptOneTimeOnly"
fi ### end do if se esta instalado
}


function FixPerms () {
    # permissao do user da pasta
    DUser=`dumpsys package $app | /system/bin/busybox grep userId | /system/bin/busybox cut -d "=" -f 2 | /system/bin/busybox head -n 1`
    echo $DUser
    chown -R $DUser:$DUser /data/data/$app
    restorecon -FR /data/data/$app
}

# check crc para testar escrita e loopa ate conseguir
function HashALLFiles() {
    /system/bin/busybox rm /data/tmp.hash >/dev/null 2>&1
    /system/bin/busybox find $1 -type f \( -iname \* \) | /system/bin/busybox sort | while read fname; do
        /system/bin/busybox md5sum "$fname" | /system/bin/busybox cut -d ' ' -f1 >>/data/tmp.hash 2>&1
    done
    export HashResult=$(/system/bin/busybox cat /data/tmp.hash)
    /system/bin/busybox rm /data/tmp.hash >/dev/null 2>&1
}

function HashFile () {
/system/bin/busybox md5sum "$1" | /system/bin/busybox cut -d ' ' -f1
}

function HashFolder () {
/system/bin/busybox rm /data/tmp.hash > /dev/null 2>&1
/system/bin/busybox find $1 -type f \( -iname \*.sh -o -iname \*.webp -o -iname \*.jpg -o -iname \*.png -o -iname \*.php -o -iname \*.html -o -iname \*.js -o -iname \*.css \) | /system/bin/busybox sort | while read fname; do
    #echo "$fname"
    /system/bin/busybox md5sum "$fname" | /system/bin/busybox cut -d ' ' -f1 >> /data/tmp.hash 2>&1
done
export HashResult=`/system/bin/busybox cat /data/tmp.hash`
/system/bin/busybox rm /data/tmp.hash > /dev/null 2>&1
}

###############################################################################################################################
function LauncherBoot () {
while [ 1 ]; do
    echo "Download do wait allert para users"
    $wget -N --no-check-certificate -P $www http://personaltecnico.net/Android/AsusBOX/A1/www/boot.webp #> $wgetLog 2>&1
    if [ $? = 0 ]; then break; fi;
    sleep 1;
done;
# carrega a launcher oficial
package="dxidev.toptvlauncher2"
file=/data/data/$package/shared_prefs/PREFERENCE_DATA.xml
if [ ! -d /data/data/$package/shared_prefs ];then
    mkdir -p /data/data/$package/shared_prefs
fi
cat <<EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <int name="horizontalScrollView_AlignLeft_R1" value="0" />
    <int name="TilesRow5TileHeight" value="140" />
    <int name="TilesRow2Visible" value="0" />
    <int name="PickColorHue" value="230" />
    <string name="PinToUnlock"></string>
    <int name="TilesRow6Height" value="80" />
    <int name="ShowAppsRequiresPIN" value="0" />
    <int name="PickColorValue" value="64" />
    <int name="ScreenHeight" value="1920" />
    <int name="0dcClockSize" value="0" />
    <int name="EditModeEnabled" value="0" />
    <int name="TilesRow4TileHeight" value="109" />
    <int name="TilesRow1Visible" value="0" />
    <int name="TilesRow4Visible" value="0" />
    <int name="TilesRow2Height" value="180" />
    <int name="PickColorAlpha" value="180" />
    <int name="PickColorSaturation" value="100" />
    <string name="LinearTilesRowGravity_Row3">Center</string>
    <string name="dynamic_gridview_textsize">Medium</string>
    <int name="horizontalScrollView_AlignLeft_R3" value="0" />
    <string name="LinearTilesRowGravity_Row1">Center</string>
    <int name="ShowLongClickMenuDisabled" value="0" />
    <string name="LinearTilesRowGravity_Row4">Center</string>
    <string name="HiddenAppsList"></string>
    <int name="TilesRow2TileHeight" value="180" />
    <int name="TilesRow6TileHeight" value="80" />
    <string name="LinearTilesRowGravity_Row5">Center</string>
    <int name="TilesRow3TileHeight" value="170" />
    <int name="RandomInt" value="887" />
    <int name="NumberofAppDrawerColumns" value="3" />
    <int name="TilesRow4Height" value="110" />
    <int name="p_LastFocusedItem" value="529646" />
    <int name="horizontalScrollView_AlignLeft_R4" value="0" />
    <int name="ShowTTLSettingsRequiresPIN" value="1" />
    <int name="customTileBorderColorValue" value="64" />
    <string name="LinearTilesRowGravity_Row2">Center</string>
    <string name="SetWallpaperMethod">method3</string>
    <string name="TilesRow2"></string>
    <int name="customTileBorderColorAlpha" value="255" />
    <int name="TilesRow1Height" value="129" />
    <string name="wallpaper_location">$www/boot.webp</string>
    <int name="TilesRow3Visible" value="0" />
    <int name="horizontalScrollView_AlignLeft_R2" value="0" />
    <int name="UserHasOpenedEditLayout" value="1" />
    <int name="ShowAndroidSettingsRequiresPIN" value="0" />
    <string name="SettingsList"></string>
    <int name="ScreenWidth" value="1920" />
    <int name="customTileBorderColorHue" value="0" />
    <string name="0dcFont">Default</string>
    <string name="TilesRow1"></string>
    <string name="TilesRow3"></string>
    <int name="TilesRow1TileHeight" value="128" />
    <int name="TilesRow5Height" value="140" />
    <int name="launchStatus" value="16" />
    <int name="customTileBorderColorSaturation" value="60" />
    <string name="mainAppDraw_gridview_textsize">Medium</string>
    <int name="TilesRow3Height" value="170" />
</map>
EOF

# extrai na hora o numero de id do users permissions
while [ 1 ]; do
	uid=`dumpsys package $package | $grep "userId" | $cut -d "=" -f 2 | $cut -d " " -f 1`
	if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
	sleep 1;
done;
#echo $uid # debug verificar o numero do usuario
# applicar a permissão
$chown -R $uid:$uid /data/data/$package
$chmod 660 /data/data/$package/shared_prefs/*.xml
restorecon -FR /data/data/$package
}

function LauncherList () {
if [ "$LauncherIntegrated" == "yes" ]; then
    echo "ADM DEBUG ###########################################################"
    echo "ADM DEBUG ### adicionado a lista de aplicativos com launcher"
    #pm hide $app # não é necessário para os apps launcher atual
    if [ ! -f /data/asusbox/LauncherLock ]; then
        pm disable $app
    fi
    echo "$app" >> /data/asusbox/LauncherList
fi
}

function RsyncUpdateWWW () {
    eval $cmdCheck
    exclude="/data/local/tmp/exclude.txt"

    echo "ADM DEBUG #################################################################################" 
    echo "ADM DEBUG ########### Entrando na função RsyncUpdateWWW ###################################"

    if [ "$versionBinLocal" == "$versionBinOnline" ]; then # if do install
        echo "ADM DEBUG ########### $app esta atualizado!"
        logcat -c
    else
        echo -n "$ExcludeItens" > $exclude
        echo "ADM DEBUG ### Atualizando via rsync $app em > $pathToInstall"
        mkdir -p $pathToInstall
        cd $pathToInstall
        # copiar a pasta para o TMP
        /system/bin/rsync \
        --progress \
        -avz \
        --delete \
        --recursive \
        --force \
        --exclude-from=$exclude \
        /data/local/tmp/UpdateF/ $pathToInstall/ > /dev/null 2>&1
    fi
    rm -rf $tmpUpdateF > /dev/null 2>&1
    rm $exclude > /dev/null 2>&1
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

function extractDTF () {
echo "<h1>$(date)</h1>" >> $bootLog 2>&1
echo "<h2>Configurando o aplicativo > $apkName</h2>" >> $bootLog 2>&1
echo "<h3>Por favor aguarde...</h3>" >> $bootLog 2>&1
am force-stop $app
# extract 7z
/system/bin/7z e -aoa -y -p$Senha7z "/data/asusbox/$apkName.DTF" -oc:/data/local/tmp
# extract tar
cd /
/system/bin/busybox tar -mxvf /data/local/tmp/$apkName.DT.tar.gz
rm /data/local/tmp/$apkName.DT.tar.gz
}

function extractDTFSplitted () {
    echo "<h1>$(date)</h1>" > $bootLog 2>&1
    echo "<h2>Configurando o aplicativo > $apkName</h2>" >> $bootLog 2>&1
    echo "<h3>Por favor aguarde...</h3>" >> $bootLog 2>&1
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
}

function killcron () {
checkPort=`/system/bin/busybox ps \
| /system/bin/busybox grep "/system/bin/busybox crond" \
| /system/bin/busybox grep -v "grep" \
| /system/bin/busybox awk '{print $1}' \
| /system/bin/busybox sed -e 's/[^0-9]*//g'`
    if [ ! "$checkPort" == "" ]; then
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### Desligando serviço cron"
        echo "ADM DEBUG ### cron rodando na porta $checkPort"
        /system/bin/busybox kill -9 $checkPort
    fi
}


function p2pgetID () {
echo "ADM DEBUG ### $torFile"
torID=`/system/bin/transmission-remote --list \
| /system/bin/busybox grep "$torFile" \
| /system/bin/busybox awk '{print $1}' \
| /system/bin/busybox sed -e 's/[^0-9]*//g'`
echo "ADM DEBUG ### $torID"
}



############### problems
# + bom para baixar filmes e series na box botar isto no burnTV


# 1 - Arquivo torrent vai ser entregado pelo chaveador
# 2 - instalação vai ser toda por torrent pack
# 3 - syncthing ???

function InstallTransmission () {
if [ ! -e "/system/bin/transmission-daemon" ] ; then
echo "iniciando download do 010101.enc"
# md5sum não faz crc de pastas
# download pack online
# "C:\_Work\Dropbox\_TMP\010101.enc"

link="https://www.dropbox.com/s/m9crrzk6gezvnrs/010101.enc?dl=1"
link="http://45.79.48.215/asusbox/010101.enc"
# contou e inicia o download do torrent na hora
while [ 1 ]; do
    echo "Download test"	
	/system/bin/aria2c \
    --check-certificate=false \
    --allow-overwrite=true  \
    --file-allocation=none \
    $link \
    --dir=/data/local/tmp #| sed -e 's/FILE:.*//g' >> $bootLog 2>&1
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;

# extract from Download
Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
cd /data/local/tmp
/system/bin/7z e -aoa -p$Senha7z -y 010101.enc

# extract install transmission bin's
cd /system/bin
/system/bin/busybox mount -o remount,rw /system
/system/bin/busybox tar -xvf /data/local/tmp/transmission.tar.gz
chown root:root /system/bin/*
chmod 755 -R /system/bin/*

# extract install transmission lib's
cd /system/lib
/system/bin/busybox mount -o remount,rw /system
/system/bin/busybox tar -xvf /data/local/tmp/transmission.lib.tar.gz


# fix do libz
ln -sf /system/lib/libz.so /system/lib/libz.so.1


chown root:root /system/lib/*
chmod 644 /system/lib/libminiupnpc.so
chmod 644 /system/lib/libcrypto.so.1.1
chmod 644 /system/lib/libcurl.so
chmod 644 /system/lib/libevent-2.1.so
chmod 644 /system/lib/libnghttp2.so
chmod 644 /system/lib/libssl.so.1.1
chmod 644 /system/lib/libz.so.1

# extract install transmission web assets
cd /system/usr/share
/system/bin/busybox mount -o remount,rw /system
/system/bin/busybox tar -xvf /data/local/tmp/transmission.web.tar.gz
chown -R root:root /system/usr/share/transmission
chmod 777 -R /system/usr/share/transmission

# clean files
rm /data/local/tmp/trans*
rm /data/local/tmp/010101.enc
fi
}


function killTransmission () {
    checkPort=`netstat -ntlup | /system/bin/busybox grep "9091" | /system/bin/busybox cut -d ":" -f 2 | /system/bin/busybox awk '{print $1}'`
    if [ "$checkPort" == "9091" ]; then
        echo "ADM DEBUG ### Desligando transmission torrent downloader"
        /system/bin/transmission-remote --exit
        killall transmission-daemon
    fi
}


function restartTransmission () {
    killTransmission
    sleep 3
    StartDaemonTransmission
# melhor seria criar uma função e um script anexo para o cron / ai o cliente não tem chance de desativar
# netstat -ntlup | grep transmission
}

function SeedBOXTransmission () {
echo "seedbox $torFile.torrent"
##############################################################################################################
######### Seed BOX Torrents ##################################################################################
##############################################################################################################

p2pgetID
# sleep 2

# se não existir ID não existe o torrent na fila de downloads para ser removido
if [ ! "$torID" == "" ]; then
    echo "ADM DEBUG ##############################################################################"
    echo "ADM DEBUG ### remove o torrent obrigatório por conta do bug de salvar na pasta downloads"
    /system/bin/transmission-remote -t $torID -r
    echo "ADM DEBUG ##############################################################################"
fi

echo "ADM DEBUG ### conceito para adicionar torrents seguindo as politicas do daemon"
/system/bin/transmission-remote \
-a /data/asusbox/$torFile.torrent \
-m \
-x \
-o \
-y \
-w /data/asusbox/ \
-S
# vai verificar todos os arquivos baixados mesmo não setando o -v
# -S stopa o torrent para não baixar nada ainda


echo "ADM DEBUG ##############################################################################"
p2pgetID
# printa o conteudo do arquivo torrent, arquivo precisa ser adicionado para listar conteudo
/system/bin/transmission-remote -t $torID -f | /system/bin/busybox awk '{print $7}' | /system/bin/busybox sed 's;.install/;./;g' > /data/local/tmp/TorrentList
# remove novas linhas em branco
/system/bin/busybox sed -i -e '/^\s*$/d' /data/local/tmp/TorrentList
# aqui compara se o conteudo do torrent bate com a pasta atual para apagar arquivos obsoletos
/system/bin/busybox find "/data/asusbox/.install/" -type f -name "*" \
| /system/bin/busybox grep -v -f /data/local/tmp/TorrentList \
| while read fname; do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Limpando a pasta .install"
    #Fileloop=`basename $fname`
    #echo "eu vou apagar este arquivo > $fname"
    rm -rf "$fname"
done
rm /data/local/tmp/TorrentList



echo "ADM DEBUG ### -v verifica o torrent | -s inicia o torrent caso esteja pausado | torrent-done-script"
/system/bin/transmission-remote -t $torID -v -s --torrent-done-script /data/transmission/tasks.sh
echo "ADM DEBUG ##############################################################################"

}



function StartDaemonTransmission () {
#source /data/.vars # sera que realmente precisa disto??
configDir="/data/transmission"
seedBox="/sdcard/Download"
# pastas 
if [ ! -d $configDir ] ; then
    mkdir -p $configDir
fi
if [ ! -d $seedBox ] ; then
    mkdir -p $seedBox
fi
fileConf="/data/transmission/settings.json"
/system/bin/busybox sed -i -e 's;"umask":.*;"umask": 63,;g' $fileConf

# iniciei o daemon basico e no remote com todas as funções e com porta 51345 fechada! não iniciou nenhum up/down nem lp
high=65535
low=49152
export PeerPort=$(( ( RANDOM % (high-low) )  + low ))

echo "start" > /data/asusbox/transmission.log
echo "ADM DEBUG ### Iniciando transmission Daemon"
/system/bin/transmission-daemon \
-g $configDir \
-a 127.0.0.1,*.* \
-P $PeerPort \
-c /sdcard/Download/ \
-w $seedBox

}

function p2pWait () {
#if [ ! -f "/data/asusbox/FullInstall" ];then
	# script fica aguardando pelo arquivo para prosseguir
	FileWaitingP2P="/data/transmission/$torFile"
	/system/bin/busybox rm $FileWaitingP2P > /dev/null 2>&1
	while [ 1 ]; do
		if [ -e $FileWaitingP2P ];then break; fi;
		echo "Wait for update $torFile"
		# ShellResult=`/system/bin/transmission-remote --list`
		# echo "ADM DEBUG ### escrevendo no log web progresso do torrent"
		# echo "<h2>$ShellResult</h2>" > $bootLog 2>&1
		sleep 5;    
	done;
	echo "ADM DEBUG ### arquivo $FileWaitingP2P apagado!"
	/system/bin/busybox rm $FileWaitingP2P
#fi
}


function scriptAtBootFN () {
    if [ ! "$scriptAtBoot" == "" ]; then
        echo "runing code"
        eval "$scriptAtBoot"
    fi
}


function z_acr.browser.barebones.change.URL () {
    
    export LD_LIBRARY_PATH=/system/lib:/system/usr/lib
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
    <string name="home">http://127.0.0.1</string>
</map>

EOF
/system/bin/busybox sed -i -e "s;<string name=\"home\">.*</string>;<string name=\"home\">$ACRURL</string>;g" $FileXML

/system/bin/busybox chmod 660 /data/data/acr.browser.barebones/shared_prefs/*.xml
app="acr.browser.barebones"
FixPerms

}





function acr.browser.barebones.launch () {

    export LD_LIBRARY_PATH=/system/lib:/system/usr/lib
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
    <string name="home">http://127.0.0.1</string>
</map>

EOF
/system/bin/busybox chmod 660 /data/data/acr.browser.barebones/shared_prefs/*.xml
app="acr.browser.barebones"
FixPerms
echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### abre o navegador pela primeira vez"
monkey -p $app -c android.intent.category.LAUNCHER 1

fi

}






# variaveis de data unix epoch
dateOld="1630436299" # dia que foi feito este script
dateNew=`date +%s` # data atual no momento do boot

# dateNew=`/system/bin/busybox date -s "@232149354"` # debug simulation
# echo "
# OldDate $dateOld
# NewDate $dateNew
# "
# exit

# comparar a data local da box com unix if update via proxy time
#if [ "3" -gt "1" ];then
if [ "$dateOld" -gt "$dateNew" ];then
    echo "ADM DEBUG ##############################################################################"
    echo "ADM DEBUG ### atualizando horário a partir do clock server"
    TZ=UTC−03:00
    export TZ
    url="https://time.is/pt_br/Unix_time_converter"
    curl -ko /data/local/tmp/getTime $url
    epochDate=`/system/bin/busybox cat /data/local/tmp/getTime | /system/bin/busybox grep 'id="unix_time" value="' | /system/bin/busybox cut -d '"' -f 8`
    /system/bin/busybox date -s "@$epochDate"
    rm /data/local/tmp/getTime
fi



# -eq # equal
# -ne # not equal
# -lt # less than
# -le # less than or equal
# -gt # greater than
# -ge # greater than or equal






if [ ! "$cronRunning" == "yes" ]; then
    pm disable com.valor.mfc.droid.tvapp.generic
fi


echo -n "performance" >  /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

echo "ADM DEBUG ##############################################################################"
echo "ADM DEBUG ### Led ativa informando que não esta mais se atualizando"
echo "ADM DEBUG ### if tiver o arquivo second boot"
filesc="/data/asusbox/.sc/boot/led-on.sh"
if [  -f $filesc ];then
    $filesc &
fi

sleep 1 # precisa deste tempo para não fechar o script a seguir

# fica no initscript
echo "ADM DEBUG ##############################################################################"
echo "ADM DEBUG ### ativando o pisca alerta ate atualizar tudo"
echo "ADM DEBUG ### if tiver o arquivo second boot"
filesc="/data/asusbox/.sc/boot/led-blink-infinity.sh"
if [  -f $filesc ];then
    $filesc &
fi


# apagar este arquivo do sistema antigo sem uso
# /system/UUID


echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### limpando virus e rootkits"
rm -rf /data/local/tmp/* > /dev/null 2>&1

# virus porre
checkPort=`/system/bin/busybox pidof storm`
if [ ! "$checkPort" == "" ];then
/system/bin/busybox kill $checkPort
echo "ADM DEBUG ### virus rodando na porta $checkPort"
/system/bin/busybox mount -o remount,rw /system
rm /system/bin/storm
rm /system/bin/install-recovery.sh
rm /system/etc/init/storm.rc
rm /system/etc/storm.key
echo "NO!" > /system/bin/storm
busybox chmod 400 /system/bin/storm
fi




# Init-script le este arquivo para desativar todas as launchers no boot
# Apaga o arquivo marcador das launchers para que um novo seja feito no processo de boot.sh > UpdateSystem.sh
rm /data/asusbox/LauncherList > /dev/null 2>&1

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### apaga arquivo que geralmente serve para reboot em caso de modificação de sistema"
listApagar="/data/asusbox/reboot
/data/local/tmp/APPList
/data/local/tmp/PackList
/data/data/com.not.aa_image_viewer/cache/*
/storage/emulated/0/Download/*.apk
/storage/emulated/0/Android/data/asusbox/.www/lighttpd.log"
for DelFile in $listApagar; do    
    if [ -f "$DelFile" ];then
        rm -rf "$DelFile" > /dev/null 2>&1
    fi
done



if [ ! "$cronRunning" == "yes" ]; then    
# apaga provisoriamente os arquivos do torrent
# /data/transmission/resume
# /data/transmission/torrents
listApagar="/data/transmission"
for DelFile in $listApagar; do    
    if [ -f "$DelFile" ];then
        rm -rf "$DelFile" > /dev/null 2>&1
    fi
done
fi



listApagar="00.snib
01.sc
03.akp.base
04.akp.oem
05.akp.cl
07.dev"
for delfolder in $listApagar; do    
    if [ -d /storage/emulated/0/Download/$delfolder ];then
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### bug do torrents sendo baixado na pasta downloads"    
        echo $delfolder
        rm -rf /storage/emulated/0/Download/$delfolder
    fi
done

listApagar="/system/asusbox
/system/priv-app/DeviceTest
/system/priv-app/StressTest"
for delfolder in $listApagar; do
    if [ -d $delfolder ];then
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### Limpando a priv-app antigos asusbox"
        echo $delfolder
        /system/bin/busybox mount -o remount,rw /system
        rm -rf $delfolder
        # vai precisar reiniciar pois /data/data/app e os icones na launcher ficam apos estas remoção direta
        #echo -n 'ok' > /data/asusbox/reboot
    fi
done

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### arquivos antigos de instalação"
/system/bin/busybox find \
 /data/asusbox \
 -maxdepth 1 \
 -type f \( -iname \*.tar.gz -o -iname \*.apk -o -iname \*.akp -o -iname \*.AKP -o -iname \*.DTF \) \
 ! -name 'as.02.DTF' \
 ! -name 'as.03.DTF' \
 ! -name 'as.02.akp' \
 ! -name 'as.04.akp' \
 | /system/bin/busybox sort | while read fname; do
    echo "$fname"
    rm "$fname" > /dev/null 2>&1
done


echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### limpa o pipoca geral no boot o app é muito problemático"
if [  -d /storage/emulated/0/time4popcorn ];then
    rm -rf /storage/emulated/0/time4popcorn
fi


# # 
# if [ ! -e /data/asusbox/SenhaIPTV ]; then
# 	# redireciona os users para novo updatesystem assim toda instalação nova vai para o boot novo
# fi

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### limpando a mensagem de online do rootsudaemon antigo sistema"
service call notification 1
cmd statusbar collapse





# echo "ADM DEBUG ##############################################################"
# echo "ADM DEBUG ### permissoes da pasta install 700 pastas 600 para arquivos"
# # acertando as permissoes locais


# # novo teste:
# # baixar via torrent e verificar quais são as permissões e se baixa a data de criação dos arquivos
# # enviar via rsync mantendo permissoes e datas
# seedBox="/data/asusbox/.install"
# /system/bin/busybox chown -R root:root $seedBox
# /system/bin/busybox find $seedBox -type d -exec chmod 700 {} \; 
# /system/bin/busybox find $seedBox -type f -exec chmod 600 {} \;


# update salvar o code find acima para uso em outra coisa.

# resolvido o lance das permissoes com o umask do torrent





echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### BLOQUEANDO O ACESSO ROOT"
checkPin=`/system/bin/busybox cat /system/.pin`
if [ ! "$checkPin" = "FSgfdgkjhç8790d5sdf85sd867f5gs876df5g876sdf5g78s6df5g78s6df5gs87df6g576sfd" ];then
    /system/bin/busybox mount -o remount,rw /system
    echo -n 'FSgfdgkjhç8790d5sdf85sd867f5gs876df5g876sdf5g78s6df5g78s6df5gs87df6g576sfd' > /system/.pin
    chmod 644 /system/.pin
fi





if [ ! "$cronRunning" == "yes" ]; then

    # adicionar o secure android_id no hostname da box
    setprop net.hostname "AsusBOX-$ID"


export MacLanReal=`/system/bin/busybox ifconfig | /system/bin/busybox grep eth0 | /system/bin/busybox awk '{ print $5 }'`
export MacWiFiReal=`/system/bin/busybox ifconfig | /system/bin/busybox grep wlan0 | /system/bin/busybox awk '{ print $5 }'`
export IPLocalAtual=`/system/bin/busybox ifconfig | /system/bin/busybox grep -v 'P-t-P' | /system/bin/busybox grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | /system/bin/busybox grep -Eo '([0-9]*\.){3}[0-9]*' | /system/bin/busybox grep -v '127.0.0.1'`


echo "ADM DEBUG ###########################################################"
echo "ADM DEBUG ### ativando mac oficial para emulação clone"
# /data/asusbox/.sc/OnLine/mac.sh

# sleep 7

#   getprop net.hostname  #(this should display the current network name)

# identificar a versao do firmware aqui

# marcar espaços e definir qual é a placa ou software instalado

fi












# script feito manual
# clear
# /system/bin/busybox mount -o remount,rw /system
# rm /system/bin/transmission-remote

app="transmission"
FileName="B.009.0-armeabi-v7a"

cmdCheck='/system/bin/transmission-remote -V > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
eval $cmdCheck
versionBinOnline="transmission-remote 3.00 (bb6b5a062e)"
Senha7z="S1IiSP6YHAcIYPgXz8urgne2xvKpcGFkVqYQdw3RO6nWa0JKMxTBAm158h2lxv2RXcO9cb"

if [ ! "$versionBinOnline" == "$versionBinLocal" ]; then
busybox mkdir -p /data/local/tmp
function CurlDownload () {
httpCode=`curl -w "%{http_code}" \
-o /data/local/tmp/B.009.0-armeabi-v7a.001 \
http://personaltecnico.net/Android/AsusBOX/A1/data/asusbox/B.009.0-armeabi-v7a.001 \
| busybox sed 's/\r$//'`
}
while [ 1 ]; do
	echo "Iniciando Download"
	CurlDownload
	if [ $httpCode = "200" ]; then break; fi; # check return value, break if successful (0)
	busybox sleep 5;     
done;

echo "ADM DEBUG ### extraindo 7z $app"
# extract 7z splitted
/system/bin/7z e -aoa -y -p$Senha7z "/data/local/tmp/B.009.0-armeabi-v7a.001" -oc:/data/local/tmp > /dev/null 2>&1
# extract tar
cd /
/system/bin/busybox mount -o remount,rw /system
/system/bin/busybox tar -mxvf /data/local/tmp/$FileName.tar.gz > /dev/null 2>&1
rm /data/local/tmp/$FileName* > /dev/null 2>&1

# Fix dos symlinks
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/transmission-create /system/bin/
ln -sf /system/usr/bin/transmission-remote /system/bin/
ln -sf /system/usr/bin/transmission-edit /system/bin/
ln -sf /system/usr/bin/transmission-show /system/bin/
ln -sf /system/usr/bin/transmission-daemon /system/bin/

fi

function Download_torrent_File () {
# erro 301 esta baixando o link
# 1 - nosso linode oficial
# 2 - site do asusbox
# 3 - linode do elton
# http://45.79.133.216/asusboxA1/.install.torrent
# http://asusbox.com.br/asusboxA1/.install.torrent
# http://45.79.48.215/asusboxA1/.install.torrent
multilinks="
http://45.79.133.216/asusboxA1/.install.torrent
https://asusbox.com.br/asusboxA1/.install.torrent
http://45.79.48.215/asusboxA1/.install.torrent
"
    ### DOWNLOAD COM SISTEMA MULTI-LINKS
    for LinkUpdate in $multilinks; do 
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### Entrando na função > Download_torrent_File"
        echo "ADM DEBUG ### tentando o link > $LinkUpdate"
        TorrentFileInstall="false" # ate que se prove o contrario não baixou o arquivo
        # Tenta conectar ao link 7 vezes 
        #/system/bin/wget --timeout=1 --tries=7 -O $bootFile --no-check-certificate $LinkUpdate
        /system/bin/wget -N --no-check-certificate --timeout=1 --tries=7 -P /data/asusbox/ $LinkUpdate > "/data/asusbox/wget.log" 2>&1
        CheckWgetCode=`/system/bin/busybox cat "/data/asusbox/wget.log" | /system/bin/busybox grep "HTTP request sent, awaiting response..."`
        #rm "/data/asusbox/wget.log"
            # Se tiver acesso finaliza esta função
            if [ "$CheckWgetCode" == "HTTP request sent, awaiting response... 200 OK" ] ; then
                echo "ADM DEBUG ### Wget :) $CheckWgetCode"
                TorrentFileInstall="true"
                break # fecha a função por completo
            fi
            if [ "$CheckWgetCode" == "HTTP request sent, awaiting response... 304 Not Modified" ] ; then
                echo "ADM DEBUG ### Wget :) $CheckWgetCode"
                TorrentFileInstall="true"
                break # fecha a função por completo
            fi            
    done ### DOWNLOAD COM SISTEMA MULTI-LINKS
    echo "ADM DEBUG ### fim da função TorrentFileInstall > TorrentFileInstall=$TorrentFileInstall"
}


function LoopForceDownloadtorrent_File () { # entra em looping até baixar o arquivo de boot
while true; do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Entrando na função > LoopForceDownloadtorrent_File"
    Download_torrent_File 
	if [ "$TorrentFileInstall" == "false" ]; then
        echo "ADM DEBUG ### Nova tentativa em loop para baixar"
        logcat -c
    else
        break
    fi
done
}

FileMark="/storage/asusboxUpdate/GitHUB/asusbox/adm.2.install/.install.torrent"
#if [ ! -f /system/etc/init/initRc.adm.drv.rc ]; then # Deu ruim pq se o pendrive não estiver montado não copia
if [ ! -f $FileMark ]; then
    # # verifica se for um symlink apaga
    # CheckSymlink=`/system/bin/busybox readlink -fn /data/asusbox/.install.torrent`
    # if [ ! "$CheckSymlink" == "/data/asusbox/.install.torrent" ] ; then
    #     rm /data/asusbox/.install.torrent
    # fi
    rm /data/asusbox/.install.torrent
    LoopForceDownloadtorrent_File
else
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### build generator testes detectado."
    echo "ADM DEBUG ### torrent vai fazer share do torrent local"
    rm /data/asusbox/.install.torrent
    /system/bin/busybox ln -sf $FileMark /data/asusbox/.install.torrent
    logcat -c
fi





TorrentPackVersion="Sat Sep 18 17:24:12 BRT 2021"



# These are inherited from Transmission.                                        #
# Do not declare these. Just use as needed.                                     #
#                                                                               #
# TR_APP_VERSION                                                                #
# TR_TIME_LOCALTIME                                                             #
# TR_TORRENT_DIR                                                                #
# TR_TORRENT_HASH                                                               #
# TR_TORRENT_ID                                                                 #
# TR_TORRENT_NAME


if [ ! -d "/data/transmission" ] ; then
    mkdir -p /data/transmission
fi

# Escreve aqui o script de pos exec do torrent
cat << 'EOF' > /data/transmission/tasks.sh
#!/system/bin/sh
echo -n $TR_TORRENT_ID > /data/transmission/$TR_TORRENT_NAME
EOF
chmod 755 /data/transmission/tasks.sh

# 
#InstallTransmission # verificar se o sistema novo de bins contempla toda esta função

killTransmission 

# export TRANSMISSION_WEB_HOME="/data/asusbox/.sc/boot/.w.conf/web-transmission"
export TRANSMISSION_WEB_HOME="/system/usr/share/transmission/web"
if [ ! -f "/data/transmission/settings.json" ];then
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### gerando config umask"
    StartDaemonTransmission
    sleep 1
    killTransmission
    sleep 1
    StartDaemonTransmission
else
    StartDaemonTransmission
fi

# abre o navegador
if [ ! "$cronRunning" == "yes" ]; then    
    CheckIPLocal
    ACRURL="http://$IPLocal:9091"
    # reconfigura a config caso seja necessario
    acr.browser.barebones.set.config
    # altera a home url do navegador
    z_acr.browser.barebones.change.URL


# temporario para testar os clientes tem que entender oque esta acontecendo
acr.browser.barebones.launch
echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### aguardando 7 segundos tempo para o StartDaemonTransmission concluir "
sleep 7

    # if [ ! -f /data/asusbox/fullInstall ]; then
    #     # abre o navegador no link setado acima
    #     acr.browser.barebones.launch
    # else
    #     echo "ADM DEBUG ########################################################"
    #     echo "ADM DEBUG ### aguardando 7 segundos tempo para o StartDaemonTransmission concluir "
    #     sleep 7
    # fi
else
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### aguardando 7 segundos tempo para o StartDaemonTransmission concluir "
    sleep 7
fi

# Pacotão update
torFile=".install"
SeedBOXTransmission

# sistema de marcador
if [ -f "/data/asusbox/AppLog/_TorrentPack=$TorrentPackVersion.log" ]; then
    echo "ADM DEBUG ###########################################################"
    echo "ADM DEBUG ### Pack torrent atualizado! liberando o p2p wait"
    echo "Skip torrent wait"
else
    p2pWait
    if [ ! -d /data/asusbox/AppLog ]; then 
        busybox mkdir -p /data/asusbox/AppLog 
    fi
    echo "ADM DEBUG ###########################################################"
    echo "ADM DEBUG ### removendo os marcadores de versão do torrent"
    /system/bin/busybox find "/data/asusbox/AppLog/" -type f -name "_TorrentPack=*" | while read fname; do
    busybox rm "$fname"
    done
    # gravando o marcador
    touch "/data/asusbox/AppLog/_TorrentPack=$TorrentPackVersion.log"
fi



# echo " parei o sistema aqui loop updatesystem"
# exit

####################### AKP Results >>> Sat Apr 10 19:30:32 BRT 2021
Senha7z="TlVoWbhybXuTUfRe3yBc8xEEG390CDLtbEFZ4CVTuMnMPxY2S3WIuse0CUFMwVUicAuucB"
apkName="006.0"
app="jackpal.androidterm"
versionNameOnline="Thu Jun  3 16:06:36 BRT 2021"
AppGrantLoop=""
SourcePack="/data/asusbox/.install/00.boot/006.0/AKP/006.0.AKP"
AKPouDTF="AKP"
LauncherIntegrated="no"
excludeListAPP
excludeListPack "/data/asusbox/.install/00.boot/006.0"
CheckAKPinstallP2P
LauncherList
### Manual AKP Config *******


####################### DTF Results >>> Sat Apr 10 19:30:32 BRT 2021
Senha7z="TlVoWbhybXuTUfRe3yBc8xEEG390CDLtbEFZ4CVTuMnMPxY2S3WIuse0CUFMwVUicAuucB"
apkName="006.0"
app="jackpal.androidterm"
versionNameOnline="Wed Dec 31 22:06:27 BRT 1969"
SourcePack="/data/asusbox/.install/00.boot/006.0/DTF/006.0.DTF"
excludeListPack "/data/asusbox/.install/00.boot/006.0"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/jackpal.androidterm/Wed Dec 31 22:06:27 BRT 1969" ] ; then
    pm clear jackpal.androidterm
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/jackpal.androidterm-*/lib/arm /data/data/jackpal.androidterm/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop=""
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/jackpal.androidterm/Wed Dec 31 22:06:27 BRT 1969"
fi
###################################################################################
# config forçada para rodar sempre no boot

#/data/asusbox/.sc/boot/menu/0.readLog/install.sh

export bootLog="/data/data/jackpal.androidterm/app_HOME/log.txt"

if [ ! -f /data/asusbox/fullInstall ]; then
    pm enable jackpal.androidterm
        if [ ! "$cronRunning" == "yes" ]; then
            echo "AsusBOX informa" > $bootLog
            echo "Aguarde atualizando Sistema" >> $bootLog
            chmod 777 $bootLog

            am force-stop jackpal.androidterm
            am start --user 0 \
            -n jackpal.androidterm/.Term \
            -a android.intent.action.VIEW 
        fi
fi

