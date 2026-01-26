#!/system/bin/sh

clear

find "$var" -maxdepth 1 -name "*.vps" | while read fname; do
    rm "$fname"
done

scriptMenu="/tmp/Menu-$(uuidgen)"

cat <<EOF > $scriptMenu
#!/system/bin/sh
clear
echo "
Digite o numero da ficha tecnica para utilizar?"
EOF

# loop da lista
find "$HOME/.local/bin/_hosts/" -maxdepth 1 -name "*.vps" | sort | while read fname; do
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
find "$HOME/.local/bin/_hosts/" -maxdepth 1 -name "*.vps" | sort | while read fname; do
i=$((i+1))
cat <<EOF >> $scriptMenu
  $i) cp "$fname" $var/;;
EOF
done

cat <<'EOF' >> $scriptMenu
  *) echo "invalid option";;
esac
EOF

bash $scriptMenu
rm $scriptMenu > /dev/null 2>&1