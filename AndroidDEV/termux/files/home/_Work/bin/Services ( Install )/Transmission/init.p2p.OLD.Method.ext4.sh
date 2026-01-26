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

# [] existem fatores aqui a considerar.. se o cara puxar o pendrive? oque acontece? se bugar
# [] montar o drive destino ou path oficial antes do script continuar. precisa adequar isto a solução atual dos arquivos



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
function .FormatEXT4 () {
# desmontar apenas o usb MEFORMATE
RawData=`$toolx blkid | $toolx grep 'LABEL="MEFORMATE"'`
Partition=`echo "$RawData" | $toolx grep -v vold | $toolx head -n 1 | $toolx cut -d ":" -f 1`
MBR=`echo "$Partition" | $toolx sed 's/.\{1\}$//'`
publicM=`echo "$RawData" | $toolx grep "public" | $toolx cut -d ":" -f 2`
if [ ! "$MBR" == "" ]; then
    echo "ADM DEBUG ############################################################################################" >> "$Log"
    echo "ADM DEBUG ### MBR = $MBR" >> "$Log"
    echo "ADM DEBUG ### Public mount point = public:$publicM" >> "$Log"
    # verificar se esta montado public mount point
    check=`$toolx mount | $toolx grep "public:$publicM"`
    if [ ! "$check" == "" ]; then
        echo "ADM DEBUG ### precisa desmontar unidade > public:$publicM" >> "$Log"
        sm unmount public:$publicM
    fi
# verificar se esta montado usando /dev/block/sd*
echo "ADM DEBUG ############################################################################################" >> "$Log"
echo "User Info = Particionando USB Drive para MultiBOX. Por favor aguarde" >> "$Log"
(
echo o # Create a new empty DOS partition table
echo n # Add a new partition
echo p # Primary partition
echo 1 # Partition number
echo   # First sector (Accept default: 1)
echo   # Last sector (Accept default: varies)
echo a # make a partition bootable
echo p # print the in-memory partition table
echo w # write the partition table
echo q # and we're done
) | /system/usr/bin/fdisk -w always -W always $MBR > /dev/null 2>&1
echo "User Info = Listando particionamento ativo MultiBOX" >> "$Log"
echo "User Info = $(/system/usr/bin/fdisk -l $MBR)" >> "$Log"

echo "ADM DEBUG ############################################################################################" >> "$Log"
echo "User Info = Formatando drive para MultiBOX" >> "$Log"
#/system/usr/bin/mkfs.ext4 -t ext4 -U cc9f60ac-c9fa-4834-8af9-cdb99d0bef10 -L "MultiBOX" $MBR'1'
/system/usr/bin/mkfs.ext4 -t ext4 -L "MultiBOX" $Partition <<BAH > /dev/null 2>&1
y
BAH
echo "User Info = Formatado com sucesso MultiBOX!" >> "$Log"
echo "User Info = $($toolx blkid | $tools grep "MultiBOX")" >> "$Log"
sleep 7
fi
}
#################################################################################################################################
function .FormatFAT32 () {
Partition=`$toolx blkid | $toolx grep 'LABEL="MultiBOX"' | $toolx grep -v vold | $toolx head -n 1 | $toolx cut -d ":" -f 1`
MBR=`echo $Partition | $toolx sed 's/.\{1\}$//'`
if [ ! "$MBR" == "" ]; then
echo "ADM DEBUG ############################################################################################" >> "$Log"
echo "User Info = Error Driver não é compativel com seu TVBOX" >> "$Log"
echo "User Info = Particionando USB Drive FAT32" >> "$Log"
(
echo o # Create a new empty DOS partition table
echo n # Add a new partition
echo p # Primary partition
echo 1 # Partition number
echo   # First sector (Accept default: 1)
echo   # Last sector (Accept default: varies)
echo t # escolher o type da partiçao
echo c # ID c W95 FAT32 (LBA) default do formatado geniusDesk
echo a # make a partition bootable
echo p # print the in-memory partition table
echo w # write the partition table
echo q # and we're done
) | /system/usr/bin/fdisk -w always -W always $MBR > /dev/null 2>&1
echo "User Info = Listando particionamento FAT32" >> "$Log"
/system/usr/bin/fdisk -l $MBR

echo "ADM DEBUG ############################################################################################" >> "$Log"
echo "User Info = Formatando Drive Lento" >> "$Log"
/system/bin/newfs_msdos -A -F 32 -L DriveLento $Partition > /dev/null 2>&1
echo "User Info = Formatado com sucesso DriveLento!" >> "$Log"
echo "User Info = $($toolx blkid | $tools grep "DriveLento")" >> "$Log"

# arquivo de referencia para o usuario vai aparecer no web interface
mv "$FileLogDrive" "/data/trueDT/BenchResults/SLOWDrive.log"
echo "Drive lento detectado. Velocidade atual: [$CheckSpeed MB]" >> "/data/trueDT/BenchResults/SLOWDrive.log"
echo "Velocidade Mínima exigida = 15MB" >> "/data/trueDT/BenchResults/SLOWDrive.log"
$toolx cat "/data/trueDT/BenchResults/SLOWDrive.log" >> "$Log"

sleep 7
fi
}
#################################################################################################################################
function .umountDrive () {
    while [ 1 ]; do
        ifMounted=`$toolx mount | $toolx grep "$FolderPath" | $toolx cut -d " " -f 1`
        if [ "$ifMounted" == "" ]; then
            rm -rf "$FolderPath"
            break
        else
            $toolx umount "$FolderPath"
            sleep 2        
        fi
    done
}
#################################################################################################################################
function .mountDrive () {
    while [ 1 ]; do
        if [ ! -d "$FolderPath/lost+found" ]; then
            echo "ADM DEBUG ### Warn iniciando montagem MultiBOX em EXT4 = $FolderPath" >> "$Log"
            # as vezes entra aqui em loop infinito e não monta de fato a partição ou não esta mostrando a pasta lost+found
            mkdir -p "$FolderPath"
            $toolx mount -t ext4 LABEL="MultiBOX" "$FolderPath"            
            sleep 11
        else
            mkdir -p "/storage/MultiBOX/DataUpdates"
            echo "ADM DEBUG ### Warn Drive montado com sucesso! MultiBOX em EXT4 = $FolderPath" >> "$Log"
            break
        fi
    done
}
#################################################################################################################################
function .Enable.Folder.NAND.DataUpdates () {
    echo "ADM DEBUG ### Warn function [.Enable.Folder.NAND.DataUpdates]" >> "$Log"
    source "/storage/P2PDir.Enabled.var"
    if [ ! "$SetP2PFolder" == "$P2PDirFolder" ]; then
        .killP2P
        echo "User Info = [Ativando memória interna NAND para armazenamento arquivos] $(date +"%d/%m/%Y %H:%M:%S")" >> "$Log"
        echo "User Info = [Drive espaço Real NAND] $($toolx df -h | $toolx grep "/storage/emulated" | $toolx sed "s;/dev/fuse                 ;;g")" >> "$Log"
        echo -n "P2PDirFolder=\"$SetP2PFolder\"" > "/storage/P2PDir.Enabled.var"
    else
        echo "User Info = [Drive ativo NAND para armazenamento arquivos] $(date +"%d/%m/%Y %H:%M:%S")" >> "$Log"
        echo "User Info = [Drive espaço Real NAND] $($toolx df -h | $toolx grep "/storage/emulated" | $toolx sed "s;/dev/fuse                 ;;g")" >> "$Log"
        #echo -n "P2PDirFolder=\"$SetP2PFolder\"" > "/storage/P2PDir.Enabled.var"
    fi
}
#################################################################################################################################
function .Enable.Folder.ExternalDrive.DataUpdates () {
    echo "ADM DEBUG ### Warn function [.Enable.Folder.ExternalDrive.DataUpdates]" >> "$Log"
    source "/storage/P2PDir.Enabled.var"
    if [ ! "$SetP2PFolder" == "$P2PDirFolder" ]; then
        .killP2P
        echo "User Info = [Ativando memória Externa para armazenamento arquivos] $(date +"%d/%m/%Y %H:%M:%S")" >> "$Log"
        echo "User Info = [Drive Externo em uso] $($toolx df -h | $toolx grep "MultiBOX" | $toolx head -n 1)" >> "$Log"        
        rm "/storage/NAND.LOCKED" > /dev/null 2>&1
        echo -n "P2PDirFolder=\"$SetP2PFolder\"" > "/storage/P2PDir.Enabled.var"
    else
        echo "User Info = [Drive Externo em uso] $($toolx df -h | $toolx grep "MultiBOX" | $toolx head -n 1)" >> "$Log"
        rm "/storage/NAND.LOCKED" > /dev/null 2>&1
        #echo -n "P2PDirFolder=\"$SetP2PFolder\"" > "/storage/P2PDir.Enabled.var"
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
    "download-dir": "$SetP2PFolder",
    "watch-dir": "/sdcard/Download/",
    "watch-dir-enabled": false,
    "port-forwarding-enabled": true,
    "preallocation": 0,
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
    echo "ADM DEBUG ### function checkStateP2P => $torFile" >> "$Log"
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
-a /data/trueDT/Torrents/$torFile.torrent \
-v -s \
--torrent-done-script /data/transmission/tasks.sh
}
#################################################################################################################################
function DownloadFiles () {
if [ ! -d "/data/trueDT/Torrents" ]; then
    mkdir -p "/data/trueDT/Torrents"
fi
echo "$multilinks" | $toolx sed -e '/^\s*$/d' | while IFS= read -r LineDownload ; do
    echo "ADM DEBUG ############################################################################################" >> "$Log"
    echo "ADM DEBUG ### download link > $LineDownload" >> "$Log"
    /system/bin/wget -N --no-check-certificate --timeout=1 --tries=7 -P $DowloadPath/ "$LineDownload" > "/data/trueDT/Torrents/$FileName-wget.log" 2>&1
    CheckWgetCode=`$toolx cat "/data/trueDT/Torrents/$FileName-wget.log" | $toolx grep "HTTP request sent, awaiting response..."`
    cat "/data/trueDT/Torrents/$FileName-wget.log"
    # Se tiver acesso finaliza esta função
    if [ "$CheckWgetCode" == "HTTP request sent, awaiting response... 200 OK" ] ; then
        echo "ADM DEBUG ### Wget :) $CheckWgetCode" >> "$Log"
        echo "$FileName" > "/data/trueDT/Torrents/$FileName-wget.log"
        echo "$CheckWgetCode" >> "/data/trueDT/Torrents/$FileName-wget.log"
        break # fecha a função por completo
    fi
    if [ "$CheckWgetCode" == "HTTP request sent, awaiting response... 304 Not Modified" ] ; then
        echo "ADM DEBUG ### Wget :) $CheckWgetCode" >> "$Log"
        echo "$FileName" > "/data/trueDT/Torrents/$FileName-wget.log"
        echo "$CheckWgetCode" >> "/data/trueDT/Torrents/$FileName-wget.log"
        break # fecha a função por completo
    fi 
done
}
#################################################################################################################################
function Downloadcheck () {
while true; do
    echo "ADM DEBUG ### Entrando na função > LoopForceDownloadLauncher" >> "$Log"
    DownloadFiles
    FileOK=`cat "/data/trueDT/Torrents/$FileName-wget.log" | sed -n '1p'`
    echo "ADM DEBUG ### download result = $FileOK" >> "$Log"
	if [ ! "$FileOK" == "$FileName" ]; then
        echo "ADM DEBUG ### Nova tentativa em loop para baixar" >> "$Log"
        logcat -c
    else
        break
    fi
done
}





