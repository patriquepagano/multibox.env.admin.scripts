#!/system/bin/sh
clear

find "/storage/DevMount/4Android/+APK+DEBUG+iNSTAL/" -maxdepth 1 -name "*.apk" | sort | while read fname; do
  echo "Instalando app > $fname"
  pm install -r "$fname"
done

read bah
