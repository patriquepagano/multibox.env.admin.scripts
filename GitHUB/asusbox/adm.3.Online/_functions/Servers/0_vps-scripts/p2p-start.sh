#!/bin/bash
#

function StartDaemonTransmission () {
seedBox="/SeedBOX"
fileConf="/var/lib/transmission-daemon/info/settings.json"
fileConf="/var/lib/transmission-daemon/.config/transmission-daemon/settings.json"

if [ ! -f $fileConf ]; then
    echo "ADM DEBUG ### Inicia a primeira vez para criar os arquivos"
    sudo service transmission-daemon start
    sleep 3
fi
echo "ADM DEBUG ### Fechando o serviço torrent"
transmission-remote --exit > /dev/null 2>&1
killall transmission-daemon > /dev/null 2>&1

sudo sed -i -e 's;"download-dir":.*;"download-dir": "/SeedBOX",;g' $fileConf
sudo sed -i -e 's;"peer-port":.*;"peer-port": 51345,;g' $fileConf
sudo sed -i -e 's;"rpc-whitelist":.*;"rpc-whitelist": "127.0.0.1",;g' $fileConf
sudo sed -i -e 's;"rpc-port":.*;"rpc-port": 9091,;g' $fileConf
sudo sed -i -e 's;"umask":.*;"umask": 63,;g' $fileConf
# sudo sed -i -e 's;"rpc-username":.*;"rpc-username": "guga",;g' $fileConf
# sudo sed -i -e 's;"rpc-password":.*;"rpc-password": "chatoUsarSenha",;g' $fileConf
sudo sed -i -e 's;"rpc-authentication-required":.*;"rpc-authentication-required": false,;g' $fileConf
sudo sed -i -e 's;"peer-limit-per-torrent":.*;"peer-limit-per-torrent": 70,;g' $fileConf

# clear
# cat $fileConf
echo "ADM DEBUG ### Iniciando daemon torrent"
sudo service transmission-daemon start
sleep 3
}


function p2pID () {
torID=`sudo transmission-remote -l \
| grep "$torFile" \
| awk '{print $1}' \
| sed -e 's/[^0-9]*//g'`
echo "ADM DEBUG ### $torID"
}


function p2pList () {
    sudo transmission-remote -l
}


# function Download_torrent_File () {
# # erro 301 esta baixando o link
# # 1 - nosso linode oficial
# # 2 - site do asusbox
# # 3 - linode do elton
# # http://45.79.133.216/asusboxA1/.install.torrent
# # http://asusbox.com.br/asusboxA1/.install.torrent
# # http://45.79.48.215/asusboxA1/.install.torrent
# multilinks="
# http://45.79.133.216/asusboxA1/.install.torrent
# https://asusbox.com.br/asusboxA1/.install.torrent
# http://45.79.48.215/asusboxA1/.install.torrent
# "
#     ### DOWNLOAD COM SISTEMA MULTI-LINKS
#     for LinkUpdate in $multilinks; do 
#         echo "ADM DEBUG ########################################################"
#         echo "ADM DEBUG ### Entrando na função > Download_torrent_File"
#         echo "ADM DEBUG ### tentando o link > $LinkUpdate"
#         TorrentFileInstall="false" # ate que se prove o contrario não baixou o arquivo
#         # Tenta conectar ao link 7 vezes 
#         wget -N --no-check-certificate --timeout=1 --tries=7 -P /SeedBOX/ $LinkUpdate > "/SeedBOX/wget.log" 2>&1
#         CheckWgetCode=`cat "/SeedBOX/wget.log" | grep "HTTP request sent, awaiting response..."`
#         #rm "/SeedBOX/wget.log"
#             # Se tiver acesso finaliza esta função
#             if [ "$CheckWgetCode" == "HTTP request sent, awaiting response... 200 OK" ] ; then
#                 echo "ADM DEBUG ### Wget :) $CheckWgetCode"
#                 TorrentFileInstall="true"
#                 break # fecha a função por completo
#             fi
#             if [ "$CheckWgetCode" == "HTTP request sent, awaiting response... 304 Not Modified" ] ; then
#                 echo "ADM DEBUG ### Wget :) $CheckWgetCode"
#                 TorrentFileInstall="true"
#                 break # fecha a função por completo
#             fi            
#     done ### DOWNLOAD COM SISTEMA MULTI-LINKS
#     echo "ADM DEBUG ### fim da função TorrentFileInstall > TorrentFileInstall=$TorrentFileInstall"
# }


