#!/system/bin/sh
CPU=`getprop ro.product.cpu.abi`
DIR=$(dirname $0)

source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin
#unset LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib
export ssh="/data/data/com.termux/files/usr/bin/ssh"
export rsync="/data/data/com.termux/files/usr/bin/rsync"

clear
echo "############################################################################"
echo " Atenção!!! não tem volta. ao continuar os arquivos serão publicados"
echo " Todas as box que ligarem vão receber os novos arquivos"
echo " Pressione qlq tecla para continuar"
echo "############################################################################"
echo ""
read input

# atualiza os torrents na distribuição
# atualiza o boot.sh na distribuição
for loop in ${0%/*}/_functions/Servers/online/*.sh; do
    echo $loop
    source $loop
    Update_publish
done


