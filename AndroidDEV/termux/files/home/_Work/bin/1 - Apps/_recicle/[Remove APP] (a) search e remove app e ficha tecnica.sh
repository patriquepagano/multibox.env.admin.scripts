#!/system/bin/sh
clear

echo "Abra o app que vc quer remover para captar seu nome fake e real
assim que o app estiver na tela pressione qlq tecla para continuar."
read bah


OnScreenNow=`dumpsys window windows | grep mCurrentFocus | cut -d " " -f 5 | cut -d "/" -f 1`
aapt="/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/bin's/aapt"
/system/bin/busybox find "/data/app/" -type d -name "$OnScreenNow*" \
| while read Folder; do
    echo "ADM DEBUG ########################################################"    
    echo "ADM DEBUG ### $Folder " 
    requestData=`$aapt dump badging "$Folder/base.apk"`
    echo -n "$requestData" > /data/local/tmp/aapt.txt
done

requestData=`busybox cat /data/local/tmp/aapt.txt`
FakeName=`echo "$requestData" | grep "application-label:" | cut -d "'" -f 2 | cut -d "'" -f 1`
PackageName=`echo "$requestData" | grep 'package: name=' | cut -d "'" -f 2 | cut -d "'" -f 1`
PackageVersion=`echo "$requestData" | grep 'versionName=' | cut -d "'" -f 6 | cut -d "'" -f 1`
echo "ADM DEBUG ### Procure pela ficha tecnica do app {$FakeName} [$PackageName] ($PackageVersion)"
echo "ADM DEBUG ### Vou fechar o app {$FakeName} [$PackageName]"

if [ "$PackageName" == "" ]; then
    echo "Erro tente novamente"
    exit
fi

echo "
Etapas da remoção de um app:

1) MOVER a ficha tecnica do export {$FakeName} [$PackageName]
2) Desistalar o app = [$PackageName]

TEM CERTEZA QUE DESEJA PROSSEGUIR? AS TAREFAS ACIMA SERÃO EXECUTADAS.
"
read bah

am force-stop $OnScreenNow

folder="/storage/DevMount/GitHUB/asusbox/adm.1.export"
/system/bin/busybox find "$folder/05.akp.cl" -maxdepth 1 -type f -name "*$PackageName*" | while read fname; do
    if [ "$fname" == "" ]; then
        echo "Erro tente novamente"
        exit
    fi
    echo "Achei a ficha técnica > $fname"
    /system/bin/busybox mv "$fname" "/storage/DevMount/GitHUB/asusbox/adm.1.export/Remover-APPS/"
done

pm clear $PackageName
pm uninstall $PackageName



