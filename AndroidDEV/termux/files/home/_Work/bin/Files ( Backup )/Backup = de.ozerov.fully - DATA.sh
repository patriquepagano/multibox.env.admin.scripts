#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear


Senha7z="123"


app="de.ozerov.fully"
FolderD="/storage/DevMount/4Android/BKP-Splitted-Apps-DATA/$app"

echo "fechando o app > $app"
am force-stop $app
echo "limpando pastas anteriores"
rm -rf "$FolderD"
mkdir -p "$FolderD"


echo "compactando data e preferencias do app full"
Files="
/data/data/$app
"
echo "criando tar file"
/system/bin/busybox tar -czvf "$FolderD/DT.tar.gz" $Files
echo "criando arquivo 7zip dos dados do > $app"
/system/bin/7z -v7m a -mx=9 -p$Senha7z -mhe=on -t7z -y "$FolderD/DTF" "$FolderD/DT.tar.gz"
rm "$FolderD/DT.tar.gz"


if [ ! "$1" == "skip" ]; then
    echo "Press enter to continue."
    read bah
fi

