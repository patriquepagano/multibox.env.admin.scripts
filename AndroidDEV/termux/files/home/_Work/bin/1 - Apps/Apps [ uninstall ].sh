#!/system/bin/sh
clear

# APPList=`pm list packages -3 | sed -e 's/.*://' | sort`
path=$( cd "${0%/*}" && pwd -P )


# {Dolphin Emulator} [org.dolphinemu.dolphinemu] (5.010945).apk

APPList=`cat "$path/aapt apps lists.txt"`


# #eval "$(cat ~/.bashrc | tail -n +10)"
# pathSC=$( cd "${0%/*}" && pwd -P )
# echo "o path atual é > /storage/emulated/0/Download"

scriptMenu="/data/local/tmp/Menu-script"
rm "$scriptMenu" > /dev/null 2>&1

cat <<EOF > $scriptMenu
#!/system/bin/sh
clear
echo "
Digite o numero do apk que vc quer DESISTALAR. obs. precisa gerar nova lista para apagar os removidos"
EOF

# loop da lista

echo -n "$APPList" | sed '/^\s*$/d' | sort | while read -r line ; do
i=$((i+1))
cat <<EOF >> $scriptMenu
echo "  $i) $line"
EOF
done

cat <<'EOF' >> $scriptMenu
read n
case $n in
EOF

i="0" # zera a contagem para proximo loop

# loop das operações
echo -n "$APPList" | sed '/^\s*$/d' | sort | while read -r line ; do
i=$((i+1))
cat <<EOF >> $scriptMenu
  $i) pm uninstall $(echo -n $line | cut -d "[" -f 2 | cut -d "]" -f 1 );;
EOF
done

cat <<'EOF' >> $scriptMenu
  *) echo "invalid option";;
esac
EOF

sh "$scriptMenu"

