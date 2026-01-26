#!/system/bin/sh
clear

export Rsync=/system/bin/rsync
export Rsync="/storage/DevMount/AndroidDEV/termux/files/usr/bin/rsync"
export ssh="/data/data/com.termux/files/usr/bin/ssh"
export sshpass="/data/data/com.termux/files/usr/bin/sshpass"

# copy inside .install pack to facilitate to vp's
file="/storage/DevMount/GitHUB/asusbox/adm.2.install/.install.torrent"
out="/storage/DevMount/asusbox/.install/.install.torrent"
$Rsync --progress -az --checksum $file $out

# upload torrent github
token="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"
file="/storage/DevMount/asusbox/.install/.install.torrent"
# buscar o valor atual
SHA=$(curl -H "Authorization: token $token" https://api.github.com/repos/nerdmin/a7/contents/.install.torrent | grep '"sha"' | cut -d '"' -f 4)
busybox base64 $file > $file.b64
CONTENT=$(cat $file.b64 | tr -d '\n')
JSON=$(echo '{"message": "Update torrent file", "content": "'$CONTENT'", "sha": "'$SHA'"}')
curl -X PUT -H "Authorization: token $token" \
     -H "Content-Type: application/json" \
     -d "$JSON" \
     https://api.github.com/repos/nerdmin/a7/contents/.install.torrent


path="/storage/DevMount/AndroidDEV/termux/files/home/_Work/hosts/"
/system/bin/busybox find "$path" -maxdepth 1 -type f -name "*.vps" | sort | while read fname; do
    Fileloop=`basename "$fname"`
    source "$fname"
    if [ ! "$key" == "" ]; then
# para o compartilhamento
$ssh -T -i $key $user@$IP << EOF
 "/usr/local/xsbin/.p2p/p2p-seed-stop.sh"
EOF
        echo "############################################################################################"
        echo $Fileloop        
        echo "$user@$IP"
        echo "
        envia os arquivos para $HostName $IP
        "
        # --checksum is tested! small use in cpu just one pike 80% no downside to use this.
        $Rsync --progress \
        --rsync-path="sudo mkdir -p /home/P2PShare/completed/.install && sudo rsync" \
        --chown=debian-transmission:debian-transmission \
        --chmod=777 \
        -az \
        --checksum \
        --delete \
        --recursive \
        -e "$ssh -i $key" \
        "/storage/DevMount/asusbox/.install/" \
        $user@$IP:"/home/P2PShare/completed/.install/"
# call script from server
$ssh -T -i $key $user@$IP << EOF
 "/usr/local/xsbin/.p2p/p2p-seed-start.sh"
EOF
    else
$sshpass -p $pass $ssh -T $user@$IP << EOF
 "/usr/local/xsbin/.p2p/p2p-seed-stop.sh"
EOF
        echo "############################################################################################"
        echo $Fileloop        
        echo "$user@$IP"
        echo "
        envia os arquivos para $HostName $IP
        "
        $sshpass -p $pass \
        $Rsync --progress \
        --rsync-path="sudo mkdir -p /home/P2PShare/completed/.install/ && sudo rsync" \
        --chown=debian-transmission:debian-transmission \
        --chmod=777 \
        -az \
        --checksum \
        --delete \
        --recursive \
        -e $ssh \
        "/storage/DevMount/asusbox/.install/" \
        $user@$IP:"/home/P2PShare/completed/.install/"
# call script from server
$sshpass -p $pass $ssh -T $user@$IP << EOF
 "/usr/local/xsbin/.p2p/p2p-seed-start.sh"
EOF
    fi

done

echo "Upload da pasta torrent Pack concluida com sucesso!"



# Normally, rsync skips files when the files have identical sizes and times on the source and destination sides. 
# This is a heuristic which is usually a good idea, as it prevents rsync from having to examine the contents of 
# files that are very likely identical on the source and destination sides.

# --ignore-times tells rsync to turn off the file-times-and-sizes heuristic, and thus unconditionally 
# transfer ALL files from source to destination. rsync will then proceed to read every file on the source 
# side, since it will need to either use its delta-transfer algorithm, or simply send every file in its 
# entirety, depending on whether the --whole-file option was specified.

# --checksum also modifies the file-times-and-sizes heuristic, but here it ignores times and examines 
# only sizes. Files on the source and destination sides that differ in size are transferred, since 
# they are obviously different. Files with the same size are checksummed (with MD5 in rsync 
# version 3.0.0+, or with MD4 in earlier versions), and those found to have differing sums are also transferred.

# In cases where the source and destination sides are mostly the same, --checksum will result in most files
# being checksummed on both sides. This could take long time, but the upshot is that the barest minimum of 
# data will actually be transferred over the wire, especially if the delta-transfer algorithm is used. Of 
# course, this is only a win if you have very slow networks, and/or very fast CPU.

# --ignore-times, on the other hand, will send more data over the network, and it will cause all source 
# files to be read, but at least it will not impose the additional burden of computing many 
# cryptographically-strong hashsums on the source and destination CPUs. I would expect this option to 
# perform better than --checksum when your networks are fast, and/or your CPU relatively slow.

# I think I would only ever use --checksum or --ignore-times if I were transferring files to a destination 
# where it was suspected that the contents of some files were corrupted, but whose modification times were 
# not changed. I can't really think of any other good reason to use either option, although there are probably 
# other use-cases.