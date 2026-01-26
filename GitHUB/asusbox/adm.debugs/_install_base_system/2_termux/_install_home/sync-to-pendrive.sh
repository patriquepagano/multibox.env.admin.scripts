#!/system/bin/sh

# pacote do termux
source="/data/data/com.termux/files"
out="/storage/DevMount/AndroidDEV/termux-files"

cd $out
/system/bin/rsync --progress \
-avz \
--delete \
--recursive \
$source/ $out/

