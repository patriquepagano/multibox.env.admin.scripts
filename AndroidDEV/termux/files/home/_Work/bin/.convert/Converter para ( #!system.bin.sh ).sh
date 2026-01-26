#!/system/bin/sh
clear
path=$var

find $path -type f -name "*.sh" ! -name "Converter para ( #!system.bin.sh ).sh" | sort |while read fname; do
    cat "$fname" | grep "#!/bin/bash"
    sed -i -e 's;#!/bin/bash;#!/system/bin/sh;g' "$fname"
done

