#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )
export TZ=UTC−03:00

# [] testar o script comentado
# [] instalar o script SHC no path oficial
# [] 

function CompileSHC () {
# remove todos echo ADM comentando o mesmo
/system/bin/busybox sed -i -e  's/echo "ADM DEBUG ###.*/#barbaridade/g' "$file"
# remove comentários
/system/bin/busybox sed -i -e 's/\s*#.*$//' "$file"
# remove TABS
/system/bin/busybox sed -i -e 's|^[[:blank:]]*||g' "$file"
/system/bin/busybox sed -i -e 's/[[:blank:]]*$//' "$file"
# remove acho que novas linhas
/system/bin/busybox sed -i -e '/^\s*$/d' "$file"
# adiciona a primeira linha operator
/system/bin/busybox sed -i '1s;^;#!/system/bin/sh \n;' "$file"

# shc File
#/data/data/com.termux/files/usr/bin/shc -v -f "$file" -e 20/10/2035
/data/data/com.termux/files/usr/bin/shc -vr -f ""$file""
rm "$file".x.c
mv "$file".x "$file"
du -hs "$file"
# permissão de execução
chmod 755 "$file"

}


# shc File
file="/data/asusbox/.sc/boot/update/init-up.sh"
rm "$file"
cp "$path/Old.Init.Asusbox [ init-up.sh ]" "$file"
CompileSHC

file="/data/asusbox/.sc/boot/update/initRc.drv.01.01.97"
rm "$file"
cp "$path/Old.Init.Asusbox [ initRc.drv.01.01.97.sh ]" "$file"
CompileSHC


echo "installed done"



