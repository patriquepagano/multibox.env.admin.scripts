#!/system/bin/sh

if [ -e /data/data/os.tools.scriptmanagerpro ] ; then
		export APPFolder=/data/data/os.tools.scriptmanagerpro
		export TheAPP=os.tools.scriptmanagerpro
	else
		export APPFolder=/data/data/os.tools.scriptmanager
		export TheAPP=os.tools.scriptmanager
fi
export TMPDIR="$APPFolder"

#export IPSERVER="1.0.0.2"
#export IPSERVER=""
aria2c="$APPFolder/bin/aria2c"
export busybox="$APPFolder/bin/busyboxTMP"

echo "Iniciando instalação aria downloader"
echo "Por favor aguarde..."

script_dir="${0%/*}"

echo $script_dir
echo $APPFolder
echo $DUser

# versão remota tem que abrir o Smanager

#am start --user 0 -a os.tools.scriptmanager.action.LAUNCH_SCRIPT -d "file://dev/null"

if [ ! -e $busybox ] ; then
	cp $EXTERNAL_STORAGE/Download/busyboxARM $busybox > /dev/null 2>&1 # path correto
	cp $script_dir/busyboxARM $busybox > /dev/null 2>&1
	chmod 755 $busybox > /dev/null 2>&1
	restorecon -FR $APPFolder/bin > /dev/null 2>&1
fi

if [ ! -e $EXTERNAL_STORAGE/Download/aria.tar.gz ] ; then
	mkdir -p $EXTERNAL_STORAGE/Download
	cp $script_dir/aria.tar.gz $EXTERNAL_STORAGE/Download/aria.tar.gz
fi

# criar um if aqui se não tem internet abre a tela de configuração wifi
# read wait  # digite qlq tecla para continuar

export DUser=`$busybox stat -c "%u" "$APPFolder"`
echo $DUser

# aria2
	if [ ! -e $EXTERNAL_STORAGE/Download/aria.tar.gz ] ; then
			echo "Arquivo aria.tar.gz não existe."
			echo "Baixe em nosso site."
			exit
		else
			cd $EXTERNAL_STORAGE/Download
			$busybox tar -mxvf $EXTERNAL_STORAGE/Download/aria.tar.gz > /dev/null 2>&1
				cp $EXTERNAL_STORAGE/Download/aria2c_github.so $APPFolder/bin/ > /dev/null 2>&1
				cp $EXTERNAL_STORAGE/Download/aria_libaria2_exec.so $APPFolder/bin/ > /dev/null 2>&1
				cp $EXTERNAL_STORAGE/Download/aria_libaria2_PIC_exec.so $APPFolder/bin/ > /dev/null 2>&1
				rm $EXTERNAL_STORAGE/Download/aria*.so > /dev/null 2>&1
					$busybox chmod 755 $APPFolder/bin/aria* > /dev/null 2>&1
					$busybox chown -R $DUser:$DUser $APPFolder/bin > /dev/null 2>&1
					restorecon -FR $APPFolder/bin > /dev/null 2>&1
			if [ -e $APPFolder/bin/aria_libaria2_exec.so ] ; then
				ariaV=`$APPFolder/bin/aria_libaria2_exec.so -v | grep "aria2 version"`
				if [ "$ariaV" == "aria2 version 1.26.1" ] ; then
						echo "instalando aria2 version 1.26.1"
						cp $APPFolder/bin/aria_libaria2_exec.so $APPFolder/bin/aria2c
				fi
			fi
			if [ -e $APPFolder/bin/aria_libaria2_PIC_exec.so ] ; then
				ariaV=`$APPFolder/bin/aria_libaria2_PIC_exec.so -v | grep "aria2 version"`
				if [ "$ariaV" == "aria2 version 1.26.1" ] ; then
						echo "instalando aria2 version 1.26.1"
						cp $APPFolder/bin/aria_libaria2_PIC_exec.so $APPFolder/bin/aria2c
				fi
			fi
			if [ -e $APPFolder/bin/aria2c_github.so ] ; then
				ariaV=`$APPFolder/bin/aria2c_github.so -v | grep "aria2 version"`
				if [ "$ariaV" == "aria2 version 1.33.1" ] ; then
						echo "instalando versao 1.33.1"
						cp $APPFolder/bin/aria2c_github.so $APPFolder/bin/aria2c
				fi
			fi
	fi
$busybox chmod 755 $APPFolder/bin/aria*
rm $APPFolder/bin/aria_libaria2_exec.so
rm $APPFolder/bin/aria_libaria2_PIC_exec.so
rm $APPFolder/bin/aria2c_github.so
# root scripts # --------------------------------------------------------------------------------------------------------------------------------------
echo "download root scripts aguarde..."
if ping -c 1 $IPSERVER &> /dev/null
	then
		DownloadFiles="
		http://$IPSERVER/.0/0_support/.root/.config_sshdroid.sh
		http://$IPSERVER/.0/0_support/.root/.pm_install_support.sh
		http://$IPSERVER/.0/0_support/.root/.timezone_unknownSources_lang.sh
		"
	else
		DownloadFiles="
		https://www.dropbox.com/s/fqlfaxvc9m892he/.config_sshdroid.sh?dl=1
		https://www.dropbox.com/s/pzjuw60ahu6qsx5/.pm_install_support.sh?dl=1
		https://www.dropbox.com/s/71dv6q0ud9ruyrw/.timezone_unknownSources_lang.sh?dl=1		
		"
fi
for link in $DownloadFiles; do
$aria2c -x 10 --file-allocation=none --check-certificate=false --allow-overwrite=true $link --dir=$APPFolder/sc  #> /dev/null 2>&1
done
chmod -R 755 $APPFolder/sc/. > /dev/null 2>&1
restorecon -FR $APPFolder/sc > /dev/null 2>&1
# end root scripts # -----------------------------------------------------------------------------------------------------------------------------------

echo "Iniciando download por favor aguarde"
if ping -c 1 $IPSERVER &> /dev/null
	then
		link="http://$IPSERVER/.0/0_support/.sc.tar"
	else
		link="https://www.dropbox.com/s/0v6uiawzljzwofn/.sc.tar?dl=1"
fi
$aria2c -x 10 --check-certificate=false --allow-overwrite=true --file-allocation=none $link --dir=$APPFolder/sc/0_support  > /dev/null 2>&1
cd $APPFolder/sc/0_support
$busybox tar -mxvf $APPFolder/sc/0_support/.sc.tar  > /dev/null 2>&1
$busybox chmod 755 $APPFolder/sc/0_support/*.sh  > /dev/null 2>&1
restorecon -FR $APPFolder/sc/0_support  > /dev/null 2>&1
$APPFolder/sc/0_support/Wpath.sh

if ping -c 1 $IPSERVER &> /dev/null
	then
		link="http://$IPSERVER/.0/0_support/.support.sh"
	else
		link="https://www.dropbox.com/s/bfhyabfafnh17h3/.support.sh?dl=1"
fi
$aria2c -x 10 --check-certificate=false --allow-overwrite=true --file-allocation=none $link --dir=$APPFolder -o tmp.sh  > /dev/null 2>&1
chmod 755 $APPFolder/tmp.sh
$APPFolder/tmp.sh
rm $APPFolder/tmp.sh

echo ""
echo ""
echo ""
echo ""
echo "concluido pode fechar a tela."

