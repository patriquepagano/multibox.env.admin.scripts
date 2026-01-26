#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear

Folder=".1730428778 = Admin"
group_name="Admin"

# Detecta dispositivos montados
mount | grep 'vold' | grep '/mnt/media_rw' | cut -d " " -f 3 | while read -r device; do
	echo "#################################################"
    echo "Path detectado > $device"
    echo "Procurando por token no root do device"
    # Caminho para o arquivo de chave pública e arquivos de verificação
    keyfile="$device/${group_name}_private_Token"
    signature="$device/${group_name}_keyfile.sig"
    public_key="$device/${group_name}_key_public.pem"

    # Verifica se todos os três arquivos existem
    if [[ -f "$keyfile" && -f "$signature" && -f "$public_key" ]]; then
        # Verifica a assinatura do keyfile
        if openssl dgst -sha256 -verify "$public_key" -signature "$signature" "$keyfile"; then
            echo "Assinatura válida. Continuando execução do script..."
            # Coloque aqui as ações que o script executará
        fi
    fi

done


if [ ! "$1" == "skip" ]; then
	echo "Press enter to continue."
	read bah
fi

