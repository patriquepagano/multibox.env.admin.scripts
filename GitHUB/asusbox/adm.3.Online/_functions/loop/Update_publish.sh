function Update_publish () {
#unset PATH
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin
#unset LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib
export ssh="/data/data/com.termux/files/usr/bin/ssh"
export sshpass="/data/data/com.termux/files/usr/bin/sshpass"
export rsync="/data/data/com.termux/files/usr/bin/rsync"


mkdir -p /data/data/com.termux
ln -sf /storage/DevMount/AndroidDEV/termux/files /data/data/com.termux/
ln -sf /storage/DevMount/asusbox/.install /data/asusbox/

Distrib="/storage/DevMount/GitHUB/asusbox/adm.3.Online"


if [ "$auth" == "key" ]; then
    chmod 400 $key
fi

if [ "$auth" == "key" ]; then
    echo "#################### enviando arquivos via auth key #######################"
    echo "#################### server > $user@$vpsIP #######################"

    # copia permissão, data e hora
    /system/bin/rsync --progress \
    --chmod=777 \
    -avz \
    --delete \
    --recursive \
    -e "$ssh -i $key" \
    $DIR/asusboxA1 $user@$vpsIP:/$NgiNX_Folder/

fi

if [ "$auth" == "pass" ]; then
    echo "#################### enviando arquivos via auth password #######################"
    echo "#################### server > $user@$vpsIP #######################"

    # copia permissão, data e hora
    $sshpass -p $pass \
    /system/bin/rsync --progress \
    --chmod=777 \
    -avz \
    --delete \
    --recursive \
    -e $ssh \
    $DIR/asusboxA1 $user@$vpsIP:/$NgiNX_Folder/

fi


}




