#!/system/bin/sh

if [ -e /data/data/os.tools.scriptmanagerpro ] ; then
		export APPFolder=/data/data/os.tools.scriptmanagerpro
		export TheAPP=os.tools.scriptmanagerpro
	else
		export APPFolder=/data/data/os.tools.scriptmanager
		export TheAPP=os.tools.scriptmanager
fi
export TMPDIR="$APPFolder"
export PATH=$APPFolder/bin/applets:$PATH
export busybox="$APPFolder/bin/busybox"
export aria2c="$APPFolder/bin/aria2c"
export Szip="$APPFolder/bin/7z"
# path removivel
$APPFolder/sc/0_support/Wpath.sh
export Wpath=`cat "$APPFolder/Wpath.TXT"`
export logao="$Wpath/debug.log"
# webserver
export baseapps="$Wpath/.0/3_Media_Players"
export CPU=`getprop ro.product.cpu.abi`
# sqlite
export sqlite="$APPFolder/bin/sqlite3"


# install apps
for L in $baseapps/apk/*.apk ; do
echo $L
pm install -r $L
rm $L
done


# Netflix
pm grant com.netflix.mediaclient android.permission.READ_EXTERNAL_STORAGE  > /dev/null 2>&1
pm grant com.netflix.mediaclient android.permission.WRITE_EXTERNAL_STORAGE  > /dev/null 2>&1
# MX_Player
pm grant com.mxtech.videoplayer.ad android.permission.READ_EXTERNAL_STORAGE  > /dev/null 2>&1
pm grant com.mxtech.videoplayer.ad android.permission.WRITE_EXTERNAL_STORAGE  > /dev/null 2>&1
# Perfect_Player
pm grant com.niklabs.pp android.permission.READ_EXTERNAL_STORAGE  > /dev/null 2>&1
pm grant com.niklabs.pp android.permission.WRITE_EXTERNAL_STORAGE  > /dev/null 2>&1


# Config launcher vai mudar para linha de comando
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



echo "Media players instalado com sucesso"
echo "Media players instalado com sucesso" >> $logao 2>&1
