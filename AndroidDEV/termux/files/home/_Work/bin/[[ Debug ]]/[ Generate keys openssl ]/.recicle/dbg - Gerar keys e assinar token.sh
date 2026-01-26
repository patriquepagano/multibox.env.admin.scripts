#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear

# Pergunta o nome do grupo
echo "Digite o nome do grupo para gerar as chaves: " 

read group_name

F="$(date +%s)"

mkdir -p "$path/.$F = ${group_name}"

# Gera uma chave privada
openssl genpkey -algorithm RSA -out "$path/.$F = ${group_name}/${group_name}_key.pem" -pkeyopt rsa_keygen_bits:2048

# Extrai a chave pública da chave privada
openssl rsa -pubout -in "$path/.$F = ${group_name}/${group_name}_key.pem" -out "$path/.$F = ${group_name}/${group_name}_key_public.pem"

# Gera um arquivo `keyfile` com conteúdo aleatório
openssl rand -out "$path/.$F = ${group_name}/${group_name}_private_Token" 256

# Assina o arquivo `keyfile` usando a chave privada
openssl dgst -sha256 -sign "$path/.$F = ${group_name}/${group_name}_key.pem" -out "$path/.$F = ${group_name}/${group_name}_keyfile.sig" "$path/.$F = ${group_name}/${group_name}_private_Token"

echo "Chaves e token para o grupo '$group_name' foram gerados com sucesso!"

echo "
Quais Arquivos Compartilhar
Compartilhe com os clientes:
${group_name}_key_public.pem
${group_name}_private_Token
${group_name}_keyfile.sig

Guarde com você (em segurança):
${group_name}_key.pem

Como os Clientes Usam os Arquivos:
	O cliente possui o key_public.pem, private_Token e keyfile.sig.
No seu script de execução, o cliente pode verificar a assinatura 
usando o key_public.pem e keyfile.sig para garantir que o private_Token não foi modificado.
O private_Token será verificado pelo script (usando o hash, por exemplo), 
permitindo a execução se tudo estiver válido.

"

if [ ! "$1" == "skip" ]; then
	echo "Press enter to continue."
	read bah
	# come back to menu
	path=$( cd "${0%/*}" && pwd -P )
	cd $path
	x
fi

