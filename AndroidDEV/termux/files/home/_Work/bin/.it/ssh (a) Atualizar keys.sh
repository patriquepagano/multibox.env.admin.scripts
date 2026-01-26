#!/system/bin/sh
clear
path="$( cd "${0%/*}" && pwd -P )"
echo $path

ssh="/data/data/com.termux/files/usr/bin/ssh"
keyscan="/data/data/com.termux/files/usr/bin/ssh-keyscan"
sshpass="/data/data/com.termux/files/usr/bin/sshpass"
Rsync="/data/data/com.termux/files/usr/bin/rsync"
IP="10.0.0.91"
port="22"
user="gambatte"
pass="admger9pqt"

# clean file IP
file="$HOME/.ssh/known_hosts"
cat $file | grep -v "$IP" > $file-tmp
mv $file-tmp $file
# cat $file
# exit

$keyscan -p $port $IP >> $HOME/.ssh/known_hosts


if [ ! -d $HOME/_Work/_keys ]; then
mkdir -p $HOME/_Work/_keys
fi

# copia permissão, data e hora
$sshpass -p $pass \
$Rsync --progress \
-avz \
--delete \
--recursive \
-e $ssh \
$user@$IP:/home/gambatte/_Work/_keys/ \
$HOME/_Work/_keys/

# permissões para arquivos acesso ssh
/system/bin/busybox find "$HOME/_Work/_keys" -type d -exec chmod 755 {} \; 
/system/bin/busybox find "$HOME/_Work/_keys" -type f -exec chmod 600 {} \;	

