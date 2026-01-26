#!/system/bin/sh

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

# novo sistema que trava em loop até conseguir baixar o uuid
# em breve o uuid sera o seria key
export UUID=`cat /system/UUID`
if [ "$UUID" = "" ] ; then
while [ 1 ]; do
    echo "Baixando novo UUID"
	while [ 1 ]; do
		UUID=`/system/bin/curl "http://personaltecnico.net/Android/RebuildRoms/keyaccess.php"`
		if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
		sleep 1;
	done;
	/system/bin/busybox mount -o remount,rw /system
	echo -n $UUID > /system/UUID
    export UUID=`cat /system/UUID`
     echo "Verificando UUID > $UUID"   
    if [  "$UUID" = "" ];then
        $?="1"	
    fi
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
fi



export ID=`cat /data/$Produto/android_id`
export UUID=`cat /system/UUID`
export CPU=`getprop ro.product.cpu.abi | sed -e 's/ /_/g'`
export Modelo=`getprop ro.product.model`
export RomBuild=`getprop ro.build.description | sed -e 's/ /_/g'`


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
    FolderPath="/storage/AsusBOX-PC"
    UUID=`/system/bin/busybox blkid | /system/bin/busybox grep "asusboxUpdate" | /system/bin/busybox head -n 1 | /system/bin/busybox cut -d "=" -f 3 | /system/bin/busybox cut -d '"' -f 2`
    if [ ! $UUID == "" ]; then    
        if [ ! -d $FolderPath ] ; then
            mkdir /storage/AsusBOX-PC
            chmod 700 /storage/AsusBOX-PC
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
        if [ ! $InstallFolder == "ENABLED" ]; then
            echo "ADM DEBUG ########################################################"
            echo "ADM DEBUG ### verificando se existe espaço na /system/.install" 
            .installSystem
        fi
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




