#!/system/bin/sh

# digitar no cel   bash ./tb.sh
CPU=`getprop ro.product.cpu.abi`

pkg update -y
pkg install lftp pure-ftpd imagemagick -y
