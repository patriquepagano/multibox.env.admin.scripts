
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

