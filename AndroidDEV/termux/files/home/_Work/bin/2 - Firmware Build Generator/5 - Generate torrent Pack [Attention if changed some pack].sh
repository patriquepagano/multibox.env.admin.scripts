#!/system/bin/sh
clear

echo "Before generate new torrent pack
enter in http://10.0.0.101:9091 
click verify local data
press ok to continue"
read bah
if [ "$bah" == "ok" ]; then
    "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/[ STOP ] Services/1 STOP ALL HERE !!!.sh" "skip"
    /storage/DevMount/GitHUB/asusbox/adm.3.Online/0-generate-torrent.sh
fi

echo "Torrent Pack gerado com sucesso!"
read bah
