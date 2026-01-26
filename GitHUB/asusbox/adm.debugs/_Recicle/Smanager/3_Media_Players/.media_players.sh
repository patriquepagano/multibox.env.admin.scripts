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
export wget="$APPFolder/bin/wget"
export Szip="$APPFolder/bin/7z"
# path removivel
$APPFolder/sc/0_support/Wpath.sh
export Wpath=`cat "$APPFolder/Wpath.TXT"`
export logao="$Wpath/debug.log"
# webserver
export baseapps="$Wpath/.0/3_Media_Players"
export CPU=`getprop ro.product.cpu.abi`

export DeviceAPI=`getprop ro.build.version.sdk`

if [ ! -e "$baseapps" ] ; then
mkdir -p $baseapps/apk
fi

echo "Baixando componentes por favor aguarde"

DownloadFiles="
https://www.dropbox.com/s/5e5e54cgld8f3c3/.media_players.sh?dl=1
https://www.dropbox.com/s/e3pxitkfqpps7ew/3.install_media_players.sh?dl=1
"
for link in $DownloadFiles; do
$aria2c -x 10 --file-allocation=none --check-certificate=false --allow-overwrite=true $link --dir=$baseapps  > $logao 2>&1
done

# google junk (lembrete não adiciona mais o google services api 23 pra cima só da dor cabeça o install manual)
if [ $DeviceAPI -gt '23' ] ; then
echo "Baixando apps por favor aguarde"
DownloadFiles="
https://www.dropbox.com/s/94k8f3hunzc40hv/21_com.google.android.youtube_13.05.52_1305523310.apk
"
cd $baseapps/apk
for link in $DownloadFiles; do
while [ 1 ]; do
    $wget --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue "$link"
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
done
	else
echo "Baixando apps por favor aguarde"
DownloadFiles="
https://www.dropbox.com/s/qshkakyqi58vv52/17_com.google.android.youtube_13.05.52_1305522310.apk
"
for link in $DownloadFiles; do
while [ 1 ]; do
    $wget --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue "$link"
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
done	
fi

# # versão teste que veio na rom android 7 tanix tx2
# if [ $DeviceAPI -gt '21' ] ; then
	# echo "Baixando apps por favor aguarde"
	# if ping -c 1 $IPSERVER &> /dev/null
		# then
			# DownloadFiles="
			# http://$IPSERVER/.0/3_Media_Players/apk/21_com.netflix.mediaclient_6.3.0_build_27728_armeabi-v7a_nodpi.apk
			# http://$IPSERVER/.0/3_Media_Players/apk/21_com.netflix.mediaclient_5.12.2_build_25768.apk
			# "
		# else
			# DownloadFiles="
			# https://www.dropbox.com
			# "
	# fi
		# for link in $DownloadFiles; do
		# $aria2c -x 10 --file-allocation=none --check-certificate=false --allow-overwrite=true $link --dir=$baseapps/apk  > $logao 2>&1
		# done
# fi

# netflix
if [ $DeviceAPI -gt '18' ] ; then
echo "Baixando netflix Android 4.4"
DownloadFiles="
https://www.dropbox.com/s/c6qtgxyzat3znf2/19_com.netflix.mediaclient_4.16.1_build_200147.apk
"
cd $baseapps/apk
for link in $DownloadFiles; do
while [ 1 ]; do
    $wget --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue "$link"
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
done
	else
echo "Baixando Netflix Android 4.0"
DownloadFiles="
https://www.dropbox.com/s/pzfvfd7scbgxbv0/14_com.netflix.mediaclient_3.16.3_build_5359_armeabi_nodpi.apk
"
cd $baseapps/apk
for link in $DownloadFiles; do
while [ 1 ]; do
    $wget --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue "$link"
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
done	
fi


# apps
if [ $DeviceAPI -gt '14' ] ; then
echo "Baixando apps por favor aguarde"
DownloadFiles="
https://www.dropbox.com/s/kmu3utyg1wevu7m/14_com.niklabs.pp_1.4.6_400.apk
https://www.dropbox.com/s/zgcx35ad793hztq/14_com.mxtech.videoplayer.ad_1.9.11_1210001032.apk
"
cd $baseapps/apk
for link in $DownloadFiles; do
while [ 1 ]; do
    $wget --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue "$link"
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
done
fi


for p in /system/xbin/su /system/bin/su /su/bin/su /sbin/su /magisk/.core/bin/su
do
	if [ -x $p ]; then
			CheckRoot="0"
			echo ""
			echo ""
			echo "Permita o acesso root."
			echo ""
			echo "Aguardando pelo acesso"
			echo ""
			su -c id -u  >> $logao 2>&1
			sleep 7
	fi
done
#echo $CheckRoot

if [ "$CheckRoot" == "0" ] ; then
		echo "Instalando apps por favor aguarde..."
		su -c /data/data/$TheAPP/sc/.pm_install_media_players.sh
		rm /data/data/$TheAPP/sc/.pm_install_media_players.sh
		echo "App instalado com sucesso."
	else
		echo "Este dispositivo não possui super user."
		echo "Sera necessário instalar manualmente."
		echo "Instale os aplicativos que serão apresentados a seguir.." 
		echo "Clique em instalar mas não abra o app ainda ok."
			for L in $baseapps/apk/*.apk ; do
				clear
				echo "Por favor aguarde ate aparecer a janela de instalação."
				sleep 2
				echo "Clique em instalar mas não abra o app ainda ok."
				sleep 2
				echo "Carregando $L"
				sleep 2
				am start --user 0 -a android.intent.action.INSTALL_PACKAGE -d "file:$L" > /dev/null 2>&1
				sleep 10
			done
fi
