#!/system/bin/sh

if [ -e /data/data/os.tools.scriptmanagerpro ] ; then
		export APPFolder=/data/data/os.tools.scriptmanagerpro
		export TheAPP=os.tools.scriptmanagerpro
	else
		export APPFolder=/data/data/os.tools.scriptmanager
		export TheAPP=os.tools.scriptmanager
fi
export TMPDIR="$APPFolder"

export IPSERVER="1.0.0.2"
aria2c="$APPFolder/bin/aria2c"
DUser=`stat -c "%u" "$APPFolder"`
#x=$(dirname "$0")

clear
echo "INSTALAR SISTEMA BASE"
echo "Para continuar digite: sim"
read var
if [ "$var" == "sim" ] ; then
    echo "Iniciando instalação"
else
    exit
fi

echo "Iniciando instalação aria downloader"
echo "Por favor aguarde..."
#echo "$x"

# aria2
if [ ! -e "$aria2c" ] ; then
	if [ ! -e $EXTERNAL_STORAGE/Download/aria.tar.gz ] ; then
			echo "Arquivo aria.tar.gz não existe."
			echo "Baixe em nosso site."
			exit
		else
			cd $EXTERNAL_STORAGE/Download
			cp $EXTERNAL_STORAGE/Download/aria.tar.gz $EXTERNAL_STORAGE/Download/.aria.tar.gz 
			gzip -d $EXTERNAL_STORAGE/Download/aria.tar.gz > /dev/null 2>&1
			tar -mxvf $EXTERNAL_STORAGE/Download/aria.tar > /dev/null 2>&1
			rm $EXTERNAL_STORAGE/Download/aria.tar
				cp $EXTERNAL_STORAGE/Download/aria2c_github.so $APPFolder/bin/ > /dev/null 2>&1
				cp $EXTERNAL_STORAGE/Download/aria_libaria2_exec.so $APPFolder/bin/ > /dev/null 2>&1
				cp $EXTERNAL_STORAGE/Download/aria_libaria2_PIC_exec.so $APPFolder/bin/ > /dev/null 2>&1	
				rm $EXTERNAL_STORAGE/Download/aria*.so > /dev/null 2>&1
					chmod 755 $APPFolder/bin/aria*.so > /dev/null 2>&1
					chown -R $DUser:$DUser $APPFolder/bin > /dev/null 2>&1
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
fi

echo "Iniciando download por favor aguarde"
if ping -c 1 $IPSERVER &> /dev/null
	then
		link="http://$IPSERVER/.0/0_support/.sc.tar"
	else
		link="https://www.dropbox.com/s/"
fi
$aria2c -x 10 --check-certificate=false --allow-overwrite=true --file-allocation=none $link --dir=$APPFolder/sc/0_support  > /dev/null 2>&1
cd $APPFolder/sc/0_support
tar -mxvf $APPFolder/sc/0_support/.sc.tar  > /dev/null 2>&1
chmod 755 $APPFolder/sc/0_support/*.sh  > /dev/null 2>&1
restorecon -FR $APPFolder/sc/0_support  > /dev/null 2>&1
$APPFolder/sc/0_support/Wpath.sh

if ping -c 1 $IPSERVER &> /dev/null
	then
		link="http://$IPSERVER/.0/0_support/.support.sh"
	else
		link="https://www.dropbox.com/s/"
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

