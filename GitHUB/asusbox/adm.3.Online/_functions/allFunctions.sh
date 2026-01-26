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




function UploadVPS () {
#unset PATH
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin
#unset LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib
export ssh="/data/data/com.termux/files/usr/bin/ssh"
export sshpass="/data/data/com.termux/files/usr/bin/sshpass"
export rsync="/data/data/com.termux/files/usr/bin/rsync"

filesToSend="
/storage/DevMount/GitHUB/asusbox/adm.3.Online/_functions/Servers/0_vps-scripts/p2p-*
/storage/DevMount/GitHUB/asusbox/adm.2.install/.install.torrent
"

mkdir -p /data/data/com.termux
ln -sf /storage/DevMount/AndroidDEV/termux/files /data/data/com.termux/
ln -sf /storage/DevMount/asusbox/.install /data/asusbox/


seedBox="/storage/DevMount/asusbox/.install"
/system/bin/busybox chown -R root:root $seedBox
/system/bin/busybox find $seedBox -type d -exec chmod 700 {} \; 
/system/bin/busybox find $seedBox -type f -exec chmod 600 {} \;


if [ "$auth" == "key" ]; then
    chmod 400 $key
fi

if [ "$auth" == "key" ]; then
    echo "#################### enviando arquivos via auth key #######################"
    echo "#################### server > $vpsName = $user@$vpsIP #######################"
    for loop in $filesToSend; do
    echo "Enviando arquivo $loop"
    # copia permissão, data e hora
    /system/bin/rsync --progress \
    -avz \
    --delete \
    --recursive \
    -e "$ssh -i $key" \
    $loop $user@$vpsIP:/SeedBOX/
    done
fi

if [ "$auth" == "pass" ]; then
    echo "#################### enviando arquivos via auth password #######################"
    echo "#################### server > $vpsName = $user@$vpsIP #######################"
    for loop in $filesToSend; do
    echo "Enviando arquivo $loop"
    # copia permissão, data e hora
    $sshpass -p $pass \
    /system/bin/rsync --progress \
    -avz \
    --delete \
    --recursive \
    -e $ssh \
    $loop $user@$vpsIP:/SeedBOX/
    done
fi

if [ "$auth" == "key" ]; then
    echo "#################### sincronizando pasta .install via auth key #######################"
    echo "#################### server > $vpsName = $user@$vpsIP #######################"
    source="/storage/DevMount/asusbox/.install/"
    vpsOut="/SeedBOX/.install/"
    echo "Sincronizando a pasta .install"
    # copia permissão, data e hora
    /system/bin/rsync --progress \
    -avz \
    --delete \
    --recursive \
    -e "$ssh -i $key" \
    $source/ $user@$vpsIP:$vpsOut/
fi

if [ "$auth" == "pass" ]; then
    echo "#################### sincronizando pasta .install via auth password #######################"
    echo "#################### server > $vpsName = $user@$vpsIP #######################"
    source="/storage/DevMount/asusbox/.install/"
    vpsOut="/SeedBOX/.install/"
    echo "Sincronizando a pasta .install"
    # copia permissão, data e hora
    $sshpass -p $pass \
    /system/bin/rsync --progress \
    -avz \
    --delete \
    --recursive \
    -e $ssh \
    $source/ $user@$vpsIP:$vpsOut/
fi

}




function VpsSeedBOX () {
#unset PATH
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin
#unset LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib
export ssh="/data/data/com.termux/files/usr/bin/ssh"
export sshpass="/data/data/com.termux/files/usr/bin/sshpass"
export rsync="/data/data/com.termux/files/usr/bin/rsync"

if [ "$auth" == "key" ]; then
    chmod 400 $key
fi


if [ "$auth" == "key" ]; then
    echo "#################### Rodando o script no server #######################"
    echo "#################### server > $vpsName $user@$vpsIP #######################"
    $ssh -i $key $user@$vpsIP "sudo chmod 777 -R /SeedBOX && /SeedBOX/p2p-start.sh"
fi

if [ "$auth" == "pass" ]; then
    echo "#################### Rodando o script no server #######################"
    echo "#################### server > $vpsName $user@$vpsIP #######################"
    $sshpass -p $pass \
        $ssh $user@$vpsIP "sudo chmod 777 -R /SeedBOX && /SeedBOX/p2p-start.sh"
fi

}




