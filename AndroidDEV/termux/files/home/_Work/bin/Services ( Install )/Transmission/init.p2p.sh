#!/system/bin/sh
export TZ=UTC−03:00
Log="/data/trueDT/peer/TMP/init.p2p.LOG"
toolx="/system/bin/busybox"

echo "ADM DEBUG ##############################################################################################################################" > "$Log"
echo "ADM DEBUG ### start script fora do loop while" >> "$Log"
echo "ADM DEBUG ### INFO, INFORMATION | WARN, WARNING | ERROR, FAIL, FAILURE" >> "$Log"
echo "ADM DEBUG ### $($toolx date +%s) => $($toolx date +"%d/%m/%Y %H:%M:%S") | cat uptime $($toolx cat /proc/uptime | $toolx cut -d " " -f 2 | $toolx cut -d "." -f 1)" >> "$Log"

export FolderPath="/storage/MultiBOX"
#export TRANSMISSION_WEB_HOME="/system/usr/share/transmission/web"
configDir="/data/transmission"
seedBox="/sdcard/Download"
fileConf="/data/transmission/settings.json"

if [ ! -d "/data/trueDT/peer/TMP" ]; then
	mkdir -p "/data/trueDT/peer/TMP"
fi
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin

checkUptime=`$toolx cat /proc/uptime | $toolx cut -d " " -f 2 | $toolx cut -d "." -f 1`
if [ "$checkUptime" -le "100" ]; then
	echo "ADM DEBUG ### sleep 120 uptime => $($toolx date +"%d/%m/%Y %H:%M:%S") | cat uptime $($toolx cat /proc/uptime | $toolx cut -d " " -f 2 | $toolx cut -d "." -f 1)" >> "$Log"
	sleep 120
fi

while [ 1 ]; do
	if [ -f "/system/bin/transmission-daemon" ];then break; fi;
	echo "ADM DEBUG ##############################################################################################################################" >> "$Log"
	echo "ADM DEBUG ### $($toolx date +%s) => $($toolx date +"%d/%m/%Y %H:%M:%S") | cat uptime $($toolx cat /proc/uptime | $toolx cut -d " " -f 2 | $toolx cut -d "." -f 1)" >> "$Log"
	echo "ADM DEBUG ### Wait install transmission-daemon components" >> "$Log"
	sleep 5;    
done;

# TASKS TO DO
# [] torrents baixados pelo user tem q cair na pasta download e quando concluir o donwload tem que apagar os gatilhos
    # watch-dir-enabled não serve. pq se caso torrent for removido ele não retorna até concluir
    # preciso criar meu proprio sistema de whatch dir
    # este serviço vai focar apenas no torrents principais para manter o sistema
    # gerenciamento de torrents do reseller vai ser via call /data/trueDT/scripts/p2pReseller.sh
    # gerenciamento de torrents do cliente download de filmes, series e jogos via call scripts tb

# [] oque fazer com este script ?   /data/transmission/tasks.sh



# for debug things
$toolx mount -o remount,rw /system


#################################################################################################################################
function .killP2P () {
	instance=`$toolx ps aux | $toolx grep "transmission" | $toolx grep -v grep | $toolx head -n 1 | $toolx awk '{print $1}'`
	if [ ! "$instance" == "" ]; then
		echo "ADM DEBUG ### [.killP2P] WARN fechando a instancia do binario {$instance}" >> "$Log"
        /system/bin/transmission-remote --exit
        $toolx kill -9 $instance
        killall transmission-daemon
	fi
}
.killP2P
#################################################################################################################################
function .killinitP2P () {
    while [ 1 ]; do
        instance=`$toolx ps aux | $toolx grep "init.p2p.sh" | $toolx grep -v grep | $toolx head -n 1 | $toolx awk '{print $1}'`
        if [ ! "$instance" == "" ]; then
            echo "ADM DEBUG ### fechando o init script $instance"
            $toolx kill -9 $instance
        else
            break
        fi
    done
}
#################################################################################################################################
function .init.p2p.CheckService () {
    # loop do bloqueio do serviço
    while [ -f /data/trueDT/peer/TMP/init.p2p.DISABLED ]; do
        echo "ADM DEBUG ############################################################################################" > "$Log"
        echo "ADM DEBUG ### [.init.p2p.CheckService] p2p desativado" >> "$Log"
        echo "ADM DEBUG ### $($toolx date +%s) => $($toolx date +"%d/%m/%Y %H:%M:%S") | cat uptime $($toolx cat /proc/uptime | $toolx cut -d " " -f 2 | $toolx cut -d "." -f 1)" >> "$Log"
        .killP2P
        sleep 61
    done
}
.init.p2p.CheckService

