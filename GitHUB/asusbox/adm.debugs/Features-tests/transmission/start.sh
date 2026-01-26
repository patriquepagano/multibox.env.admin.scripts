

configDir="/data/transmission"
seedBox="/sdcard/Download"

# desativando a web interface
export TRANSMISSION_WEB_HOME="/dev/null"

# precisa dos assets
export TRANSMISSION_WEB_HOME="/system/usr/share/transmission/web"

# interface completa
export TRANSMISSION_WEB_HOME="/data/asusbox/adm.build/www_transmission"

# # este baguio não funciona e só buga o shell
# export http_proxy="127.0.0.1:8789"
# export http_proxy="127.0.0.1:8989"
# export http_proxy="52.67.203.38:80"
#export Environment=http_proxy=http://52.67.203.38:80


# # desta maneira foi oque achou mais seeders mas não baixa
# export http_proxy=http://52.67.203.38:80
# echo "$http_proxy"

# export http_proxy=http://127.0.0.1:8989
# echo "$http_proxy"

export http_proxy=http://127.0.0.1:1080
echo "$http_proxy"




# pastas 
    if [ ! -d $configDir ] ; then
        mkdir -p $configDir
    fi
    if [ ! -d $seedBox ] ; then
        mkdir -p $seedBox
    fi
# iniciei o daemon basico e no remote com todas as funções e com porta 51345 fechada! não iniciou nenhum up/down nem lp
high=65535
low=49152
PeerPort=$(( ( RANDOM % (high-low) )  + low ))

echo "start" > /data/asusbox/transmission.log


# fechando antes de abrir
checkPort=`netstat -ntlup | /system/bin/busybox grep "9091" | /system/bin/busybox cut -d ":" -f 2 | /system/bin/busybox awk '{print $1}'`
if [ "$checkPort" == "9091" ]; then
    echo "ADM DEBUG ### Desligando transmission torrent downloader"
    /system/bin/transmission-remote --exit
    killall transmission-daemon
fi

/system/bin/transmission-daemon \
-g $configDir \
-a 127.0.0.1,*.* \
-P $PeerPort \
-c /sdcard/Download/ \
-w $seedBox
# desativar log > -e /data/asusbox/transmission.log \

netstat -ntlup

cat /data/transmission/settings.json





