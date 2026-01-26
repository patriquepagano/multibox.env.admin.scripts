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

# Lista os arquivos modificado
git status
git pull


echo ""
echo "Digita um lembrete para o git push"
read input
git add .   # track all files 
git add -u  # track all deleted files
git commit -m "$input"
git push --force


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




