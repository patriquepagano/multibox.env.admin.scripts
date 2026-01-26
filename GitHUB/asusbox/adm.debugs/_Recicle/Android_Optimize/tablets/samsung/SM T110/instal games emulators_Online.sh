



# atualizando os cores do pendrive
source="/storage/32A7-021D"
rsync -ah --progress /data/data/com.retroarch/cores/*.so $source/TopApps/Game_Emulators/Retroarch_arm_cores/





/data/data/com.retroarch/cores








# third emulators
Apks='
/storage/32A7-021D/TopApps/Game_Emulators/ePSXe_2.0.8.apk
/storage/32A7-021D/TopApps/Game_Emulators/Mupen64Plus_FZ_Edition_3.0.154_(beta).apk
'


# emulators base arcade
Apks='
/storage/32A7-021D/TopApps/Game_Emulators/DraStic_r2.2.1.2a.apk
/storage/32A7-021D/TopApps/Game_Emulators/RetroArch_1.6.7.apk
'


for i in $Apks; do
echo "$i"
pm install -r "$i"
done





# emulators base arcade (versao intranet )
Apks='
http://1.0.0.95/0/_Android_Pendrive/TopApps/Game_Emulators/DraStic_r2.2.1.2a.apk
http://1.0.0.95/0/_Android_Pendrive/TopApps/Game_Emulators/RetroArch_1.6.9.apk
'
for i in $Apks; do
echo "$i"
cd /sdcard/
wget -q "$i" -O /sdcard/tmp.apk
pm install -r /sdcard/tmp.apk
rm /sdcard/tmp.apk
done






# garantir permissoes para android 6 aqui
apps=`pm list packages -f | grep -e '/data/app/' | sed -e 's,package:/data/app/,,g' | cut -d "=" -f 2 | sort`
for i in $apps; do
echo "liberando permissão de " $i
pm grant $i android.permission.WRITE_EXTERNAL_STORAGE
pm grant $i android.permission.READ_EXTERNAL_STORAGE
done







# liberar permissões retroarch
pm grant com.retroarch android.permission.WRITE_EXTERNAL_STORAGE
pm grant com.retroarch android.permission.READ_EXTERNAL_STORAGE


rm -Rf $EXTERNAL_STORAGE/Android/data/com.retroarch/files
rm -Rf $EXTERNAL_STORAGE/RetroArch
monkey -p com.retroarch -c android.intent.category.LAUNCHER 1
sleep 3

# copy cores  /data
source="/storage/32A7-021D"
rsync -ah --progress $source/TopApps/Game_Emulators/Retroarch_arm_cores/*.so /data/data/com.retroarch/cores/







# perm 600 puxar a permissao do user da pasta
retroarchUser=`stat -c "%U" /data/data/com.retroarch/shared_prefs/com.retroarch_preferences.xml`
chmod 600 /data/data/com.retroarch/cores/*
chown -R $retroarchUser:$retroarchUser /data/data/com.retroarch/cores
# configurar os /sdcard/RetroArch   wallpapers

# nosso pack de autoconfig de controles

am force-stop com.retroarch
# ativa a config Padrão
/data/app/mediaserver/sh/retroarch/configs/enableDefaultConfig.sh


am force-stop com.retroarch







 melhorar este code nao esta pegando alinha com os espaços
# instalando apps via linha comando




/storage/32A7-021D/TopApps/Analize/GamepadTest_1.0.apk
/storage/32A7-021D/TopApps/File_Manager/File_Manager_2.8.0.apk
/storage/32A7-021D/TopApps/Hack_Tool/Universal_Init.d_1.2.1.apk
/storage/32A7-021D/TopApps/Remote_Access/OpenVPN_Connect_1.1.24.apk
/storage/32A7-021D/TopApps/Video/Kodi_17.6.apk
/storage/32A7-021D/TopApps/Video/MX_Player_Pro_v1.9.5_Mod.apk
/storage/32A7-021D/TopApps/Web_Brownser/Fullscreen_Browser_7.apk
# base pack
Apks='

'
for i in $Apks; do
echo "$i"
pm install -r "$i"
done





# online video
Apks='
/storage/32A7-021D/TopApps/Video/Netflix_4.16.1_build_15145.apk
/storage/32A7-021D/TopApps/Video/Youtube_Android_Tv_v2.01.04-20104320.apk
/storage/32A7-021D/TopApps/Video/YouTube_Kids_Android_TV_v1.00.03.apk
'
for i in $Apks; do
echo "$i"
pm install -r "$i"
done











for i in /data/app/PersonalTecnico.net/tmp/*.apk; do
echo "$i"
pm install -r "$i"
rm "$i"
done