# inicio do script para executar as funções
# não botar links quebrados ou redirecionados pois vai baixar um arquivo provocando download do arquivo sempre.
DowloadPath="/data/trueDT/Torrents"

FileName=".install.torrent"
multilinks="
http://45.79.133.216/asusboxA1/.install.torrent
http://45.79.48.215/asusboxA1/.install.torrent
"
Downloadcheck


# FileName="kubuntu-22.10-desktop-amd64.iso.torrent"
# multilinks="
# https://cdimage.ubuntu.com/kubuntu/releases/22.10/release/kubuntu-22.10-desktop-amd64.iso.torrent
# "
# Downloadcheck


# FileName="ubuntu-22.10-desktop-amd64.iso.torrent"
# multilinks="
# https://releases.ubuntu.com/22.10/ubuntu-22.10-desktop-amd64.iso.torrent
# "
# Downloadcheck


echo "ADM DEBUG ### $($toolx date +%s) => $($toolx date +"%d/%m/%Y %H:%M:%S") | cat uptime $($toolx cat /proc/uptime | $toolx cut -d " " -f 2 | $toolx cut -d "." -f 1)" >> "$Log"
echo "ADM DEBUG ### Starting > P2P service" >> "$Log"

echo "ADM DEBUG ### $($toolx ps aux | $toolx grep "transmission" | $toolx grep -v grep)" >> "$Log"

