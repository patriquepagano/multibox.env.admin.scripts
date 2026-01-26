#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear

echo "
Atenção: isto vai apagar a chave antiga!
Todos os scripts assinados pela chave anterior não funcionarão!

Digite 'YES' para confirmar e continuar, ou qualquer outra tecla para cancelar.
"

read choice

if [[ "$choice" == "YES" ]]; then
    echo "Procedendo com a exclusão da chave antiga..."
	rm -rf "$path/Key"
else
    echo "Operação cancelada."
	sleep 2
    exit 1
fi

mkdir -p "$path/Key"

# Gera uma chave privada
openssl genpkey -algorithm RSA -out "$path/Key/private_key.pem" -pkeyopt rsa_keygen_bits:4048

# Extrai a chave pública da chave privada
openssl rsa -pubout -in "$path/Key/private_key.pem" -out "$path/Key/public_key.pem"

# Gera o hash da chave pública "hash de verificação" da chave pública
hash=$(openssl dgst -sha256 < "$path/Key/public_key.pem" | busybox awk '{print $2}')
echo -n "$hash" > "$path/Key/public_key.hash"


if [ ! "$1" == "skip" ]; then
	echo "Press enter to continue."
	read bah
fi


