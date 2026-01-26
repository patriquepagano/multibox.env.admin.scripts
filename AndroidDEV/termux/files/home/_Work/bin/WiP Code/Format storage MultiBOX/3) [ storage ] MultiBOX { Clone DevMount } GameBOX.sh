#!/system/bin/sh

rsync="/data/data/com.termux/files/usr/bin/rsync"

# copia os apks para minha vm linux
$rsync --progress \
-avz \
--delete \
--recursive \
--exclude '4Android' \
--exclude 'Android' \
--exclude 'lost+found' \
--exclude 'asusbox' \
--exclude 'TWRP' \
"/storage/DevMount/" \
"/storage/MultiBOX/"


$rsync --progress \
-avz \
--delete \
--recursive \
"/storage/DevMount/GitHUB/asusbox/" \
"/storage/MultiBOX/GitHUB/asusbox/"


