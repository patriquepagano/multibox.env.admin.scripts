#!/system/bin/sh
clear

#eval "$(cat ~/.bashrc | tail -n +10)"
pathSC=$( cd "${0%/*}" && pwd -P )
echo "o path atual é > /storage/DevMount/4Android/+APK+DEBUG+iNSTAL/"

scriptMenu="/data/local/tmp/Menu-script"
rm "$scriptMenu" > /dev/null 2>&1

cat <<EOF > $scriptMenu
#!/system/bin/sh
clear
echo "
Digite o numero do apk que vc quer instalar"
EOF


# loop da lista
find "/storage/DevMount/4Android/+APK+DEBUG+iNSTAL/" -maxdepth 1 -name "*.apk" | sort | while read fname; do
i=$((i+1))
cat <<EOF >> $scriptMenu
echo "  $i) $(basename "$fname")"
EOF
done

cat <<'EOF' >> $scriptMenu
read n
case $n in
EOF

# loop das operações
find "/storage/DevMount/4Android/+APK+DEBUG+iNSTAL/" -maxdepth 1 -name "*.apk" | sort | while read fname; do
i=$((i+1))
cat <<EOF >> $scriptMenu
  $i) pm install -r "$fname" && read bah && sh "$scriptMenu";;
EOF
done

cat <<'EOF' >> $scriptMenu
  *) echo "invalid option";;
esac
EOF

bash "$scriptMenu"


# cd $pathSC
# x

echo "feito!"

read bah