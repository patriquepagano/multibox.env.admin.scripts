source "/data/asusbox/adm.1.export/_functions/debug/transmission-seedBOX.sh"


function generateTorrent () {

source "/data/asusbox/adm.2.install/_functions/generate.sh"
source "/data/asusbox/adm.2.install/_functions/allFunctions.sh"

trackerList="/data/asusbox/adm.1.export/_functions/debug/transmission.trackers"
taskRun="/data/asusbox/adm.1.export/_functions/debug/transmission-create.sh"


killTransmission

path=$(dirname $0)
torFile=`basename $path`
torDir="/data/asusbox/.install/$torFile"
rm $torDir/*.txt

# escreve o arquivo para rodar o comando
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
du -h "/$path/$torFile.torrent"

echo "#################### envia arquivo para o vps do anibal #######################"
vpsIP="45.79.48.215"
vpsOut="/www/asusbox/"
user="root"
pass="4a7s5d4f5asd4f7as4d6fads0f87fds097sda65f56as4f876sadf6987sad67as"
ssh="/data/data/com.termux/files/usr/bin/ssh"
rsync="/data/data/com.termux/files/usr/bin/rsync"
path=$(dirname $0)
file="$path/$torFile.torrent"

echo "Enviando arquivo para o vps $vpsIP"
echo ""
echo $pass
echo ""
/system/bin/sshpass -p $pass $rsync --chmod=777 --progress -avz -e $ssh $file root@$vpsIP:$vpsOut

AtivaSeedBOX

exit


# echo "#################### envia arquivo para o vps do anibal #######################"
# path=$(dirname $0)
# file="$path/$torFile.torrent"
# Origem="/data/asusbox/.install/$torFile"
# Destino="/SeedBOX/.install/$torFile"

# echo "Enviando arquivo para o vps /SeedBOX/.install/$torFile"
# /system/bin/sshpass -p $pass \
# $rsync \
# --progress \
# -avz \
# --delete --recursive \
# -e $ssh $Origem/ root@$vpsIP:$Destino/


# echo "Enviando arquivo para o vps $path/$torFile.torrent"
# /system/bin/sshpass -p $pass \
# $rsync \
# --progress \
# -avz \
# --delete --recursive \
# -e $ssh "$path/$torFile.torrent" root@$vpsIP:/SeedBOX/.install/






# echo "#################### envia arquivo para o digital ocean #######################"
# vpsIP="67.205.146.236"
# key="/data/asusbox/adm.debugs/_keys/digitalOcean/id_rsa"
# chmod 400 $key

# user="root"
# ssh="/data/data/com.termux/files/usr/bin/ssh"
# rsync="/data/data/com.termux/files/usr/bin/rsync"

# Origem="/data/asusbox/.install/$torFile"
# Destino="/SeedBOX/.install/$torFile"

# echo "Enviando arquivo para o vps /SeedBOX/.install/$torFile"
# $rsync \
# --progress \
# -avz \
# --delete --recursive \
# -e "$ssh -i $key" $Origem/ root@$vpsIP:$Destino/


# echo "Enviando arquivo para o vps $path/$torFile.torrent"
# $rsync \
# --progress \
# -avz \
# --delete --recursive \
# -e "$ssh -i $key" "$path/$torFile.torrent" root@$vpsIP:/SeedBOX/.install/



echo "#################### envia arquivo para o asusbox.com.br #######################"
vpsIP="52.67.220.245"


# # não funcionou
# key="/data/asusbox/adm.debugs/_keys/asusbox.com.br/asusbox-28-04-2020.pem"
# /data/data/com.termux/files/usr/bin/openssl rsa -in $key -out $key.id_rsa
# key="/data/asusbox/adm.debugs/_keys/asusbox.com.br/asusbox-28-04-2020.pem.id_rsa"

key="/data/asusbox/adm.debugs/_keys/digitalOcean/id_rsa"
key="/data/asusbox/adm.debugs/_keys/asusbox.com.br/asusbox-28-04-2020.pem"
chmod 400 $key


# $ssh -i $key root@$vpsIP

# sudo chown ubuntu:ubuntu -R /SeedBOX
sudo chmod 777 -R /SeedBOX
# exit

user="ubuntu"
ssh="/data/data/com.termux/files/usr/bin/ssh"
rsync="/data/data/com.termux/files/usr/bin/rsync"

Origem="/data/asusbox/.install/$torFile"
Destino="/SeedBOX/.install/$torFile"

echo "Enviando arquivo para o vps /SeedBOX/.install/$torFile"
$rsync \
--progress \
-avz \
--delete --recursive \
-e "$ssh -i $key" $Origem/ ubuntu@$vpsIP:$Destino/


echo "Enviando arquivo para o vps $path/$torFile.torrent"
$rsync \
--progress \
-avz \
--delete --recursive \
-e "$ssh -i $key" "$path/$torFile.torrent" ubuntu@$vpsIP:/SeedBOX/.install/


cp /data/asusbox/adm.1.export/$torFile/$torFile.torrent /data/asusbox/.install/





# #################################################################################################################
# echo "####################  ativa o seedBOX #########################################"

# mkdir -p /data/transmission

# # para não confundir o sistema aqui é para upload imediato!
# rm /data/transmission/tasks.sh

# # 
# InstallTransmission # verificar se o sistema novo de bins contempla toda esta função
# killTransmission # como é o boot depois eu removo esta etapa
# StartDaemonTransmission

# # chama o navegador para frente da box mostrando o p2p
# # verificar usando o comando uptime se a box estiver ligada mais que 3 minutos não chama o navegador para frente
# # com isto consigo rodar este script via cron

# am force-stop com.xyz.fullscreenbrowser
# am start --user 0 \
# -n com.xyz.fullscreenbrowser/.BrowserActivity \
# -a android.intent.action.VIEW -d "http://127.0.0.1:9091" > /dev/null 2>&1 # abre a pagina inicial para atualizar a imagem qrcode

# # Variaveis
# /system/bin/busybox rm /data/transmission/$torFile
# SeedBOXTransmission

}

