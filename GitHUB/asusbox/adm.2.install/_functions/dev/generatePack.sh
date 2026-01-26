#!/system/bin/sh

function generatePack () {
clear
export path=$(dirname $0)

echo "#!/system/bin/sh" > "$path/Download-Install.sh"
#echo "#!/system/usr/bin/bash" > "$path/Download-Install.sh"

# funções
/system/bin/busybox find "/storage/DevMount/GitHUB/asusbox/adm.2.install/_functions/firmware/" -type f -name "*"| sort | while read fname; do
    FileName=`basename "$fname"`
    chmod 700 "$fname"
    cat "$fname" >> "$path/Download-Install.sh"
done

/system/bin/busybox find "$path/loop"  -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do
    FileName=`basename "$fname"`
    chmod 700 "$fname"
    echo "$fname"
    cat "$fname" >> "$path/Download-Install.sh"
done


chmod 700 "$path/Download-Install.sh"

}




