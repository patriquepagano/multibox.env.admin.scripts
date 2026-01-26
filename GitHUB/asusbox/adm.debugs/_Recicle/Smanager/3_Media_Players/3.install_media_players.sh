#!/system/bin/sh

if [ -e /data/data/os.tools.scriptmanagerpro ] ; then
		export APPFolder=/data/data/os.tools.scriptmanagerpro
		export TheAPP=os.tools.scriptmanagerpro
	else
		export APPFolder=/data/data/os.tools.scriptmanager
		export TheAPP=os.tools.scriptmanager
fi
export TMPDIR="$APPFolder"
export PATH=$APPFolder/bin/applets:$PATH
export busybox="$APPFolder/bin/busybox"
export aria2c="$APPFolder/bin/aria2c"

#export IPSERVER="1.0.0.2"
export IPSERVER=""

clear
echo "INSTALAR MEDIA PLAYERS"
echo "Para continuar digite: sim"
read var
if [ "$var" == "sim" ] ; then
    echo "Iniciando instalação"
else
    exit
fi

echo "Iniciando download por favor aguarde"
if ping -c 1 $IPSERVER &> /dev/null
	then
		link="http://$IPSERVER/.0/3_Media_Players/.media_players.sh"
	else
		link="https://www.dropbox.com/s/5e5e54cgld8f3c3/.media_players.sh?dl=1"
fi
rm $APPFolder/tmp.sh > /dev/null 2>&1
$aria2c -x 10 --check-certificate=false --allow-overwrite=true --file-allocation=none $link --dir=$APPFolder -o tmp.sh > /dev/null 2>&1
chmod 755 $APPFolder/tmp.sh > /dev/null 2>&1
$APPFolder/tmp.sh
rm $APPFolder/tmp.sh > /dev/null 2>&1

echo "concluido pode fechar a tela."
