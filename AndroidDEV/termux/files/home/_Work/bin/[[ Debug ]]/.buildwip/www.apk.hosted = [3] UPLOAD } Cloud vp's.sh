#!/system/bin/sh
clear

export Rsync=/system/bin/rsync
export Rsync="/storage/DevMount/AndroidDEV/termux/files/usr/bin/rsync"
export ssh="/data/data/com.termux/files/usr/bin/ssh"
export sshpass="/data/data/com.termux/files/usr/bin/sshpass"

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
        --rsync-path="sudo mkdir -p /www/AsusboxTMP/www/hostFiles/ && sudo rsync" \
        -az \
        --delete \
        --recursive \
        -e "$ssh -i $key" \
        "/storage/DevMount/4Android/App/www.apk.hosted/" \
        $user@$IP:"/www/AsusboxTMP/www/hostFiles/"
    else
        echo "############################################################################################"
        echo $Fileloop        
        echo "$user@$IP"
        echo "
        envia os arquivos para $HostName $IP
        "
        $sshpass -p $pass \
        $Rsync --progress \
        --rsync-path="sudo mkdir -p /www/AsusboxTMP/www/hostFiles/ && sudo rsync" \
        -az \
        --delete \
        --recursive \
        -e $ssh \
        "/storage/DevMount/4Android/App/www.apk.hosted/" \
        $user@$IP:"/www/AsusboxTMP/www/hostFiles/"
    fi

# echo "/www/AsusboxTMP/update.sh" | $ssh -i $key $user@$IP
done

# --chown=www-data:www-data \ NÃO FUNCIONAAAAA SEI LA PQ ????
# --usermap=STRING         custom username mapping
# --groupmap=STRING        custom groupname mapping
# --chown=USER:GROUP       simple username/groupname mapping

echo "Upload dos arquivos enviado com sucesso!"
cd "/storage/DevMount/4Android/App/www.apk.hosted/"
lx
