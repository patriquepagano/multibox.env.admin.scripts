#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear

export Rsync=/system/bin/rsync
export Rsync="/storage/DevMount/AndroidDEV/termux/files/usr/bin/rsync"
export ssh="/data/data/com.termux/files/usr/bin/ssh"
export sshpass="/data/data/com.termux/files/usr/bin/sshpass"

#path="$( cd "${0%/*}" && pwd -P )"

# no dia 10/10/2023 simplesmente o rsync não conseguia fazer comandos sudo em 3 maquinas linode o problema era na linode e nao no teu codigo

# upload boot github
token="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"
file="/storage/DevMount/GitHUB/asusbox/adm.3.Online/asusboxA1/boot/armeabi-v7a/UpdateSystem.sh"
# Buscar o valor atual do sha
SHA=$(curl -H "Authorization: token $token" https://api.github.com/repos/nerdmin/a7/contents/armeabi-v7a_UpdateSystem.sh | grep '"sha"' | cut -d '"' -f 4)
# Codificar o arquivo em Base64
busybox base64 $file > $file.b64
# Remover quebras de linha no conteúdo Base64
CONTENT=$(cat $file.b64 | tr -d '\n')
# Criar o JSON manualmente e armazenar em um arquivo temporário
echo '{"message": "Update boot file", "content": "'"$CONTENT"'", "sha": "'"$SHA"'"}' > "$path/json_payload.txt"
# Fazer o upload usando curl com o arquivo de payload
curl -X PUT -H "Authorization: token $token" \
     -H "Content-Type: application/json" \
     -d "@$path/json_payload.txt" \
     https://api.github.com/repos/nerdmin/a7/contents/armeabi-v7a_UpdateSystem.sh
rm "$path/json_payload.txt"

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

read bah