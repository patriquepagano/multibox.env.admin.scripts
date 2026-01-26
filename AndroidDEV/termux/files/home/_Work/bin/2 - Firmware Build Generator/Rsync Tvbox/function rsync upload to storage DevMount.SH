
ssh="/data/data/com.termux/files/usr/bin/ssh"
sshpass="/data/data/com.termux/files/usr/bin/sshpass"
rsync="/data/data/com.termux/files/usr/bin/rsync"
user="root"
key="/storage/DevMount/AndroidDEV/termux/files/home/_Work/_keys/opensshAsusBox/ssh_host_rsa_key"


# limpando arquivo temporario
/system/bin/busybox find "/storage/DevMount/AndroidDEV/termux/files/usr/tmp/" -maxdepth 1 \
-type f -name "tr_session_id_*" \
| sort | while read fname; do
echo "del > $fname"
rm "$fname"
done

# copia os apks para minha vm linux
$rsync --progress \
-avz \
--delete \
--recursive \
--exclude 'lost+found' \
--exclude '4Android' \
--exclude 'Android' \
--exclude 'TWRP' \
--exclude 'LanHost' \
--exclude '*.pid' \
-e "$ssh -i "$key" -p 4399 -o 'StrictHostKeyChecking no' -oKexAlgorithms=+diffie-hellman-group1-sha1" \
"/storage/DevMount/" \
$user@$IP:"/storage/DevMount/"

# precisa escapar os spaços com   \


