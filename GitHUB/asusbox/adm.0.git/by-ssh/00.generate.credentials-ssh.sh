#!/system/bin/sh


# para gerar o id_rsa é necessario fixar o path home em vez do asusbox
HOME=/data/data/com.termux/files/home

# need for download from git
export GIT_SSH_COMMAND="/data/data/com.termux/files/usr/bin/ssh"


# precisa gerar um rsa unico para cada git repository
/data/data/com.termux/files/usr/bin/ssh-keygen -t rsa -b 4096 -C "debugtvbox@gmail.com"



