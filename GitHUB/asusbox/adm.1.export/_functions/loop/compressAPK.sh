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


