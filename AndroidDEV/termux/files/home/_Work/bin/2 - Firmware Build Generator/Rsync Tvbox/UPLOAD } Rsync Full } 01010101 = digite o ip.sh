#!/system/bin/sh
clear


echo "Digite o final do octeto os 3 ultimos digitos da box que deseja conectar?
ex: 110 = 10.0.0.110
e pressione enter"
read bah
IP="10.0.0.$bah"

path=$( cd "${0%/*}" && pwd -P )
source "$path/function rsync upload to storage DevMount.SH"
