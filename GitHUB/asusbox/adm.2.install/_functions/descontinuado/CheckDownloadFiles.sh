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



