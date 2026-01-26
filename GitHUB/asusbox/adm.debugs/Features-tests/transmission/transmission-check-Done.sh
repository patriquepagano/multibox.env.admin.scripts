
torFile=00.snib









TorDone=`/system/bin/transmission-remote --list | grep "$torFile" | cut -d " " -f 9`

if [ "$TorDone" == "100%" ]; then
echo "torrent concluido e atualizado"
fi


exit

# Extrair o ID do torrent
torID=`/system/bin/transmission-remote --list | grep "$torFile" | cut -d " " -f 6`