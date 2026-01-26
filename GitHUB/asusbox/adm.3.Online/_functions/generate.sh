#!/system/bin/sh

# funções
path="/storage/DevMount/GitHUB/asusbox/adm.3.Online/_functions"
rm "$path/allFunctions.sh" > /dev/null 2>&1
/system/bin/busybox find "$path/loop" -maxdepth 1 -type f -name "*.sh"| sort | while read fname; do
    #echo $fname
    cat $fname >> "$path/allFunctions.sh"
done

