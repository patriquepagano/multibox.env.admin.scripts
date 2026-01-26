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

