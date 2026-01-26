#!/system/bin/sh
clear

APPList=`pm list packages -3 | sed -e 's/.*://' | sort`


# #eval "$(cat ~/.bashrc | tail -n +10)"
# pathSC=$( cd "${0%/*}" && pwd -P )
# echo "o path atual é > /storage/emulated/0/Download"

scriptMenu="/data/local/tmp/Menu-script"
rm "$scriptMenu" > /dev/null 2>&1

cat <<EOF > $scriptMenu
#!/system/bin/sh
clear
echo "
Digite o numero do apk que vc quer DESISTALAR"
EOF

# loop da lista
for fname in $APPList; do
i=$((i+1))
cat <<EOF >> $scriptMenu
echo "  $i) $(basename "$fname")"
EOF
done

cat <<'EOF' >> $scriptMenu
read n
case $n in
EOF

i="0" # zera a contagem para proximo loop

# loop das operações
for fname in $APPList; do
i=$((i+1))
cat <<EOF >> $scriptMenu
  $i) pm clear "$fname";;
EOF
done

cat <<'EOF' >> $scriptMenu
  *) echo "invalid option";;
esac
EOF

sh "$scriptMenu"


