#!/system/bin/sh

#unset PATH
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin
#unset LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib
# need for download from git
export GIT_SSH_COMMAND="/data/data/com.termux/files/usr/bin/ssh"

DIR=$(dirname $0)


# chaves do artscris.com.br

#!/bin/bash
mkdir  ~/.ssh
cat << EOF >  ~/.ssh/id_rsa
-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----
EOF

cat << EOF >  ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDP+i7Dyth4hfUjrYZXvwbui3xyEHqtqaEKVY/NeBSvMQPkm6PiSlojiQKJIOxMnOuI+1lkztjkKykPsE6/zprQMfaEZoj89HMusHLE53hxvsMRSfM7SFJ2cF+jMVaUDbTSGF5Z6Nbou9gVBscLTaIij0+nKOjVnCGcHeX9KSm+n1G/XbfogSK3wl9OSbf8sNL+7nuq7JYAwDJgymZui4z5jK2UA9C38ZWq+ObNEYfQxUWYAlNwdY7niqvKzFDZDHZlWV9n9k5BagP2W/9SR4HT8HW2KPfvw/znbAj04htL4jmsiLCJYjAO89LGKJAWbPh4UADVjIOTw2DtmTzBT8il0EfdrkLI2A6aRTqiIbJOJdpMGPHJpXsgogME+3cFm3tFaD4iXvbCv4VF6xlOqJjvqIaC/bni50ken7ke9ZwxheK2ZaGQV3hF3LqO3ijtKVGb+kxHR4RNDMPrRZ5cY6W1r1hnllifv+7d8sbQYnPV54pXqhMTkZMIWwxvPMteS7qGI9TT9hc4iwWx/+4vkatMwQyYQrPhhqKZ8/t/KBBGhVcR+yWbL7rLczeVJP0+txQKMlrhewAumAkLC3j65AnD4WubFTI+PVvdRq5mR9lw3/GBhbdZr1CK2pjk5Z3RPqkQVySSsEug2+eeaRHiRKHnsZpd9zsyevhaYUlbHzY8Mw== meu-email@gmail.com
EOF
chmod 700  ~/.ssh
chmod 600  ~/.ssh/id_rsa
chmod 644  ~/.ssh/id_rsa.pub
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
# Start the ssh-agent in the background.
#   eval "$(ssh-agent -s)"
# Add your SSH private key to the ssh-agent.
#   ssh-add ~/.ssh/id_rsa

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


read bah
exit




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


