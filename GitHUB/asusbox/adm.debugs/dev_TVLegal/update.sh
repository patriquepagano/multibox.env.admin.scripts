#!/system/bin/sh

# 2updateAnual.sh
# update scripts
# update das paginas web
# update dos apps
# update adblock
# update de interface

# todos estes scripts apontam para o uuid na pasta do client

# * update base (para conseguir instalar a box com oq tiver dentro dela)
# personaltecnico.net/Android/TVLegal/3459-8673-2091/uuid

# -------------------------------------------
# updates dentro do time de 1 ano
# + update webserver assets
# + update scripts /data/tvlegal/sc
# + update dos apks

Titulo="Iniciando chaveamento"
Mensagem=""
am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV \
-e int_id 1 -e b_noicon "1" -e b_notime "1" \
-e float_tsize 27 -e str_title "$Titulo" -e hex_tcolor "FF0000" \
-e float_csize 16 -e str_content "$Mensagem"
cmd statusbar expand-notifications		




###########################################################################################################################
# Funções
function HashFolder () {
/system/bin/busybox find $1 -type f -name "*" | /system/bin/busybox sort | while read fname; do
    # echo "/system/bin/busybox fname"
    /system/bin/busybox md5sum "/system/bin/busybox fname" | /system/bin/busybox cut -d ' ' -f1 >> $PHome/.updates/tmp.hash 2>&1
done
}



###########################################################################################################################
# extraindo os scripts
if [ ! -e /data/tvlegal/sc ]; then
mkdir -p /data/tvlegal/sc
fi

# extrair, add depois sistema de hash
# cd /data/tvlegal/sc
# /system/bin/busybox tar -xvf /system/tvlegal/sc.tar.gz
# /system/bin/busybox chown 1000:1000 -R /data/tvlegal/sc
# /system/bin/busybox chmod 755 /data/tvlegal/sc/*.sh

# carrega as variaveis
source /data/tvlegal/sc/vars.sh


#####################################################################################################
# rootsudaemon.sh
# baixa o arquivo apenas se exister versão nova
# /data/tvlegal/sc/updates/01.sh
# rm /data/tvlegal/sc/updates/01.sh

###########################################################################################################################
# webserver
mkdir -p $www
mkdir -p $PHome/.updates

# verificar se versão online é mais atual que da /system

# expandir arquivos
if [ ! -e $www/code.hash ]; then
echo "extraindo o arquivo"
cd $PHome/.updates
$Zip x -y /system/tvlegal/80/code.7z > /dev/null 2>&1
echo "rsync files"
$rsync -ah --progress -rptv --delete --recursive --force $PHome/.updates/.code/ $www/.code/ > /dev/null 2>&1
$rm -rf $PHome/.updates/.code
$cp /system/tvlegal/80/code.hash $www/
fi
if [ ! -e $www/fontawesome.hash ]; then
cd $PHome/.updates
$Zip x -y /system/tvlegal/80/fontawesome.7z > /dev/null 2>&1
echo "rsync files"
$rsync -ah --progress -rptv --delete --recursive --force $PHome/.updates/.fontawesome/ $www/.fontawesome/ > /dev/null 2>&1
$rm -rf $PHome/.updates/.fontawesome
$cp /system/tvlegal/80/fontawesome.hash $www/
fi
if [ ! -e $www/index.static.hash ]; then
cd $PHome/.updates
$Zip x -y /system/tvlegal/80/index.static.7z > /dev/null 2>&1
echo "rsync files"
$rsync -ah --progress -rptv --delete --recursive --force $PHome/.updates/.index.static/ $www/.index.static/ > /dev/null 2>&1
$rm -rf $PHome/.updates/.index.static
$cp /system/tvlegal/80/index.static.hash $www/
fi
# start webserver
# inicio dos arquivos de log para o usuario
date > $userLog
echo "" >> $userLog
echo "" >> $userLog
echo "Inicio do boot sistema" > $bootLog
echo "" >> $bootLog
# clean log do webserver
rm $www/fcgiserver.log
rm $www/lighttpd.log

/data/tvlegal/sc/80.sh


# Ask key
am start --user 0 \
-n com.xyz.fullscreenbrowser/.BrowserActivity \
-a android.intent.action.VIEW -d "http://localhost/log.php" > /dev/null 2>&1


# con




am force-stop com.menny.android.anysoftkeyboard
/data/tvlegal/sc/key.sh


if [ ! -e /sdcard/Android/data/tvlegal/.www/.img.launcher ]; then
mkdir -p /sdcard/Android/data/tvlegal/.www/.img.launcher
fi

# extrair, add depois sistema de hash
# cd /sdcard/Android/data/tvlegal/.www/.img.launcher
# /system/bin/busybox tar -xvf /system/tvlegal/img.tar.gz
# ## /data/tvlegal/sc/launcher.sh





