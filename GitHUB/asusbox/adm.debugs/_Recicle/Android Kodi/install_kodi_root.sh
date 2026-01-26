#!/system/bin/sh

LD_LIBRARY_PATH=`echo $LD_LIBRARY_PATH | cut -c 2-`
export LD_LIBRARY_PATH
export TMPDIR=/data/data/os.tools.scriptmanager
export APPFolder=/data/data/os.tools.scriptmanager
export aria2c="$APPFolder/bin/aria2c"
export Szip="/data/data/os.tools.scriptmanager/files/p7zip/7z"
export logao="$EXTERNAL_STORAGE/Download/PersonalTecnico.net/debug.log"

echo "Iniciando download por favor aguarde"
echo "Iniciando download por favor aguarde" > $logao 2>&1

# root scripts # --------------------------------------------------------------------------------------------------------------------------------------
echo "download root scripts aguarde..."
DownloadFiles="
https://www.dropbox.com/s/gjgm38pq32c95je/_pm_install_kodi.sh?dl=1
"
for link in $DownloadFiles; do
$aria2c -x 10 --file-allocation=none --check-certificate=false --allow-overwrite=true $link --dir=/data/data/os.tools.scriptmanager/sc/  >> $logao 2>&1
done
chmod 755 $APPFolder/sc/*.sh >> $logao 2>&1
chown -R $DUser:$DUser $APPFolder/sc/ >> $logao 2>&1
restorecon -FR $APPFolder/sc >> $logao 2>&1
# end root scripts # -----------------------------------------------------------------------------------------------------------------------------------

link="https://www.dropbox.com/s/g9e9xxk3sci9oo9/install_kodi_code.sh?dl=1"
$aria2c -x 10 --check-certificate=false --allow-overwrite=true --file-allocation=none $link --dir=$APPFolder -o tmp.sh >> $logao 2>&1
chmod 755 $APPFolder/tmp.sh
$APPFolder/tmp.sh
rm $APPFolder/tmp.sh

echo "concluido pode fechar a tela."
