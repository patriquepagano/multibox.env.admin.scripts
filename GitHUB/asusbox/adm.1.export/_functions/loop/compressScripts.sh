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



