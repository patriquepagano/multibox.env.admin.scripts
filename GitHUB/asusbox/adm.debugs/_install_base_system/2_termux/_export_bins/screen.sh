#!/system/bin/sh
# pkg files screen
clear
Dir=$(dirname $0)
source $Dir/_function.sh

export pack="screen"
export cmd="/system/usr/bin/screen --version"
cat << EOF > "$Dir/$pack.FileList"
/data/data/com.termux/files/usr/bin
/data/data/com.termux/files/usr/bin/screen-4.8.0
/data/data/com.termux/files/usr/etc
/data/data/com.termux/files/usr/etc/screenrc
/data/data/com.termux/files/usr/share/screen
/data/data/com.termux/files/usr/share/screen/utf8encodings
/data/data/com.termux/files/usr/share/screen/utf8encodings/c4
/data/data/com.termux/files/usr/share/screen/utf8encodings/01
/data/data/com.termux/files/usr/share/screen/utf8encodings/02
/data/data/com.termux/files/usr/share/screen/utf8encodings/c3
/data/data/com.termux/files/usr/share/screen/utf8encodings/cc
/data/data/com.termux/files/usr/share/screen/utf8encodings/04
/data/data/com.termux/files/usr/share/screen/utf8encodings/cd
/data/data/com.termux/files/usr/share/screen/utf8encodings/a1
/data/data/com.termux/files/usr/share/screen/utf8encodings/c8
/data/data/com.termux/files/usr/share/screen/utf8encodings/03
/data/data/com.termux/files/usr/share/screen/utf8encodings/c2
/data/data/com.termux/files/usr/share/screen/utf8encodings/bf
/data/data/com.termux/files/usr/share/screen/utf8encodings/18
/data/data/com.termux/files/usr/share/screen/utf8encodings/c6
/data/data/com.termux/files/usr/share/screen/utf8encodings/c7
/data/data/com.termux/files/usr/share/screen/utf8encodings/19
/data/data/com.termux/files/usr/share/screen/utf8encodings/d6
/data/data/com.termux/files/usr/bin/screen
EOF

SyncGenerateList

DebugBINs

bkpBins

# clean
rm "$Dir/$pack.FileList" > /dev/null 2>&1

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
