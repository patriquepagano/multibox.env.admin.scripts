#!/system/bin/sh
clear
path=$( cd "${0%/*}" && pwd -P )

busybox ps -o user,pid,args | busybox sort -k1,1 > "$path/LOG - Listar users apps em uso.log"

cat "$path/LOG - Listar users apps em uso.log"

read bah
