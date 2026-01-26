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


# https://stackoverflow.com/questions/48414127/gitignore-with-wildcards-for-filenames
# limpando do repositorio local e online para depois ignorar de fato
git rm --cached "AndroidDEV/termux/files/home/.bash_history"
git rm --cached "AndroidDEV/termux/files/home/4Android"
git rm --cached "AndroidDEV/termux/files/home/_Work/bin/.apps/aapt apps lists.txt"


# Lista os arquivos modificado
git status 

git stash clear

