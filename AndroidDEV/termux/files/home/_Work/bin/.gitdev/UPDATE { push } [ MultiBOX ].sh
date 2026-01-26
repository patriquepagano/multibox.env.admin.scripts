#!/system/bin/sh

# não vale a pena este lance do acl pois toda vez que transfere do pc para box retransmite tudo de novo
# echo "Salvando as preferencias de permissoes para pc nao bagunçar tudo"
# aclget

#unset PATH
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin
#unset LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib
# need for download from git
export GIT_SSH_COMMAND="/data/data/com.termux/files/usr/bin/ssh"

DIR=$(dirname $0)

# path=`echo $DIR | /system/bin/busybox sed 's;/adm.0.git;;g'`
# path"/storage/DevMount/GitHUB/asusbox" # não funciona não me lembro pq???
path="/storage/DevMount"
HOME="$path"
cd $path

# # fix de um bug novo
# /system/bin/busybox mount -o remount,rw /system
# ln -sf /data/data/com.termux/files/usr/lib/libz.so.1.2.11 /system/lib/libz.so.1

# +99000k = 99 mega


check=`/system/bin/busybox find "/storage/DevMount/AndroidDEV/termux/files/home/" -type f -size +99000k`
if [ ! "$check" == "" ]; then
echo "HOME = Atenção! 
existem arquivos maiores que o limite do upload do github
O git push não sera efetivado.
confira os arquivos abaixo"
echo "
$check
"
echo "Done!"
read bah
exit
fi

# Lista os arquivos modificados
git status

# Traz atualizações do branch remoto e verifica se houve conflitos
echo "Atualizando o branch local com o remoto..."
git pull
if [[ $? -ne 0 ]]; then
    echo "Conflitos detectados durante o pull. Resolva-os antes de continuar."
    read bah
    exit 1
fi

echo ""
echo "Digite uma mensagem de commit:"
read input

# Adiciona todas as mudanças (adições, modificações e exclusões)
git add -A  

# Realiza o commit com a mensagem fornecida
git commit -m "$input"

# Envia as mudanças para o repositório remoto
git push


echo "
Done! Completed!
"


# # gera as configs
# git config --global user.email "asusbox-generator@admin.com"
# git config --global user.name "admin asusbox"

# # # grava os ultimos commit log
# # path=$(dirname $0)
# # echo "GitLog gerado pelo script push, ultimo commit não esta aqui" > $path/commit.log
# # git log >> $path/commit.log




