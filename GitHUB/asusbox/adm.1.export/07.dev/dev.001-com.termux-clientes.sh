#!/system/bin/sh
#
export DIR=`dirname $(dirname $0)`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z=678asdf8asdf9087asd567f4gad86fg6utjkgk´9er0ubvbewtc48739cfumv293vtr2347rct2397498210wekfkdsjhglih2q3
# app vars
app="com.termux"
apkSection="007.dev-"
apkName="dev.001"
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
# # symlinks
# /system/bin/busybox mount -o remount,rw /system
# ln -sf /data/data/com.termux/files/usr/bin/git /system/bin/git
# ln -sf /data/data/com.termux/files/usr/bin/ncdu /system/bin/ncdu
# ln -sf /data/data/com.termux/files/usr/bin/screen /system/bin/screen
# ln -sf /data/data/com.termux/files/usr/bin/rclone /system/bin/rclone
# # fix de um bug novo
# ln -sf /data/data/com.termux/files/usr/lib/libz.so.1.2.11 /system/lib/libz.so.1
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




cat << EOF > /data/tmp.termux.sh
#!/system/bin/sh
clear
apt-get update
apt-get -y upgrade
pkg install -y root-repo
pkg install -y p7zip mc screen ncdu file
pkg install -y sshpass transmission wget curl rsync
rm -rf /data/data/com.termux/cache/apt/archives/*.deb
EOF
chmod 755 /data/tmp.termux.sh
# chama script na tela do termux
input text "/data/tmp.termux.sh"
input keyevent KEYCODE_ENTER




pm disable com.termux



# necessário permissao root na pasta home para acessar via ssh no winscp
chown root:root -R /data/data/com.termux/files/home


