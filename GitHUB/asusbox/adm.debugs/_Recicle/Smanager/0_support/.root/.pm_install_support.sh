#!/system/bin/sh

export APPFolder=/data/data/os.tools.scriptmanager
export PATH=$APPFolder/bin:$APPFolder/bin/applets:$PATH
# path removivel
$APPFolder/sc/0_support/Wpath.sh
export Wpath=`cat "$APPFolder/Wpath.TXT"`
# webserver
export baseapps="$Wpath/.0/0_support"

echo ""
echo ""
echo ""
echo ""


if [ ! -e /data/data/com.siriusapplications.quickboot ] ; then
echo "Instalando Quick_Boot favor aguardar..."
pm install $baseapps/apk/Quick_Boot.apk
fi

if [ ! -e /data/data/org.cosinus.launchertv ] ; then
echo "Instalando Simple_TV_Launcher favor aguardar..."
pm install $baseapps/apk/Simple_TV_Launcher.apk
fi

if [ ! -e /data/.vpsInstall_DataCenter ]; then
if [ ! -e /data/data/berserker.android.apps.sshdroid ] ; then
echo "Instalando SShdroid favor aguardar..."
pm install $baseapps/apk/SSHDroid.apk
fi
fi

if [ ! -e /data/.vpsInstall_DataCenter ]; then
if [ ! -e /data/data/net.openvpn.openvpn ] ; then
echo "Instalando OpenVPN favor aguardar..."
pm install $baseapps/apk/OpenVPN.apk
pm grant net.openvpn.openvpn android.permission.READ_EXTERNAL_STORAGE > /dev/null 2>&1
pm grant net.openvpn.openvpn android.permission.WRITE_EXTERNAL_STORAGE > /dev/null 2>&1
fi
fi



echo "Apps instalados com sucesso."
