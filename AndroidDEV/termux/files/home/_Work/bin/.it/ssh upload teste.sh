#!/system/bin/sh
clear

export Rsync=/system/bin/rsync
export Rsync="/storage/DevMount/AndroidDEV/termux/files/usr/bin/rsync"
export ssh="/data/data/com.termux/files/usr/bin/ssh"
export sshpass="/data/data/com.termux/files/usr/bin/sshpass"



vps="/storage/DevMount/AndroidDEV/termux/files/home/_Work/hosts/Cloud (Linode) [45.79.48.215] {asusbox-elton}.vps"
vps="/storage/DevMount/AndroidDEV/termux/files/home/_Work/hosts/Cloud (Linode) [66.175.210.64] {Linode Pixkey}.vps"

source "$vps"
cat "$vps"

keyscan="/data/data/com.termux/files/usr/bin/ssh-keyscan"
sshpass="/data/data/com.termux/files/usr/bin/sshpass"
ssh="/data/data/com.termux/files/usr/bin/ssh"

#$sshpass -p $pass $ssh -v $user@$IP



# $ssh -v -T -i $key $user@$IP << EOF
# sudo mkdir -p /Abatatafrita
# EOF

# $ssh -v -o StrictHostKeyChecking=no -T -i $key $user@$IP << EOF
# sudo mkdir -p /Abatatafrita
# EOF

# $ssh -v -x -i $key $user@$IP << EOF
# sudo mkdir -p /Abatatafrita
# EOF

# $ssh -v -o StrictHostKeyChecking=no -T -i $key $user@$IP "sudo mkdir -p /Abatatafrita"

$Rsync --progress \
    --rsync-path="sudo mkdir -p /Abatatafrita/ && sudo rsync" \
    -v \
    -az \
    --delete \
    --recursive \
    -e "$ssh -v -i $key" \
    "/data/asusbox/AppLog/" \
    $user@$IP:"/Abatatafrita/"

exit


--rsync-path="sudo sh -c 'mkdir -p /Abatatafrita && sudo rsync'" \


este comando sempre funcionou! mas agora estou parado nesta linha
debug1: Sending command: sudo mkdir -p /Abatatafrita && sudo rsync --server -vlogDtprze.iLsfxCIvu --delete . /Abatatafrita/



$sshpass -p $pass \

    -e $ssh -v \


#path="$( cd "${0%/*}" && pwd -P )"

path="/storage/DevMount/AndroidDEV/termux/files/home/_Work/hosts/"

/system/bin/busybox find "$path" -maxdepth 1 -type f -name "*.vps" | sort | while read fname; do
    Fileloop=`basename "$fname"`
    source "$fname"
    if [ ! "$key" == "" ]; then
        echo "############################################################################################"
        echo $Fileloop        
        echo "$user@$IP"
        echo "
        envia os arquivos para $HostName $IP
        "
        $Rsync --progress \
        --rsync-path="sudo mkdir -p /www/AsusboxTMP/data/asusboxA1/ && sudo rsync" \
        -az \
        --delete \
        --recursive \
        -e "$ssh -v -i $key" \
        "/storage/DevMount/GitHUB/asusbox/adm.3.Online/asusboxA1/" \
        $user@$IP:"/www/AsusboxTMP/data/asusboxA1/"
# executa os comandos no vps
$ssh -T -i $key $user@$IP << EOF
 #lsb_release -a
 "/www/AsusboxTMP/update.sh"
EOF
    else
        echo "############################################################################################"
        echo $Fileloop        
        echo "$user@$IP"
        echo "
        envia os arquivos para $HostName $IP
        "
        $sshpass -p $pass \
        $Rsync --progress \
        --rsync-path="sudo mkdir -p /www/AsusboxTMP/data/asusboxA1/ && sudo rsync" \
        -az \
        --delete \
        --recursive \
        -e $ssh -v \
        "/storage/DevMount/GitHUB/asusbox/adm.3.Online/asusboxA1/" \
        $user@$IP:"/www/AsusboxTMP/data/asusboxA1/"
# executa os comandos no vps
$sshpass -p $pass $ssh -T $user@$IP << EOF
 #lsb_release -a
 "/www/AsusboxTMP/update.sh"
EOF
    fi

# echo "/www/AsusboxTMP/update.sh" | $ssh -i $key $user@$IP
done

# --chown=www-data:www-data \ NÃO FUNCIONAAAAA SEI LA PQ ????
# --usermap=STRING         custom username mapping
# --groupmap=STRING        custom groupname mapping
# --chown=USER:GROUP       simple username/groupname mapping

echo "Upload do arquivo boot enviado com sucesso!"