# pasta configDir onde fica resume torrents e paths de torrents antigos. 
# tem q ser apagado em caso de desconfigurar algo ou path de arquivos
# em caso de torrent novo vai sobrescrever corretamente!


rm -rf $configDir
mkdir -p $configDir

if [ ! -d $seedBox ] ; then
    mkdir -p $seedBox
fi
#################################################################################################################################
function .Check.ExternalDrive () {
echo "User Info = Verificando se existe drive externo conectado" >> "$Log"
# teste de velocidade e exclusão dos drivers lentos
DriveList=`$toolx blkid | $toolx grep 'vfat' | $toolx grep -v vold | $toolx cut -d '"' -f 2`
echo "$DriveList" | while read -r UUID ; do	
    if [ -d "/storage/$UUID/MULTIBOX" ]; then
        echo "User Info = Analizando Drive :$UUID" >> "$Log"
        FileLogDrive="/storage/$UUID/MULTIBOX/Teste de velocidade do drive [$UUID].txt"
        # debug
        #rm "$FileLogDrive" > /dev/null 2>&1
        if [ ! -f "$FileLogDrive" ]; then
            echo "ADM DEBUG ### testando velocidade de gravação = $UUID" >> "$Log"
            $toolx dd if=/dev/zero of="/storage/$UUID/MULTIBOX/Drive.Speed.Test.img" bs=200M count=1 > "/data/local/tmp/speed.log" 2>&1    
            # deleta arquivo img test
            rm "/storage/$UUID/MULTIBOX/Drive.Speed.Test.img"
            # write FileLogDrive
            echo "Speed test result:" > "$FileLogDrive"
            $toolx cat "/data/local/tmp/speed.log" | $toolx tail -n 1 >> "$FileLogDrive"
            echo "Drive Specs:" >> "$FileLogDrive"
            echo "$UUID" >> "$FileLogDrive"
            $toolx df -h | $toolx grep "/storage/$UUID" >> "$FileLogDrive"
            # remove TABS
            $toolx sed -i -e 's|^[[:blank:]]*||g' "$FileLogDrive"
            $toolx sed -i -e 's/[[:blank:]]*$//' "$FileLogDrive"
            $toolx cat "$FileLogDrive" >> "$Log"
            # clean old log
            rm "/data/local/tmp/speed.log"
        fi
        CheckSpeed=`$toolx cat "$FileLogDrive" | $toolx sed -n '2p' | $toolx awk '{print $7}' | $toolx cut -d "." -f 1`
        echo "ADM DEBUG ### Warn if Comparando dados if driver for lento" >> "$Log"
        if [ "$CheckSpeed" -lt "10" ];then
            echo "User Info = Drive Lento :$UUID" >> "$Log"
            cat "$FileLogDrive" >> "$Log"
            echo "###############################################################" >> "$Log"
            mv "/storage/$UUID/MULTIBOX" "/storage/$UUID/Driver Lento [$CheckSpeed MB]"
            if [ ! -f /storage/NAND.LOCKED ]; then
                echo "ADM DEBUG ### Driver externo Lento. [NAND.LOCKED]" >> "$Log"
                echo -n "NAND" > /storage/NAND.LOCKED
            fi
        else
            echo "User Info = Velocidade de escrita do drive [$UUID] = $CheckSpeed MB" >> "$Log"
            #export SetP2PFolder="/storage/$UUID/MULTIBOX/DataUpdates"
            # caso user remova o hdd
            if [ -d "/storage/$UUID/MULTIBOX" ]; then # isto quer dizer que o drive esta montado!
                # verificar se o symlink aponta para o uuid atual
                Clink=`$toolx readlink -v "/storage/MULTIBOX"` > /dev/null 2>&1
                if [ ! "$Clink" == "/storage/$UUID/MULTIBOX" ]; then
                    echo "ADM DEBUG ### Symlink atual = [$Clink]" >> "$Log"
                    echo "ADM DEBUG ### alterando symlink do drive [$UUID] /storage/$UUID/MULTIBOX /storage/MULTIBOX" >> "$Log"
                    $toolx rm /storage/MULTIBOX > /dev/null 2>&1
                    $toolx ln -s /storage/$UUID/MULTIBOX /storage/MULTIBOX
                    $toolx rm /storage/NAND.LOCKED > /dev/null 2>&1
                    # finaliza a seleção do drive ficando com a primeira escolha de drive rapido
                    .Enable.Folder.ExternalDrive.DataUpdates
                    break
                else
                    $toolx rm /storage/NAND.LOCKED > /dev/null 2>&1
                    echo "ADM DEBUG ### Driver symlink já esta montado [$Clink]" >> "$Log"
                    .Enable.Folder.ExternalDrive.DataUpdates
                    break
                fi
            fi
        fi
    else
        if [ ! -f /storage/NAND.LOCKED ]; then
            echo "ADM DEBUG ### Não existe drive externo com a pasta MULTIBOX [NAND.LOCKED]" >> "$Log"
            echo -n "NAND" > /storage/NAND.LOCKED
        fi
    fi
    echo "ADM DEBUG ### External Driver LOOP [$UUID]" >> "$Log"
done

if [ "$DriveList" == "" ]; then
    echo "ADM DEBUG ### Nenhum Driver conectado [NAND.LOCKED]" >> "$Log"
    if [ ! -f /storage/NAND.LOCKED ]; then
        echo -n "NAND" > /storage/NAND.LOCKED
    fi
fi

}