function CheckAKPinstallP2P () {
# senha dos arquivos compactados

if [ "$Senha7z" == "" ]; then
    Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
fi

versionLocal=`dumpsys package $app | /system/bin/busybox grep versionName | /system/bin/busybox cut -d "=" -f 2 | /system/bin/busybox head -n 1`
echo "ADM DEBUG ###########################################################"
echo "ADM DEBUG ### $apkName >>>>>>> $app"
echo "ADM DEBUG ### versao local  > $versionLocal"
echo "ADM DEBUG ### versao online > $versionNameOnline"

if [ ! "$versionLocal" == "$versionNameOnline" ]; then # NOVA TAREFA SE O CLIENTE ATUALIZAR O APP VAI SOBREESCREVER O INSTALL NO BOOT
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
        /system/bin/7z e -aoa -y -p$Senha7z "$SourcePack*.001" -oc:/data/local/tmp > /dev/null 2>&1
# # binario do termux dando problema mesmo apontando arquivo direto não trabalha com split files
# /system/bin/7z e -aoa -y -p$Senha7z "/data/asusbox/.install/04.akp.oem/ao.05/AKP/ao.05.AKP.001" -oc:/data/local/tmp
        # instalando o app
        if [ -d /data/data/$app ];then
            echo "ADM DEBUG ### Uninstall old app version"
            pm uninstall $app
        fi
        echo "ADM DEBUG ### instalando $app por favor aguarde"
        pm install -r /data/local/tmp/base.apk
        rm /data/local/tmp/base.apk > /dev/null 2>&1
        echo "ADM DEBUG ### verificando se precisa liberar permissão para o $app"
        AppGrant
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








function CheckDownloadFiles () {
for line in $DataBankTMP; do
    #echo "linha >>> $line"
    # processar o DataBankTMP
    InstallDir=`echo $line | cut -d ";" -f 1`
    InstallFile=`echo $line | cut -d ";" -f 2`
    crcOnline=`echo $line | cut -d ";" -f 3`
    mirror1=`echo $line | cut -d ";" -f 4`
    mirror2=`echo $line | cut -d ";" -f 5`
    mirror3=`echo $line | cut -d ";" -f 6`
    mirror4=`echo $line | cut -d ";" -f 7`
    AKPouDTF=`echo $InstallDir | cut -d "/" -f 7`
    # verifica o arquivo local one time only no loop
    crclocal=`HashFile "$InstallDir$InstallFile"`
    echo "ADM DEBUG #############################################################"
    echo "ADM DEBUG ### Dentro da função CheckDownloadFiles #####################"
    echo "ADM DEBUG ### $InstallDir$InstallFile"
    echo "ADM DEBUG ### line LOCAL databank  > $crclocal"
    echo "ADM DEBUG ### line databank ONLINE > $crcOnline"
# Padrões de url
# https://docs.google.com/uc?id=1-T80NIomPkBxMPXyYVrIsHGfCzIf5Gmp&export=download
# https://drive.google.com/uc?export=download&id=1-T80NIomPkBxMPXyYVrIsHGfCzIf5Gmp
multilinks="https://drive.google.com/uc?export=download&id=$mirror1
https://drive.google.com/uc?export=download&id=$mirror2
https://drive.google.com/uc?export=download&id=$mirror3
https://drive.google.com/uc?export=download&id=$mirror4"

### DOWNLOAD COM SISTEMA MULTI-LINKS
for LinkUpdate in $multilinks; do
    #echo "line multilinks > $crcOnline"
    if [ ! "$crclocal" == "$crcOnline" ]; then
            echo "ADM DEBUG ### crc alterado $InstallDir$InstallFile"
            echo "ADM DEBUG ### loop download > $LinkUpdate"
            echo "ADM DEBUG ### Download $AKPouDTF"
            echo "ADM DEBUG ### Arquivo local esta desatualizado!"
            # cat /data/local/tmp/url.list # debug mostra oque tem dentro da lista

            # log para o painel
            echo "<h2>Iniciando download $apkName por favor espere.</h2>" > $bootLog 2>&1
            echo -n $LinkUpdate > /data/local/tmp/url.list            

            DownloadSplitted
            rm /data/local/tmp/url.list > /dev/null 2>&1
            crclocal=`HashFile "$InstallDir$InstallFile"`      
            if [ "$crclocal" == "$crcOnline" ]; then break; fi; # check return value, break if successful (0)
            sleep 1;
    fi
echo "<h2>Componente $apkName foi atualizado!</h2>" > $bootLog 2>&1
done ### DOWNLOAD COM SISTEMA MULTI-LINKS
done ### loop das linhas do DataBankTMP
}



function CheckFileListInstall () {
Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
# verifica se esta instalado e funcionando
eval $cmdCheck
echo "ADM DEBUG #############################################################"
echo "ADM DEBUG ### $app | $FileName | $FileExtension"
echo "ADM DEBUG ### versão local $versionBinLocal"
echo "ADM DEBUG ### versão online $versionBinOnline"

# sleep 3 # PARA FIMS DE DEBUGS

if [ "$versionBinOnline" == "$versionBinLocal" ]; then # if do install
    echo "ADM DEBUG ### Componente $FileName Atualizado"
    logcat -c
else
for line in $DataBankTMP; do
    #echo "linha >>> $line"
    # processar o DataBankTMP
    InstallDir=`echo $line | cut -d ";" -f 1`
    InstallFile=`echo $line | cut -d ";" -f 2`
    crcOnline=`echo $line | cut -d ";" -f 3`
    mirror1=`echo $line | cut -d ";" -f 4`
    mirror2=`echo $line | cut -d ";" -f 5`
    mirror3=`echo $line | cut -d ";" -f 6`
    mirror4=`echo $line | cut -d ";" -f 7`
    mirror5=`echo $line | cut -d ";" -f 8`
    mirror6=`echo $line | cut -d ";" -f 9`
    mirror7=`echo $line | cut -d ";" -f 10`
    # verifica o arquivo local one time only no loop
    crclocal=`HashFile "$InstallDir$InstallFile"`
    echo "ADM DEBUG ### $InstallDir$InstallFile"
    echo "ADM DEBUG ### line crc file $InstallFile > $crcOnline"
# Padrões de url
# https://docs.google.com/uc?id=1-T80NIomPkBxMPXyYVrIsHGfCzIf5Gmp&export=download
# https://drive.google.com/uc?export=download&id=1-T80NIomPkBxMPXyYVrIsHGfCzIf5Gmp
multilinks="https://drive.google.com/uc?export=download&id=$mirror1
https://drive.google.com/uc?export=download&id=$mirror2
https://drive.google.com/uc?export=download&id=$mirror3
https://drive.google.com/uc?export=download&id=$mirror4
https://drive.google.com/uc?export=download&id=$mirror5
https://drive.google.com/uc?export=download&id=$mirror6
https://drive.google.com/uc?export=download&id=$mirror7"
# echo "$multilinks"
    ### DOWNLOAD COM SISTEMA MULTI-LINKS
    for LinkUpdate in $multilinks; do # serão 7 loops dos 7 mirrors
        #echo "line multilinks > $crcOnline"
        if [ "$crclocal" == "$crcOnline" ]; then
                    #echo "arquivo exato! $InstallDir$InstallFile > $crclocal > $LinkUpdate"
                    break # se o arquivo de instalação esta com crc correto salta o loop
                else
                    echo "ADM DEBUG ### crc alterado $InstallDir$InstallFile"
                    echo "ADM DEBUG ### loop download > $LinkUpdate"
                    echo "<h2>Iniciando download $FileName por favor espere.</h2>" > $bootLog 2>&1
                    echo -n $LinkUpdate > /data/local/tmp/url.list
                    # cat /data/local/tmp/url.list # exibe a linha de download entregue para o wget
                    DownloadSplitted
                    rm /data/local/tmp/url.list
                    echo "<h2>Download concluido $FileName.</h2>" > $bootLog 2>&1
                    crclocal=`HashFile "$InstallDir$InstallFile"`    
                    if [ "$crclocal" == "$crcOnline" ]; then break; fi; # check return value, break if successful (0)
                    sleep 1;
        fi    
    done ### DOWNLOAD COM SISTEMA MULTI-LINKS    
done ### loop das linhas do DataBankTMP
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
        /system/bin/7z e -aoa -y -p$Senha7z "$InstallDir$FileName.*" -oc:/data/local/tmp > /dev/null 2>&1
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
    if [ "$FileExtension" == "SC" ]; then
        echo "ADM DEBUG ### extraindo ScriptPack $app"
        # extract 7z splitted
        echo "ADM DEBUG ### nome do path arquivo >>>> $InstallDir$FileName"
        echo "ADM DEBUG ### onde vai instalar $pathToInstall"
        /system/bin/7z e -aoa -y -p$Senha7z "$InstallDir$FileName" -oc:/data/local/tmp > /dev/null 2>&1
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
    # roda o script para concluir a instalação do binário em questão
    eval "$scriptOneTimeOnly"
fi ### end do if se esta instalado
}


function CheckIPLocal () {

IPLocal=`/system/bin/busybox ifconfig \
| /system/bin/busybox grep -v 'P-t-P' \
| /system/bin/busybox grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' \
| /system/bin/busybox grep -Eo '([0-9]*\.){3}[0-9]*' \
| /system/bin/busybox grep -v '127.0.0.1'`

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
-w /data/asusbox/
# -w /data/asusbox/.install/
#/storage/DevMount/asusbox/.install/
echo "ADM DEBUG ##############################################################################"

p2pgetID

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
PeerPort=$(( ( RANDOM % (high-low) )  + low ))

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
if [ ! -f "/data/asusbox/FullInstall" ];then
	# script fica aguardando pelo arquivo para prosseguir
	FileWaitingP2P="/data/transmission/$torFile"
	/system/bin/busybox rm $FileWaitingP2P > /dev/null 2>&1
	while [ 1 ]; do
		if [ -e $FileWaitingP2P ];then break; fi;
		echo "ADM DEBUG ### aguardando arquivo $torFile"
		# ShellResult=`/system/bin/transmission-remote --list`
		# echo "ADM DEBUG ### escrevendo no log web progresso do torrent"
		# echo "<h2>$ShellResult</h2>" > $bootLog 2>&1
		sleep 1;    
	done;
	echo "ADM DEBUG ### arquivo $FileWaitingP2P apagado!"
	/system/bin/busybox rm $FileWaitingP2P
fi
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
FileConfigAcr="/data/data/acr.browser.barebones/shared_prefs/settings.xml"
/system/bin/busybox sed -i -e "s;<string name=\"home\">.*</string>;<string name=\"home\">$ACRURL</string>;g" $FileConfigAcr

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





####################### busybox > B.001.0-armeabi-v7a Results >>> Wed Dec 31 21:23:53 BRT 1969
Senha7z="D2XL1wPhGR1Sb0dtJDkdGo18wHGQcbiIOGLo5SbL9Gjaar2HqQC0coypPRRdiyrtg131vS"
app="busybox"
CpuPack="armeabi-v7a"
FileName="B.001.0-armeabi-v7a"
apkName="B.001.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.001.0-armeabi-v7a/B.001.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/busybox > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="BusyBox v1.31.1-meefik (2019-12-29 23:43:11 MSK) multi-call binary."
scriptOneTimeOnly=""
excludeListPack "/data/asusbox/.install/00.snib/B.001.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
####################### termuxLibs > B.002.0-armeabi-v7a Results >>> Wed Dec 31 21:24:09 BRT 1969
Senha7z="3fxgglKD03BDLwhyNOQa5uVqOIcfaAMJCXl6nAppeglwIxUW86XGt3oFvyIRq1xvypOeNz"
app="termuxLibs"
CpuPack="armeabi-v7a"
FileName="B.002.0-armeabi-v7a"
apkName="B.002.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.002.0-armeabi-v7a/B.002.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/7z -h > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 2p` && rm /data/local/tmp/swap'
versionBinOnline="7-Zip (a) [32] 17.02 : Copyright (c) 1999-2020 Igor Pavlov : 2017-08-28"
scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/lib/p7zip/7za /system/bin/7z
ln -sf /system/usr/lib/p7zip/7za /system/bin/7z.so
"
excludeListPack "/data/asusbox/.install/00.snib/B.002.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
####################### bash > B.003.0-armeabi-v7a Results >>> Wed Dec 31 21:24:14 BRT 1969
Senha7z="1Z5K1egIUI0UbiVI3QaaDMzgM0uzd5K2T8PeOW9j9cV36LhrghsRSHbisl2h1bVjhHM3Qk"
app="bash"
CpuPack="armeabi-v7a"
FileName="B.003.0-armeabi-v7a"
apkName="B.003.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.003.0-armeabi-v7a/B.003.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/bash -version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="GNU bash, version 5.1.0(1)-release (arm-unknown-linux-androideabi)"
scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/bash /system/bin/bash
"
excludeListPack "/data/asusbox/.install/00.snib/B.003.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
####################### curl > B.004.0-armeabi-v7a Results >>> Wed Dec 31 21:24:19 BRT 1969
Senha7z="zTlHBfxdeVzs9upefed4oGrExxpHAzdzZoj3G0jmce6NEqJs46c4CUoFtp4B9YwW44rJOz"
app="curl"
CpuPack="armeabi-v7a"
FileName="B.004.0-armeabi-v7a"
apkName="B.004.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.004.0-armeabi-v7a/B.004.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/curl --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="curl 7.73.0 (arm-unknown-linux-androideabi) libcurl/7.73.0 OpenSSL/1.1.1h zlib/1.2.11 libssh2/1.9.0 nghttp2/1.42.0"
scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/curl /system/bin/curl
"
excludeListPack "/data/asusbox/.install/00.snib/B.004.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
####################### lighttpd > B.005.0-armeabi-v7a Results >>> Wed Dec 31 21:24:24 BRT 1969
Senha7z="M9rkBR4Et5Zh37gYyghXQE4p0AQtwW0PAm5Xshy4vufdV9qwb9QTSqgXn5UQcj4i092Yrj"
app="lighttpd"
CpuPack="armeabi-v7a"
FileName="B.005.0-armeabi-v7a"
apkName="B.005.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.005.0-armeabi-v7a/B.005.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/lighttpd -h > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="lighttpd/1.4.56 (ssl) - a light and fast webserver"
scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/lighttpd /system/bin/lighttpd
"
excludeListPack "/data/asusbox/.install/00.snib/B.005.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
####################### PHP > B.006.0-armeabi-v7a Results >>> Wed Dec 31 21:25:26 BRT 1969
Senha7z="6jH058EnMppKHbWvUB7nbNMxtAYigIKr7Xv9XWA7oi0AotUcY3SWJqRP1dZlsbUno7a4CB"
app="PHP"
CpuPack="armeabi-v7a"
FileName="B.006.0-armeabi-v7a"
apkName="B.006.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.006.0-armeabi-v7a/B.006.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/php-cgi --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="PHP 8.0.0 (cgi-fcgi) (built: Dec  6 2020 20:57:33)"
scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/php-cgi /system/bin/php-cgi
"
excludeListPack "/data/asusbox/.install/00.snib/B.006.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
####################### rsync > B.007.0-armeabi-v7a Results >>> Wed Dec 31 21:25:31 BRT 1969
Senha7z="53F7cWQEUJx1zfRoAhjjoj5XmXePcJqM8RdwOqfu1ldjvxIW6PzBe6wRNcAYC0p71d3OG2"
app="rsync"
CpuPack="armeabi-v7a"
FileName="B.007.0-armeabi-v7a"
apkName="B.007.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.007.0-armeabi-v7a/B.007.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/rsync --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="rsync  version 3.2.3  protocol version 31"
scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/rsync /system/bin/rsync
ln -sf /system/usr/bin/rsync-ssl /system/bin/rsync-ssl
"
excludeListPack "/data/asusbox/.install/00.snib/B.007.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
####################### screen > B.008.0-armeabi-v7a Results >>> Wed Dec 31 21:25:36 BRT 1969
Senha7z="Qfl5U522d4fVAktW6IWii7GhTUadyyQlWrPhfF4Dp4tCmeFK4QXODAdnvqMFmhOhEUZpFL"
app="screen"
CpuPack="armeabi-v7a"
FileName="B.008.0-armeabi-v7a"
apkName="B.008.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.008.0-armeabi-v7a/B.008.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/screen --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="Screen version 4.08.00 (GNU) 05-Feb-20"
scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/screen /system/bin/screen
"
excludeListPack "/data/asusbox/.install/00.snib/B.008.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
####################### transmission > B.009.0-armeabi-v7a Results >>> Wed Dec 31 21:25:52 BRT 1969
Senha7z="Fhwa9h9Pf2f6290lhPrVrptLjl5QrhHFqZlNAfPHUIUaAzYj3VzvoaU1M37FR4r1gv4h4h"
app="transmission"
CpuPack="armeabi-v7a"
FileName="B.009.0-armeabi-v7a"
apkName="B.009.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.009.0-armeabi-v7a/B.009.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/transmission-remote -V > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="transmission-remote 3.00 (bb6b5a062e)"
scriptOneTimeOnly="
# Fix dos symlinks
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/transmission-create /system/bin/
ln -sf /system/usr/bin/transmission-remote /system/bin/
ln -sf /system/usr/bin/transmission-edit /system/bin/
ln -sf /system/usr/bin/transmission-show /system/bin/
ln -sf /system/usr/bin/transmission-daemon /system/bin/
"
excludeListPack "/data/asusbox/.install/00.snib/B.009.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
####################### wget > B.010.0-armeabi-v7a Results >>> Wed Dec 31 21:25:57 BRT 1969
Senha7z="NVJwvNGGpx2CQuQ893IqW2pyBy1GlXTxfy8NQbFewudgc7dfxd9KoHAGf2RwHjfBpDxWW2"
app="wget"
CpuPack="armeabi-v7a"
FileName="B.010.0-armeabi-v7a"
apkName="B.010.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.010.0-armeabi-v7a/B.010.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/wget --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="GNU Wget 1.20.3 built on linux-androideabi."
scriptOneTimeOnly="
# Fix dos symlinks
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/wget /system/bin/
"
excludeListPack "/data/asusbox/.install/00.snib/B.010.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
####################### diskUtils > B.011.0-armeabi-v7a Results >>> Wed Dec 31 21:26:06 BRT 1969
Senha7z="tkge1FaBOHhjdEnTwtWInrv3CdKGQo1OT15vPVncxkJq3S4mJ399inJkxY1Sz70S9nsmDb"
app="diskUtils"
CpuPack="armeabi-v7a"
FileName="B.011.0-armeabi-v7a"
apkName="B.011.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.011.0-armeabi-v7a/B.011.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/fdisk -V > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="fdisk from util-linux 2.32.95-1c199"
scriptOneTimeOnly="
# Fix dos symlinks
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/wget /system/bin/
ln -sf /system/usr/bin/fdisk /system/bin/
ln -sf /system/usr/bin/gdisk /system/bin/
ln -sf /system/usr/bin/mkfs.ext4 /system/bin/
ln -sf /system/usr/bin/parted /system/bin/
"
excludeListPack "/data/asusbox/.install/00.snib/B.011.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
####################### aria2c > B.013.0-armeabi-v7a Results >>> Wed Dec 31 21:26:19 BRT 1969
Senha7z="gkCm8vjOViYaJ4dbvlSxsbuL2LUutmij7NfdCbZihRBVnT2UsZHVDoqc9pyLNcsGxutAs9"
app="aria2c"
CpuPack="armeabi-v7a"
FileName="B.013.0-armeabi-v7a"
apkName="B.013.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.013.0-armeabi-v7a/B.013.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/bin/aria2c -v > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="aria2 version 1.35.0"
scriptOneTimeOnly=""
excludeListPack "/data/asusbox/.install/00.snib/B.013.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
