#!/system/bin/sh
clear

aapt="/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/bin's/aapt"

ssh="/data/data/com.termux/files/usr/bin/ssh"
sshpass="/data/data/com.termux/files/usr/bin/sshpass"
rsync="/data/data/com.termux/files/usr/bin/rsync"
IP="10.0.0.33"
port="22"
user="gambatte"
pass="admger9pqt"

keyscan="/data/data/com.termux/files/usr/bin/ssh-keyscan"
#$keyscan -p $port $IP >> $HOME/.ssh/known_hosts

# $sshpass -p $pass $ssh $user@$IP

# echo "bah v7"
# exit


tmpApp=/storage/DevMount/_apkInstalled.log
if [ -f $tmpApp ]; then
        rm $tmpApp
fi

# copia apk por apk comparando se tem novos, mas não exclui os antigos
/system/bin/busybox find "/data/app/" -type f -name "base.apk" \
| while read fname; do
echo "ADM DEBUG ########################################################"
echo "$fname"
app=`echo "$fname" | /system/bin/busybox cut -d "/" -f 4 | /system/bin/busybox cut -d "-" -f 1`
version=`dumpsys package $app | /system/bin/busybox grep versionName | /system/bin/busybox cut -d "=" -f 2 | /system/bin/busybox head -n 1 | /system/bin/busybox cut -d " " -f 1`
AppNameH=`$aapt dump badging "$fname" | grep "application-label:" | cut -d "'" -f 2 | cut -d "'" -f 1`

echo "$version"
# copia os apks para minha vm linux
$sshpass -p $pass \
$rsync --protect-args \
--progress \
-avz \
--delete \
--recursive \
-e $ssh -v \
$fname \
$user@$IP:"/cygdrive/e/Sync/+Work/+Firmwares+WiP/A7/AppsEmUso/{$AppNameH} [$app] ($version).apk"
# alimentando o log
echo "/cygdrive/e/Sync/+Work/+Firmwares+WiP/A7/AppsEmUso/{$AppNameH} [$app] ($version).apk" >> $tmpApp
done

# {Spotify} [com.spotify.music] (8.5.94.839)


cat <<'EOF' > "/storage/DevMount/_apkInstalled.sh"
#!/bin/bash
path=/cygdrive/e/Sync/+Work/+Firmwares+WiP/A7/AppsEmUso/
find "$path" -type f -name "*.apk" \
| grep -v -f $path/_apkInstalled.log \
| while read fname; do
    #echo "eu vou mover este arquivo > $fname"
    cd "$path"
    if [ ! -d old ]; then
    echo "criando a pasta old"
    mkdir old
    fi
    mv "$fname" "$path/old/"
done
echo "limpando os arquivos"
#rm $path/_apkInstalled.sh
EOF
chmod 755 "/storage/DevMount/_apkInstalled.sh"

$sshpass -p $pass \
$rsync --progress \
-az \
--delete \
--recursive \
-e $ssh \
/storage/DevMount/_apkInstalled* \
$user@$IP:"/cygdrive/e/Sync/+Work/+Firmwares+WiP/A7/AppsEmUso/"


# # roda o comando no server
$sshpass -p $pass \
$ssh $user@$IP "bash /cygdrive/e/Sync/+Work/+Firmwares+WiP/A7/AppsEmUso/_apkInstalled.sh"

rm /storage/DevMount/_apkInstalled*
exit











# ###############################################################################################
# # ideia usando synlinks não compensa
# tmpApp=/storage/DevMount/tmpApp
# if [ -d $tmpApp ]; then
#         rm -rf $tmpApp
#         mkdir -p $tmpApp
#     else
#         mkdir -p $tmpApp
# fi
# # no loop crio um link
# ln -s "$fname" "$tmpApp/{$AppNameH} [$app] ($version).apk"

# # o rsync copia a partir do destino do link

# # copia os apks excluindo os antigos da pasta destino
# # - toda vez que roda ele regrava todos os apps de novo pq é um synlink
# # não grava a data original de criação do arquivo
# $sshpass -p $pass \
# $rsync --progress \
# -z \
# -L \
# --delete \
# --recursive \
# -e $ssh \
# $tmpApp/ \
# $user@$IP:"/home/gambatte/_Work/Firmwares/AsusBox/A1/_Apps_em_USO/"



# rm -rf $tmpApp