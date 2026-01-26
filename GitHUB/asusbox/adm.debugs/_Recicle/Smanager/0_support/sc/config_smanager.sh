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

# config
export file="$APPFolder"/shared_prefs/"$TheAPP"_preferences.xml
cat <<EOF > $file
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="overridepath" value="false" />
    <boolean name="use_sh_copy" value="true" />
    <boolean name="F2" value="true" />
    <boolean name="vibrate_bg_shortcut" value="false" />
    <boolean name="F3" value="true" />
    <boolean name="showclose" value="true" />
    <boolean name="showconsolealiaskeys" value="false" />
    <boolean name="Sup" value="true" />
    <boolean name="showconsoleextrakeys" value="false" />
    <boolean name="Hom" value="true" />
    <boolean name="Ctl" value="true" />
    <boolean name="checkmissingschedulesboot" value="true" />
    <boolean name="exporthome" value="false" />
    <boolean name="sh_suexec" value="false" />
    <boolean name="F11" value="true" />
    <boolean name="Ins" value="true" />
    <boolean name="dw" value="true" />
    <boolean name="Pg-" value="true" />
    <boolean name="F1" value="true" />
    <boolean name="askwidgets" value="false" />
    <boolean name="con_hidelandkeyboard" value="true" />
    <boolean name="con_utf8" value="true" />
    <boolean name="hidenavigationbuttons" value="false" />
    <boolean name="smb_casesensitiveorder" value="true" />
    <boolean name="End" value="true" />
    <boolean name="F7" value="true" />
    <boolean name="showconsoleguides" value="true" />
    <boolean name="runningbgnotification" value="true" />
    <boolean name="Alt" value="true" />
    <boolean name="extragestures" value="false" />
    <boolean name="&lt;-" value="true" />
    <boolean name="wakelockenabled" value="true" />
    <boolean name="singletouchfav" value="true" />
    <boolean name="showthumbnail" value="true" />
    <boolean name="gridlist" value="false" />
    <string name="confirmationflags">0</string>
    <boolean name="F8" value="true" />
    <boolean name="-&gt;" value="true" />
    <boolean name="showusebar" value="true" />
    <boolean name="F4" value="true" />
    <boolean name="Pg+" value="true" />
    <boolean name="F6" value="true" />
    <string name="baseDirPref">$EXTERNAL_STORAGE/Download</string>
    <boolean name="F12" value="true" />
    <boolean name="hidescriptoptions" value="true" />
    <string name="browser_zoom2">10</string>
    <boolean name="up" value="true" />
    <boolean name="dontcatchfiles" value="false" />
    <boolean name="F5" value="true" />
    <string name="smversion">114</string>
    <boolean name="Brk" value="true" />
    <boolean name="F10" value="true" />
    <string name="con_fontsize">10</string>
    <boolean name="dontcatchhttpzip" value="false" />
    <boolean name="Del" value="true" />
    <boolean name="favorites" value="true" />
    <boolean name="con_vibrateonlandkeyboard" value="true" />
    <boolean name="Sys" value="true" />
    <string name="consoletextkeysize">56</string>
    <boolean name="smb_show_se_info" value="true" />
    <boolean name="hidelsinfo" value="true" />
    <boolean name="F9" value="true" />
    <boolean name="enableacra" value="false" />
    <boolean name="showpushpin" value="false" />
    <boolean name="Esc" value="true" />
    <boolean name="Tab" value="true" />
</map>
EOF
chmod 660 $file

if [ -e /sys/class/display/HDMI ]; then
	# Desativa o virtual controle na tela da xml
	sed -i -e 's;<string name="con_fontsize">.*</string>;<string name="con_fontsize">20</string>;g' $file
fi

# permissao do user da pasta
DUser=`stat -c "%u" "$APPFolder"`
chown -R $DUser:$DUser $APPFolder > /dev/null 2>&1
restorecon -F $file > /dev/null 2>&1
#ls -ld /data/data/os.tools.scriptmanager/*
#echo $DUser

# acesso root
for p in /system/xbin/su /system/bin/su /su/bin/su /sbin/su /magisk/.core/bin/su
do
	if [ -x $p ]; then
			export CheckRoot="0"
	fi
done

if [ "$CheckRoot" == "0" ] ; then
	su -c $APPFolder/sc/0_support/stop_smanager.sh
fi














exit

cat /data/data/os.tools.scriptmanager/shared_prefs/os.tools.scriptmanager_preferences.xml | grep con_fontsize

cat /data/data/os.tools.scriptmanager/shared_prefs/os.tools.scriptmanager_preferences.xml | grep consoletextkeysize
ls -la $APPFolder/shared_prefs/os.tools.scriptmanager_preferences.xml
# fonte do console para tvbox. criar code detectar o tamanho da coluna em devices mobile
    <string name="consoletextkeysize">56</string> # valores diferenciados cada device tem columas diferentes



