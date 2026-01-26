function TarOnly () {
    echo "ADM DEBUG ################### TarOnly ###########################################"
    # clean
    rm -rf "$path/$FileName"
    mkdir -p "$path/$FileName"
    # compactando arquivos e diretórios com permissões unix
    tarFile="$path/$FileName/$FileName.tar.gz"
    # tar file
    /system/bin/busybox tar -czvf "$tarFile" $FileList
}