#################################################################################################################################
function .CLEAN.NAND.DataUpdates () {
# apaga a pasta de downloads local na nand
# seria uma confusão mover arquivos da nand para drive externo
if [ -d /storage/emulated/0/.DataUpdates ]; then
    # rsync apenas da minha pasta .install, os pacotes de usuarios apagaria
    $toolx rm -rf /storage/emulated/0/.DataUpdates > /dev/null 2>&1
fi
}
#################################################################################################################################
function .Enable.Folder.NAND.DataUpdates () {
    if [ -f /storage/NAND.LOCKED ]; then
        SetP2PFolder=`$toolx readlink -v "/storage/MULTIBOX"` > /dev/null 2>&1
        # Symlink da NAND >  /storage/MULTIBOX
        if [ ! "$SetP2PFolder" == "/storage/emulated/0/MULTIBOX" ]; then
            echo "ADM DEBUG ### Symlink atual = [$SetP2PFolder]" >> "$Log"
            echo "ADM DEBUG ### alterando symlink para o drive [NAND] /storage/emulated/0/MULTIBOX /storage/MULTIBOX" >> "$Log"
            $toolx rm /storage/MULTIBOX > /dev/null 2>&1
            $toolx ln -s /storage/emulated/0/MULTIBOX /storage/MULTIBOX            
        fi
        # marcador para reiniciar o transmission caso seja necessário
        echo "ADM DEBUG ### Warn function [.Enable.Folder.NAND.DataUpdates]" >> "$Log"
        source "/storage/P2PDir.Enabled.var"
        if [ ! "$SetP2PFolder" == "$P2PDirFolder" ]; then
            .killP2P
            echo "User Info = [Ativando memória interna NAND para armazenamento arquivos] $(date +"%d/%m/%Y %H:%M:%S")" >> "$Log"
            echo -n "P2PDirFolder=\"$SetP2PFolder\"" > "/storage/P2PDir.Enabled.var"
        else
            echo "User Info = [Drive ativo NAND para armazenamento arquivos] $(date +"%d/%m/%Y %H:%M:%S")" >> "$Log"
            echo "User Info = [Drive espaço Real NAND] $($toolx df -h | $toolx grep "/storage/emulated" | $toolx sed "s;/dev/fuse                 ;;g")" >> "$Log"
        fi
    fi
}
#################################################################################################################################
function .Enable.Folder.ExternalDrive.DataUpdates () {
    SetP2PFolder=`$toolx readlink -v "/storage/MULTIBOX"` > /dev/null 2>&1
    echo "ADM DEBUG ### Warn function [.Enable.Folder.ExternalDrive.DataUpdates]" >> "$Log"
    source "/storage/P2PDir.Enabled.var"
    if [ ! "$SetP2PFolder" == "$P2PDirFolder" ]; then
        .killP2P
        #.CLEAN.NAND.DataUpdates
        echo "User Info = [Ativando memória Externa para armazenamento arquivos] $(date +"%d/%m/%Y %H:%M:%S")" >> "$Log"
        #rm "/storage/NAND.LOCKED" > /dev/null 2>&1
        echo -n "P2PDirFolder=\"$SetP2PFolder\"" > "/storage/P2PDir.Enabled.var"
    else
        echo "User Info = [Drive Externo em uso] $($toolx df -h | $toolx grep "MultiBOX" | $toolx head -n 1)" >> "$Log"
        #rm "/storage/NAND.LOCKED" > /dev/null 2>&1
        #.CLEAN.NAND.DataUpdates
    fi
}
#################################################################################################################################
function .P2PWriteCFG () {
$toolx cat << EOF > "/data/transmission/settings.json"
{
    "peer-limit-global": 200,
    "peer-limit-per-torrent": 100,
    "cache-size-mb": 2,
    "dht-enabled": true,
    "utp-enabled": true,
    "pex-enabled": true,
    "lpd-enabled": true,
    "download-dir": "/storage/MULTIBOX/Updates",
    "watch-dir": "/sdcard/Download/",
    "watch-dir-enabled": false,
    "port-forwarding-enabled": true,
    "preallocation": 1,
    "script-torrent-done-enabled": false,
    "script-torrent-done-filename": "",
    "download-queue-enabled": true,
    "download-queue-size": 1,
    "encryption": 0,
    "peer-port-random-high": 65535,
    "peer-port-random-low": 49152,
    "peer-port-random-on-start": true,
    "start-added-torrents": false,
    "rename-partial-files": false,
    "alt-speed-down": 50,
    "alt-speed-enabled": false,
    "alt-speed-time-begin": 540,
    "alt-speed-time-day": 127,
    "alt-speed-time-enabled": false,
    "alt-speed-time-end": 1020,
    "alt-speed-up": 50,
    "bind-address-ipv4": "0.0.0.0",
    "bind-address-ipv6": "::",
    "blocklist-enabled": false,
    "blocklist-url": "http://www.example.com/blocklist",
    "idle-seeding-limit": 30,
    "idle-seeding-limit-enabled": false,
    "incomplete-dir": "/sdcard/incompleteDownloads",
    "incomplete-dir-enabled": false,
    "message-level": 2,
    "peer-congestion-algorithm": "",
    "peer-id-ttl-hours": 6,
    "peer-port": 50614,
    "peer-socket-tos": "default",
    "prefetch-enabled": false,
    "queue-stalled-enabled": true,
    "queue-stalled-minutes": 30,
    "ratio-limit": 2,
    "ratio-limit-enabled": false,
    "rpc-authentication-required": false,
    "rpc-bind-address": "0.0.0.0",
    "rpc-enabled": true,
    "rpc-host-whitelist": "",
    "rpc-host-whitelist-enabled": true,
    "rpc-password": "{48553fe464f1b520c45aca48329a4cf39a0960e7/CEXUub4",
    "rpc-port": 9091,
    "rpc-url": "/transmission/",
    "rpc-username": "",
    "rpc-whitelist": "127.0.0.1,*.*",
    "rpc-whitelist-enabled": true,
    "scrape-paused-torrents-enabled": true,
    "seed-queue-enabled": false,
    "seed-queue-size": 10,
    "speed-limit-down": 100,
    "speed-limit-down-enabled": false,
    "speed-limit-up": 100,
    "speed-limit-up-enabled": false,
    "trash-original-torrent-files": false,
    "umask": 63,
    "upload-slots-per-torrent": 14
}
EOF

# Escreve aqui o script de pos exec do torrent
cat << 'EOF' > /data/transmission/tasks.sh
#!/system/bin/sh
mkdir -p /data/transmission/CompletedTorrents
echo -n $TR_TORRENT_ID > /data/transmission/CompletedTorrents/$TR_TORRENT_NAME
EOF
chmod 755 /data/transmission/tasks.sh

}
#################################################################################################################################
function .StartDaemonTransmission () {
# iniciei o daemon basico e no remote com todas as funções e com porta 51345 fechada! não iniciou nenhum up/down nem lp
# high=65535
# low=49152
# export PeerPort=$(( ( RANDOM % (high-low) )  + low ))

echo "ADM DEBUG ### Iniciando transmission Daemon" >> "$Log"
/system/bin/transmission-daemon \
-g $configDir \
-a 127.0.0.1,*.* 

# \
# -P $PeerPort
# removido da linha de comando para definir isto no config.json
#  \
# -c /sdcard/Download/ \
# -w $seedBox
}
#################################################################################################################################
function .checkStateP2P () {
    echo "ADM DEBUG ### function [.checkStateP2P] => $torFile" >> "$Log"
    export DataVar=`/system/bin/transmission-remote --list`
    export torID=`echo "$DataVar" \
    | $toolx grep -w "$torFile" \
    | $toolx awk '{print $1}' \
    | $toolx sed -e 's/[^0-9]*//g'`

    export torDone=`echo "$DataVar" \
    | $toolx grep -w "$torFile" \
    | $toolx awk '{print $2}' \
    | $toolx sed -e 's/[^0-9]*//g'`

    export torStatus=`echo "$DataVar" \
    | $toolx grep -w "$torFile" \
	| $toolx rev \
    | $toolx awk '{print $2}' \
	| $toolx rev`

    export torName=`echo "$DataVar" \
    | $toolx grep -w "$torFile" \
	| $toolx rev \
    | $toolx awk '{print $1}' \
	| $toolx rev`
}



