#!/system/bin/sh
source /data/.vars


function FechaAria () {
    $kill -9 $($pgrep aria2c) > /dev/null 2>&1
}

# link das roms
tor="/data/asusbox/.tor.gamebox/GameBOX-TopGames-GAMEFLIX.torrent" # 13m57.60s real para baixar os jogos 480MB

link="https://www.dropbox.com/s/ardkkjemeorf3k2/GameBOX-TopGames-GAMEFLIX.torrent?dl=1"

tor="/data/asusbox/.tor.gamebox/GameBOX-TopGames.torrent" # 
link="https://www.dropbox.com/s/eostfy2wew6kbgl/GameBOX-TopGames.torrent?dl=1"
while [ 1 ]; do
    /system/bin/wget -O $tor --no-check-certificate $link
    if [ $? = 0 ]; then break; fi;
    sleep 1;
done;




#tor="/data/asusbox/.tor.gamebox/GameBOX-TopGames.torrent"

echo "Iniciando download" > $bootLog 2>&1


#$aria2c -h > /data/ariamanuel.sh



# aria não sobreescreve o arquivo em caso de mudança do conteudo
while [ 1 ]; do
    FechaAria
    $aria2c -V \
    --allow-overwrite=true \
    --show-console-readout=false \
    --summary-interval=10 \
    --console-log-level=error \
    --bt-enable-lpd=true \
    --enable-dht6=false \
    --seed-time=0 \
    --file-allocation=none \
    -d $www -T $tor | sed -e 's/FILE:.*//g' >> $bootLog 2>&1
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    $sleep 1;
done;

# apagar o rastro do log do aria
echo "Download Concluido!" > $bootLog 2>&1


exit

    --listen-port=9000 \



    https://github.com/aria2/aria2/issues/510
    I did some experiments.
If I have .aria2 file, then aria2c can resume from last download. Good.
If I don't have .aria2 file, then I have two options:
Without -V options, aria2c restarts from the very begining.
With -V, it can resume from last download. However, it displays an error message:
[ERROR] Checksum error detected. file=...
This is confusing since I don't know whether the resume is successful or not. If the resume is guaranteed to be correct, knowing how to disable the error message will be helpful.

-V verifica o pacote antes de baixar.. atualiza oque for necessario


