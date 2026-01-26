#!/data/data/com.termux/files/usr/bin/env /data/data/com.termux/files/usr/bin/bash
#

# estudar sobre a sobreescrita de arquivos no google drive ?

# * se os arquivos forem iguais na origem e no Gdrive: 
#     não upa nada
#     não altera o glink share.
# * se os arquivos estiverem diferentes:
#     o novo arquivo enviado sempre será o da tvbox
#     teremos um novo md5sum
#     NÃO ALTERA O GLINK SHARE

# ao upar nova versão a url muda share

# contas do google drive



accounts="capitaoganchoweb
meugamebox
gibileiro
downloaderCrazy
personaltecniconet
cardsharingsystem
vendasasusbox"

export rclone="/data/data/com.termux/files/usr/bin/rclone"
export config="/storage/DevMount/GitHUB/asusbox/adm.1.export/_tools/rclone.conf"


#############################################################################################################################
#############################################################################################################################
#### UPLOAD DE BINÁRIOS #####################################################################################################
function rcloneUploadFileList () {
# gerar a lista arquivos
rm "$path/$FileName-list.txt" > /dev/null 2>&1
/system/bin/busybox find "$path/$FileName/" -type f -name "*"|while read fname; do
    Fileloop=`basename $fname`
    echo "" >> "$path/$FileName-list.txt"
    echo -n "$path/$FileName/;$Fileloop" >> "$path/$FileName-list.txt"
done
# eliminar a ultima linha em branco
/system/bin/busybox sed -i -e '/^\s*$/d' "$path/$FileName-list.txt"

# mudar o lugar do export
# source     > /data/asusbox/adm.1.export/03.akp.base
# quero isto > /data/asusbox/adm.2.install/03.akp.base
admExport=`echo $admExport | sed "s|adm.1.export|adm.2.install|g"`
# log resultado
if [ ! -d "$admExport/loop" ];then
    mkdir -p "$admExport/loop"
fi
varDataLinks="$admExport/loop/$apkSection$FileName.$FileExtension.sh"
rm $varDataLinks > /dev/null 2>&1

datebuild=`date`

echo "####################### $app > $FileName Results >>> $datebuild" >> $varDataLinks
echo "app=\"$app\"" >> $varDataLinks
echo "FileName=\"$FileName\"" >> $varDataLinks
echo "FileExtension=\"$FileExtension\"" >> $varDataLinks
echo "cmdCheck='$cmdCheck'" >> $varDataLinks
echo "versionBinOnline=\"$versionBinOnline\"" >> $varDataLinks
echo "Senha7z=\"$Senha7z\"" >> $varDataLinks
echo "DataBankTMP=\"" >> $varDataLinks

# loop da lista
file=`cat "$path/$FileName-list.txt"`
echo "$file" | while IFS= read -r line ; do
    pathfile=`echo $line | cut -d ";" -f 1`
    FileName=`echo $line | cut -d ";" -f 2`
    crc=`/system/bin/busybox md5sum "$pathfile$FileName" | /system/bin/busybox cut -d ' ' -f1`

    echo -n "$pathfile;$FileName;$crc" >> $varDataLinks
        for loop in $accounts; do
            #clear # não vale a pena limpar pq preciso ver se alguma falhou no upload
            echo "Verificando crc do arquivo > $FileName da conta Online > $loop"       
            crcOnline=`$rclone --config=$config md5sum $loop:$path/$FileName | cut -d " " -f 1` # verifica o crc ONLINE de todas as partes MIRRORS, precisa de internet    
            echo "crc local  > $crc"
            echo "crc Online > $crcOnline"
                # updando o arquivo
                if [ ! "$crc" == "$crcOnline" ]; then
                    echo "####### Upload para a conta $loop #######" 
                    echo "Precisa upar o arquivo"
                    $rclone --config=$config --progress copyto "$pathfile$FileName" $loop:$path/$FileName
                fi
            #echo "parte $FileName"
            # Compartilhando o arquivo para obter codigo share url
            Glink=`$rclone --config=$config link $loop:$path/$FileName | cut -d "=" -f 2`   
            echo -n ";$Glink" >> $varDataLinks
        done
    # need for new line
    echo "" >> $varDataLinks
done # loop da lista
# fechar as aspas da variavel
echo '"' >> $varDataLinks

# configs do binario na instalação
cat <<EOF >> $varDataLinks
### Imagem alerta comunicação
$ImgAlert

### Script install one time Only
scriptOneTimeOnly="$scriptOneTimeOnly"

# verifica e instala o binário ou lista de arquivos
CheckFileListInstall

### Script start all on boot
scriptAtBoot="$scriptAtBoot"
scriptAtBootFN
EOF
# apaga a lista arquivos
rm "$path/$FileName-list.txt" > /dev/null 2>&1
} # end > rcloneUploadFileList