#################################################################################################################################
# -m   --portmap	Enable portmapping via NAT-PMP or UPnP
# -x   --pex		Enable peer exchange (PEX)
# -o   --dht		Enable distributed hash tables (DHT)
# -y   --lpd		Enable local peer discovery (LPD)
# -S stopa o torrent para não baixar nada ainda
# vai verificar todos os arquivos baixados mesmo não setando o -v
function .addTorrent () {
echo "ADM DEBUG ### function addTorrent => $torFile" >> "$Log"
/system/bin/transmission-remote \
-a /data/trueDT/DownloadList/$torFile.key \
-v -s \
--torrent-done-script /data/transmission/tasks.sh
}


# aqui ficava a seção de download dos torrents


echo "ADM DEBUG ### $($toolx date +%s) => $($toolx date +"%d/%m/%Y %H:%M:%S") | cat uptime $($toolx cat /proc/uptime | $toolx cut -d " " -f 2 | $toolx cut -d "." -f 1)" >> "$Log"
echo "ADM DEBUG ### Starting > P2P service" >> "$Log"

echo "ADM DEBUG ### $($toolx ps aux | $toolx grep "transmission" | $toolx grep -v grep)" >> "$Log"

# abaixo o script começa entregando data para as funções.
# travar dentro do serviço o download dos torrents principais
# baixa o torrents e fica semeando infinitamente

