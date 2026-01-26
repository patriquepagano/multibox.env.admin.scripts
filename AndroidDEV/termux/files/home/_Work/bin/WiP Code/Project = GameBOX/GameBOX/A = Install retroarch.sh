#!/system/bin/sh
source /data/.vars
echo -n "performance" >  /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

function AriaStop () {
$kill -9 $($pgrep aria2c) > /dev/null 2>&1
}


function AriaDownHttpsFile () {
while [ 1 ]; do
    AriaStop
    #echo $link
    # obs o aria erro de certificado faz ele seguir adiante no script
    $aria2c --check-certificate=false \
    --show-console-readout=false \
    --always-resume=true \
    --summary-interval=10 \
    --console-log-level=error \
    --file-allocation=none \
    $1 -d $2 | sed -e 's/FILE:.*//g' >> $bootLog 2>&1
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    $sleep 1;
done;
}



mkdir -p /data/$Produto/Gamebox.tmp

appN="RetroArch"


# abre o webserver
am start --user 0 \
-n com.xyz.fullscreenbrowser/.BrowserActivity \
-a android.intent.action.VIEW -d "http://localhost/log.php" > /dev/null 2>&1


# output to log
echo "<h1>Checando atualização</h1>" > $bootLog 2>&1
echo "<h2>$appN</h2>" >> $bootLog 2>&1

# sistema utilizando o hosting do retroarch mesmo / no futuro vamos utilizar torrent do nosso server
while [ 1 ]; do
	$wget -N --no-check-certificate www.retroarch.com/?page=platforms -O /data/$Produto/Gamebox.tmp/RetroArchversionAndroid
	if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
	sleep 1;
done;

# link=`cat /data/$Produto/Gamebox.tmp/RetroArchversionAndroid | grep "https://buildbot.libretro.com/stable/.*/android" | grep "RetroArch.apk" | cut -d '"' -f 2`
VersionOnline=`cat /data/$Produto/Gamebox.tmp/RetroArchversionAndroid | grep "https://buildbot.libretro.com/stable/.*/android" | cut -d '/' -f 5 | head -1`
rm /data/$Produto/Gamebox.tmp/RetroArchversionAndroid > /dev/null 2>&1

echo "Ultima versão localizada $VersionOnline" >> $bootLog 2>&1

if [ "$CPU" == "arm64-v8a" ] ; then
		link="https://buildbot.libretro.com/stable/$VersionOnline/android/RetroArch_aarch64.apk"
        package=com.retroarch.aarch64
	else
		link="https://buildbot.libretro.com/stable/$VersionOnline/android/RetroArch.apk"
        package=com.retroarch
fi	
echo "Seu processador é $CPU" >> $bootLog 2>&1

mkdir -p $EXTERNAL_STORAGE/RetroArch > /dev/null 2>&1
echo $VersionOnline > $www/retroarch.version
export VersionOnline=`cat $www/retroarch.version`




# verificando a atual
userID=`dumpsys package $package | $grep "userId" | $cut -d "=" -f 2 | $cut -d " " -f 1`


version=`dumpsys package $package | $grep "versionName" | $cut -d "=" -f 2 | $cut -d " " -f 1`


echo $VersionOnline






exit



if [ "$VersionOnline" == "$version" ] ; then
	echo "<h1>RetroArch atualizado.</h1>" > $bootLog 2>&1
	echo "<h2>$appN</h2>" >> $bootLog 2>&1
else
	echo "<h1>Baixando Aplicativo</h1>" > $bootLog 2>&1
	echo "<h2>$appN</h2>" >> $bootLog 2>&1
    AriaDownHttpsFile "$link" "/data/$Produto/Gamebox.tmp/"
	# instalando o apk
	echo "<h1>Instalando Aplicativo</h1>" > $bootLog 2>&1
	echo "<h2>$appN</h2>" >> $bootLog 2>&1
	# pm install app
	pm install -r /data/$Produto/Gamebox.tmp/RetroArch.apk
	rm /data/$Produto/Gamebox.tmp/RetroArch.apk
	pm grant com.retroarch android.permission.READ_EXTERNAL_STORAGE  > /dev/null 2>&1
	pm grant com.retroarch android.permission.WRITE_EXTERNAL_STORAGE  > /dev/null 2>&1
	# adicionando a versão nova a atual
	echo $VersionOnline > $EXTERNAL_STORAGE/RetroArch/version
fi


