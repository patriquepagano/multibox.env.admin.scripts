#!/system/bin/sh

eval "$(cat ~/.bashrc | tail -n +10)"

CPU=`getprop ro.product.cpu.abi`
DirPath="/storage/DevMount/4Android/App/www.apk.hosted/bins/$CPU"


pathSC=$( cd "${0%/*}" && pwd -P )
echo "o path atual é > $DirPath"

scriptMenu="/data/local/tmp/dbg.Menu-script"
rm "$scriptMenu" > /dev/null 2>&1

cat <<EOF > $scriptMenu
#!/system/bin/sh
clear
echo "
Digite o numero do script que quer rodar?"
EOF

# loop da lista
find "$DirPath" -maxdepth 1 -type f -name "*" | sort | while read fname; do
chmod 755 "$fname"
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
find "$DirPath" -maxdepth 1 -type f -name "*" | sort | while read fname; do
i=$((i+1))
cat <<EOF >> $scriptMenu
  $i) "$fname";;
EOF
done

cat <<'EOF' >> $scriptMenu
  *) echo "invalid option";;
esac
EOF

sh "$scriptMenu"
# clean
rm /tmp/connectsshHost > /dev/null 2>&1

