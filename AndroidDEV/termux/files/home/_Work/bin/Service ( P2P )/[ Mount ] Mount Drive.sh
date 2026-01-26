#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear
Log="/data/trueDT/peer/TMP/init.p2p.LOG"
toolx="/system/bin/busybox"


export FolderPath="/storage/MultiBOX"
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

function .mountDrive () {
    echo "iniciando montagem"
    mkdir -p "$FolderPath"
    busybox mount -t ext4 LABEL="MultiBOX" "$FolderPath"
    sleep 2
}


while [ 1 ]; do
ifInserted=`$toolx blkid | $toolx grep 'LABEL="MultiBOX"' | $toolx grep -v vold | $toolx head -n 1 | $toolx cut -d ":" -f 1`
if [ ! "$ifInserted" == "" ]; then
    echo "ADM DEBUG ### Drive connected!"
    echo "ADM DEBUG ### [$ifInserted]"
    if [ ! -d "$FolderPath/lost+found" ]; then
        .umountDrive
        .mountDrive
    else
        echo "ADM DEBUG ### Drive mounted at > $ifMounted <=> $FolderPath"
        if [ ! -d "$FolderPath/cachedData" ]; then
            mkdir -p "$FolderPath/cachedData"
        fi
        break
    fi
fi
done

echo "done"