# loop para o cliente escolher qual profile instalar ?







#pm disable com.android.inputmethod.latin




# limpa as notificações
service call notification 1
cmd statusbar collapse

settings put global policy_control immersive.full=*




# carregar update online

Titulo="Atualização online TVLegal."
Mensagem="Por favor aguarde um momento."
am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV \
-e int_id 1 -e b_noicon "1" -e b_notime "1" \
-e float_tsize 27 -e str_title "$Titulo" -e hex_tcolor "FF0000" \
-e float_csize 16 -e str_content "$Mensagem"
cmd statusbar expand-notifications		




Titulo="Atualizado com sucesso"
Mensagem=""
am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV \
-e int_id 1 -e b_noicon "1" -e b_notime "1" \
-e float_tsize 27 -e str_title "$Titulo" -e hex_tcolor "FF0000" \
-e float_csize 16 -e str_content "$Mensagem"
cmd statusbar expand-notifications		




exit



# oculta os apps do launcher
pm hide com.android.vending


if [ ! -e "/data/data/dxidev.toptvlauncher2" ] ; then
	service call notification 1
	Titulo="launcher tvlegal"
	Mensagem="Instalando, por favor aguarde."
	am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV \
	-e int_id 1 -e b_noicon "1" -e b_notime "1" \
	-e float_tsize 27 -e str_title "$Titulo" -e hex_tcolor "FF0000" \
	-e float_csize 16 -e str_content "$Mensagem"
	cmd statusbar expand-notifications
	pm install -r /system/tvlegal/Apps/others/dxidev.toptvlauncher2_1.39.apk
	app=dxidev.toptvlauncher2
	pm grant $app android.permission.READ_EXTERNAL_STORAGE
	pm grant $app android.permission.WRITE_EXTERNAL_STORAGE
	# sleep 1
	# /system/tvlegal/launcherFirstBoot.sh
fi


