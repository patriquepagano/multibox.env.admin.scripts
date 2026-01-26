#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear

Folder=".1730428778 = Admin"
group_name="Admin"

mount | grep 'vold' | grep '/mnt/media_rw' | cut -d " " -f 3 | while read -r device; do
    echo "path detectado > $device"
    echo "procurando por token no root do device"
	cp "$path/$Folder/${group_name}_key_public.pem" "$device/"
	cp "$path/$Folder/${group_name}_private_Token" "$device/"
	cp "$path/$Folder/${group_name}_keyfile.sig" "$device/"
done






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

