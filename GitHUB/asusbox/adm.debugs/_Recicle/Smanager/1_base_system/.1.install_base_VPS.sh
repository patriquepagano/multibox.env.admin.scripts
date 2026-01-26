#!/system/bin/sh

export APPFolder=/data/data/os.tools.scriptmanager
export TheAPP=os.tools.scriptmanager
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
export baseapps="$Wpath/.0/1_base_system"
export CPU=`getprop ro.product.cpu.abi`
# sqlite
export sqlite="$APPFolder/bin/sqlite3"

if [ ! -e "$baseapps" ] ; then
mkdir -p $baseapps/apk
fi

am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV -e b_noicon "1" -e b_notime "1" -e int_id 3 -e str_title "Download apps" -e hex_tcolor "FF0000" -e float_tsize 27 -e float_csize 16 -e str_content "MiXplorer e navegador web"
cmd statusbar collapse
cmd statusbar expand-notifications

DownloadFiles="
https://www.dropbox.com/s/j5024pktdk6u8bd/Lightning.apk
https://www.dropbox.com/s/o28z2pz0gt29qlt/MiXplorer.apk
https://www.dropbox.com/s/2ahszp5hl88oqoc/MiX_Ptbr.apk
"
cd $baseapps/apk
for link in $DownloadFiles; do
while [ 1 ]; do
    /system/bin/wget --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue $link
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
done

am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV -e b_noicon "1" -e b_notime "1" -e int_id 3 -e str_title "Instalando apps" -e hex_tcolor "FF0000" -e float_tsize 27 -e float_csize 16 -e str_content "MxPlayer e PerfectPlayer"
cmd statusbar collapse
cmd statusbar expand-notifications

echo "Instalando MiXplorer favor aguardar..."
while [ 1 ]; do
    pm install -r $baseapps/apk/MiXplorer.apk
	pm install -r $baseapps/apk/MiX_Ptbr.apk
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
pm grant com.mixplorer android.permission.READ_EXTERNAL_STORAGE > /dev/null 2>&1
pm grant com.mixplorer android.permission.WRITE_EXTERNAL_STORAGE > /dev/null 2>&1

#------------------------------------------------------------------------------------------------------------

echo "Navegador tela cheia favor aguardar..."
while [ 1 ]; do
    pm install -r $baseapps/apk/Lightning.apk
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
