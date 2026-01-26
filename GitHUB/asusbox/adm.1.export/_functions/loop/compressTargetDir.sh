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


