#!/system/bin/sh
clear
"/storage/DevMount/GitHUB/asusbox/adm.debugs/kill/kill-UpdateSystem.sh"
"/storage/DevMount/GitHUB/asusbox/adm.debugs/kill/cron.sh"
"/storage/DevMount/GitHUB/asusbox/adm.debugs/kill/transmission.sh"

# cola as variaveis do app a remover
# app vars
app="tv.pluto.android"
fakeName="Pluto TV"
apkSection="oem"
apkName="ao.10"
path="/data/asusbox/.install/04.akp.oem"

echo "desinstalando o $app"
if [ -d /data/data/$app ]; then
    pm uninstall $app
fi

# limpando a ficha do install
search="/storage/DevMount/GitHUB/asusbox/adm.2.install"
/system/bin/busybox find "$search/" -type f -name "*$apkName*.sh" \
| while read fname; do
echo "ADM DEBUG ########################################################"
echo "$fname"
rm "$fname"
done

# limpando a ficha do export
search="/storage/DevMount/GitHUB/asusbox/adm.1.export"
/system/bin/busybox find "$search/" -type f -name "*$apkName*.sh" \
| while read fname; do
echo "ADM DEBUG ########################################################"
#echo "$fname"
basename "$fname"
DirOut="/storage/DevMount/GitHUB/asusbox/adm.1.export/04.akp.oem/_disable"
if [ -d $DirOut ]; then
    mkdir -p $DirOut
fi
mv "$fname" "$DirOut/$(basename $fname).Del"
done

echo "ADM DEBUG ########################################################"
echo "Tamanho da pasta atual p2p"
du -hs /storage/asusboxUpdate/asusbox/.install

if [ -d $path/$apkName ]; then
echo "ADM DEBUG ########################################################"
echo "Tamanho da pasta cache $app"
du -h $path/$apkName

echo "ADM DEBUG ########################################################"
echo "apagando o diretório do $app"
rm -rf $path/$apkName

echo "ADM DEBUG ########################################################"
echo "Tamanho da pasta atual p2p"
du -hs /storage/asusboxUpdate/asusbox/.install
fi

echo "Agora falta os passos:
gerar novo boot completo
novo torrent
publicar"


