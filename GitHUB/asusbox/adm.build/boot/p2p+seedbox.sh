#!/system/bin/sh

torFile=".install"

function p2pgetID () {
echo "ADM DEBUG ### arquivo torrent $torFile.torrent"
torID=`/system/bin/transmission-remote --list \
| /system/bin/busybox grep "$torFile" \
| /system/bin/busybox awk '{print $1}' \
| /system/bin/busybox sed -e 's/[^0-9]*//g'`
echo "ADM DEBUG ### ID do arquivo = $torID"
}

# p2pgetID
# exit

echo "seedbox $torFile.torrent"
##############################################################################################################
######### Seed BOX Torrents ##################################################################################
##############################################################################################################

p2pgetID
# sleep 2

# se não existir ID não existe o torrent na fila de downloads para ser removido
if [ ! "$torID" == "" ]; then
    echo "ADM DEBUG ##############################################################################"
    echo "ADM DEBUG ### remove o torrent obrigatório por conta do bug de salvar na pasta downloads"
    /system/bin/transmission-remote -t $torID -r
    echo "ADM DEBUG ##############################################################################"
fi

echo "ADM DEBUG ### conceito para adicionar torrents seguindo as politicas do daemon"
/system/bin/transmission-remote \
-a /data/asusbox/$torFile.torrent \
-m \
-x \
-o \
-y \
-w /data/asusbox/ \
-S \
-SR
# vai verificar todos os arquivos baixados mesmo não setando o -v
# -S stopa o torrent para não baixar nada ainda
# -SR infinite Seed

# limpeza dos arquivos antigos que não pertencem ao .torrent atual funciona perfeito!
echo "ADM DEBUG ##############################################################################"
echo "ADM DEBUG ### printa o conteudo do arquivo torrent, arquivo precisa ser adicionado para listar conteudo"
p2pgetID
/system/bin/transmission-remote -t $torID -f | /system/bin/busybox awk '{print $7}' | /system/bin/busybox sed 's;.install/;./;g' > /data/local/tmp/TorrentList
# remove novas linhas em branco
/system/bin/busybox sed -i -e '/^\s*$/d' /data/local/tmp/TorrentList

echo "ADM DEBUG ##############################################################################"
echo "ADM DEBUG ### aqui compara se o conteudo do torrent bate com a pasta atual para apagar arquivos obsoletos"
/system/bin/busybox find "/data/asusbox/.install/" -type f -name "*" \
| /system/bin/busybox grep -v -f /data/local/tmp/TorrentList \
| while read fname; do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Limpando a pasta .install"
    #Fileloop=`basename $fname`
    #echo "eu vou apagar este arquivo > $fname"
    rm -rf "$fname"
done
rm /data/local/tmp/TorrentList

echo "ADM DEBUG ### -v verifica o torrent | -s inicia o torrent caso esteja pausado | torrent-done-script"
/system/bin/transmission-remote -t $torID -v -s -SR --torrent-done-script /data/transmission/tasks.sh
echo "ADM DEBUG ##############################################################################"



