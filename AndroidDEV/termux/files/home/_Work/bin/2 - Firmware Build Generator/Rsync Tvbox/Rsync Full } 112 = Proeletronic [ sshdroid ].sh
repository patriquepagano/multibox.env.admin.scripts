#!/system/bin/sh
clear

# limpando arquivo temporario
/system/bin/busybox find "/storage/DevMount/AndroidDEV/termux/files/usr/tmp/" -maxdepth 1 \
-type f -name "tr_session_id_*" \
| sort | while read fname; do
echo "del > $fname"
rm "$fname"
done

ssh="/data/data/com.termux/files/usr/bin/ssh"
sshpass="/data/data/com.termux/files/usr/bin/sshpass"
rsync="/data/data/com.termux/files/usr/bin/rsync"
IP="10.0.0.112"
user="root"
pass="admin"


# copia os apks para minha vm linux
$sshpass -p $pass \
$rsync --progress \
-avz \
--delete \
--recursive \
--exclude 'lost+found' \
--exclude 'Android' \
--exclude 'TWRP' \
-e "$ssh -o 'StrictHostKeyChecking no' -oKexAlgorithms=+diffie-hellman-group1-sha1" \
"/storage/DevMount/" \
$user@$IP:"/storage/DevMount/"

# precisa escapar os spaços com   \


