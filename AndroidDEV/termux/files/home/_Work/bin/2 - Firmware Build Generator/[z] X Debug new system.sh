#!/system/bin/sh
clear

export Rsync=/system/bin/rsync
export Rsync="/storage/DevMount/AndroidDEV/termux/files/usr/bin/rsync"
export ssh="/data/data/com.termux/files/usr/bin/ssh"
export sshpass="/data/data/com.termux/files/usr/bin/sshpass"

#path="$( cd "${0%/*}" && pwd -P )"
# no dia 10/10/2023 simplesmente o rsync não conseguia fazer comandos sudo em 3 maquinas linode o problema era na linode e nao no teu codigo


$Rsync --progress \
-az \
--delete \
--recursive \
"/storage/DevMount/GitHUB/asusbox/adm.3.Online/asusboxA1/" \
"/storage/DevMount/RsyncFolder/piratebox/www/distros/A7/"


tag="Cloud"
group="Linode"
HostName="asusbox-a1"
ext="vps"
user="gambatte"
IP="66.175.210.64"
homeDev="/root/"
key="~/_Work/_keys/digitalOcean/id_rsa"
port="22"


# echo "
# envia os arquivos para $HostName $IP
# "
# $Rsync --progress \
# --rsync-path="sudo mkdir -p /RsyncFolder && sudo rsync" \
# -az \
# --delete \
# --recursive \
# -e "$ssh -v -i $key" \
# "/storage/DevMount/RsyncFolder/" \
# $user@$IP:"/RsyncFolder/"



pass="admger9pqt"
user=gambatte
IP="10.0.0.7"
port=22

# keyscan="/data/data/com.termux/files/usr/bin/ssh-keyscan"
# sshpass="/data/data/com.termux/files/usr/bin/sshpass"
# ssh="/data/data/com.termux/files/usr/bin/ssh"
# $keyscan -p $port $IP >> $HOME/.ssh/known_hosts



$sshpass -p $pass \
$Rsync --progress \
--rsync-path="sudo mkdir -p /RsyncFolder && sudo rsync" \
-az \
--delete \
--recursive \
--chmod=Du=rwx,Dg=rx,Do=rx,Fu=rw,Fg=r,Fo=r \
-e $ssh -v \
"/storage/DevMount/RsyncFolder/" \
$user@$IP:"/RsyncFolder/"


# executa os comandos no vps
$sshpass -p $pass $ssh -T $user@$IP << EOF
#lsb_release -a
sudo sh "/RsyncFolder/LinuxScript.sh"
EOF















# se arquivos são para rodarem em box fica na box, debuga e envia direto
# vps fica com o código linux nativo
# arquivos são enviados como sudo o root é dono
# [] precisa enviar os arquivos para diretorio temporario e executar um script para update local é mais seguro para dar um reload no webservice


# # executa os comandos no vps
# $ssh -T -i $key $user@$IP << EOF
#  #lsb_release -a
#  "/RsyncFolder/LinuxScript.sh"
# EOF



