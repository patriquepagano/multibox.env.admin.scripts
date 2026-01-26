#!/system/bin/sh
clear
path=$( cd "${0%/*}" && pwd -P )

ListaOfficial="/data/local/tmp/APPList"

echo "
# global debugger
in.co.pricealert.apps2sd

# liberar apenas para mim
com.retroarch
org.xbmc.kodi
com.ss.squarehome2

# updates do google
com.google.android.gms
com.google.android.webview
com.android.vending

" >> "$ListaOfficial"


# 🔧 Remove linhas em branco direto na lista oficial
busybox sed -i '/^[[:space:]]*$/d' "$ListaOfficial"

# 📋 Lista pacotes instalados que NÃO estão na lista oficial
for dir in /data/app/*/; do
    pkg=$(basename "$dir" | cut -d- -f1)
    if ! grep -Fxq "$pkg" "$ListaOfficial"; then
        echo "Não oficial: $pkg"
        pm uninstall $pkg
    fi
done



echo "Done!"
read bah

