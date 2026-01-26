#!/system/bin/sh


# descompactar ssh
cd /
/system/bin/busybox tar -xvf /storage/0EED-98EA/4Android/.install_DEV/.ssh.tar.gz


# permissions
package=com.termux
uid=`dumpsys package $package | grep "userId" | cut -d "=" -f 2 | head -n 1`
chown -R $uid:$uid /data/data/$package
restorecon -FR /data/data/$package




am force-stop com.termux
# necessário permissao root na pasta home para acessar via ssh no winscp
chown root:root -R /data/data/com.termux/files/home



# Rodar o server SSH
pidClose=`netstat -ntlup | grep "sshd" | cut -d '/' -f 1 | head -1 | tail -c 5`
kill $pidClose
netstat -ntlup
chown root:root -R /data/data/com.termux/files/home

config="/data/data/com.termux/files/usr/etc/ssh/sshd_config"
key="/data/data/com.termux/files/usr/etc/ssh/ssh_host_rsa_key"
su -c /data/data/com.termux/files/usr/bin/sshd -p 4399 -f $config -h $key #-E /storage/emulated/0/Download/sshport
netstat -ntlup #>> /storage/emulated/0/Download/sshport

