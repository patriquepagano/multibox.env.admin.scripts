#!/system/bin/sh
clear

vps="/storage/DevMount/AndroidDEV/termux/files/home/_Work/hosts/Cloud (Linode) [45.79.48.215] {asusbox-elton}.vps"
source "$vps"
cat "$vps"

keyscan="/data/data/com.termux/files/usr/bin/ssh-keyscan"
sshpass="/data/data/com.termux/files/usr/bin/sshpass"
ssh="/data/data/com.termux/files/usr/bin/ssh"

$sshpass -p $pass $ssh -v $user@$IP

