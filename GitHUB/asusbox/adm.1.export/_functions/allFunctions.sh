function RenameExportDataFile () {
echo "$SCRIPT"
DIR=`dirname "$SCRIPT"`
mv "$SCRIPT" "$DIR/$apkName $fakeName $app.sh"

}





function RsyncGenPackF () {
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Rsync $DevFolder/. $GenPackF/."
    export GenPackF="/data/local/tmp/GenPack"
    export exclude="/data/local/tmp/exclude.txt"
    mkdir -p $GenPackF
    echo -n "$ExcludeItens" > $exclude
    # copiar a pasta para o TMP
    /system/bin/rsync \
    --progress \
    -avz \
    --delete \
    --recursive \
    --force \
    --exclude-from=$exclude \
    $DevFolder/. $GenPackF/. > /dev/null 2>&1
    date > $GenPackF/version
    # echo baaaaaaaaaaaaaaaaaaa
    # sleep 500
}


function TarOnly () {
    echo "ADM DEBUG ################### TarOnly ###########################################"
    # clean
    rm -rf "$path/$FileName"
    mkdir -p "$path/$FileName"
    # compactando arquivos e diretórios com permissões unix
    tarFile="$path/$FileName/$FileName.tar.gz"
    # tar file
    /system/bin/busybox tar -czvf "$tarFile" $FileList
}


# pathfile=/data/asusbox/.install/00.boot/sc.000/
# FileName=sc.000

# vpsIP="45.79.48.215"
# vpsOut="/www/asusbox/"
# user="root"
# pass="4a7s5d4f5asd4f7as4d6fads0f87fds097sda65f56as4f876sadf6987sad67as"
# ssh="/data/data/com.termux/files/usr/bin/ssh"

# echo "Upando o arquivo"
# echo "$pathfile$FileName"
# echo "Enviando arquivo para o vps $vpsIP"
# /system/bin/sshpass -p $pass /system/bin/rsync --chmod=777 --progress -avz -e $ssh "$pathfile$FileName" root@$vpsIP:$vpsOut





