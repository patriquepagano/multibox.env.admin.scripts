function obfuscatePHP () {
    export GenPackF="/data/local/tmp/GenPack"
    # limpar os códigos PHP
    /system/bin/busybox find $GenPackF -type f \( -iname \*.php \) | /system/bin/busybox sort | while read fname; do
        echo "$fname"
        /system/bin/busybox sed -i -e '/^[[:space:]]*\/\//d; /^$/d;' "$fname"
        /system/bin/busybox sed -i -e '/^\s*$/d' "$fname"
        /system/bin/busybox sed -i -e 's|^[[:blank:]]*||g' "$fname"
        /system/bin/busybox sed -i -e 's/[[:blank:]]*$//' "$fname"
    done
}



