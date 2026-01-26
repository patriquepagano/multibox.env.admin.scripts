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

#export IPSERVER="1.0.0.2"
export IPSERVER=""

# root scripts # --------------------------------------------------------------------------------------------------------------------------------------
echo "download root scripts aguarde..."
if ping -c 1 $IPSERVER &> /dev/null
	then
		DownloadFiles="
		http://$IPSERVER/.0/1_base_system/.root/.pm_install_base.sh
		"
	else
		DownloadFiles="
		https://www.dropbox.com/s/s2qatp9xcxulq89/.pm_install_base.sh?dl=1
		"
fi
for link in $DownloadFiles; do
$aria2c -x 10 --file-allocation=none --check-certificate=false --allow-overwrite=true $link --dir=$APPFolder/sc  > /dev/null 2>&1
done
chmod -R 755 $APPFolder/sc/. > /dev/null 2>&1
restorecon -FR $APPFolder/sc > /dev/null 2>&1
# end root scripts # -----------------------------------------------------------------------------------------------------------------------------------

echo "Iniciando download por favor aguarde"
if ping -c 1 $IPSERVER &> /dev/null
	then
		link="http://$IPSERVER/.0/1_base_system/.base.sh"
	else
		link="https://www.dropbox.com/s/rbr7g69tx3mfisg/.base.sh?dl=1"
fi
rm $APPFolder/tmp.sh > /dev/null 2>&1
$aria2c -x 10 --check-certificate=false --allow-overwrite=true --file-allocation=none $link --dir=$APPFolder -o tmp.sh > /dev/null 2>&1
chmod 755 $APPFolder/tmp.sh > /dev/null 2>&1
$APPFolder/tmp.sh
rm $APPFolder/tmp.sh > /dev/null 2>&1

echo "concluido pode fechar a tela."

