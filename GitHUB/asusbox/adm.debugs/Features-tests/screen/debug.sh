#!/system/bin/bash

clear

while true
do
    echo "ADM DEBUG ### Eu sou um loop infinito"
    sleep 5
done


exit



exit

HOME=/data/asusbox


# rodar um comando
screen -dmS loopinfinito bash -c '/data/asusbox/adm.debugs/screen/debug.sh'


# entra dentro de uma screen
screen -r loopinfinito

# fecha uma sessão em aberto
screen -X -S loopinfinito quit
screen -wipe
screen -ls


Control A + D = minimiza a screen sem fechar o processo
#= lista as screens rodando
screen -ls



# For dead sessions use: pode usar a vontade que ele não afeta screens em andamento
screen -wipe


/system/bin/busybox mount -o remount,rw /system
#rm /system/bin/screen

# cp /data/data/com.termux/files/usr/bin/screen-4.8.0 /system/bin/screen











exit


ln -sf /data/data/com.termux/files/usr/bin/rclone /system/bin/rclone
