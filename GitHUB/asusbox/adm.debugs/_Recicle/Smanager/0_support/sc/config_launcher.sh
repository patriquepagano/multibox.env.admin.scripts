#!/system/bin/sh

LDFIX=`echo "$LD_LIBRARY_PATH" | cut -c1-1`
if [ "$LDFIX" == ":" ] ; then
	export LD_LIBRARY_PATH=`echo "$LD_LIBRARY_PATH" | cut -c 2-`
fi

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

echo ""
if [ ! -e "$APPFolder/shared_prefs" ] ; then
mkdir -p $APPFolder/shared_prefs
fi

app="/data/data/org.cosinus.launchertv"
# apps
export file="$app/shared_prefs/applications.xml"
cat <<EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <string name="application_00">os.tools.scriptmanager</string>
    <string name="application_01">net.openvpn.openvpn</string>
    <string name="application_02">com.siriusapplications.quickboot</string>	
    <string name="application_03">berserker.android.apps.sshdroid</string>	
</map>
EOF
chmod 660 $file

# config
export file="$app/shared_prefs/org.cosinus.launchertv_preferences.xml"
cat <<EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <float name="preference_transparency" value="0.4" />
    <boolean name="preference_screen_always_on" value="false" />
    <boolean name="preference_show_name" value="true" />
    <string name="preference_margin_x">5</string>
    <string name="preference_grid_y">3</string>
    <string name="preference_grid_x">6</string>
    <boolean name="preference_default_transparency" value="true" />
    <boolean name="preference_show_date" value="false" />
    <string name="preference_margin_y">5</string>
</map>
EOF
chmod 660 $file

# permissao do user da pasta
DUser=`stat -c "%u" "$app"`
chown -R $DUser:$DUser "$app/shared_prefs/" > /dev/null 2>&1
restorecon -F "$app/shared_prefs/*.xml" > /dev/null 2>&1

# acesso root
for p in /system/xbin/su /system/bin/su /su/bin/su /sbin/su /magisk/.core/bin/su
do
	if [ -x $p ]; then
			export CheckRoot="0"
	fi
done

if [ "$CheckRoot" == "0" ] ; then
	su -c "am force-stop org.cosinus.launchertv"
fi



