#!/system/bin/sh

rsync=/system/bin/rsync
List="
/storage/DevMount/AndroidDEV
/storage/DevMount/asusbox
/storage/DevMount/GitHUB
/storage/DevMount/TWRP
"
destino="/storage/asusboxUpdate"
for loop in $List; do
    $rsync --progress -avz --delete --recursive $loop $destino/
done
