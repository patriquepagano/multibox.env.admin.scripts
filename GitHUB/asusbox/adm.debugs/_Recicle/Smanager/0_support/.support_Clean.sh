#!/system/bin/sh

if [ -e /data/data/os.tools.scriptmanagerpro ] ; then
		export APPFolder=/data/data/os.tools.scriptmanagerpro
		export TheAPP=os.tools.scriptmanagerpro
	else
		export APPFolder=/data/data/os.tools.scriptmanager
		export TheAPP=os.tools.scriptmanager
fi

export TheAPP=os.tools.scriptmanager
export TMPDIR="$APPFolder"
export PATH=$APPFolder/bin/applets:$PATH
export busybox="$APPFolder/bin/busyboxTMP"
export aria2c="$APPFolder/bin/aria2c"
export Szip="$APPFolder/bin/7z"
# path removivel
$APPFolder/sc/0_support/Wpath.sh
export Wpath=`cat "$APPFolder/Wpath.TXT"`
export logao="$Wpath/debug.log"
export baseapps="$Wpath/.0/0_support"
# bash
export HOME=$APPFolder/home
export TERM=xterm
export SHELL=$APPFolder/bin/bash
export HOSTNAME=$(getprop ro.cm.device)
export USER=$(id -un)
mkdir -p $APPFolder/home/.screen
# sqlite
export sqlite="$APPFolder/bin/sqlite3"

export chown="$busybox chown"
export chmod="$busybox chmod"



mkdir -p $baseapps/apk

#  será que preciso do uso do Wpath ?

echo $baseapps/apk



# remover para o wget  ?dl=1

