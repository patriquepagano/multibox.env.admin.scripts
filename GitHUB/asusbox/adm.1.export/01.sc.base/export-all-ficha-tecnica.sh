#!/data/data/com.termux/files/usr/bin/env /data/data/com.termux/files/usr/bin/bash
#

SECONDS=0

path=$(dirname $0)

/system/bin/busybox find "$path" -maxdepth 1 -type f -name "00*.sh" | sort | while read fname; do
    FileName=`basename $fname`
    echo $fname
    chmod 755 $fname
    $fname
done


# monstra a contagem final de tempo 
duration=$SECONDS
echo "<h3>$(($duration / 60)) minutos e $(($duration % 60)) segundos para concluir inicialização e atualização completa.</h3>"



