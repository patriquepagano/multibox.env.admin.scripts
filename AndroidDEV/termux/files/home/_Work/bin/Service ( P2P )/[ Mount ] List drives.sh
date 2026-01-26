#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear
Log="/data/trueDT/peer/TMP/init.p2p.LOG"
toolx="/system/bin/busybox"

echo "
ifInserted = blkid"
$toolx blkid | $toolx grep 'LABEL="MultiBOX"' | $toolx grep -v vold | $toolx head -n 1 | $toolx cut -d ":" -f 1

echo "
ifMounted mount"
$toolx mount | $toolx grep "$FolderPath" | $toolx cut -d " " -f 1

echo "
df -h"
$toolx df -h | $toolx grep "$FolderPath"

echo "
cat /proc/mounts"
cat /proc/mounts | grep MultiBOX

echo "done"
