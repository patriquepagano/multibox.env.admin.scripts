#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear

Folder=".1730502400 = Developer"
group_name="Developer"

# Detecta dispositivos montados
mount | grep 'vold' | grep '/mnt/media_rw' | cut -d " " -f 3 | while read -r device; do
	echo "#################################################"
    echo "Path detectado > $device"
    echo "Procurando por token no root do device"

    # Caminho do arquivo de chave
    keyfile="$device/${group_name}.key"

    # Hash SHA-256 esperado (exemplo: hash de 64 caracteres)
    expected_sha256="b605e23608fc055ddb740f5c75d13792616ad9fcdc6993e40803a024132ecb03"

    # Verifica se o arquivo de chave existe
    if [ ! -f "$keyfile" ]; then
        echo "Arquivo de chave não encontrado."
        exit 1
    fi

    # Calcula o hash SHA-256 do arquivo de chave
    keyfile_sha256=$(sha256sum "$keyfile" | busybox awk '{print $1}')

    # Compara o hash SHA-256 com o esperado
    if [ "$keyfile_sha256" == "$expected_sha256" ]; then
        echo "Chave válida. Continuando execução do script..."
        # Coloque aqui as ações que o script executará
    else
        echo "Chave inválida. Acesso negado."
        #exit 1
    fi

done




if [ ! "$1" == "skip" ]; then
	echo "Press enter to continue."
	read bah
fi

