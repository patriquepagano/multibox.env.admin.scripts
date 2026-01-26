#!/system/bin/sh

# a ideia é gerar novos ids a cada 24hs e deixar disponivel para a rede
source /data/.vars
syncthing="/system/bin/libsyncthing.so"


fauth=/data/debugtvbox/features/syncthing/auth
# cria a pasta auth
function cdkey () {
cdkey=`echo $((RANDOM%2000+1000))-$((RANDOM%2000+1000))-$((RANDOM%2000+1000))-$((RANDOM%2000+1000))`
}


rm -rf $fauth

for i in $(seq 1 10); do
cdkey
if [ ! -e "$fauth/$cdkey" ] ; then
    echo "criando nova pasta > $fauth/$cdkey"
    export HOME="$fauth/$cdkey"
    mkdir -p $HOME
    if [ ! -e "$HOME/key.pem" ] ; then
        $syncthing  -generate="$HOME"   
    fi
    $syncthing -device-id -home=$HOME >> $fauth/Syncthing-ids
    mv $HOME/config.xml $fauth/config.orig.xml
else
    echo "pasta ja existe, parando o script aqui."
    exit
fi
done

exit

666 cert.pem
600 key.pem




HOME=/data/debugtvbox/features/syncthing/config
mkdir -p $HOME
# apaga para forçar no boot o resync
rm -rf $HOME/index-v0.14.0.db
rm -rf $HOME/Sync


if [ ! -e "$HOME/key.pem" ] ; then
$syncthing  -generate="$HOME"   
fi

$syncthing -device-id -home=$HOME

# permite acessar brownser
defaultConfig="$HOME/config.xml"
/system/bin/busybox sed -i -e 's/127.0.0.1/0.0.0.0/g' $defaultConfig


$syncthing -no-browser -no-restart -home=$HOME &







