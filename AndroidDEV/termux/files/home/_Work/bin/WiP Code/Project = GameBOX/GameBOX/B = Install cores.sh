#!/system/bin/sh
source /data/.vars
echo -n "performance" >  /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

# # este é um script debug provisorio
# 1) linux vps vai baixar os cores
# 2) extrair, verificar md5 .so e gravar .md5
# 3) compactar em 7z com senha
# 4) criar torrent


# comprovado este script puxa os cores mais atuais!
# são os mesmos cores se baixado da ui do retroarch!

# abre o webserver
am start --user 0 \
-n com.xyz.fullscreenbrowser/.BrowserActivity \
-a android.intent.action.VIEW -d "http://localhost/log.php" > /dev/null 2>&1
# output to log
echo "<h1>Retroarch cores</h1>" > $bootLog 2>&1
echo "<h2>Selecionando os melhores emuladores para sua placa.</h2>" >> $bootLog 2>&1	

# todos os cpus caso a box não passe pelo filtro
export DownloadFiles="
fbalpha2012_libretro_android.so.zip
mame_libretro_android.so.zip
mame2000_libretro_android.so.zip
mame2003_libretro_android.so.zip
mame2010_libretro_android.so.zip
genesis_plus_gx_libretro_android.so.zip
picodrive_libretro_android.so.zip
nestopia_libretro_android.so.zip
pcsx_rearmed_libretro_android.so.zip
snes9x_libretro_android.so.zip
stella_libretro_android.so.zip
vba_next_libretro_android.so.zip
fbalpha_libretro_android.so.zip
mednafen_psx_hw_libretro_android.so.zip
mednafen_psx_libretro_android.so.zip
mupen64plus_gles3_libretro_android.so.zip
mupen64plus_libretro_android.so.zip
picodrive_libretro_android.so.zip
parallel_n64_libretro_android.so.zip
"


# baixando para a pasta Sdcard
for link in $DownloadFiles; do
	#file=`echo $link | cut -d "/" -f 8`
	file=`echo $link`	
	CoresFolder="$EXTERNAL_STORAGE/RetroArch/cores"
	if [ ! -e $CoresFolder ]; then mkdir -p $CoresFolder; fi # pasta destino dos zips
    if [ ! -e /data/data/com.retroarch/cores ]; then mkdir -p /data/data/com.retroarch/cores; fi # pasta cores do retroarch 

	# output to log
	echo "<h1>Checando atualização</h1>" > $bootLog 2>&1
	echo "<h2>$file</h2>" >> $bootLog 2>&1		
	$wget -N --no-check-certificate -P $CoresFolder https://buildbot.libretro.com/nightly/android/latest/$CPU/$file > $wgetLog 2>&1
    #echo "https://buildbot.libretro.com/nightly/android/latest/$CPU/$file"
	checkFileNew=`cat $wgetLog | grep "Server file no newer than local file" | cut -d "-" -f 3`
	noUpdate=" not retrieving."		
	if [ "$checkFileNew" == "$noUpdate" ] ; then
            echo "Checando atualização"
            echo $file
			echo "<h1>Checando atualização</h1>" > $bootLog 2>&1
			echo "<h2>$file</h2>" >> $bootLog 2>&1
		else
            echo " --- "
            echo "Extraindo core do RetroArch"
            echo $file
            echo " --- "
			echo "<h1>Extraindo core do RetroArch</h1>" > $bootLog 2>&1
			echo "<h2>$file</h2>" >> $bootLog 2>&1
			coreP="/data/data/com.retroarch/cores"
			if [ ! -e $coreP ]; then mkdir -p $coreP; fi
			cd  $coreP
			/system/bin/busybox unzip -o -q "$EXTERNAL_STORAGE/RetroArch/cores/$file" >> $bootLog 2>&1
	fi
done # loop do download dos cores

if [ "$CPU" == "arm64-v8a" ] ; then
        package=com.retroarch.aarch64
	else
        package=com.retroarch
fi	