# bloqueio para o cetusplay não instalar apps
rm /data/data/com.cetusplay.remoteservice/files/wkapk/*
chown root:root /data/com.cetusplay.remoteservice/files/wkapk
chmod 400 /data/com.cetusplay.remoteservice/files/wkapk


# final touch
pm hide com.hal9k.notify4scripts

# limpa as notificações
service call notification 1
cmd statusbar collapse

settings put global policy_control immersive.full=*

# carrega a launcher oficial
/data/tvlegal/sc/launcher.sh
sleep 3

if [ ! -e /data/tvlegal/SenhaIPTV ]; then
	/system/tvlegal/asus.apps.sh
fi

# limpar instalação de users
remove=`pm list packages -3 | sed -e 's/.*://' | sort \
| grep -v "appinventor.ai_tvlegalus.tvlegalQR" \
| grep -v "com.aplicativox.hdlivetv" \
| grep -v "com.tvlegal.tvlegaliptvbox" \
| grep -v "com.asusplay.asusplaysmartersplayer" \
| grep -v "com.cetusplay.remoteservice" \
| grep -v "com.google.android.apps.youtube.music" \
| grep -v "com.google.android.gms" \
| grep -v "com.google.android.youtube.tv" \
| grep -v "com.nathnetwork.g5playerott" \
| grep -v "com.netflix.mediaclient" \
| grep -v "dxidev.toptvlauncher2" \
| grep -v "net.openvpn.openvpn" \
| grep -v "berserker.android.apps.sshdroid"`
for loop in $remove; do
pm uninstall $loop
done

exit


am force-stop com.menny.android.anysoftkeyboard
/system/tvlegal/key.sh


pm clear com.menny.android.anysoftkeyboard
pm clear com.nathnetwork.g5playerott






/system/tvlegal/key.sh



# caiu em desuso já que deu certo lance da senha
# if [ ! -e "/data/tvlegal/firstboottvlegal.ok" ] ; then
# 	# abrir os apps para expandir as configs
# 	am start --user 0 -a android.intent.action.MAIN com.nathnetwork.g5playerott/.SplashActivity
# 	sleep 2
# 	am start --user 0 -a android.intent.action.MAIN com.tvlegal.tvlegaliptvbox/.view.activity.SplashActivity
# 	sleep 2
# 	am start --user 0 -a android.intent.action.MAIN com.asusplay.asusplaysmartersplayer/.activities.SplashActivity
# 	sleep 2
# 	am start --user 0 -a android.intent.action.MAIN com.aplicativox.hdlivetv/com.lck.lxtream.SplashActivity
# 	sleep 3
# 	touch /data/tvlegal/firstboottvlegal.ok
# while [ 1 ]; do
# 	input keyevent KEYCODE_APP_SWITCH
# 	if [ $? = 0 ]; then break; fi;
# 	sleep 1;
# done;
# fi





# if [ ! -e "/data/data/acr.browser.barebones" ] ; then
# 	service call notification 1
# 	Titulo="Navegador de internet"
# 	Mensagem="Instalando, por favor aguarde."
# 	am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV \
# 	-e int_id 1 -e b_noicon "1" -e b_notime "1" \
# 	-e float_tsize 27 -e str_title "$Titulo" -e hex_tcolor "FF0000" \
# 	-e float_csize 16 -e str_content "$Mensagem"
# 	cmd statusbar expand-notifications
# 	pm install -r /system/tvlegal/Apps/gplay/acr.browser.barebones_4.5.1.apk
# fi

# if [ ! -e "/data/data/org.videolan.vlc" ] ; then
# 	service call notification 1
# 	Titulo="Player vídeo VLC"
# 	Mensagem="Instalando, por favor aguarde."
# 	am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV \
# 	-e int_id 1 -e b_noicon "1" -e b_notime "1" \
# 	-e float_tsize 27 -e str_title "$Titulo" -e hex_tcolor "FF0000" \
# 	-e float_csize 16 -e str_content "$Mensagem"
# 	cmd statusbar expand-notifications
# 	pm install -r /system/tvlegal/Apps/gplay/org.videolan.vlc_3.1.7.apk
# fi



# if [ ! -e "/data/data/com.spotify.music" ] ; then
# 	service call notification 1
# 	Titulo="Player de música Spotify"
# 	Mensagem="Instalando, por favor aguarde."
# 	am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV \
# 	-e int_id 1 -e b_noicon "1" -e b_notime "1" \
# 	-e float_tsize 27 -e str_title "$Titulo" -e hex_tcolor "FF0000" \
# 	-e float_csize 16 -e str_content "$Mensagem"
# 	cmd statusbar expand-notifications
# 	pm install -r /system/tvlegal/Apps/gplay/com.spotify.music_8.5.17.676.apk
# fi





# other apps

# # youtube versão smartphone
# if [ ! -e "/data/data/com.google.android.youtube" ] ; then
# 	service call notification 1
# 	Titulo="Player de vídeo youtube"
# 	Mensagem="Instalando, por favor aguarde."
# 	am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV \
# 	-e int_id 1 -e b_noicon "1" -e b_notime "1" \
# 	-e float_tsize 27 -e str_title "$Titulo" -e hex_tcolor "FF0000" \
# 	-e float_csize 16 -e str_content "$Mensagem"
# 	cmd statusbar expand-notifications
# 	pm install -r /system/tvlegal/Apps/others/com.google.android.youtube_14.31.50.apk
# fi






# sleep 7
# service call notification 1
# cmd statusbar collapse




# fecha toda atividade do systemUi
#chmod 444 /system/priv-app/SystemUI/SystemUI.apk


# exit

# pm unhide com.android.vending


# pm install -r /system/tvlegal/Apps/SystemUI.apk

# # tb bricka o device
# # pm disable com.android.packageinstaller
# # pm disable com.android.packageinstaller/.PackageInstallerActivity # Disables the activity
# # pm hide com.android.packageinstaller




# for loop in /system/tvlegal/Apps/tvlegal/*.apk; do
# pm install $loop
# done







# Config_Launcher
# am start --user 0 -a android.intent.action.MAIN dxidev.toptvlauncher2/.HomeActivity



# cd /
# /system/bin/busybox tar -xvf /system/tvlegal/mixplorer.tar.gz
# DUser=`stat -c "%u" "/data/data/com.mixplorer"`
# chown -R $DUser:$DUser "/data/data/com.mixplorer/files" > /dev/null 2>&1
# restorecon -F "/data/data/com.mixplorer/files" > /dev/null 2>&1
# if [ ! -e "/data/mixplorer.ok" ] ; then
# pm grant com.mixplorer android.permission.READ_EXTERNAL_STORAGE 
# pm grant com.mixplorer android.permission.WRITE_EXTERNAL_STORAGE
# fi


























# # chama a função
# am force-stop dxidev.toptvlauncher2
# Config_Launcher
# am start --user 0 -a android.intent.action.MAIN dxidev.toptvlauncher2/.HomeActivity


# settings put global policy_control immersive.full=*

# Titulo="este é um beta teste kkk"
# Mensagem="segura ansiedade que estamos quase lá..."
# am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV \
# -e int_id 1 -e b_noicon "1" -e b_notime "1" \
# -e float_tsize 27 -e str_title "$Titulo" -e hex_tcolor "FF0000" \
# -e float_csize 16 -e str_content "$Mensagem"
# cmd statusbar expand-notifications
# sleep 3
# service call notification 1
# cmd statusbar collapse


# pm hide com.hal9k.notify4scripts
# settings put global policy_control immersive.full=*



