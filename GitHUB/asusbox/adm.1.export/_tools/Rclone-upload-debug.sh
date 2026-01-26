#!/data/data/com.termux/files/usr/bin/env /data/data/com.termux/files/usr/bin/bash
#
clear







exit

config=/data/asusbox/adm.1.export/_tools/rclone.conf





# conta dropbox teste checagem de md5sum, NÃO FUNCIONA HASH NÃO EXISTE
# Dropbox tem seu proprio sistema de checagem crc e com isto não vale a pena usar
conta="PersonaltecnicoGmail"
arquivo="/storage/emulated/0/Android/tech-01.log"
echo "Precisa upar o arquivo"
rclone --config=$config --progress copyto "$arquivo" $conta:/teste-debugado-garai

rclone --config=$config md5sum $conta:/teste-debugado-garai #| cut -d " " -f 1



exit


# entrega do link do rclone
linkRaw="https://drive.google.com/open?id=10Q3UqG7TGLCP2zoAoP5vO1vyduUYwZ-I"
linkRaw="https://www.dropbox.com/s/rimm6o77wemrhhn/teste-debugado-garai?dl=0"
# cut extrai o endereço do file hoster
mirrorID=`echo "$linkRaw" | cut -d "/" -f 3`
# if do google
if [ "$mirrorID" == "drive.google.com" ]; then
    tmplink=`echo "$linkRaw"`
    link="https://drive.google.com/uc?export=download&id=$tmplink"
    echo $link
fi

# if do dropbox
if [ "$mirrorID" == "www.dropbox.com" ]; then
    link=`echo "$linkRaw" | sed 's;dl=0;dl=1;g'`
    echo $link
fi

exit



rclone --config=$config link $conta:/teste-debugado-garai # | cut -d "=" -f 2

# https://www.dropbox.com/s/rimm6o77wemrhhn/teste-debugado-garai?dl=0

# https://drive.google.com/open?id=10Q3UqG7TGLCP2zoAoP5vO1vyduUYwZ-I





