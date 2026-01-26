#!/system/bin/sh

export APPFolder=/data/data/os.tools.scriptmanager
export TheAPP=os.tools.scriptmanager
export TMPDIR="$APPFolder"
aria2c="$APPFolder/bin/aria2c"
export busybox="$APPFolder/bin/busyboxTMP"

echo "Iniciando instalação aria downloader"
echo "Por favor aguarde..."

script_dir="${0%/*}"

echo $script_dir
echo $APPFolder

if [ ! -e $busybox ] ; then
	cp $EXTERNAL_STORAGE/Download/busyboxARM $busybox > /dev/null 2>&1 # path correto
	cp $script_dir/busyboxARM $busybox > /dev/null 2>&1
	chmod 755 $busybox > /dev/null 2>&1
	restorecon -FR $APPFolder/bin > /dev/null 2>&1
fi

# criar um if aqui se não tem internet abre a tela de configuração wifi
# read wait  # digite qlq tecla para continuar

export DUser=`$busybox stat -c "%u" "$APPFolder"`
echo $DUser

# aria2
	if [ ! -e $EXTERNAL_STORAGE/Download/aria.tar.gz ] ; then
			echo "Arquivo aria.tar.gz não existe."
			am start -a android.intent.action.REBOOT
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
DownloadFiles="
https://www.dropbox.com/s/fqlfaxvc9m892he/.config_sshdroid.sh
https://www.dropbox.com/s/pzjuw60ahu6qsx5/.pm_install_support.sh
https://www.dropbox.com/s/71dv6q0ud9ruyrw/.timezone_unknownSources_lang.sh		
"
mkdir -p $APPFolder/sc
cd $APPFolder/sc
for link in $DownloadFiles; do
while [ 1 ]; do
    /system/bin/wget --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue "$link"
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
done
chmod -R 755 $APPFolder/sc/. > /dev/null 2>&1
restorecon -FR $APPFolder/sc > /dev/null 2>&1
# end root scripts # -----------------------------------------------------------------------------------------------------------------------------------

echo "Iniciando download por favor aguarde"
link="https://www.dropbox.com/s/0v6uiawzljzwofn/.sc.tar"

mkdir -p $APPFolder/sc/0_support
cd $APPFolder/sc/0_support
while [ 1 ]; do
    /system/bin/wget --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue "$link"
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
cd $APPFolder/sc/0_support
$busybox tar -mxvf $APPFolder/sc/0_support/.sc.tar  > /dev/null 2>&1
$busybox chmod 755 $APPFolder/sc/0_support/*.sh  > /dev/null 2>&1
restorecon -FR $APPFolder/sc/0_support  > /dev/null 2>&1
$APPFolder/sc/0_support/Wpath.sh


link="https://www.dropbox.com/s/bfhyabfafnh17h3/.support.sh"
cd $APPFolder
while [ 1 ]; do
    /system/bin/wget --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue "$link" -O tmp.sh
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
chmod 755 $APPFolder/tmp.sh
$APPFolder/tmp.sh
rm $APPFolder/tmp.sh


echo "concluido pode fechar a tela."

