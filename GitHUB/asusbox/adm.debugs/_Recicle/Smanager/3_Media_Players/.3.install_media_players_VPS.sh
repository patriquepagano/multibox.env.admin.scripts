#!/system/bin/sh

export APPFolder=/data/data/os.tools.scriptmanager
export TheAPP=os.tools.scriptmanager
export TMPDIR="$APPFolder"
export PATH=$APPFolder/bin/applets:$PATH
export busybox="$APPFolder/bin/busybox"
export aria2c="$APPFolder/bin/aria2c"
export wget="$APPFolder/bin/wget"
export Szip="$APPFolder/bin/7z"
# path removivel
$APPFolder/sc/0_support/Wpath.sh
export Wpath=`cat "$APPFolder/Wpath.TXT"`
export logao="$Wpath/debug.log"
# webserver
export baseapps="$Wpath/.0/3_Media_Players"
export CPU=`getprop ro.product.cpu.abi`

export DeviceAPI=`getprop ro.build.version.sdk`

if [ ! -e "$baseapps" ] ; then
mkdir -p $baseapps/apk
fi

echo "Baixando componentes por favor aguarde"

am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV -e b_noicon "1" -e b_notime "1" -e int_id 3 -e str_title "Download apps" -e hex_tcolor "FF0000" -e float_tsize 27 -e float_csize 16 -e str_content "MxPlayer e PerfectPlayer"
cmd statusbar collapse
cmd statusbar expand-notifications

# apps
if [ $DeviceAPI -gt '14' ] ; then
		echo "Baixando apps por favor aguarde"
				DownloadFiles="
			https://www.dropbox.com/s/kmu3utyg1wevu7m/14_com.niklabs.pp_1.4.6_400.apk
			https://www.dropbox.com/s/zgcx35ad793hztq/14_com.mxtech.videoplayer.ad_1.9.11_1210001032.apk
				"
cd $baseapps/apk
for link in $DownloadFiles; do
while [ 1 ]; do
    $wget --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue $link
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
done
fi

am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV -e b_noicon "1" -e b_notime "1" -e int_id 3 -e str_title "Download apps" -e hex_tcolor "FF0000" -e float_tsize 27 -e float_csize 16 -e str_content "Youtube"
cmd statusbar collapse
cmd statusbar expand-notifications
# youtube
# google junk (lembrete não adiciona mais o google services api 23 pra cima só da dor cabeça o install manual)
if [ $DeviceAPI -gt '23' ] ; then
echo "Baixando apps por favor aguarde"
DownloadFiles="
https://www.dropbox.com/s/94k8f3hunzc40hv/21_com.google.android.youtube_13.05.52_1305523310.apk
"
cd $baseapps/apk
for link in $DownloadFiles; do
while [ 1 ]; do
    $wget --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue "$link"
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
done
	else
echo "Baixando apps por favor aguarde"
DownloadFiles="
https://www.dropbox.com/s/qshkakyqi58vv52/17_com.google.android.youtube_13.05.52_1305522310.apk
"
for link in $DownloadFiles; do
while [ 1 ]; do
    $wget --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue "$link"
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
done	
fi

am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV -e b_noicon "1" -e b_notime "1" -e int_id 3 -e str_title "Download apps" -e hex_tcolor "FF0000" -e float_tsize 27 -e float_csize 16 -e str_content "Netflix"
cmd statusbar collapse
cmd statusbar expand-notifications
# netflix
if [ $DeviceAPI -gt '18' ] ; then
echo "Baixando netflix Android 4.4"
DownloadFiles="
https://www.dropbox.com/s/c6qtgxyzat3znf2/19_com.netflix.mediaclient_4.16.1_build_200147.apk
"
cd $baseapps/apk
for link in $DownloadFiles; do
while [ 1 ]; do
    $wget --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue "$link"
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
done
	else
echo "Baixando Netflix Android 4.0"
DownloadFiles="
https://www.dropbox.com/s/pzfvfd7scbgxbv0/14_com.netflix.mediaclient_3.16.3_build_5359_armeabi_nodpi.apk
"
cd $baseapps/apk
for link in $DownloadFiles; do
while [ 1 ]; do
    $wget --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue "$link"
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
done	
fi



am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV -e b_noicon "1" -e b_notime "1" -e int_id 3 -e str_title "Instalando apps" -e hex_tcolor "FF0000" -e float_tsize 27 -e float_csize 16 -e str_content "Por favor aguarde..."
cmd statusbar collapse
cmd statusbar expand-notifications