#############################################################################################################################
#############################################################################################################################
#### UPLOAD DE SCRIPTS ######################################################################################################
function rcloneUploadScripts () {
# gerar a lista arquivos
rm "$path/$FileName-list.txt" > /dev/null 2>&1
/system/bin/busybox find "$path/$FileName/" -type f -name "*"|while read fname; do
    Fileloop=`basename $fname`
    echo "" >> "$path/$FileName-list.txt"
    echo -n "$path/$FileName/;$Fileloop" >> "$path/$FileName-list.txt"
done
# eliminar a ultima linha em branco
/system/bin/busybox sed -i -e '/^\s*$/d' "$path/$FileName-list.txt"

# mudar o lugar do export
# source     > /data/asusbox/adm.1.export/03.akp.base
# quero isto > /data/asusbox/adm.2.install/03.akp.base
admExport=`echo $admExport | sed "s|adm.1.export|adm.2.install|g"`

echo $admExport
#sleep 500

# log resultado
if [ ! -d "$admExport/loop" ];then
    mkdir -p "$admExport/loop"
fi
varDataLinks="$admExport/loop/$apkSection$FileName.$FileExtension.sh"
rm $varDataLinks > /dev/null 2>&1

datebuild=`date`

echo "####################### $app > $FileName Results >>> $datebuild" >> $varDataLinks
echo "app=\"$app\"" >> $varDataLinks
echo "FileName=\"$FileName\"" >> $varDataLinks
echo "FileExtension=\"$FileExtension\"" >> $varDataLinks
echo "cmdCheck='$cmdCheck'" >> $varDataLinks
echo "versionBinOnline=\"$versionBinOnline\"" >> $varDataLinks
echo "pathToInstall=\"$pathToInstall\"" >> $varDataLinks
echo "SourcePack=\"$path/$FileName/$FileName\"" >> $varDataLinks
echo "ExcludeItens='$ExcludeItens'" >> $varDataLinks
echo "DataBankTMP=\"" >> $varDataLinks

# loop da lista
file=`cat "$path/$FileName-list.txt"`
echo "$file" | while IFS= read -r line ; do
    pathfile=`echo $line | cut -d ";" -f 1`
    FileName=`echo $line | cut -d ";" -f 2`
    crc=`/system/bin/busybox md5sum "$pathfile$FileName" | /system/bin/busybox cut -d ' ' -f1`
    echo -n "$pathfile;$FileName;$crc" >> $varDataLinks
        for loop in $accounts; do
            #clear # não vale a pena limpar pq preciso ver se alguma falhou no upload
            # updando o arquivo
            echo "####### Upload para a conta $loop #######" 
            echo "Upando o arquivo"
            echo "$pathfile$FileName"
            $rclone --config=$config --progress copyto "$pathfile$FileName" $loop:$path/$FileName
            #echo "parte $FileName"
            # Compartilhando o arquivo para obter codigo share url
            Glink=`$rclone --config=$config link $loop:$path/$FileName | cut -d "=" -f 2`
            if [ "$Glink" == "" ]; then
                $rclone --config=$config delete $loop:$path/$FileName
                echo "Arquivo $loop:$path/$FileName"
                echo "apagado online por conta do rate limit"
                echo "upando novamente"
                $rclone --config=$config --progress copyto "$pathfile$FileName" $loop:$path/$FileName
                Glink=`$rclone --config=$config link $loop:$path/$FileName | cut -d "=" -f 2`
            fi
            echo -n ";$Glink" >> $varDataLinks
        done
    # need for new line
    echo "" >> $varDataLinks
done # loop da lista
# fechar as aspas da variavel
echo '"' >> $varDataLinks

# configs do binario na instalação
cat <<EOF >> $varDataLinks
# verifica e instala os scripts
CheckFileListInstall

EOF
# apaga a lista arquivos
rm "$path/$FileName-list.txt" > /dev/null 2>&1
} # end > rcloneUploadScripts

