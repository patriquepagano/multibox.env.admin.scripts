#!/data/data/com.termux/files/usr/bin/env /data/data/com.termux/files/usr/bin/bash
#

# fazer este script screver um módulo de desativação das launchers

SECONDS=0

path=$(dirname $0)

rm $path/*.txt

/system/bin/busybox find "$path" -maxdepth 1 -type f -name "ac.*.sh"| sort | while read fname; do
    app=`cat $fname | grep "app=" | cut -d '"' -f 2`
    LauncherIntegrated=`cat $fname | grep "LauncherIntegrated=" | cut -d '"' -f 2`
    echo $app
    echo $app >> $path/AKPList.txt

    if [ "$LauncherIntegrated" == "yes" ]; then
        echo $app >> $path/AKPListLauncherIntegrated.txt
    fi
    #$fname
done


# monstra a contagem final de tempo 
duration=$SECONDS
echo "<h3>$(($duration / 60)) minutos e $(($duration % 60)) segundos para concluir inicialização e atualização completa.</h3>" 



