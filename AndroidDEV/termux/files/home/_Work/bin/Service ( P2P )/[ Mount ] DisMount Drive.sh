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

.umountDrive

