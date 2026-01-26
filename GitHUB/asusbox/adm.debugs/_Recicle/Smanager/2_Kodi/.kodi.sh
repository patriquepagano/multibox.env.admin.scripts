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
export Szip="$APPFolder/bin/7z"
# path removivel
$APPFolder/sc/0_support/Wpath.sh
export Wpath=`cat "$APPFolder/Wpath.TXT"`
export logao="$Wpath/debug.log"
# webserver
#export IPSERVER="1.0.0.2"
export IPSERVER=""
export baseapps="$Wpath/.0/2_Kodi"
export CPU=`getprop ro.product.cpu.abi`

export DeviceAPI=`getprop ro.build.version.sdk`

if [ ! -e "$baseapps" ] ; then
mkdir -p $baseapps/apk
fi

echo "Baixando componentes por favor aguarde"

if ping -c 1 $IPSERVER &> /dev/null
	then
		DownloadFiles="
		http://$IPSERVER/.0/2_Kodi/.kodi.sh
		http://$IPSERVER/.0/2_Kodi/2.install_kodi.sh
		"
	else
		DownloadFiles="
		https://www.dropbox.com/s/negxpxoo7u7l87b/.kodi.sh?dl=1
		https://www.dropbox.com/s/viepuutqyp3mnh5/2.install_kodi.sh?dl=1
		"
fi
for link in $DownloadFiles; do
$aria2c -x 10 --file-allocation=none --check-certificate=false --allow-overwrite=true $link --dir=$baseapps  > $logao 2>&1
done


# download do apk
if [ $DeviceAPI -gt '19' ] ; then
		if ping -c 1 $IPSERVER &> /dev/null
			then
				DownloadFiles="
				http://$IPSERVER/.0/2_Kodi/apk/21_org.xbmc.kodi_17.6_1760000.apk
				"
			else
				DownloadFiles="
				https://www.dropbox.com/s/0009rbt38d3y74d/21_org.xbmc.kodi_17.6_1760000.apk?dl=1
				"
		fi
	else
		echo "Baixando kodi por favor aguarde"
		if ping -c 1 $IPSERVER &> /dev/null
			then
				DownloadFiles="
				http://$IPSERVER/.0/2_Kodi/apk/17_org.xbmc.kodi_16.1_161001.apk
				http://$IPSERVER/.0/2_Kodi/apk/main.161001.org.xbmc.kodi.obb
				"
			else
				DownloadFiles="
				https://www.dropbox.com/s/ml4aea84q7rqfpt/17_org.xbmc.kodi_16.1_161001.apk?dl=1
				https://www.dropbox.com/s/c2e3dzuvgusttyb/main.161001.org.xbmc.kodi.obb?dl=1
				"
		fi
fi
#echo $DownloadFiles
for link in $DownloadFiles; do
$aria2c -x 10 --file-allocation=none --check-certificate=false --allow-overwrite=true $link --dir=$baseapps/apk  >> $logao 2>&1
done

# obb kodi 16.1
obbKodi="$baseapps/apk/main.161001.org.xbmc.kodi.obb"
if [ -e "$obbKodi" ] ; then
mkdir -p $EXTERNAL_STORAGE/Android/obb/org.xbmc.kodi
mv $obbKodi $EXTERNAL_STORAGE/Android/obb/org.xbmc.kodi/  >> $logao 2>&1
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
		echo "Instalando kodi por favor aguarde..."
		su -c /data/data/$TheAPP/sc/.pm_install_kodi.sh
		rm /data/data/$TheAPP/sc/.pm_install_kodi.sh
		echo "App instalado com sucesso."
	else
		echo "Este dispositivo não possui super user."
		echo "Sera necessário instalar manualmente."
		echo "Instale os aplicativos que serão apresentados a seguir.." 
		echo "Clique em instalar mas não abra o app ainda ok."
			if [ $DeviceAPI -gt '17' ] ; then
				L="21_org.xbmc.kodi_17.6_1760000.apk"
				else
				L="17_org.xbmc.kodi_16.1_161001.apk			"
			fi
				clear
				echo "Por favor aguarde ate aparecer a janela de instalação."
				sleep 2
				echo "Clique em instalar mas não abra o app ainda ok."
				sleep 2
				echo "Carregando $L"
				sleep 2
				am start --user 0 -a android.intent.action.INSTALL_PACKAGE -d "file:$baseapps/apk/$L" > /dev/null 2>&1
fi

# config padrão do retroarch
if ping -c 1 $IPSERVER &> /dev/null
	then
		link="http://$IPSERVER/.0/2_Kodi/.root/kodi_16.1_v2.1.tar.gz"
	else
		link="https://www.dropbox.com/s/jnknz2pmc091gye/kodi_16.1_v2.1.tar.gz?dl=1"
fi
$aria2c -x 10 --check-certificate=false --allow-overwrite=true --file-allocation=none $link --dir=$EXTERNAL_STORAGE -o tmp.tar.gz > /dev/null 2>&1
# configs kodi
rm -rf $EXTERNAL_STORAGE/Android/data/org.xbmc.kodi
mkdir -p $EXTERNAL_STORAGE/Android/data/org.xbmc.kodi
cd $EXTERNAL_STORAGE/Android/data/org.xbmc.kodi
	tar -mzxvf $EXTERNAL_STORAGE/tmp.tar.gz  >> $logao 2>&1
	rm $EXTERNAL_STORAGE/tmp.tar.gz  >> $logao 2>&1


echo "Kodi instalado."
