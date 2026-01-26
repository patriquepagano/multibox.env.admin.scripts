#!/system/bin/sh

rm -rf /data/data/com.termux

Dir=$(dirname $0)
#unset PATH
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin
#unset LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib

node -v

node $Dir/app.js

env

