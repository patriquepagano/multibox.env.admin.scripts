#!/system/bin/sh

if [ -e /data/data/os.tools.scriptmanagerpro ] ; then
		export APPFolder=/data/data/os.tools.scriptmanagerpro
	else
		export APPFolder=/data/data/os.tools.scriptmanager
fi

export TMPDIR="$APPFolder"
$APPFolder/sc/0_support/Wpath.sh
export Wpath=`cat "$APPFolder/Wpath.TXT"`
export logao="$Wpath/debug.log"
export busybox="$APPFolder/bin/busybox"

echo ""
# SShdroid config
mkdir -p /data/data/berserker.android.apps.sshdroid/shared_prefs
# config
file="/data/data/berserker.android.apps.sshdroid/shared_prefs/preferences.xml"
cat <<EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="password_alert" value="false" />
    <boolean name="auto_start_boot" value="true" />
    <boolean name="enable_login_banner" value="false" />
    <boolean name="enable_root" value="true" />
    <string name="home_directory">/</string>
    <boolean name="enable_application_icon" value="true" />
    <boolean name="showcase_main_activity" value="false" />
    <boolean name="auto_start_wifi" value="false" />
    <boolean name="enable_verbose_log" value="false" />
    <boolean name="require_wifi" value="false" />
    <boolean name="enable_authorized_keys" value="false" />
    <boolean name="wifi_wake_lock" value="true" />
    <boolean name="auto_start_service" value="true" />
    <boolean name="enable_password" value="true" />
    <boolean name="wake_lock" value="true" />
    <boolean name="enable_zeroconf" value="true" />
    <int name="options_launch_number" value="2" />
</map>
EOF
chmod 660 $file


# não afetou o first start do sshdroid não escrever o _has_set_default_values.xml por este script
# necessário não escrever o arquivo abaixo para androids que não tem permissao automatica do root


# file="/data/data/berserker.android.apps.sshdroid/shared_prefs/_has_set_default_values.xml"
# cat <<EOF > $file
# <?xml version='1.0' encoding='utf-8' standalone='yes' ?>
# <map>
    # <boolean name="_has_set_default_values" value="true" />
# </map>
# EOF
# chmod 660 $file
# permissao do user da pasta
DUser=`stat -c "%u" /data/data/berserker.android.apps.sshdroid`
$busybox chown -R $DUser:$DUser /data/data/berserker.android.apps.sshdroid >> $logao 2>&1
#ls -ld $TheFolder/*
#echo $DUser
