
clear

# printa o conteudo do arquivo torrent
id=2
/system/bin/transmission-remote -t $id -f | /system/bin/busybox awk '{print $7}'





exit






/system/bin/transmission-remote --list 


/system/bin/transmission-remote --list \
| /system/bin/busybox grep ".install" \
| /system/bin/busybox awk '{print $4}' \
| /system/bin/busybox sed -e 's/[^0-9]*//g'

exit


Verifying

function torCheckResult () {
torCheck=`/system/bin/transmission-remote --list \
| /system/bin/busybox grep ".install" \
| /system/bin/busybox awk '{print $2}' \
| /system/bin/busybox sed -e 's/[^0-9]*//g'`
}

function LoopForcetorCheckResult () { # entra em looping até chegar a 100
while true; do
    torCheckResult
	if [ "$torCheck" == "100" ]; then
        break
    else
        echo "Aguardando conclusão do pack p2p"
        sleep 3
    fi
done
}

LoopForcetorCheckResult






exit

netstat -ntlup


torID=`/system/bin/transmission-remote --list \
| /system/bin/busybox grep "$torFile" \
| /system/bin/busybox awk '{print $1}' \
| /system/bin/busybox sed -e 's/[^0-9]*//g'`
echo "ADM DEBUG ### $torID"