coreP="/data/data/com.retroarch/cores"
chmod 600 $coreP/*.so
userID=`dumpsys package $package | $grep "userId" | $cut -d "=" -f 2 | $cut -d " " -f 1`
chown -R $userID:$userID $coreP
/system/bin/restorecon -FR $coreP   # preciso resolver esta parte nem todo android tem este binario



########################
exit

abaixo e old



bootLog=/data/asusbox/bitgamer.log
wget="/system/bin/wget"


# abre o webserver
am start --user 0 \
-n com.xyz.fullscreenbrowser/.BrowserActivity \
-a android.intent.action.VIEW -d "http://localhost/log.php" > /dev/null 2>&1
# output to log
echo "<h1>Retroarch cores</h1>" > $bootLog 2>&1
echo "<h2>Selecionando os melhores emuladores para sua placa.</h2>" >> $bootLog 2>&1	

# downloading cpus
export RomBuild=`getprop ro.build.description | sed -e 's/ /_/g'`
export cpu=`getprop ro.product.cpu.abi`

# todos os cpus caso a box não passe pelo filtro
export DownloadFiles="
fbalpha2012_libretro_android.so.zip
mame2003_libretro_android.so.zip
genesis_plus_gx_libretro_android.so.zip
picodrive_libretro_android.so.zip
nestopia_libretro_android.so.zip
pcsx_rearmed_libretro_android.so.zip
snes9x_libretro_android.so.zip
stella_libretro_android.so.zip
vba_next_libretro_android.so.zip
fbalpha_libretro_android.so.zip
mednafen_psx_hw_libretro_android.so.zip
mednafen_psx_libretro_android.so.zip
mupen64plus_gles3_libretro_android.so.zip
mupen64plus_libretro_android.so.zip
picodrive_libretro_android.so.zip
parallel_n64_libretro_android.so.zip
"
# filtro para tvbox expecificas ....
if [ $RomBuild == "rk322x_box-userdebug_7.1.2_NHG47K_NV3.20171214_test-keys" ] ; then
export DownloadFiles="
fbalpha2012_libretro_android.so.zip
mame2003_libretro_android.so.zip
picodrive_libretro_android.so.zip
nestopia_libretro_android.so.zip
pcsx_rearmed_libretro_android.so.zip
snes9x_libretro_android.so.zip
stella_libretro_android.so.zip
vba_next_libretro_android.so.zip
"
fi

if [ $RomBuild == "rk322x_box-userdebug_7.1.2_NHG47K_eng.qiaohy.20171209.120525_release-keys" ] ; then
export DownloadFiles="
fbalpha2012_libretro_android.so.zip
mame2003_libretro_android.so.zip
picodrive_libretro_android.so.zip
nestopia_libretro_android.so.zip
pcsx_rearmed_libretro_android.so.zip
snes9x_libretro_android.so.zip
stella_libretro_android.so.zip
vba_next_libretro_android.so.zip
"
fi

# baixando para a pasta Sdcard
mkdir -p /sdcard/RetroArch/cores
cd /sdcard/RetroArch/cores
for link in $DownloadFiles; do
	#file=`echo $link | cut -d "/" -f 8`
	file=`echo $link`	
	CoresFolder="$EXTERNAL_STORAGE/RetroArch/cores"
	if [ ! -e $CoresFolder ]; then mkdir -p $CoresFolder; fi
	echo $CoresFolder/$file
	wgetLog="$EXTERNAL_STORAGE/RetroArch/cores/version.log"	
	# output to log
	echo "<h1>Checando atualização</h1>" > $bootLog 2>&1
	echo "<h2>$file</h2>" >> $bootLog 2>&1		
	$wget -N --no-check-certificate -P $CoresFolder https://buildbot.libretro.com/nightly/android/latest/$cpu/$file > $wgetLog 2>&1
	checkFileNew=`cat $wgetLog | grep "Server file no newer than local file" | cut -d "-" -f 3`
	noUpdate=" not retrieving."		
	if [ "$checkFileNew" == "$noUpdate" ] ; then
			echo "<h1>Checando atualização</h1>" > $bootLog 2>&1
			echo "<h2>$file</h2>" >> $bootLog 2>&1
		else
			echo "<h1>Extraindo core do RetroArch</h1>" > $bootLog 2>&1
			echo "<h2>$file</h2>" >> $bootLog 2>&1
			coreP="/data/data/com.retroarch/cores"
			if [ ! -e $coreP ]; then mkdir -p $coreP; fi
			cd  $coreP
			/system/bin/busybox unzip -o -q "$EXTERNAL_STORAGE/RetroArch/cores/$file" >> $bootLog 2>&1
	fi
done # loop do download dos cores





coreP="/data/data/com.retroarch/cores"
chmod 600 $coreP/*.so
userID=`dumpsys package $package | $grep "userId" | $cut -d "=" -f 2 | $cut -d " " -f 1`
chown -R $userID:$userID $coreP
/system/bin/restorecon -FR $coreP   # preciso resolver esta parte nem todo android tem este binario




