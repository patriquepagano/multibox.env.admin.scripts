#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear


Senha7z="123"


app="com.google.android.webview"
Files="/data/app/$app-*/*.apk"
FolderD="/storage/DevMount/4Android/BKP-Splitted-Apps/$app"
rm -rf "$FolderD"
mkdir -p "$FolderD"
/system/bin/7z -v7m a -mx=9 -p$Senha7z -mhe=on -t7z -y "$FolderD/AKP" $Files



if [ ! "$1" == "skip" ]; then
    echo "Press enter to continue."
    read bah
fi