# install apps
for L in $baseapps/apk/*.apk ; do
echo $L
while [ 1 ]; do
    pm install -r $L
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
rm $L
done

# MX_Player
pm grant com.mxtech.videoplayer.ad android.permission.READ_EXTERNAL_STORAGE  > /dev/null 2>&1
pm grant com.mxtech.videoplayer.ad android.permission.WRITE_EXTERNAL_STORAGE  > /dev/null 2>&1
# Perfect_Player
pm grant com.niklabs.pp android.permission.READ_EXTERNAL_STORAGE  > /dev/null 2>&1
pm grant com.niklabs.pp android.permission.WRITE_EXTERNAL_STORAGE  > /dev/null 2>&1


TheFolder="/data/data/com.niklabs.pp"
mkdir -p $TheFolder/shared_prefs
file="$TheFolder/shared_prefs/com.niklabs.pp_preferences.xml"
cat <<EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <string name="pref_key_last_startup_day">09.05.2018</string>
    <string name="pref_key_last_channel"></string>
    <boolean name="pref_key_show_clock" value="false" />
    <boolean name="pref_key_enable_perfect_remote" value="false" />
    <string name="pref_key_playlist_1">http://bit.ly/AllCanais;m3u;ffff;0</string>
    <string name="pref_key_channels_list_selected_group">TV Aberta</string>
    <boolean name="pref_key_groups_management_mode" value="false" />
    <boolean name="pref_key_change_volume_by_left_right_keys" value="false" />
    <boolean name="pref_key_epgs_assign_mode" value="false" />
    <boolean name="pref_key_logos_assign_mode" value="false" />
    <long name="pref_key_first_settings_showed" value="1525886426575" />
    <string name="pref_key_clock_position">tr</string>
    <boolean name="pref_key_channels_list_in_groups" value="false" />
    <boolean name="pref_key_change_system_volume" value="true" />
    <boolean name="pref_key_play_last_channel_at_startup" value="false" />
    <boolean name="pref_key_download_supposed_logos" value="true" />
    <boolean name="pref_key_channels_window_additional_selected" value="false" />
    <boolean name="pref_key_autostart_at_bootup" value="false" />
    <string name="pref_key_decoder">auto</string>
    <boolean name="pref_key_mute" value="false" />
    <string name="pref_key_theme">satin</string>
    <boolean name="pref_key_show_channels_groups_as_folders" value="true" />
    <string name="pref_key_language">pt</string>
    <float name="pref_key_volume" value="1.0" />
    <string name="pref_key_clock_font_size">1</string>
    <boolean name="pref_key_remote_control_hidden" value="true" />
    <string name="pref_key_font_size">1</string>
    <boolean name="pref_key_playback_in_background" value="false" />
</map>
EOF
perms=`stat -c "%u" "$TheFolder"`
chown -R $perms:$perms $TheFolder/shared_prefs
chmod 660 $TheFolder/shared_prefs/*.xml
restorecon -FR $TheFolder/shared_prefs >> $logao 2>&1




app="/data/data/org.cosinus.launchertv"
if [ ! -e "$app/shared_prefs" ] ; then
mkdir -p $app/shared_prefs
fi
# apps
export file="$app/shared_prefs/applications.xml"
cat <<EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <string name="application_07">com.siriusapplications.quickboot</string>
    <string name="application_00">org.xbmc.kodi</string>
    <string name="application_02">com.mxtech.videoplayer.ad</string>
    <string name="application_01">com.netflix.mediaclient</string>
    <string name="application_03">com.niklabs.pp</string>
    <string name="application_05">acr.browser.barebones</string>
    <string name="application_06">com.mixplorer</string>
    <string name="application_04">com.google.android.youtube</string>
    <string name="application_08">os.tools.scriptmanager</string>
    <string name="application_09">com.android.vending</string>
</map>
EOF
chmod 660 $file

# config
export file="$app/shared_prefs/org.cosinus.launchertv_preferences.xml"
cat <<EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="preference_show_date" value="false" />
    <boolean name="preference_default_transparency" value="true" />
    <float name="preference_transparency" value="0.4" />
    <string name="preference_grid_y">3</string>
    <boolean name="preference_show_name" value="true" />
    <string name="preference_grid_x">5</string>
    <string name="preference_margin_x">5</string>
    <string name="preference_margin_y">5</string>
    <boolean name="preference_screen_always_on" value="false" />
</map>
EOF
chmod 660 $file

# permissao do user da pasta
DUser=`stat -c "%u" "$app"`
chown -R $DUser:$DUser "$app/shared_prefs/" > /dev/null 2>&1
restorecon -F "$app/shared_prefs/*.xml" > /dev/null 2>&1



am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV -e b_noicon "1" -e b_notime "1" -e int_id 3 -e str_title "Instalado apps MCE" -e hex_tcolor "FF0000" -e float_tsize 27 -e float_csize 16 -e str_content "Aguarde nova etapa."
cmd statusbar collapse
cmd statusbar expand-notifications