# abaixo o script começa entregando data para as funções.
# travar dentro do serviço o download dos torrents principais
# baixa o torrents e fica semeando infinitamente

while [ 1 ]; do
echo "ADM DEBUG ##############################################################################################################################" >> "$Log"
echo "ADM DEBUG ### Info while main loop [start] $(date +"%d/%m/%Y %H:%M:%S")" >> "$Log"
    .init.p2p.CheckService
    # formata apenas se um drive label "MEFORMATE" for conectado..
    .FormatEXT4
    export RawData=`$toolx blkid | $toolx grep 'LABEL="MultiBOX"'`
    export Partition=`echo "$RawData" | $toolx grep -v vold | $toolx head -n 1 | $toolx cut -d ":" -f 1`
    export MBR=`echo "$Partition" | $toolx sed 's/.\{1\}$//'`
    export publicM=`echo "$RawData" | $toolx grep "public" | $toolx cut -d ":" -f 2`
    export UUID=`echo "$RawData" | $toolx cut -d '"' -f 4 | $toolx head -n 1`
    if [ ! "$RawData" == "" ]; then
        echo "ADM DEBUG ### $Partition | $MBR | $publicM | $UUID" >> "$Log"
    fi

    # code = montagem e teste de velocidade do drive ext4
    FileLogDrive="/data/trueDT/BenchResults/FullSpeedDriveTest.$UUID.txt"
    if [ ! "$Partition" == "" ]; then
        echo "ADM DEBUG ### Drive connected!" >> "$Log"
        echo "ADM DEBUG ### [$Partition]" >> "$Log"
        if [ ! -d "$FolderPath/lost+found" ]; then
            .umountDrive
            .mountDrive
        else
            echo "User Info = Driver conectado $Partition <=> $FolderPath" >> "$Log"
        fi
        if [ ! -d /data/trueDT/BenchResults ]; then
            mkdir -p /data/trueDT/BenchResults
        fi        
        if [ ! -f "$FileLogDrive" ]; then
            echo "ADM DEBUG ### testando velocidade de gravação = $Partition" >> "$Log"
            $toolx dd if=/dev/zero of="$FolderPath/Drive.Speed.Test.img" bs=200M count=1 > "/data/local/tmp/speed.log" 2>&1    
            # deleta arquivo img test
            rm "$FolderPath/Drive.Speed.Test.img"
            # write FileLogDrive
            echo "Speed test result:" > "$FileLogDrive"
            $toolx cat "/data/local/tmp/speed.log" | $toolx tail -n 1 >> "$FileLogDrive"
            echo "Drive Specs:" >> "$FileLogDrive"
            echo "$UUID" >> "$FileLogDrive"
            $toolx df -h | $toolx grep "$FolderPath" >> "$FileLogDrive"
            # remove TABS
            $toolx sed -i -e 's|^[[:blank:]]*||g' "$FileLogDrive"
            $toolx sed -i -e 's/[[:blank:]]*$//' "$FileLogDrive"
            $toolx cat "$FileLogDrive" >> "$Log"
            # clean old log
            rm "/data/local/tmp/speed.log"
        fi
    fi