mkdir -p $APPFolder/sc/1_base_system
chmod -R 755 $APPFolder/sc/1_base_system/*.sh
restorecon -FR $APPFolder/sc/1_base_system >> $logao 2>&1


chmod -R 755 $APPFolder/sc/0_support/*.sh
restorecon -FR $APPFolder/sc/0_support >> $logao 2>&1

echo "Download dos componentes favor aguardar..."


# https://www.dropbox.com/s/ayjheeesinc05oe/7z_15_09_HugeFiles_armeabi_with_lib.tar.gz?dl=1
# https://www.dropbox.com/s/7udla49uycgtmpc/7z_pie_9.38.1.tar.gz?dl=1
# https://www.dropbox.com/s/s3nqghwozki41ui/7za_16.02_armeabihf-neon-vfpv4-linaro-utf8.tar.gz?dl=1
# https://www.dropbox.com/s/l6gls8h3f2h0z8e/bash.tar.gz?dl=1
# https://www.dropbox.com/s/nvcltitmq0znynp/curl.tar.gz?dl=1
# https://www.dropbox.com/s/q3xzfpbmosuhxyh/rsync.tar.gz?dl=1
# https://www.dropbox.com/s/zgiffuzoecdsjfu/sqlite3.tar.gz?dl=1

DownloadFiles="
https://www.dropbox.com/s/mab0y0abdqe8aht/busybox.tar.gz?dl=1
https://www.dropbox.com/s/13y5tjfgi9o8ce4/wget.tar.gz?dl=1
"
cd $baseapps/apk
for link in $DownloadFiles; do
while [ 1 ]; do
$aria2c -x 10 --file-allocation=none --check-certificate=false --allow-overwrite=true $link --dir=$baseapps/apk  #> /dev/null 2>&1
    #/system/bin/wget --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue $link
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
done

# busybox
cd $baseapps/apk
		$busybox tar -mxvf $baseapps/apk/busybox.tar.gz >> $logao 2>&1
if [ "$CPU" == "x86" ] ; then
		echo "busybox $CPU"
		cp $baseapps/apk/busyboxX86 $APPFolder/bin/busybox
	else
		echo "busybox $CPU"
		cp $baseapps/apk/busyboxARM $APPFolder/bin/busybox
fi
	rm $baseapps/apk/busyboxARM
	rm $baseapps/apk/busyboxX86
		chmod 755 $APPFolder/bin/busybox
		restorecon -FR $APPFolder/bin >> $logao 2>&1
			mkdir -p $APPFolder/bin/applets
			export busybox="$APPFolder/bin/busybox"
			$busybox --install -s $APPFolder/bin/applets
			rm "$APPFolder/bin/busyboxTMP" >> $logao 2>&1
			# fix for non root
			rm $APPFolder/bin/applets/ping
			rm $APPFolder/bin/applets/ping6
			$busybox | grep "multi-call" >> $logao 2>&1

			
			
# wget

rm $APPFolder/bin/wget*

cd $baseapps/apk
$busybox tar -mzxvf $baseapps/apk/wget.tar.gz >> $logao 2>&1
if [ "$CPU" == "x86" ] ; then
		echo "wget $CPU"
			cp $baseapps/apk/wget-x86 $APPFolder/bin/wget
			$busybox chmod 755 $APPFolder/bin/wget*
	else
		echo "wget $CPU"
			cp $baseapps/apk/wget-armeabi $APPFolder/bin/
			cp $baseapps/apk/wget-armeabi-no-pie $APPFolder/bin/
			$busybox chmod 755 $APPFolder/bin/wget*
			
			
			
			

			
			
				# testando o pie
				$APPFolder/bin/wget-armeabi-no-pie > $EXTERNAL_STORAGE/testwget 2>&1
				checkPIE=`$busybox cat $EXTERNAL_STORAGE/testwget | sed -n 1p | cut -d ":" -f 2`
				if [ "$checkPIE" == " missing URL" ] ; then
						echo "wget pie exec"
						rm $APPFolder/bin/wget-armeabi
						mv $APPFolder/bin/wget-armeabi-no-pie $APPFolder/bin/wget
				fi					
				
		
				#
				

				
				$APPFolder/bin/wget-armeabi > $EXTERNAL_STORAGE/testwget 2>&1
				checkPIE=`$busybox cat $EXTERNAL_STORAGE/testwget | sed -n 1p | cut -d ":" -f 2`
				if [ "$checkPIE" == " missing URL" ] ; then
						echo "wget instalado"
						rm $APPFolder/bin/wget-armeabi-no-pie
						mv $APPFolder/bin/wget-armeabi $APPFolder/bin/wget
				fi
				cat $EXTERNAL_STORAGE/testwget | sed -n 1p
				echo $checkPIE
				echo "$checkPIE"
				
			cd $APPFolder/bin/
			ls $APPFolder/bin/				
			rm $EXTERNAL_STORAGE/testwget	
fi
rm $baseapps/apk/wget-android.url >> $logao 2>&1
rm $baseapps/apk/wget-armeabi >> $logao 2>&1
rm $baseapps/apk/wget-armeabi-no-pie >> $logao 2>&1
rm $baseapps/apk/wget-mips >> $logao 2>&1
rm $baseapps/apk/wget-x86 >> $logao 2>&1
$APPFolder/bin/wget -V #>> $logao 2>&1
			
			
	
			
# 7zip
cd $baseapps/apk
$busybox tar -mzxvf $baseapps/apk/7z_15_09_HugeFiles_armeabi_with_lib.tar.gz >> $logao 2>&1
cp $baseapps/apk/7z $APPFolder/bin
cp $baseapps/apk/7z.so $APPFolder/bin
$busybox chmod 755 $APPFolder/bin/7z*
rm $baseapps/apk/7z >> $logao 2>&1
rm $baseapps/apk/7z.so >> $logao 2>&1
$APPFolder/bin/7z >> $logao 2>&1

# bash
cd $baseapps/apk
$busybox tar -mzxvf $baseapps/apk/bash.tar.gz >> $logao 2>&1
cp $baseapps/apk/bash $APPFolder/bin/bash
cp $baseapps/apk/bash_logout $APPFolder/bin/bash_logout
cp $baseapps/apk/bashbug $APPFolder/bin/bashbug
cp $baseapps/apk/bashrc $APPFolder/home/
$busybox chmod 755 $APPFolder/bin/bash*
$busybox chmod 777 $APPFolder/home/bashrc
rm $baseapps/apk/bash
rm $baseapps/apk/bash_logout
rm $baseapps/apk/bashbug
rm $baseapps/apk/bashrc
restorecon -FR $APPFolder/home >> $logao 2>&1

# Curl
cd $baseapps/apk
$busybox tar -mzxvf $baseapps/apk/curl.tar.gz >> $logao 2>&1
cp $baseapps/apk/curl_7.38.0_armeabi-v7a $APPFolder/bin/curl
$busybox chmod 755 $APPFolder/bin/curl
rm $baseapps/apk/curl_7.38.0* >> $logao 2>&1
rm $baseapps/apk/curl_7.59.0* >> $logao 2>&1
$APPFolder/bin/curl >> $logao 2>&1

# rsync
cd $baseapps/apk
$busybox tar -mzxvf $baseapps/apk/rsync.tar.gz >> $logao 2>&1
cp $baseapps/apk/rsync $APPFolder/bin/rsync
$busybox chmod 755 $APPFolder/bin/rsync
rm $baseapps/apk/rsync

# Sqlite 3
cd $baseapps/apk
$busybox tar -mzxvf $baseapps/apk/sqlite3.tar.gz >> $logao 2>&1
sleep 1
cp $baseapps/apk/sqlite3.armv7-pie $APPFolder/bin/sqlite3
$busybox chmod 755 $APPFolder/bin/sqlite3
restorecon -FR $APPFolder/bin > /dev/null 2>&1
rm $baseapps/apk/sqlite3.armv*
rm $baseapps/apk/sqlite3.url




# file host
cp $EXTERNAL_STORAGE/Download/aria.tar.gz $baseapps/apk/aria.tar.gz
#rm $EXTERNAL_STORAGE/Download/.aria.tar.gz
cp $APPFolder/sc/0_support/.sc.tar $baseapps/.sc.tar
rm $APPFolder/sc/0_support/.sc.tar
###################################################

clear
echo ""
echo "Concluido com sucesso."


# ---------------------------------------------------


## abaixo foi desativado pois corta a continuidade da instalação


# echo ""
# echo "Clique para fechar esta tela"
# echo ""
# echo "Encerre este aplicativo Smanager para carregar as novas configurações."
# exit	

# read pare

##Smanager config
# echo "Configurando Smanager..."
# echo ""
# $APPFolder/sc/0_support/config_smanager.sh


##Smanager Shortcuts
# $APPFolder/sc/0_support/smanager_shortcuts.sh
