#!/system/bin/sh

echo "Baixando kodi por favor aguarde"
# kodi
link="https://www.dropbox.com/s/4ecxm8voo5mupiz/Kodi_17.6.apk?dl=1"
$aria2c -x 10 --file-allocation=none --check-certificate=false --allow-overwrite=true $link --dir=$EXTERNAL_STORAGE/Download/PersonalTecnico.net >> $logao 2>&1

echo "Baixando configuração para seu kodi com filmes e séries"
# kodi config
link="https://www.dropbox.com/s/1bsggmns69pclct/kodi_16.1_v2.1.tar.gz?dl=1"
$aria2c -x 10 --file-allocation=none --check-certificate=false --allow-overwrite=true $link --dir=$EXTERNAL_STORAGE/Download/PersonalTecnico.net >> $logao 2>&1

echo ""
echo ""
echo "Permita o acesso root."
echo ""
echo "Aguardando pelo acesso"
echo ""
su -c id -u  >> $logao 2>&1
sleep 7

for p in /system/xbin/su /system/bin/su /su/bin/su /sbin/su /magisk/.core/bin/su
do
	if [ -x $p ]; then
			CheckRoot="0"
	fi
done
#echo $CheckRoot

if [ "$CheckRoot" == "0" ] ; then
		echo "Instalando kodi por favor aguarde..."
		su -c /data/data/os.tools.scriptmanager/sc/_pm_install_kodi.sh
		rm /data/data/os.tools.scriptmanager/sc/_pm_install_kodi.sh
		echo "App instalado com sucesso."
	else
		echo "Este dispositivo não possui super user."
		echo "Siga o guia em nosso site para configurar manualmente."
		echo "Instale o Kodi_17.6.apk esta na pasta download" > $EXTERNAL_STORAGE/Download/kodi_install_manual.txt
fi

# configs kodi
# gzip extract
	gzip -d $EXTERNAL_STORAGE/Download/PersonalTecnico.net/kodi_16.1_v2.1.tar.gz  >> $logao 2>&1
		# tar extract
			rm -rf $EXTERNAL_STORAGE/Android/data/org.xbmc.kodi
			mkdir -p $EXTERNAL_STORAGE/Android/data/org.xbmc.kodi
			cd $EXTERNAL_STORAGE/Android/data/org.xbmc.kodi
				tar -xvf $EXTERNAL_STORAGE/Download/PersonalTecnico.net/kodi_16.1_v2.1.tar  >> $logao 2>&1
				rm $EXTERNAL_STORAGE/Download/PersonalTecnico.net/kodi_16.1_v2.1.tar  >> $logao 2>&1
				rm $EXTERNAL_STORAGE/Download/install_kodi.sh  >> $logao 2>&1
echo "Kodi instalado."
