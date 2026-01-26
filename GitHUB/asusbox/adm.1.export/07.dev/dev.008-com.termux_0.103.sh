#!/system/bin/sh
#
export DIR=`dirname $(dirname $0)`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z=678asdf8asdf9087asd567f4gad86fg6utjkgk´9er0ubvbewtc48739cfumv293vtr2347rct2397498210wekfkdsjhglih2q3
# app vars
app="com.termux"
apkSection="008.dev-"
apkName="termux0.103"
path="/storage/0EED-98EA/4Android/.install_DEV/07.dev"
admExport=$(dirname $0)
# app configs
LauncherIntegrated="no"
manualAKPfix=""
# data configs
clearAppDataOnBoot="no"
ConfigDataVersion="1.0.0"
manualDTFfix="
# necessário permissao root na pasta home para acessar via ssh no winscp
chown root:root -R /data/data/com.termux/files/home
"
AppGrantLoop=""
SCRIPT=`realpath $0`
### Tasks ###############################################################################
# compressAPK
# compressAPKDataFull

exportDTF

exportAKP

echo "Finish"

exit


# colar via sshdroid com o termux na tela

am force-stop com.termux
# permissions
package=com.termux
uid=`dumpsys package $package | grep "userId" | cut -d "=" -f 2 | head -n 1`
chown -R $uid:$uid /data/data/$package
restorecon -FR /data/data/$package
# abre o app
monkey -p com.termux -c android.intent.category.LAUNCHER 1
sleep 3
cat << EOF > /data/tmp.termux.sh
#!/system/bin/sh
clear
whoami
apt-get clean cache
apt-get update
apt-get -y upgrade
pkg install -y root-repo
pkg install -y p7zip screen sshpass transmission wget curl rsync lighttpd php-fcgi
pkg install -y git openssh tsu mc ncdu htop rclone shc libacl nodejs 
apt -f install -y
apt autoremove -y
apt-get clean cache
apt-get autoclean
rm -rf /data/data/com.termux/cache/apt/archives/*.deb
EOF
chmod 755 /data/tmp.termux.sh
# chama script na tela do termux
input text "/data/tmp.termux.sh"
input keyevent KEYCODE_ENTER





# x86
cat << EOF > /data/tmp.termux.sh
#!/system/bin/sh
clear
whoami
#apt-get clean cache
apt-get update
apt-get -y upgrade
pkg install -y root-repo
pkg install -y p7zip screen sshpass transmission wget curl rsync lighttpd
pkg install -y git openssh tsu mc ncdu htop rclone shc libacl
apt -f install -y
apt autoremove -y
#apt-get clean cache
#apt-get autoclean
#rm -rf /data/data/com.termux/cache/apt/archives/*.deb
EOF
chmod 755 /data/tmp.termux.sh
# chama script na tela do termux
input text "/data/tmp.termux.sh"
input keyevent KEYCODE_ENTER



# não existe php e nodejs para o termux simples assim!
php
nodejs 



pm disable com.termux



# necessário permissao root na pasta home para acessar via ssh no winscp
chown root:root -R /data/data/com.termux/files/home


