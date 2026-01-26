function RsyncUpdateWWW () {
    eval $cmdCheck
    exclude="/data/local/tmp/exclude.txt"

    echo "ADM DEBUG #################################################################################" 
    echo "ADM DEBUG ########### Entrando na função RsyncUpdateWWW ###################################"

    if [ "$versionBinLocal" == "$versionBinOnline" ]; then # if do install
        echo "$app esta atualizado!"
    else
        echo -n "$ExcludeItens" > $exclude
        echo "ADM DEBUG ### Atualizando via rsync $app em > $pathToInstall"
        mkdir -p $pathToInstall
        cd $pathToInstall
        # copiar a pasta para o TMP
        /system/bin/rsync \
        --progress \
        -avz \
        --delete \
        --recursive \
        --force \
        --exclude-from=$exclude \
        /data/local/tmp/UpdateF/ $pathToInstall/ > /dev/null 2>&1
    fi
    rm -rf $tmpUpdateF > /dev/null 2>&1
    rm $exclude > /dev/null 2>&1
}

