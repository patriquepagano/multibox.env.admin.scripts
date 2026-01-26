#!/system/bin/sh

clear


export LD_LIBRARY_PATH=/system/lib:/system/usr/lib
am force-stop acr.browser.barebones &
sleep 2
while [ 1 ]; do    
    am start --user 0 \
    -n acr.browser.barebones/acr.browser.lightning.MainActivity \
    -a android.intent.action.VIEW -d "https://asusbox.com.br/atualizando-nova-plataforma-aguarde" #> /dev/null 2>&1
    if [ $? = 0 ]; then break; fi;
    sleep 1
done;

function killTransmission () {
    checkPort=`netstat -ntlup | /system/bin/busybox grep "9091" | /system/bin/busybox cut -d ":" -f 2 | /system/bin/busybox awk '{print $1}'`
    if [ "$checkPort" == "9091" ]; then
        /system/bin/transmission-remote --exit
        killall transmission-daemon
    fi
}
killTransmission
rm -rf /data/transmission

export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib

export CPU=`getprop ro.product.cpu.abi`
export bootFile="/data/asusbox/UpdateSystem.sh"

checkPin=`/system/bin/busybox cat /system/.pin`
if [ ! "$checkPin" = "FSgfdgkjhç8790d5sdf85sd867f5gs876df5g876sdf5g78s6df5g78s6df5gs87df6g576sfd" ];then
    /system/bin/busybox mount -o remount,rw /system
    echo -n 'FSgfdgkjhç8790d5sdf85sd867f5gs876df5g876sdf5g78s6df5g78s6df5gs87df6g576sfd' > /system/.pin
    chmod 644 /system/.pin
fi

function DownloadBOOT () { 
multilinks="
http://45.79.133.216/asusboxA1/boot/$CPU/UpdateSystem.sh
https://asusbox.com.br/asusboxA1/boot/$CPU/UpdateSystem.sh
http://45.79.48.215/asusboxA1/boot/$CPU/UpdateSystem.sh
"
    ### DOWNLOAD COM SISTEMA MULTI-LINKS
    for LinkUpdate in $multilinks; do 
        BootFileInstall="false" # ate que se prove o contrario não baixou o arquivo
        # Tenta conectar ao link 7 vezes 
        #/system/bin/wget --timeout=1 --tries=7 -O $bootFile --no-check-certificate $LinkUpdate
        /system/bin/wget -N --no-check-certificate --timeout=1 --tries=7 -P /data/asusbox/ $LinkUpdate > "/data/asusbox/wget.log" 2>&1
        CheckWgetCode=`/system/bin/busybox cat "/data/asusbox/wget.log" | /system/bin/busybox grep "HTTP request sent, awaiting response..."`
        #rm "/data/asusbox/wget.log"
            # Se tiver acesso finaliza esta função
            if [ "$CheckWgetCode" == "HTTP request sent, awaiting response... 200 OK" ] ; then
                BootFileInstall="true"
                break # fecha a função por completo
            fi
            if [ "$CheckWgetCode" == "HTTP request sent, awaiting response... 304 Not Modified" ] ; then
                BootFileInstall="true"
                break # fecha a função por completo
            fi            
    done ### DOWNLOAD COM SISTEMA MULTI-LINKS
}


function LoopForceDownloadBoot () { # entra em looping até baixar o arquivo de boot
while true
do
    DownloadBOOT 
	if [ "$BootFileInstall" == "false" ]; then
        logcat -c
    else
        break
    fi
done
}

LoopForceDownloadBoot 
# executa o script
/system/bin/busybox chmod 700 $bootFile

path=$(dirname $0)

$bootFile > $path/boot-atual.log 2>&1



exit

# ainda esta com o erro dos torrents anteriores tem q apagar a pasta do /data/transmission

# apos o reboot a box vem com a launcher sem o acesso de leitura a os icones que ficam no /sdcard