# function LoopForceDownloadtorrent_File () { # entra em looping até baixar o arquivo de boot
# while true; do
#     echo "ADM DEBUG ########################################################"
#     echo "ADM DEBUG ### Entrando na função > LoopForceDownloadtorrent_File"
#     Download_torrent_File 
# 	if [ "$TorrentFileInstall" == "false" ]; then
#         echo "ADM DEBUG ### Nova tentativa em loop para baixar"
#         logcat -c
#     else
#         break
#     fi
# done
# }


function SeedBOXTransmission () {
echo "seedbox $torFile.torrent"
##############################################################################################################
######### Seed BOX Torrents ##################################################################################
##############################################################################################################

echo "ADM DEBUG ### $torFile"
p2pID

# se não existir ID não existe o torrent na fila de downloads para ser removido
if [ ! "$torID" == "" ]; then
    echo "ADM DEBUG ##############################################################################"
    echo "ADM DEBUG ### removendo o torrent > $torID "
	sudo transmission-remote -t $torID -r
    echo "ADM DEBUG ##############################################################################"
fi

echo "ADM DEBUG ### conceito para adicionar torrents seguindo as politicas do daemon"
sudo transmission-remote \
-a /SeedBOX/$torFile.torrent \
-m \
-x \
-o \
-y \
-w /SeedBOX/
echo "ADM DEBUG ########## Adicionado o $torFile ################################################"

p2pID

#echo "ADM DEBUG ### -v verifica o torrent | -s inicia o torrent caso esteja pausado | torrent-done-script"
#--torrent-done-script /data/transmission/tasks.sh
echo "ADM DEBUG ### -v verifica o torrent"
sudo transmission-remote -t $torID -v
echo "ADM DEBUG ### -s inicia o torrent caso esteja pausado"
sudo transmission-remote -t $torID -s
echo "ADM DEBUG ##############################################################################"

}




function stopSEED () {
    echo "seedbox $torFile.torrent"
    echo "ADM DEBUG ### $torFile"
    p2pID
    # se não existir ID não existe o torrent na fila de downloads para ser removido
    if [ ! "$torID" == "" ]; then
        echo "ADM DEBUG ##############################################################################"
        echo "ADM DEBUG ### removendo o torrent > $torID "
        sudo transmission-remote -t $torID -r
        echo "ADM DEBUG ##############################################################################"
    fi
}



# Find and change the "umask" value. Note that the json format uses decimal notation, so take a look at the table and find a value for the new umask (ex: 22)

# Umask   Created Files       Created Directories
# -------------------------------------------------------------
# 000     666 (rw-rw-rw-)     777     (rwxrwxrwx)
# 002     664 (rw-rw-r--)     775     (rwxrwxr-x)
# 022     644 (rw-r--r--)     755     (rwxr-xr-x)
# 027     640 (rw-r-----)     750     (rwxr-x---)
# 077     600 (rw-------)     700     (rwx------)
# 277     400 (r--------)     500     (r-x------)
# then in a terminal:

# #echo $((8#022)) 
# 18
# Finally change the umask value to 18

sudo chmod -R 777 /SeedBOX/.install

#LoopForceDownloadtorrent_File

# Variaveis Binarios
torFile=".install"


StartDaemonTransmission
SeedBOXTransmission
p2pList

sudo netstat -ntlup



# tarefas do crontab   https://crontab.guru/every-5-minutes
crontab -u $(whoami) -l # lista crontabs do user
cd /SeedBOX
crontab -l > mycron
# echo new cron into cron file
echo "*/120 * * * * /SeedBOX/p2p-kill.sh" > mycron # roda a cada 120 minuto
crontab mycron # install new cron file
crontab -u $(whoami) -l # lista crontabs do user