#############################################################################################################################
#############################################################################################################################
#### UPLOAD DE SCRIPTS ######################################################################################################
function UploadVPSScripts () {
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
echo "DataBankTMP=\"" >> $varDataLinks

accounts="45.79.48.215"

# envia arquivo para o vps do anibal
vpsIP="45.79.48.215"
vpsOut="/www/asusbox/"
user="root"
pass="4a7s5d4f5asd4f7as4d6fads0f87fds097sda65f56as4f876sadf6987sad67as"
ssh="/data/data/com.termux/files/usr/bin/ssh"


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
            du -h $pathfile$FileName
            echo "Enviando arquivo para o vps $vpsIP"
            cd $pathfile
            /system/bin/sshpass -p $pass \
            /system/bin/rsync --chmod=777 --progress -avz -e \
            $ssh "$FileName" root@$vpsIP:$vpsOut
            #echo "parte $FileName"
            # Compartilhando o arquivo para obter codigo share url           

            echo -n ";http://45.79.48.215/asusbox/$FileName" >> $varDataLinks
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

function base64encode () {
    resultBase64=`/system/bin/busybox cat "$1" | /system/bin/busybox base64`
}

function base64decode () {
    resultBase64=`/system/bin/busybox cat "$1" | /system/bin/busybox base64 -d`
}

function compressAPK () {

    checkPort=`netstat -ntlup | /system/bin/busybox grep "9091" | /system/bin/busybox cut -d ":" -f 2 | /system/bin/busybox awk '{print $1}'`
    if [ "$checkPort" == "9091" ]; then
        echo "ADM DEBUG ### Desligando transmission torrent downloader"
        /system/bin/transmission-remote --exit
        killall transmission-daemon
    fi

    randomPassword
    echo "ADM DEBUG ## nova senha > $Senha7z"
    # APK
    am force-stop $app
    #version=`dumpsys package $app | /system/bin/busybox grep versionName | /system/bin/busybox cut -d "=" -f 2 | /system/bin/busybox head -n 1`

    # novo sistema de verificação de app tagando um arquivo de texto
    # não compensa muito trabalho e exploitavel
    #version="App exportado em = $(date)"

    version=`/system/bin/busybox cksum /data/app/$app*/base.apk | /system/bin/busybox cut -d "/" -f 1`

    /system/bin/busybox mount -o remount,rw /system
    # limpando
    rm -rf "$path/$apkName/AKP"
    if [ ! -d $path/$apkName/AKP ];then
        mkdir -p $path/$apkName/AKP
    fi

    echo "criando arquivo 7zip > $app"
    Files="/data/app/$app-*/*.apk"
    /system/bin/7z -v7m a -mx=9 -p$Senha7z -mhe=on -t7z -y "$path/$apkName/AKP/$apkName.AKP" $Files

    echo -n $version > "$path/$apkName/AKP/version"

}


function compressAPKDataFull () {
    checkPort=`netstat -ntlup | /system/bin/busybox grep "9091" | /system/bin/busybox cut -d ":" -f 2 | /system/bin/busybox awk '{print $1}'`
    if [ "$checkPort" == "9091" ]; then
        echo "ADM DEBUG ### Desligando transmission torrent downloader"
        /system/bin/transmission-remote --exit
        killall transmission-daemon
    fi

    echo "fechando o app > $app"
    am force-stop $app
    echo "limpando pastas anteriores"
    rm -rf "$path/$apkName/DTF"
    if [ ! -d $path/$apkName/DTF ];then
        mkdir -p $path/$apkName/DTF
    fi
    echo "compactando data e preferencias do app full"
    Files="
    /data/data/$app
    "
    echo "criando tar file"
    /system/bin/busybox tar -czvf "$path/$apkName/DTF/$apkName.DT.tar.gz" $Files
    echo "criando arquivo 7zip dos dados do > $app"
    /system/bin/7z -v7m a -mx=9 -p$Senha7z -mhe=on -t7z -y "$path/$apkName/DTF/$apkName.DTF" "$path/$apkName/DTF/$apkName.DT.tar.gz"
    rm "$path/$apkName/DTF/$apkName.DT.tar.gz"

    date > "$path/$apkName/DTF/version"

}

function compressAPKSplit () {

    checkPort=`netstat -ntlup | /system/bin/busybox grep "9091" | /system/bin/busybox cut -d ":" -f 2 | /system/bin/busybox awk '{print $1}'`
    if [ "$checkPort" == "9091" ]; then
        echo "ADM DEBUG ### Desligando transmission torrent downloader"
        /system/bin/transmission-remote --exit
        killall transmission-daemon
    fi

    randomPassword
    echo "ADM DEBUG ## nova senha > $Senha7z"
    # APK
    am force-stop $app
    #version=`dumpsys package $app | /system/bin/busybox grep versionName | /system/bin/busybox cut -d "=" -f 2 | /system/bin/busybox head -n 1`

    # novo sistema de verificação de app tagando um arquivo de texto
    # não compensa muito trabalho e exploitavel
    #version="App exportado em = $(date)"

    version=`/system/bin/busybox cksum /data/app/$app*/base.apk | /system/bin/busybox cut -d "/" -f 1`

    /system/bin/busybox mount -o remount,rw /system
    # limpando
    rm -rf "$path/$apkName/AKP"
    if [ ! -d $path/$apkName/AKP ];then
        mkdir -p $path/$apkName/AKP
    fi

    echo "criando arquivo 7zip > $app"
    Files="/data/app/$app-*/base.apk"
    /system/bin/7z -v7m a -mx=9 -p$Senha7z -mhe=on -t7z -y "$path/$apkName/AKP/$apkName.AKP" $Files

    echo -n $version > "$path/$apkName/AKP/version"

}


function compressScripts () {
    checkPort=`netstat -ntlup | /system/bin/busybox grep "9091" | /system/bin/busybox cut -d ":" -f 2 | /system/bin/busybox awk '{print $1}'`
    if [ "$checkPort" == "9091" ]; then
        echo "ADM DEBUG ### Desligando transmission torrent downloader"
        /system/bin/transmission-remote --exit
        killall transmission-daemon
    fi

    echo "ADM DEBUG ################### compressScripts #####################################"
    randomPassword
    echo "ADM DEBUG ## nova senha > $Senha7z"
    # clean
    rm -rf "$path/$FileName"
    mkdir -p "$path/$FileName"
    # vars
    tarFile="$path/$FileName/$FileName.tar.gz"
    Zfile="$path/$FileName/$FileName"
    # tar file compactando arquivos e diretórios com permissões unix
    mkdir -p /data/local/tmp/GenPack > /dev/null 2>&1
    cd /data/local/tmp/GenPack
    echo "Comprimindo em tar"
    /system/bin/busybox tar -czvf "$tarFile" . > /dev/null 2>&1
    echo "Comprimindo em 7zip" 
    # scripts não precisa comprimir em volumes de 7mb
    /system/bin/7z a -mx=9 -p$Senha7z -mhe=on -t7z -y "$Zfile" "$tarFile" #> /dev/null 2>&1
    rm "$tarFile"
}



function compressTarget () {
    checkPort=`netstat -ntlup | /system/bin/busybox grep "9091" | /system/bin/busybox cut -d ":" -f 2 | /system/bin/busybox awk '{print $1}'`
    if [ "$checkPort" == "9091" ]; then
        echo "ADM DEBUG ### Desligando transmission torrent downloader"
        /system/bin/transmission-remote --exit
        killall transmission-daemon
    fi

    echo "ADM DEBUG ################### compressTarget #####################################"
    randomPassword
    echo "ADM DEBUG ## nova senha > $Senha7z"
    # clean
    rm -rf "$path/$FileName"
    mkdir -p "$path/$FileName"
    # vars
    tarFile="$path/$FileName/$FileName.tar.gz"
    Zfile="$path/$FileName/$FileName"
    # tar file compactando arquivos e diretórios com permissões unix
    /system/bin/busybox tar -czvf "$tarFile" $FileList
    # 7zip
    /system/bin/7z -v7m a -mx=9 -p$Senha7z -mhe=on -t7z -y "$Zfile" "$tarFile"
    rm "$tarFile"
}


function compressTargetDir () {
    checkPort=`netstat -ntlup | /system/bin/busybox grep "9091" | /system/bin/busybox cut -d ":" -f 2 | /system/bin/busybox awk '{print $1}'`
    if [ "$checkPort" == "9091" ]; then
        echo "ADM DEBUG ### Desligando transmission torrent downloader"
        /system/bin/transmission-remote --exit
        killall transmission-daemon
    fi

    echo "ADM DEBUG ################### compressTargetDir #####################################"
    randomPassword
    echo "ADM DEBUG ## nova senha > $Senha7z"
    echo "ADM DEBUG ### Compactando em 7z "$path/$FileName/$FileName""
    # clean
    rm -rf "$path/$FileName"
    mkdir -p "$path/$FileName"
    # entra no diretório para não salvar o path
    cd $GenPackF
    # vars
    Zfile="$path/$FileName/$FileName"
    # 7zip
    /system/bin/7z -v7m a -mx=9 -p$Senha7z -mhe=on -t7z -y "$Zfile" .
}




function HashFolderSC () {
$rm /data/tmp.hash > /dev/null 2>&1
$find $1 -type f \( -iname \*.sh -o -iname \*.ini -o -iname \.vars -o -iname \*.conf -o -iname fcgiserver \) | $sort | while read fname; do
    #echo "$fname"
    $md5sum "$fname" | $cut -d ' ' -f1 >> /data/tmp.hash 2>&1
done
export HashResult=`$cat /data/tmp.hash`
$rm /data/tmp.hash > /dev/null 2>&1
}


function exportAKP () {
# mudar o lugar do export
# source     > /data/asusbox/adm.1.export/03.akp.base
# quero isto > /data/asusbox/adm.2.install/03.akp.base
admExport=`echo "$admExport" | sed "s|adm.1.export|adm.2.install|g"`
# log resultado
if [ ! -d "$admExport/loop" ];then
    mkdir -p "$admExport/loop"
fi
varDataLinks="$admExport/loop/$apkSection-$apkName-$fakeName.AKP.sh"
rm "$varDataLinks" > /dev/null 2>&1
datebuild=`date`

# sistema antigo de versionamento dos apks via dumpsys / não serve!
# clean de instalações antigas
rm $path/$apkName/AKP/version > /dev/null 2>&1

# novo sistema de versionamento usando crc32
# version=`/system/bin/busybox cksum /data/app/$app*/base.apk | /system/bin/busybox cut -d "/" -f 1`


# novo sistema de marcador de app ( Thu Jun  3 16:06:36 BRT 2021 )
# version="Thu Jun  3 16:06:36 BRT 2021" # marcador forçado para consertar todas as fichas técnicas
version="$datebuild" # CUIDADO ESCREVER NOVOS APKS FORÇA OS TVBOX A INSTALAREM NOVAMENTE

echo "####################### AKP Results >>> $datebuild" >> "$varDataLinks"
echo "Senha7z=\"$Senha7z\"" >> $varDataLinks
echo "apkName=\"$apkName\"" >> "$varDataLinks"
echo "app=\"$app\"" >> "$varDataLinks"

aapt="/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.bin's/aapt"
/system/bin/busybox find "/data/app/" -type d -name "$app*" \
| while read fname; do
    echo $fname
    echo "ADM DEBUG ########################################################"    
    requestData=`$aapt dump badging "$fname/base.apk"`
    FakeName=`echo "$requestData" | grep "application-label:" | cut -d "'" -f 2 | cut -d "'" -f 1`
    PackageVersion=`echo "$requestData" | grep 'versionName=' | cut -d "'" -f 6 | cut -d "'" -f 1`
    #echo "$FakeName ($PackageVersion)"
    echo "fakeName=\"$FakeName ($PackageVersion)\"" >> "$varDataLinks"
    # alterando fakeName da ficha técnica
    /system/bin/busybox sed -i -e "s/fakeName=.*/fakeName=\"$FakeName ($PackageVersion)\"/g" "$SCRIPT"
done


echo "versionNameOnline=\"$version\"" >> "$varDataLinks"
echo "AppGrantLoop=\"$AppGrantLoop\"" >> "$varDataLinks"
echo "SourcePack=\"$path/$apkName/AKP/$apkName.AKP\"" >> "$varDataLinks"
echo "AKPouDTF=\"AKP\"" >> "$varDataLinks"

cat <<EOF >> "$varDataLinks"
LauncherIntegrated="$LauncherIntegrated"
EOF

echo "excludeListAPP" >> "$varDataLinks"
echo "excludeListPack \"$path/$apkName\"" >> "$varDataLinks"

echo "CheckAKPinstallP2P" >> "$varDataLinks"
echo "LauncherList" >> "$varDataLinks"

cat <<EOF >> "$varDataLinks"
### Manual AKP Config *******
$manualAKPfix

EOF




chmod 755 "$varDataLinks"
}


function exportBase64 () {
# mudar o lugar do export
# source     > /data/asusbox/adm.1.export/03.akp.base
# quero isto > /data/asusbox/adm.2.install/03.akp.base
admExport=`echo $admExport | sed "s|adm.1.export|adm.2.install|g"`
# log resultado
if [ ! -d "$admExport/loop" ];then
    mkdir -p "$admExport/loop"
fi
varDataLinks="$admExport/loop/$apkSection$FileName.sh"
rm "$varDataLinks" > /dev/null 2>&1

datebuild=`date`

echo "####################### $app > $FileName Results >>> $datebuild" >> "$varDataLinks"
echo "app=\"$app\"" >> "$varDataLinks"
echo "FileName=\"$FileName\"" >> "$varDataLinks"
echo "FilePerms=\"$FilePerms\"" >> "$varDataLinks"
echo "FileCmd=\"$FileCmd\"" >> "$varDataLinks"
echo "NeedReboot=\"$NeedReboot\"" >> "$varDataLinks"
echo "pathToInstall=\"$pathToInstall\"" >> "$varDataLinks"
echo "cmdCheck='$cmdCheck'" >> "$varDataLinks"
echo "versionBinOnline=\"$versionBinOnline\"" >> "$varDataLinks"


cat <<'EOF' >> "$varDataLinks"

# chama a função e entra em looping até gravar direito.
CheckBase64

EOF

chmod 755 "$varDataLinks"
}

#echo "$versionBinOnline" | /system/bin/busybox base64 -d | echo -n > "$pathToInstall"





function exportBase64_build.prop () {
# mudar o lugar do export
# source     > /data/asusbox/adm.1.export/03.akp.base
# quero isto > /data/asusbox/adm.2.install/03.akp.base
admExport=`echo $admExport | sed "s|adm.1.export|adm.2.install|g"`
# log resultado
if [ ! -d "$admExport/loop" ];then
    mkdir -p "$admExport/loop"
fi
varDataLinks="$admExport/loop/$apkSection$FileName.sh"
rm "$varDataLinks" > /dev/null 2>&1

datebuild=`date`

echo "####################### $app > $FileName Results >>> $datebuild" >> "$varDataLinks"
echo "app=\"$app\"" >> "$varDataLinks"
echo "FileName=\"$FileName\"" >> "$varDataLinks"
echo "FilePerms=\"$FilePerms\"" >> "$varDataLinks"
echo "FileCmd=\"$FileCmd\"" >> "$varDataLinks"
echo "NeedReboot=\"$NeedReboot\"" >> "$varDataLinks"
echo "pathToInstall=\"$pathToInstall\"" >> "$varDataLinks"
echo "cmdCheck='$cmdCheck'" >> "$varDataLinks"
echo "versionBinOnline=\"$versionBinOnline\"" >> "$varDataLinks"


cat <<'EOF' >> "$varDataLinks"

if [ -f "/system/$app" ];then
    echo "ADM DEBUG ###########################################################################################"
    echo "ADM DEBUG ### verificando build.prop compativel > $app"
    # chama a função e entra em looping até gravar direito.
    CheckBase64
fi

EOF

chmod 755 "$varDataLinks"
}




function exportDTF () {
# mudar o lugar do export
# source     > /data/asusbox/adm.1.export/03.akp.base
# quero isto > /data/asusbox/adm.2.install/03.akp.base
admExport=`echo "$admExport" | sed "s|adm.1.export|adm.2.install|g"`
# log resultado
if [ ! -d "$admExport/loop" ];then
    mkdir -p "$admExport/loop"
fi
varDataLinks="$admExport/loop/$apkSection-$apkName-$fakeName.DTF.sh"
rm "$varDataLinks" > /dev/null 2>&1

if [ ! -f "$path/$apkName/DTF/version" ];then
    date > "$path/$apkName/DTF/version"
fi
version=`cat $path/$apkName/DTF/version`
datebuild=`date`

echo "####################### DTF Results >>> $datebuild" >> "$varDataLinks"
echo "Senha7z=\"$Senha7z\"" >> $varDataLinks
echo "apkName=\"$apkName\"" >> "$varDataLinks"
echo "app=\"$app\"" >> "$varDataLinks"

aapt="/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.bin's/aapt"
/system/bin/busybox find "/data/app/" -type d -name "$app*" \
| while read fname; do
    echo $fname
    echo "ADM DEBUG ########################################################"    
    requestData=`$aapt dump badging "$fname/base.apk"`
    FakeName=`echo "$requestData" | grep "application-label:" | cut -d "'" -f 2 | cut -d "'" -f 1`
    PackageVersion=`echo "$requestData" | grep 'versionName=' | cut -d "'" -f 6 | cut -d "'" -f 1`
    #echo "$FakeName ($PackageVersion)"
    echo "fakeName=\"$FakeName ($PackageVersion)\"" >> "$varDataLinks"
    # alterando fakeName da ficha técnica
    /system/bin/busybox sed -i -e "s/fakeName=.*/fakeName=\"$FakeName ($PackageVersion)\"/g" "$SCRIPT"
done


echo "versionNameOnline=\"$version\"" >> "$varDataLinks"
echo "SourcePack=\"$path/$apkName/DTF/$apkName.DTF\"" >> "$varDataLinks"

echo "excludeListPack \"$path/$apkName\"" >> "$varDataLinks"

# final da ficha técnica
cat <<EOF >> "$varDataLinks"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
EOF
#clearAppDataOnBoot="$clearAppDataOnBoot"
if [ "$clearAppDataOnBoot" == "yes" ]; then
    echo "# Condição variavel do app para limpar o data no boot" >> "$varDataLinks"
    echo "pm clear $app" >> "$varDataLinks"
fi

cat <<EOF >> "$varDataLinks"
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/$app/$version" ] ; then
    pm disable $app
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
    date > "/data/data/$app/$version"
    pm enable $app
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "$app" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot
$manualDTFfixForced
EOF

chmod 755 "$varDataLinks"
}





function exportVarsBINs () {
admExport=`echo $admExport | sed "s|adm.1.export|adm.2.install|g"`
# log resultado
if [ ! -d "$admExport/loop" ];then
    mkdir -p "$admExport/loop"
fi
varDataLinks="$admExport/loop/$apkSection-$FileName-$app.$FileExtension.sh"
rm $varDataLinks > /dev/null 2>&1
# vars fixas para todos os packs
datebuild=`date`

# upload files
echo "####################### $app > $FileName Results >>> $datebuild" >> $varDataLinks
echo "Senha7z=\"$Senha7z\"" >> $varDataLinks
echo "app=\"$app\"" >> $varDataLinks
echo "CpuPack=\"$CpuPack\"" >> $varDataLinks
echo "FileName=\"$FileName\"" >> $varDataLinks
echo "apkName=\"$apkName\"" >> $varDataLinks
echo "SourcePack=\"$path/$FileName/$FileName\"" >> $varDataLinks
echo "FileExtension=\"$FileExtension\"" >> $varDataLinks
echo "cmdCheck='$cmdCheck'" >> $varDataLinks
echo "versionBinOnline=\"$versionBinOnline\"" >> $varDataLinks
echo "scriptOneTimeOnly=\"$scriptOneTimeOnly\"" >> $varDataLinks
echo "excludeListPack \"$path/$FileName\"" >> $varDataLinks


# configs do binario na instalação
cat <<'EOF' >> $varDataLinks
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
EOF

chmod 755 $varDataLinks
}


function exportVarsFiles () {
admExport=`echo $admExport | sed "s|adm.1.export|adm.2.install|g"`
# log resultado
if [ ! -d "$admExport/loop" ];then
    mkdir -p "$admExport/loop"
fi
varDataLinks="$admExport/loop/$apkSection$FileName.$FileExtension.sh"
rm $varDataLinks > /dev/null 2>&1
# vars fixas para todos os packs
datebuild=`date`

# upload files
echo "####################### $app > $FileName Results >>> $datebuild" >> $varDataLinks
echo "Senha7z=\"$Senha7z\"" >> $varDataLinks
echo "app=\"$app\"" >> $varDataLinks
echo "FileName=\"$FileName\"" >> $varDataLinks
echo "SourcePack=\"$path/$FileName/$FileName\"" >> $varDataLinks
echo "FileExtension=\"$FileExtension\"" >> $varDataLinks
echo "cmdCheck='$cmdCheck'" >> $varDataLinks
echo "versionBinOnline=\"$versionBinOnline\"" >> $varDataLinks

echo "excludeListPack \"$path/$FileName\"" >> $varDataLinks

# configs do binario na instalação
cat <<EOF >> $varDataLinks
# verifica e instala os scripts
FileListInstall

EOF

chmod 755 $varDataLinks
}


function exportVarsScripts () {
admExport=`echo $admExport | sed "s|adm.1.export|adm.2.install|g"`
# log resultado
if [ ! -d "$admExport/loop" ];then
    mkdir -p "$admExport/loop"
fi
varDataLinks="$admExport/loop/$apkSection$FileName.$FileExtension.sh"
rm $varDataLinks > /dev/null 2>&1
# vars fixas para todos os packs
datebuild=`date`

# upload scripts
echo "####################### $app > $FileName Results >>> $datebuild" >> $varDataLinks
echo "Senha7z=\"$Senha7z\"" >> $varDataLinks
echo "app=\"$app\"" >> $varDataLinks
echo "FileName=\"$FileName\"" >> $varDataLinks
echo "FileExtension=\"$FileExtension\"" >> $varDataLinks
echo "cmdCheck='$cmdCheck'" >> $varDataLinks
echo "versionBinOnline=\"$versionBinOnline\"" >> $varDataLinks
echo "pathToInstall=\"$pathToInstall\"" >> $varDataLinks
echo "SourcePack=\"$path/$FileName/$FileName\"" >> $varDataLinks
echo "ExcludeItens='$ExcludeItens'" >> $varDataLinks

echo "excludeListPack \"$path/$FileName\"" >> $varDataLinks

# configs do binario na instalação
cat <<EOF >> $varDataLinks
# verifica e instala os scripts
FileListInstall

EOF

chmod 755 $varDataLinks
}

function exportWwwAssets () {
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

versionBinOnline=`cat /data/local/tmp/GenPack/version`

echo "####################### $app > $FileName Results >>> $datebuild" >> $varDataLinks
echo "Senha7z=\"$Senha7z\"" >> $varDataLinks
echo "app=\"$app\"" >> $varDataLinks
echo "FileName=\"$FileName\"" >> $varDataLinks
echo "FileExtension=\"$FileExtension\"" >> $varDataLinks
echo "cmdCheck='$cmdCheck'" >> $varDataLinks
echo "versionBinOnline=\"$versionBinOnline\"" >> $varDataLinks
echo "pathToInstall=\"$pathToInstall\"" >> $varDataLinks
echo "SourcePack=\"$path/$FileName/$FileName\"" >> $varDataLinks
echo "ExcludeItens='$ExcludeItens'" >> $varDataLinks

echo "excludeListPack \"$path/$FileName\"" >> $varDataLinks

cat <<EOF >> $varDataLinks
# verifica e instala 
7ZextractDir
# rsync folder
RsyncUpdateWWW

EOF

chmod 755 $varDataLinks
}



function obfuscateFolder () {
echo "############################################################################"
echo "Deseja compilar via shc digite on"
echo "############################################################################"
echo ""
read input
shc=$input

GenPackF="/data/local/tmp/GenPack/"
mkdir -p $GenPackF > /dev/null 2>&1
# copiar a pasta para o TMP
/system/bin/rsync --progress -avz --delete --recursive --force $DevFolder/ $GenPackF > /dev/null 2>&1
# limpar os códigos
/system/bin/busybox find $GenPackF -type f \( -iname \*.sh \) | /system/bin/busybox sort | while read fname; do
    #echo "$fname"
    if [ "$shc" = "on" ];then
        # remove TABS
        /system/bin/busybox sed -i -e 's|^[[:blank:]]*||g' "$fname"
        # remove todos echo ADM comentando o mesmo
        /system/bin/busybox sed -i -e  's/echo "ADM DEBUG ###.*/#barbaridade/g' "$fname"
        # remove comentários
        /system/bin/busybox sed -i -e 's/\s*#.*$//' "$fname"
        # insere na primeira linha
        /system/bin/busybox sed -i -e '1i#!/system/bin/sh\' "$fname"
        #/system/bin/busybox sed -i -e '1i#!/system/usr/bin/bash\' "$fname"
        # remove novas linhas
        /system/bin/busybox sed -i -e '/^\s*$/d' "$fname"
        # altera os paths
        /system/bin/busybox sed -i -e 's;/storage/DevMount/GitHUB/asusbox/adm.build;/data/asusbox/.sc;g' "$fname"

        if [ ! -f /system/bin/cc ];then
            /system/bin/busybox mount -o remount,rw /system
            ln -sf /storage/DevMount/AndroidDEV/termux/files/usr/bin/shc /system/bin/shc
            ln -sf /storage/DevMount/AndroidDEV/termux/files/usr/bin/clang-10 /system/bin/cc
            ln -sf /storage/DevMount/AndroidDEV/termux/files/usr/bin/strip /system/bin/strip
        fi
        if [ -f /data/data/com.termux/files/usr/bin/shc ];then
            clear
            echo "Termux + SHC detectado!"
            echo "Compilando script via shc"
            # shc File
            # /data/data/com.termux/files/usr/bin/shc -v -f "$fname" -e 20/10/2035
            /data/data/com.termux/files/usr/bin/shc -vr -f "$fname"
            rm "$fname.x.c"
            mv "$fname.x" "$fname"
        fi
    fi

    chmod 700 "$fname"
done

rm $GenPackF/keys.hash > /dev/null 2>&1
/system/bin/busybox find $GenPackF -type f \( -iname \*.sh -o -iname \*.ini -o -iname \.vars -o -iname \*.conf -o -iname fcgiserver \) | /system/bin/busybox sort | while read fname; do
    #echo "$fname"
    /system/bin/busybox md5sum "$fname" | /system/bin/busybox cut -d ' ' -f1 >> $GenPackF/keys.hash 2>&1
done
# seta a nova variavel da versão para a ficha tecnica
echo ""
echo "Alterado na ficha técnica do $app versionBinOnline abaixo"
export versionBinOnline=`/system/bin/busybox md5sum "$GenPackF/keys.hash" | /system/bin/busybox cut -d ' ' -f1`
echo "versionBinOnline=\"$versionBinOnline\""
echo ""
# alterando o version da ficha técnica
sed -i -e "s/versionBinOnline=".*"/versionBinOnline=\"$versionBinOnline\"/g" $SCRIPT
}





# sobre o shc
# https://github.com/yanncam/UnSHc
# root@server:~/shc/shc-3.8.9# shc -h
# shc Version 3.8.9, Generic Script Compiler
# shc Copyright (c) 1994-2012 Francisco Rosales <frosal@fi.upm.es>
# shc Usage: shc [-e date] [-m addr] [-i iopt] [-x cmnd] [-l lopt] [-rvDTCAh] -f script
# -e %s Expiration date in dd/mm/yyyy format [none]
# -m %s Message to display upon expiration [&quot;Please contact your provider&quot;]
# -f %s File name of the script to compile
# -i %s Inline option for the shell interpreter i.e: -e
# -x %s eXec command, as a printf format i.e: exec('%s',@ARGV);
# -l %s Last shell option i.e: --
# -r Relax security. Make a redistributable binary
# -v Verbose compilation
# -D Switch ON debug exec calls [OFF]
# -T Allow binary to be traceable [no]
# -C Display license and exit
# -A Display abstract and exit
# -h Display help and exit
# Environment variables used:
# Name Default Usage
# CC cc C compiler command
# CFLAGS C compiler flags
# Please consult the shc(1) man page.



function obfuscatePHP () {
    export GenPackF="/data/local/tmp/GenPack"
    # limpar os códigos PHP
    /system/bin/busybox find $GenPackF -type f \( -iname \*.php \) | /system/bin/busybox sort | while read fname; do
        echo "$fname"
        /system/bin/busybox sed -i -e '/^[[:space:]]*\/\//d; /^$/d;' "$fname"
        /system/bin/busybox sed -i -e '/^\s*$/d' "$fname"
        /system/bin/busybox sed -i -e 's|^[[:blank:]]*||g' "$fname"
        /system/bin/busybox sed -i -e 's/[[:blank:]]*$//' "$fname"
    done
}



function randomPassword () {
    # bash generate random 70 character alphanumeric string (upper and lowercase) and 
    export Senha7z=$(/system/bin/busybox cat /dev/urandom \
    | /system/bin/busybox tr -dc 'a-zA-Z0-9' \
    | /system/bin/busybox fold -w 70 \
    | /system/bin/busybox head -n 1)
    # alterando Senha7z da ficha técnica
    /system/bin/busybox sed -i -e "s/Senha7z=.*/Senha7z=\"$Senha7z\"/g" "$SCRIPT"
}



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

























