#!/system/bin/sh

path="/storage/asusboxUpdate/GitHUB/asusbox/adm.1.export/04.akp.oem"
path="/storage/DevMount/GitHUB/asusbox/adm.1.export/04.akp.oem"
clear

scriptMenu="/data/local/tmp/Menu-script"
rm "$scriptMenu" > /dev/null 2>&1

cat <<EOF > $scriptMenu
#!/system/bin/sh
clear
echo "Atenção! ao selecionar um script ira gerar uma nova ficha técnica!
alterando a data da ficha técnica vai forçar nas box para instalar de novo o app

Digite o numero do script que quer exportar"
EOF

# loop da lista
find "$path" -maxdepth 1 -name "ao.*.sh" | sort | while read fname; do
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
find "$path" -maxdepth 1 -name "ao.*.sh" | sort | while read fname; do
i=$((i+1))
cat <<EOF >> $scriptMenu
  $i) sh "$fname";;
EOF
done

cat <<'EOF' >> $scriptMenu
  *) echo "invalid option";;
esac
EOF

sh "$scriptMenu"


# cd $pathSC
# x

