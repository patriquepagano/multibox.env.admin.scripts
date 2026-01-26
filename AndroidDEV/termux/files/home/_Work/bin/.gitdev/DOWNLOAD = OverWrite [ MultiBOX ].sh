#!/system/bin/sh

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
cd "$path"

REPO_NAME="MultiBOX TVBox Code"

# Mensagem de alerta
echo "ATENÇÃO: DOWNLOAD do repo "$REPO_NAME"

Tudo que estiver no Destino > $path
sera sobreescrito!!!

Digite sim para continuar 
ou esc para cancelar
"
# Leitura da entrada do usuário
read input
if [[ "$input" == "sim" ]]; then
    BRANCH=main  # ou outra branch
    git fetch origin
    git reset --hard origin/$BRANCH
    git clean -fd
fi

echo "
Done! Completed!
"
