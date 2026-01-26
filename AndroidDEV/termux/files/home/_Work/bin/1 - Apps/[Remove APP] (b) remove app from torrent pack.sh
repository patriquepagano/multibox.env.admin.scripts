#!/system/bin/sh
clear


echo "* * * * * * * Atenção!
Este script remove: 
1) fichas tecnicas que geram os script master da pasta > Remover-APPS
2) pacote p2p do app

para o trabalho feito não ser apagado em reboots:
1) stop all services
2) remove o boot online de atualização (corrigir o path nao ta funcionando)

pressione enter para continuar.
"

read bha
"/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/Services ( STOP )/1 STOP ALL HERE !!!.sh"
#"/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.devbox/remove Asusbox boot updatesystem.sh"

while true
do
    echo "ADM DEBUG ########################################################"
    killPort=`busybox netstat -ntlup | grep 9091`    
    echo "ADM DEBUG ### porta ativa do torrent > $killPort "
	if [ ! "$killPort" == "" ]; then
        echo "Desligando transmission torrent downloader"
        /system/bin/transmission-remote --exit
        killall transmission-daemon
        logcat -c
    else
        break
    fi
done


# listar os apps a remover
# [] precisa de log dos apps e packs de cada coisa para saber oque remover

# preciso localizar manualmente qual é o apk para remover, dar um am force-stop para ter certeza

log=`busybox du -hs /storage/DevMount/asusbox/.install`
echo "Tamanho total da pasta .install com apps
$log
"

folder="/storage/DevMount/GitHUB/asusbox/adm.1.export/Remover-APPS/"

/system/bin/busybox find "$folder" -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do

echo "Apagando as entradas de variaveis da ficha tecnica:
$fname

"

busybox sed -i -e  's;.*source "$DIR/_functions/generate.sh";;g' "$fname"
busybox sed -i -e  's;.*source "$DIR/_functions/allFunctions.sh";;g' "$fname"
busybox sed -i -e  's;SCRIPT.*;;g' "$fname"
busybox sed -i -e  's;compressAPK.*;;g' "$fname"
busybox sed -i -e  's;compressAPKDataFull.*;;g' "$fname"
busybox sed -i -e  's;exportDTF.*;;g' "$fname"
busybox sed -i -e  's;exportAKP.*;;g' "$fname"
busybox sed -i -e  's;RenameExportDataFile.*;;g' "$fname"



echo "carregando ficha técnica"
source "$fname"


if [ -d /data/data/$app ]; then
echo "desistalando o app"
echo removendo o $app
pm clear $app
pm uninstall $app
fi


/system/bin/busybox find "/storage/DevMount/GitHUB/asusbox/adm.2.install/"\
 -type f -name "*$apkName*" \
 | sort | while read flist; do
echo "removendo a ficha tecnica do install $flist"
rm "$flist"
done

if [ -d $path/$apkName ]; then
log=`busybox du -hs $path/$apkName`
echo "pacote p2p do $app localizado, removendo.
busybox rm -rf \"$path/$apkName\"
$log
"
busybox rm -rf "$path/$apkName"
fi

if [ ! -d $path/$apkName ]; then
echo "limpeza concluida do $app
vou renomear a ficha tecnica"
mv "$fname" "$fname.removido"
fi
#sleep 900999

done

log=`busybox du -hs /storage/asusboxUpdate/asusbox/.install`
echo "Tamanho total da pasta .install com apps removidos
$log
"



read bah

