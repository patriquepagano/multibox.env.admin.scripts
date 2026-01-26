#!/system/bin/sh

source /data/asusbox/adm.1.export/_functions/transmission.sh
trackerList="/data/asusbox/adm.1.export/_functions/transmission.trackers"


killTransmission

path=$(dirname $0)
taskRun="/data/asusbox/adm.1.export/_functions/transmission-create.sh"

torFile="07.dev"
torDir="/data/asusbox/.install/$torFile"
rm $torDir/*.txt

cat <<EOF > "$taskRun"
#!/system/bin/sh
/system/bin/transmission-create \\
-o /$path/$torFile.torrent \\
EOF

cat "$trackerList" >> "$taskRun"

cat <<EOF >> "$taskRun"

-s 512 \\
$torDir
EOF

chmod 755 "$taskRun"
"$taskRun"

# envia arquivo para o vps do anibal
vpsIP="45.79.48.215"
vpsOut="/www/asusbox/"
user="root"
pass="4a7s5d4f5asd4f7as4d6fads0f87fds097sda65f56as4f876sadf6987sad67as"
ssh="/data/data/com.termux/files/usr/bin/ssh"
path=$(dirname $0)
file="$path/$torFile.torrent"

echo "Enviando arquivo para o vps $vpsIP"
echo ""
echo $pass
echo ""
rsync --chmod=777 --progress -avz -e $ssh $file root@$vpsIP:$vpsOut
