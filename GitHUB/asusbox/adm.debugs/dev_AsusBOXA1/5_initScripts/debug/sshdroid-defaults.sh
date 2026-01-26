#!/system/bin/sh

mkdir -p /data/data/berserker.android.apps.sshdroid/shared_prefs
chmod 771 /data/data/berserker.android.apps.sshdroid/shared_prefs
file="/data/data/berserker.android.apps.sshdroid/shared_prefs/_has_set_default_values.xml"
cat << EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="_has_set_default_values" value="true" />
</map>
EOF

file="/data/data/berserker.android.apps.sshdroid/shared_prefs/berserker.android.apps.sshdroid_preferences.xml"
cat << EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="auto_start_boot" value="false" />
    <boolean name="enable_root" value="true" />
    <boolean name="enable_login_banner" value="true" />
    <boolean name="auto_start_service" value="true" />
    <boolean name="wifi_wake_lock" value="true" />
    <boolean name="enable_application_icon" value="false" />
    <boolean name="enable_password" value="true" />
    <boolean name="auto_start_wifi" value="false" />
    <boolean name="wake_lock" value="true" />
    <boolean name="enable_verbose_log" value="false" />
    <boolean name="enable_zeroconf" value="true" />
    <boolean name="require_wifi" value="true" />
</map>
EOF

file="/data/data/berserker.android.apps.sshdroid/shared_prefs/preferences.xml"
cat << EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="password_alert" value="false" />
    <boolean name="auto_start_boot" value="true" />
    <boolean name="enable_root" value="true" />
    <boolean name="enable_login_banner" value="false" />
    <boolean name="enable_application_icon" value="false" />
    <string name="home_directory">"/storage/DevMount/GitHUB/asusbox/"</string>
    <boolean name="showcase_main_activity" value="false" />
    <boolean name="auto_start_wifi" value="false" />
    <boolean name="enable_verbose_log" value="false" />
    <boolean name="require_wifi" value="false" />
    <boolean name="wifi_wake_lock" value="true" />
    <boolean name="enable_authorized_keys" value="false" />
    <boolean name="auto_start_service" value="true" />
    <boolean name="enable_password" value="true" />
    <boolean name="wake_lock" value="true" />
    <boolean name="enable_zeroconf" value="true" />
    <int name="options_launch_number" value="2" />
</map>
EOF

chmod 660 /data/data/berserker.android.apps.sshdroid/shared_prefs/*.xml


# permissions
package=berserker.android.apps.sshdroid
uid=`dumpsys package $package | grep "userId" | cut -d "=" -f 2 | head -n 1`
chown -R $uid:$uid /data/data/$package
restorecon -FR /data/data/$package



cat <<'EOF' > /storage/DevMount/GitHUB/asusbox/.bashrc
export PS1='$(whoami):$(pwd)/ sshdroid :) '
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib
alias asus='cd /storage/DevMount/GitHUB/asusbox'
alias tempo='/storage/DevMount/GitHUB/asusbox/adm.0.git/set-date-proxy.sh'
alias up='/storage/DevMount/GitHUB/asusbox/adm.0.git/push.sh'
alias dbg='cd /data/debugtvbox'
EOF

source /storage/DevMount/GitHUB/asusbox/.bashrc