#############################################################################################################################
#############################################################################################################################
#### UPLOAD DE APPS #########################################################################################################
function rcloneUpload () {
# gerar a lista arquivos
rm "$path/$apkName-list.txt" > /dev/null 2>&1
/system/bin/busybox find "$path/$apkName/$AKPouDTF/" -type f -name "$apkName*"|while read fname; do
    FileName=`basename $fname`
    echo "" >> $path/$apkName-list.txt
    echo -n "$path/$apkName/$AKPouDTF/;$FileName" >> $path/$apkName-list.txt
done
# eliminar a ultima linha em branco
/system/bin/busybox sed -i -e '/^\s*$/d' $path/$apkName-list.txt


# mudar o lugar do export
# source     > /data/asusbox/adm.1.export/03.akp.base
# quero isto > /data/asusbox/adm.2.install/03.akp.base
admExport=`echo $admExport | sed "s|adm.1.export|adm.2.install|g"`

if [ ! -d "$admExport/loop" ];then
    mkdir -p "$admExport/loop"
fi
varDataLinks="$admExport/loop/$apkSection$apkName.$AKPouDTF.sh"
rm $varDataLinks > /dev/null 2>&1

version=`dumpsys package $app | grep versionName | cut -d "=" -f 2`
datebuild=`date`

echo "####################### $AKPouDTF Results >>> $datebuild" >> $varDataLinks
if [ "$AKPouDTF" == "AKP" ]; then
    echo "apkName=\"$apkName\"" >> $varDataLinks
    echo "app=\"$app\"" >> $varDataLinks
    echo "versionNameOnline=\"$version\"" >> $varDataLinks
    echo "AppGrantLoop=\"$AppGrantLoop\"" >> $varDataLinks
fi
echo "DataBankTMP=\"" >> $varDataLinks

# loop da lista
file=`cat "$path/$apkName-list.txt"`
echo "$file" | while IFS= read -r line ; do
    pathfile=`echo $line | cut -d ";" -f 1`
    FileName=`echo $line | cut -d ";" -f 2`
    crc=`/system/bin/busybox md5sum "$path/$apkName/$AKPouDTF/$FileName" | /system/bin/busybox cut -d ' ' -f1`

    echo -n "$pathfile;$FileName;$crc" >> $varDataLinks
        for loop in $accounts; do
            #clear # não vale a pena limpar pq preciso ver se alguma falhou no upload
            echo "### Pacote do aplicativo $apkName > $app" 
            echo "Verificando crc do arquivo > $FileName da conta Online > $loop"       
            crcOnline=`$rclone --config=$config md5sum $loop:$path/$FileName | cut -d " " -f 1` # verifica o crc ONLINE de todas as partes MIRRORS, precisa de internet    
            echo "crc local  > $crc"
            echo "crc Online > $crcOnline"
                # updando o arquivo
                if [ ! "$crc" == "$crcOnline" ]; then
                    echo "####### Upload para a conta $loop #######" 
                    echo "Precisa upar o arquivo"
                    $rclone --config=$config --progress copyto "$path/$apkName/$AKPouDTF/$FileName" $loop:$path/$FileName
                fi
            #echo "parte $FileName"
            # Compartilhando o arquivo para obter codigo share url
            Glink=`$rclone --config=$config link $loop:$path/$FileName | cut -d "=" -f 2`
            if [ "$Glink" == "" ]; then
                $rclone --config=$config delete $loop:$path/$FileName
                echo "Arquivo $loop:$path/$FileName"
                echo "apagado online por conta do rate limit"
                echo "upando novamente"
                $rclone --config=$config --progress copyto "$path/$apkName/$AKPouDTF/$FileName" $loop:$path/$FileName
                Glink=`$rclone --config=$config link $loop:$path/$FileName | cut -d "=" -f 2`
            fi
            echo -n ";$Glink" >> $varDataLinks
        done
    # need for new line
    echo "" >> $varDataLinks
done # loop da lista
# fechar as aspas da variavel
echo '"' >> $varDataLinks
# final da ficha técnica
if [ "$AKPouDTF" == "DTF" ]; then
cat <<EOF >> $varDataLinks
# Check e download Files, if o torrent já não tiver feito
CheckDownloadFiles
EOF
#clearAppDataOnBoot="$clearAppDataOnBoot"
if [ "$clearAppDataOnBoot" == "yes" ]; then
    echo "# Condição variavel do app para limpar o data no boot" >> $varDataLinks
    echo "pm clear $app" >> $varDataLinks
fi
cat <<EOF >> $varDataLinks
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f /data/data/$app/$ConfigDataVersion ] ; then
    pm clear $app
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    $manualDTFfix
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/$app-*/lib/arm /data/data/$app/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="$AppGrantLoop"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    $manualDTFposPerms
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > /data/data/$app/$ConfigDataVersion
fi
###################################################################################
# config forçada para rodar sempre no boot
$manualDTFfixForced
EOF
fi

if [ "$AKPouDTF" == "AKP" ]; then
cat <<EOF >> $varDataLinks
LauncherIntegrated="$LauncherIntegrated"
EOF
cat <<EOF >> $varDataLinks
CheckAKPinstall
### Manual AKP Config *******
$manualAKPfix

EOF
fi

# apaga a lista arquivos
rm "$path/$apkName-list.txt" > /dev/null 2>&1
} # end > rcloneUpload

