## user este code para dar uma pausa dentro do código
# while true; do
# echo "ADM DEBUG ### $($toolx date +"%d/%m/%Y %H:%M:%S") adicionado pausa infinita para debug de code" >> "$Log"
# sleep 120
# done

    CheckSpeed=`$toolx cat "$FileLogDrive" | $toolx sed -n '2p' | $toolx awk '{print $7}' | $toolx cut -d "." -f 1`
    echo "ADM DEBUG ### Warn if Comparando dados if driver for lento" >> "$Log"
    if [ "$CheckSpeed" -lt "15" ];then
        .umountDrive
        .FormatFAT32
        export SetP2PFolder="/sdcard/.DataUpdates"
        .Enable.Folder.NAND.DataUpdates
    else
        echo "User Info = Velocidade de escrita do drive = $CheckSpeed MB" >> "$Log"
        export SetP2PFolder="/storage/MultiBOX/DataUpdates"
        rm "/data/trueDT/BenchResults/SLOWDrive.log" > /dev/null 2>&1
        .Enable.Folder.ExternalDrive.DataUpdates
    fi
    echo "ADM DEBUG ### P2PFolder = [$SetP2PFolder]" >> "$Log"
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
    echo "ADM DEBUG ### Info find loop dos torrents [start] $(date +"%d/%m/%Y %H:%M:%S")" >> "$Log"
    $toolx find "/data/trueDT/Torrents" -type f -name "*.torrent" | while read fullfile; do
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
            echo "ADM DEBUG ### $(date +"%d/%m/%Y %H:%M:%S") While loop [$torFile] $torStatus" >> "$Log"
            sleep 9 # 61
        done
        # variaveis que não estou utilizando no momento
        #     if [ "$torStatus-$torName" == "Downloading-$torFile" ]; then
        echo "ADM DEBUG ### Info find loop dos torrents [END] $(date +"%d/%m/%Y %H:%M:%S")" >> "$Log"
        echo "ADM DEBUG ### Last torrent file [$torName]" >> "$Log"
    done

echo "ADM DEBUG ### Info while main loop [END] $(date +"%d/%m/%Y %H:%M:%S")" >> "$Log"
echo "ADM DEBUG ### --------------------------------------------------------------------------------------------------------------------------" >> "$Log"
# adicionar aqui o codigo se o arquivo de log crescer muito para apagar..
# sleep indicado para uma volta completa é minimo 60 seconds
sleep 30


done




