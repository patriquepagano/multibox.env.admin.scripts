#!/system/bin/sh

mkdir -p /data/data/com.termux
ln -sf /storage/DevMount/AndroidDEV/termux/files /data/data/com.termux/

cd /
/system/bin/busybox tar -mxvf /storage/0EED-98EA/4Android/.install_DEV/.ssh.tar.gz > /dev/null 2>&1

# permissions
package=com.termux
uid=`dumpsys package $package | grep "userId" | cut -d "=" -f 2 | head -n 1`
chown -R $uid:$uid /storage/DevMount/AndroidDEV/termux/files
restorecon -FR /storage/DevMount/AndroidDEV/termux/files

# necessário permissao root na pasta home para acessar via ssh no winscp
chown root:root -R /data/data/com.termux/files/home






