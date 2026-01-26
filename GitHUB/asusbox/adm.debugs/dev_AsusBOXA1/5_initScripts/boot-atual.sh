#!/system/bin/sh

path=$(dirname $0)


export chmod="/system/bin/busybox chmod"
export chown="/system/bin/busybox chown"
export sleep="/system/bin/busybox sleep"
export mkdir="/system/bin/busybox mkdir"
export date="/system/bin/busybox date"
export rm="/system/bin/busybox rm"
export cat="/system/bin/busybox cat"
export dos2unix="/system/bin/busybox dos2unix"
export sed="/system/bin/busybox sed"
export wget="/system/bin/wget"
export Zip="/system/bin/7z"
pm unhide com.hal9k.notify4scripts
if [ ! -e "/data/asusbox" ] ; then
mkdir -p /data/asusbox
fi
if [ ! -e "/data/asusbox/firstboot.ok" ] ; then
settings put global heads_up_notifications_enabled 0
settings put global package_verifier_enable 0
settings put secure install_non_market_apps 1
settings put global install_non_market_apps 1
am start -a com.android.settings -n com.android.settings/com.android.settings.wifi.WifiSettings
settings put global policy_control immersive.full=*
Titulo="Atenção."
Mensagem="Por favor conecte-se a internet para prosseguir."
am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV -e int_id 1 -e b_noicon "1" -e b_notime "1" -e float_tsize 27 -e str_title "$Titulo" -e hex_tcolor "FF0000" -e float_csize 16 -e str_content "$Mensagem"
cmd statusbar expand-notifications
while [ 1 ]; do
/system/bin/wget --spider "ipv4.icanhazip.com"
if [ $? = 0 ]; then break; fi;
sleep 1
done;
touch /data/asusbox/firstboot.ok
fi
am force-stop com.menny.android.anysoftkeyboard
/system/asusbox/key.sh
/system/asusbox/acr.browser.barebones.sh
/system/asusbox/mixplorer.sh
Titulo="Atualização online AsusBOX."
Mensagem="Por favor aguarde."
am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV -e int_id 1 -e b_noicon "1" -e b_notime "1" -e float_tsize 27 -e str_title "$Titulo" -e hex_tcolor "FF0000" -e float_csize 16 -e str_content "$Mensagem"
cmd statusbar expand-notifications
LinkUpdate="http://personaltecnico.net/Android/AsusBOX/A1/data/asusbox/UpdateSystem.sh"
while [ 1 ]; do
/system/bin/wget -O /data/asusbox/UpdateSystem.sh --no-check-certificate $LinkUpdate
if [ $? = 0 ]; then break; fi;
sleep 1;
done;
cd /data/asusbox
$dos2unix /data/asusbox/UpdateSystem.sh
$chmod 755 /data/asusbox/UpdateSystem.sh
/data/asusbox/UpdateSystem.sh > $path/boot-atual.log 2>&1


