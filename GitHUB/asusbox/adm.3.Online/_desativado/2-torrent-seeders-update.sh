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

# atualiza a pasta .install
# envia novo .install.torrent
# envia scripts vps
for loop in ${0%/*}/_functions/Servers/online/*.sh; do
    echo $loop
    source $loop
    UploadVPS
done

