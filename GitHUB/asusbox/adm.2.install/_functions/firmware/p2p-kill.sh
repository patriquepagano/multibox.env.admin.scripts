function killTransmission () {
    checkPort=`netstat -ntlup | /system/bin/busybox grep "9091" | /system/bin/busybox cut -d ":" -f 2 | /system/bin/busybox awk '{print $1}'`
    if [ "$checkPort" == "9091" ]; then
        echo "ADM DEBUG ### Desligando transmission torrent downloader"
        /system/bin/transmission-remote --exit
        killall transmission-daemon
    fi


# fix das boxes travadas que não esta atualizando por algum motivo
# existem varias versoes do arquivo settings.json e fica em branco
busybox find /data/transmission/ -type f -name 'settings.json*' -exec busybox rm {} +


}




