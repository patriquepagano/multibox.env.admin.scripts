#!/system/bin/sh

function killTransmission () {
    # verificação da função
    checkPort=`/system/bin/busybox netstat -ntlup | /system/bin/busybox grep "9091" | /system/bin/busybox cut -d ":" -f 2 | /system/bin/busybox awk '{print $1}'`
    if [ "$checkPort" == "9091" ]; then        
        /system/bin/transmission-remote --exit
        killall transmission-daemon
    fi
}

# verificação do primeiro loop
checkPort=`/system/bin/busybox netstat -ntlup | /system/bin/busybox grep "9091" | /system/bin/busybox cut -d ":" -f 2 | /system/bin/busybox awk '{print $1}'`

while true; do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### verificando se daemon esta ativo"     
	if [ "$checkPort" == "9091" ]; then
        echo "ADM DEBUG ### Desligando transmission torrent downloader"
        killTransmission
        logcat -c
    else
        break
    fi
done






