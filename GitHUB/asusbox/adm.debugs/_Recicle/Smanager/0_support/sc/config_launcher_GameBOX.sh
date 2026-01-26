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


app="/data/data/org.cosinus.launchertv"
if [ ! -e "$app/shared_prefs" ] ; then
mkdir -p $app/shared_prefs
fi
# apps
export file="$app/shared_prefs/applications.xml"
cat <<EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <string name="application_00">os.tools.scriptmanager</string>
    <string name="application_01">net.openvpn.openvpn</string>
    <string name="application_02">com.siriusapplications.quickboot</string>	
    <string name="application_03">berserker.android.apps.sshdroid</string>
	<string name="application_04">com.mixplorer</string>
	<string name="application_05">acr.browser.barebones</string>
	<string name="application_06">de.ozerov.fully</string>
	<string name="application_07">com.xyz.fullscreenbrowser</string>
	<string name="application_08">org.xbmc.kodi</string>
	<string name="application_09">com.google.android.youtube</string>
	<string name="application_10">com.netflix.mediaclient</string>
	<string name="application_11">org.videolan.vlc</string>
	<string name="application_12">com.niklabs.pp</string>
    <string name="application_13">com.retroarch</string>
    <string name="application_14">com.chiarly.gamepad</string>
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
f="$APPFolder/tmpS.sh"
cat <<EOF > $f
#!/system/bin/sh
am force-stop org.cosinus.launchertv
EOF
chmod 755 $f
su -c $f
rm $f
fi
am start --user 0 -a android.intent.action.HOME org.cosinus.launchertv/.Launcher



