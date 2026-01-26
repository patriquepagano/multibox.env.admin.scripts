#!/system/bin/sh
clear
path="$( cd "${0%/*}" && pwd -P )"
echo $path

ssh="/data/data/com.termux/files/usr/bin/ssh"
keyscan="/data/data/com.termux/files/usr/bin/ssh-keyscan"
sshpass="/data/data/com.termux/files/usr/bin/sshpass"
Rsync="/data/data/com.termux/files/usr/bin/rsync"
IP="10.0.0.91"
port="22"
user="gambatte"
pass="admger9pqt"

# sincronizando novas fichas tecnicas
$sshpass -p $pass \
$Rsync --progress \
-avz \
--include '*.vps' \
--include '*Rpi*' \
--exclude '*' \
--delete \
--recursive \
-e $ssh \
$user@$IP:/home/gambatte/.local/bin/_hosts/ \
"$HOME/_Work/hosts/"

function WriteSSHFingerprint () {
# clean file IP
file="$HOME/.ssh/known_hosts"
check=`cat $file | grep -v "$IP"`
if [ ! "$check" == "" ]; then
    cat $file | grep -v "$IP" > $file-tmp
    mv $file-tmp $file
    # cat $file
    # exit
fi
SshFingerPrint=`$keyscan -p $port $IP`
if [ $? -eq 0 ]; then
    echo "add $HostName $IP"
    echo "#### START $IP $tag $group $HostName.$ext User=$user" >> $HOME/.ssh/known_hosts
    #sed -i -e "s;.*$IP.*;;g" $HOME/.ssh/known_hosts
    #sed -i -e '/^\s*$/d' $HOME/.ssh/known_hosts # remove novas linhas
    echo "$SshFingerPrint" >> $HOME/.ssh/known_hosts
    echo "########################################################################### $IP END #" >> $HOME/.ssh/known_hosts
fi
}


/system/bin/busybox find "$HOME/_Work/hosts/" -maxdepth 1 \
-type f -name "*" \
! -name "*.tar.gz" \
! -name "*.zip" \
! -name "*.sh" \
! -name "*.directory" \
! -name "*.added" \
| sort | while read fname; do
    Fileloop=`basename "$fname"`

source "$fname"
if [ ! "$IP" == "" ]; then
    # renomeia a ficha técnica
    file="$HOME/_Work/hosts/$tag ($group) [$IP] {$HostName}.$ext"
    if [ ! -f "$file" ]; then
        mv "$fname" "$file"
        Fileloop=`basename "$file"`
        fname="$HOME/_Work/hosts/$tag ($group) [$IP] {$HostName}.$ext"
    fi
fi

WriteSSHFingerprint

# final do loop limpa a var do IP para não dar erro proximo loop
IP=""
done

clear
cat $HOME/.ssh/known_hosts

