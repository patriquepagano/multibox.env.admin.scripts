#!/system/bin/sh

#unset PATH
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin
#unset LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib
# need for download from git
export GIT_SSH_COMMAND="/data/data/com.termux/files/usr/bin/ssh"

DIR=$(dirname $0)



#!/bin/bash
mkdir  ~/.ssh
cat << EOF >  ~/.ssh/github
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACCgOGonCC4NXowi6jj5w4+vyOA7VABboAYcKXt7ynUOqgAAAKB8lwKwfJcC
sAAAAAtzc2gtZWQyNTUxOQAAACCgOGonCC4NXowi6jj5w4+vyOA7VABboAYcKXt7ynUOqg
AAAEAELhLYGoT177WSQuDYQNDpOszEIT5V9o87TyP5j0NEIaA4aicILg1ejCLqOPnDj6/I
4DtUAFugBhwpe3vKdQ6qAAAAGmdhbWJhdHRlQGxhbi1ub3RlYWNlcm5pdHJvAQID
-----END OPENSSH PRIVATE KEY-----
EOF

cat << EOF >  ~/.ssh/github.pub
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKA4aicILg1ejCLqOPnDj6/I4DtUAFugBhwpe3vKdQ6q gambatte@lan-noteacernitro
EOF
chmod 700  ~/.ssh
chmod 600  ~/.ssh/github
chmod 644  ~/.ssh/github.pub



touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
# Start the ssh-agent in the background.
#   eval "$(ssh-agent -s)"
# Add your SSH private key to the ssh-agent.
#   ssh-add ~/.ssh/id_rsa



read bah
exit





# copiar a key para o github
clear
echo ""
echo "copiar a key para o github"
cat ~/.ssh/id_rsa.pub



mkdir  ~/.ssh
cat << EOF >  ~/.ssh/known_hosts
|1|uRnCHCm90uqz445yKjhLGC49z4I=|ILc36Hrr8sKjVaQhgexIIXl5ssU= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==
|1|kPqBbHEiqtj4vZyGwL+MJb+L4Ig=|1TmwUrgWrKk3PlYvj3KEm54KcYk= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==
EOF

chmod 664  ~/.ssh/known_hosts

# path=`echo $DIR | /system/bin/busybox sed 's;/adm.0.git;;g'`
# path"/storage/DevMount/GitHUB/asusbox" # não funciona não me lembro pq???
path="/storage/DevMount"
HOME="$path"
cd $path






# unica maneira que deu certo.
# criei o repo online primeiro
# executei este comando na pasta corrente
echo "# MultiBOX" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:patriquepagano/MultiBOX.git
git push -u origin main











# # isto não funcionou para minha solução criou uma pasta no root da pasta corrente
# echo "clonando via acesso ssh"
# git clone git@github.com:patriquepagano/MultiBOX.git .















#https://www.shellhacks.com/git-config-username-password-store-credentials/


# # limpando a build do qrcode
# rm $path/www/.code/qrcode/*.txt
# rm -rf $path/www/.code/qrcode/temp


# # fix de um bug novo
# /system/bin/busybox mount -o remount,rw /system
# ln -sf /data/data/com.termux/files/usr/lib/libz.so.1.2.11 /system/lib/libz.so.1



# gera as configs
git config --global user.email "asusbox-generator@admin.com"
git config --global user.name "admin asusbox"

# # grava os ultimos commit log
# path=$(dirname $0)
# echo "GitLog gerado pelo script push, ultimo commit não esta aqui" > $path/commit.log
# git log >> $path/commit.log



echo "# MultiBOX" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/patriquepagano/MultiBOX.git
git push -u origin main


pause
exit

…or create a new repository on the command line

echo "# MultiBOX" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/patriquepagano/MultiBOX.git
git push -u origin main

…or push an existing repository from the command line

git remote add origin https://github.com/patriquepagano/MultiBOX.git
git branch -M main
git push -u origin main


git pull


# Lista os arquivos modificado
git status 










echo "listar arquivos maior que 99mb"
/system/bin/busybox find . -type f -size +99000k
echo ""

echo ""
echo "Digita um lembrete para o git push"
read input
git add .   # track all files 
git add -u  # track all deleted files
git commit -m "$input"
git push


