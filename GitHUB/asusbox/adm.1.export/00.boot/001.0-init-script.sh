#!/system/bin/sh

echo " Vou gerar um novo init-script na pasta build
apos fazer isto tem que gerar novo pack da pasta .sc/boot
"

in="/storage/DevMount/GitHUB/asusbox/adm.build/boot-files/init-scripts/AsusBOX.A1/initRc.drv.01.01.97.sh"
out="/storage/DevMount/GitHUB/asusbox/adm.build/boot/update/initRc.drv.01.01.97"

rm "$out"
cp "$in" "$out"

# remove TABS
/system/bin/busybox sed -i -e 's|^[[:blank:]]*||g' "$out"
# remove todos echo ADM comentando o mesmo
/system/bin/busybox sed -i -e  's/echo "ADM DEBUG ###.*/#barbaridade/g' "$out"
# remove comentários
/system/bin/busybox sed -i -e 's/\s*#.*$//' "$out"
# insere na primeira linha
/system/bin/busybox sed -i -e '1i#!/system/bin/sh\' "$out"
#/system/bin/busybox sed -i -e '1i#!/system/usr/bin/bash\' "$fname"
# remove novas linhas
/system/bin/busybox sed -i -e '/^\s*$/d' "$out"
# altera os paths
/system/bin/busybox sed -i -e 's;/storage/DevMount/GitHUB/asusbox/adm.build;/data/asusbox/.sc;g' "$out"

echo "Compilando script via shc"
# shc File
#/data/data/com.termux/files/usr/bin/shc -v -f "$out" -e 20/10/2035
/data/data/com.termux/files/usr/bin/shc -vr -f "$out"
rm "$out.x.c"
mv "$out.x" "$out"

/system/bin/busybox du -hs "$out"

# cria um arquivo sh para forçar o update do pacote sc.boot
cat << EOF > /storage/DevMount/GitHUB/asusbox/adm.build/boot/update/version.sh
echo "$(date)"
EOF

# atualiza o novo init-up
cp /storage/DevMount/GitHUB/asusbox/adm.build/boot-files/init-scripts/AsusBOX.A1/init-up.sh \
   /storage/DevMount/GitHUB/asusbox/adm.build/boot/update/init-up.sh

echo "precisa atualizar a pasta sc.boot"
"/storage/DevMount/GitHUB/asusbox/adm.1.export/01.sc.base/001.0-sc-boot.sh"