while [ 1 ]; do
echo "ADM DEBUG ##############################################################################################################################" >> "$Log"
echo "ADM DEBUG ### Info while {01} main loop [start] $(date +"%d/%m/%Y %H:%M:%S")" >> "$Log"
    .init.p2p.CheckService
    .Check.ExternalDrive
    .Enable.Folder.NAND.DataUpdates    
## user este code para dar uma pausa dentro do código
# while true; do
# echo "ADM DEBUG ### $($toolx date +"%d/%m/%Y %H:%M:%S") adicionado pausa infinita para debug de code" >> "$Log"
# sleep 120
# done

    echo "ADM DEBUG ### verificando se o serviço esta ativo?" >> "$Log"
	instance=`$toolx ps aux | $toolx grep "transmission" | $toolx grep -v grep | $toolx head -n 1 | $toolx awk '{print $1}'`
	if [ "$instance" == "" ]; then
		echo "ADM DEBUG ### $($toolx date +%s) => $($toolx date +"%d/%m/%Y %H:%M:%S") | cat uptime $($toolx cat /proc/uptime | $toolx cut -d " " -f 2 | $toolx cut -d "." -f 1)" >> "$Log"
		echo "ADM DEBUG ### call function > [.P2PWriteCFG]" >> "$Log"
		.P2PWriteCFG
        echo "ADM DEBUG ### call function > [.StartDaemonTransmission]" >> "$Log"
		.StartDaemonTransmission
		echo "ADM DEBUG ### $($toolx date +%s) => $($toolx date +"%d/%m/%Y %H:%M:%S") | cat uptime $($toolx cat /proc/uptime | $toolx cut -d " " -f 2 | $toolx cut -d "." -f 1)" >> "$Log"
		echo "ADM DEBUG ### $($toolx ps aux | $toolx grep "transmission" | $toolx grep -v grep)" >> "$Log"
	fi
    echo "ADM DEBUG ### Info find {01} loop dos torrents [start] $(date +"%d/%m/%Y %H:%M:%S")" >> "$Log"
    $toolx find "/data/trueDT/DownloadList" -type f -name "*.key" | sort | while read fullfile; do
        .init.p2p.CheckService
        echo "ADM DEBUG ### Torrent file > $fullfile" >> "$Log"
        torFile=$(basename -- "$fullfile")
        extension="${torFile##*.}"
        torFile="${torFile%.*}"     
        echo "ADM DEBUG ### Definido arquivo torrent $torFile.torrent" >> "$Log"
        # dentro do while trava ate concluir o download e prosseguir para o proximo torrent
        while true; do
            .init.p2p.CheckService
            .checkStateP2P
            echo "ADM DEBUG ### Info While {02} loop torrent file [$torFile.torrent]" >> "$Log" 
            if [ "$torStatus-$torName" == "-" ]; then
                echo "User Info = [Adicionando Download a lista] ($torFile) $(date +"%d/%m/%Y %H:%M:%S")" >> "$Log"
                #echo "ADM DEBUG ### Adicionando torrent = [$torFile] seguindo as politicas do daemon" >> "$Log"
                .addTorrent
                sleep 11
                .checkStateP2P
            fi            
            if [ "$torStatus-$torName" == "Stopped-$torFile" ]; then
                echo "User Info = [Verificando integridade do download] ($torFile) $(date +"%d/%m/%Y %H:%M:%S")" >> "$Log"
                # echo "ADM DEBUG ### -v verifica integridade do torrent = [$torFile]" >> "$Log"
                # echo "ADM DEBUG ### -s inicia o torrent" >> "$Log"
                /system/bin/transmission-remote -t $torID -v -s --torrent-done-script /data/transmission/tasks.sh
            fi
            if [ ! "$torStatus-$torName" == "Verifying-$torFile" ]; then
                if [ "$torDone" == "100" ]; then
                    echo "User Info = [Download concluido! em $torDone%] ($torFile) $(date +"%d/%m/%Y %H:%M:%S")" >> "$Log"
                    #echo "ADM DEBUG ### $(date +"%d/%m/%Y %H:%M:%S") Download concluido = $torName %$torDone" >> "$Log"
                    break
                fi
            fi
            if [ ! "$torDone" == "100" ]; then
                echo "User Info = [Download em: $torDone%] ($torFile) $(date +"%d/%m/%Y %H:%M:%S")" >> "$Log"
                #echo "ADM DEBUG ### $(date +"%d/%m/%Y %H:%M:%S") aguardando Download concluir = $torName $torDone%" >> "$Log"
            fi
            if [ "$(echo "$DataVar" | $toolx grep -w ".install" | $toolx rev | $toolx awk '{print $2}' | $toolx rev)-.install" == "-.install" ]; then
                # torrent foi removido da lista
                .killP2P
                .killinitP2P
            fi
            if [ "$(echo "$DataVar" | $toolx grep -w ".install" | $toolx rev | $toolx awk '{print $2}' | $toolx rev)-.install" == "Stopped-.install" ]; then
                # torrent foi pausado na lista
                .killP2P
                .killinitP2P
            fi
            echo "ADM DEBUG ### $(date +"%d/%m/%Y %H:%M:%S") While loop [$torFile] $torStatus" >> "$Log"
            sleep 9 # 61
        done
        # variaveis que não estou utilizando no momento
        #     if [ "$torStatus-$torName" == "Downloading-$torFile" ]; then
        echo "ADM DEBUG ### Info find loop dos torrents [END] $(date +"%d/%m/%Y %H:%M:%S")" >> "$Log"
        echo "ADM DEBUG ### Last torrent file [$torName]" >> "$Log"
    done

echo "ADM DEBUG ### Info while main loop [END] $(date +"%d/%m/%Y %H:%M:%S")" >> "$Log"
echo "ADM DEBUG ### File LOG size= $($toolx du "$Log" | $toolx awk '{print $1}')" >> "$Log"
echo "ADM DEBUG ### --------------------------------------------------------------------------------------------------------------------------" >> "$Log"
# adicionar aqui o codigo se o arquivo de log crescer muito para apagar..
checkSize=`$toolx du "$Log" | $toolx awk '{print $1}'`
if [ "$checkSize" -gt "50" ]; then
	echo "User Warn = Log Cleanner" > "$Log"
fi
# sleep indicado para uma volta completa é minimo 60 seconds
sleep 30


done




