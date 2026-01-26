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




