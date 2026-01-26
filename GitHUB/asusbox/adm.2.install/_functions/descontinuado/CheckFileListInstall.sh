
# descontinuado sistema usando os links do google só deu bug e links com error 404

function CheckFileListInstall () {
#Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
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


