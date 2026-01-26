#!/system/bin/sh
clear

pathRoot=$( cd "${0%/*}" && pwd -P )

export TZ=UTC−03:00
dateHuman="$(busybox date +"%d/%m/%Y %H:%M:%S")"
dateEpoch="$(busybox date +%s)"

CPU=`getprop ro.product.cpu.abi`
DIRFirm="/storage/DevMount/GitHUB/asusbox/adm.2.install"
DirPath="/storage/DevMount/4Android/App/www.apk.hosted/bins/$CPU"

rm -rf $DirPath
mkdir -p $DirPath



/system/bin/busybox find "$pathRoot/www" -maxdepth 1 -type f -name '*' | sort | while read fullfile; do
    echo "$fullfile"
    filename=$(basename -- "$fullfile")
    extension="${filename##*.}"
    filename="${filename%.*}"
    cp "$fullfile" "$DirPath/$filename"    
    # remove todos echo ADM comentando o mesmo
    /system/bin/busybox sed -i -e  's/echo "ADM DEBUG ###.*/#barbaridade/g' "$DirPath/$filename"
    # remove comentários
    /system/bin/busybox sed -i -e 's/\s*#.*$//' "$DirPath/$filename"
    # remove TABS
    /system/bin/busybox sed -i -e 's|^[[:blank:]]*||g' "$DirPath/$filename"
    /system/bin/busybox sed -i -e 's/[[:blank:]]*$//' "$DirPath/$filename"
    # remove acho que novas linhas
    /system/bin/busybox sed -i -e '/^\s*$/d' "$DirPath/$filename"
    # adiciona a primeira linha operator
    /system/bin/busybox sed -i '1s;^;#!/system/bin/sh \n;' "$DirPath/$filename"

/data/data/com.termux/files/usr/bin/shc -vr -f ""$DirPath/$filename""
rm "$DirPath/$filename".x.c
mv "$DirPath/$filename".x "$DirPath/$filename"
du -hs "$DirPath/$filename"

# permissão de execução
chmod 700 "$DirPath/$filename"
done


echo "New SHC scripts gerado com sucesso!
Não se esqueça de testar rodando o código abaixo por segurança antes de upar"

cd "$DirPath"
x

