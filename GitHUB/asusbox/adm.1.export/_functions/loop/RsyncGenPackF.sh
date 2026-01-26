function RsyncGenPackF () {
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Rsync $DevFolder/. $GenPackF/."
    export GenPackF="/data/local/tmp/GenPack"
    export exclude="/data/local/tmp/exclude.txt"
    mkdir -p $GenPackF
    echo -n "$ExcludeItens" > $exclude
    # copiar a pasta para o TMP
    /system/bin/rsync \
    --progress \
    -avz \
    --delete \
    --recursive \
    --force \
    --exclude-from=$exclude \
    $DevFolder/. $GenPackF/. > /dev/null 2>&1
    date > $GenPackF/version
    # echo baaaaaaaaaaaaaaaaaaa
    # sleep 500
}


