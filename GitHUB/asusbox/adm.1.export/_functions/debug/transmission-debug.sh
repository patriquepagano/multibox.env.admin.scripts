#!/system/bin/sh


# criar link magnetico

/system/bin/transmission-show -m /data/asusbox/.install/03.akp.base.torrent
# magnet:?xt=urn:btih:136ef679dc5c9b677519017fb414c51658cac046&dn=03.akp.base&tr=http%3A%2F%2Ftracker.yoshi210.com%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.yoshi210.com%3A6969%2Fannounce&tr=http%3A%2F%2Fsecure.pow7.com%2Fannounce&tr=http%3A%2F%2Fatrack.pow7.com%2Fannounce&tr=http%3A%2F%2Ft1.pow7.com%2Fannounce&tr=http%3A%2F%2Fpow7.com%3A80%2Fannounce&tr=http%3A%2F%2Ft2.pow7.com%2Fannounce&tr=http%3A%2F%2Fp4p.arenabg.com%3A1337%2Fannounce&tr=http%3A%2F%2Fopen.acgtracker.com%3A1096%2Fannounce&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80%2Fannounce&tr=udp%3A%2F%2Ftracker.tiny-vps.com%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.coppersurfer.tk%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.leechers-paradise.org%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce&tr=udp%3A%2F%2F62.138.0.158%3A6969%2Fannounce&tr=udp%3A%2F%2Fexplodie.org%3A6969%2Fannounce&tr=udp%3A%2F%2Fopen.stealth.si%3A80%2Fannounce



exit


     1     4%   16.22 MB  Unknown      0.0     0.0    0.0  Stopped      05.akp.cl
     2    20%   37.94 MB  Unknown      0.0     0.0    0.0  Stopped      04.akp.oem
     3   100%   14.09 MB  Done         0.0     0.0    0.0  Idle         03.akp.base
     4     9%    2.10 MB  Unknown      0.0     0.0    0.0  Idle         00.snib


grep "$torFile" | grep Stopped

# script after download
https://forum.transmissionbt.com/viewtopic.php?t=18255
https://forum.transmissionbt.com/viewtopic.php?t=18714





# remove qlq torrent que esteja em 100% 
/system/bin/transmission-remote --list | /system/bin/busybox awk '$2 == "100%"{ system("transmission-remote -t " $1 " --remove") }'

exit

/system/bin/transmission-remote --list | /system/bin/busybox sed -e '1d' -e '$d' | /system/bin/busybox awk '{print $1}' | /system/bin/busybox sed -e 's/[^0-9]*//g'



# Clears finished downloads from Transmission.
# Version: 1.1
#
# Newest version can always be found at:
# https://gist.github.com/pawelszydlo/e2e1fc424f2c9d306f3a
#
# Server string is resolved in this order:
# 1. TRANSMISSION_SERVER environment variable
# 2. Parameters passed to this script
# 3. Hardcoded string in this script (see below).

# # Server string: "host:port --auth username:password"
# SERVER="host:port --auth user:pass"

# # Which torrent states should be removed at 100% progress.
# DONE_STATES=("Seeding" "Stopped" "Finished" "Idle")

# # Get the final server string to use.
# if [[ -n "$TRANSMISSION_SERVER" ]]; then
#     echo -n "Using server string from the environment: "
#     SERVER="$TRANSMISSION_SERVER"
# elif [[ "$#" -gt 0 ]]; then
#     echo -n "Using server string passed through parameters: "
#     SERVER="$*"
# else
#     echo -n "Using hardcoded server string: "
# fi
# echo "${SERVER: : 10}(...)"  # Truncate to not print auth.

# # Use transmission-remote to get the torrent list from transmission-remote.
# TORRENT_LIST=$(transmission-remote $SERVER --list | sed -e '1d' -e '$d' | awk '{print $1}' | sed -e 's/[^0-9]*//g')

# # Iterate through the torrents.
# for TORRENT_ID in $TORRENT_LIST
# do
#     INFO=$(transmission-remote $SERVER --torrent "$TORRENT_ID" --info)
#     echo -e "Processing #$TORRENT_ID: \"$(echo "$INFO" | sed -n 's/.*Name: \(.*\)/\1/p')\"..."
#     # To see the full torrent info, uncomment the following line.
#     # echo "$INFO"
#     PROGRESS=$(echo "$INFO" | sed -n 's/.*Percent Done: \(.*\)%.*/\1/p')
#     STATE=$(echo "$INFO" | sed -n 's/.*State: \(.*\)/\1/p')
 
#     # If the torrent is 100% done and the state is one of the done states.
#     if [[ "$PROGRESS" == "100" ]] && [[ "${DONE_STATES[@]}" =~ "$STATE" ]]; then
#         echo "Torrent #$TORRENT_ID is done. Removing torrent from list."
#         transmission-remote $SERVER --torrent "$TORRENT_ID" --remove
#     else
#         echo "Torrent #$TORRENT_ID is $PROGRESS% done with state \"$STATE\". Ignoring."
#     fi
# done









exit

# a idéia é quando estiver 100% ai chama o proximo para baixar um por vez
# não funciona pq os espaços são variaveis 4% de 97% 
torFile="04.akp.oem"
#TorDone=`/system/bin/transmission-remote --list | grep "$torFile" | cut -d " " -f 9` # na versão 3.0
TorDone=`/system/bin/transmission-remote --list | grep "$torFile" | cut -d "%" -f 1` # na versão 2.94
if [ "$TorDone" == "100%" ]; then
echo "torrent concluido e atualizado"
fi


echo $TorDone





torFile=04.akp.oem

# transmission an versão 2.94
# se estiver em stop muda na grade
torID=`/system/bin/transmission-remote --list | grep "$torFile" | grep Stopped | cut -d " " -f 4`
if [ "$torID" == "" ]; then
# Extrair o ID do torrent
torID=`/system/bin/transmission-remote --list | grep "$torFile" | cut -d " " -f 4`
fi



# transmission an versão 3.0
# se estiver em stop muda na grade
torID=`/system/bin/transmission-remote --list | grep "$torFile" | grep Stopped | cut -d " " -f 6`
if [ "$torID" == "" ]; then
# Extrair o ID do torrent
torID=`/system/bin/transmission-remote --list | grep "$torFile" | cut -d " " -f 6`
fi





echo "O $torFile esta pausado sobre o ID > $torID"




#    1   100%   14.09 MB  Done         0.0     0.0    0.0  Idle         03.akp.base
#    3    14%   28.14 MB  Unknown      0.0     0.0    0.0  Stopped      04.akp.oem
#    4     7%   29.26 MB  Unknown      0.0     0.0    0.0  Stopped      05.akp.cl
#    5     0%       None  Unknown      0.0     0.0   None  Idle         00.snib





# transmission na versão 3.0
# se estiver em stop muda na grade
torID=`/system/bin/transmission-remote --list | grep "$torFile" | grep Stopped | cut -d "*" -f 1`
if [ "$torID" == "" ]; then
# Extrair o ID do torrent
torID=`/system/bin/transmission-remote --list | grep "$torFile" | cut -d " " -f 4`
fi