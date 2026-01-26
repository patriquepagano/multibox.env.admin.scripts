# ☐ portabilizando a pasta install Show!!!!
#     - deixar o setup para o inicio não da! pq não tem interface para explicações
#     - gravar na /system/.install é uma péssima ideia! em menos de 3 messes todos os packs serão totalmente obsoletos e vai regravar tudo
#         * allwinner e varias box com uma partição system com mais de 2GB!!
#         * restore apos um hard-reset é muito rapido e atualizado!
#         + SEEDERS NA MARRA não tem como os clientes removerem o pendrive e parar de semear
#         + /system/.install inicia no firmware VAZIO! no primeiro connect com a rede baixa e enche o diretorio
#     + criar uma função para gerir a decisão do cache externo
#         - vai dar gente removendo o pendrive e o seed vai parar
#     + velocidade na gravação dos bin,libs e apps
#     + libera o data para apps
#     + criar um container dentro da /system/drive deixando 20% livre para uso do cliente, filmes ou jogos usar a memoria interna dele
#     + criar um if se a pasta existe $Drive/.install ele faz o symlink
#     ☐ definir quais etapas e funções
#         + is /data/asusbox/.install is monted ?
#         + check DevMount is present, mount .install
#         + check space target
#         + mount

mkdir -p /data/trueDT/www/.stfolder > /dev/null 2>&1
chmod -R 777 /data/trueDT/www
mkdir -p /data/trueDT/assets > /dev/null 2>&1
mkdir -p /data/trueDT/peer/Sync > /dev/null 2>&1

function .installAsusBOX-PC () {
    FolderPath="/storage/asusboxUpdate"
    UUID=`/system/bin/busybox blkid | /system/bin/busybox grep "ThumbDriveDEV" | /system/bin/busybox head -n 1 | /system/bin/busybox cut -d "=" -f 3 | /system/bin/busybox cut -d '"' -f 2`
    if [ ! $UUID == "" ]; then    
        if [ ! -d $FolderPath ] ; then
            mkdir $FolderPath
            chmod 700 $FolderPath
        fi
        # montando o device
        #   /system/bin/busybox umount $FolderPath > /dev/null 2>&1
		check=`/system/bin/busybox mount | /system/bin/busybox grep "$FolderPath"`
		if [ "$check" == "" ]; then
			echo "ADM DEBUG ########################################################"
			echo "ADM DEBUG ### $FolderPath MONTANDO como pasta .install"
			/system/bin/busybox mount -t ext4 LABEL="ThumbDriveDEV" "$FolderPath"
		fi
        # Symlink
        rm /data/asusbox/.install > /dev/null 2>&1    
        /system/bin/busybox ln -sf $FolderPath/asusbox/.install /data/asusbox/
        InstallFolder="ENABLED"
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### $FolderPath ativado como pasta .install"
    fi
}


# function .installSystem () {
#     FolderPath="/system/.install"
#     ### tamanho atual da pasta .install = 697512
#     #/system/bin/busybox du -s /storage/AsusBOX-PC/asusbox/.install | /system/bin/busybox cut -f1
#     SystemSpace=`/system/bin/busybox df | grep "/system" | /system/bin/busybox awk '/[0-9]%/{print $(NF-2)}'`
#     #if [ "$SystemSpace" -ge "75000000000000000000000" ];then # debug para não utilizar a system
#     if [ "$SystemSpace" -ge "750000" ];then        
#         if [ ! -d $FolderPath ] ; then
#             /system/bin/busybox mount -o remount,rw /system
#             # montando o device
#             mkdir $FolderPath
#             chmod 700 $FolderPath
#         fi
#         # Symlink
#         rm /data/asusbox/.install > /dev/null 2>&1    
#         /system/bin/busybox ln -sf $FolderPath /data/asusbox/.install
#         InstallFolder="ENABLED"
#         echo "ADM DEBUG ########################################################"
#         echo "ADM DEBUG ### $FolderPath ativado como pasta .install"   
#     fi
# }

function .installSDcard () {
        FolderPath="/storage/emulated/0/Download/AsusBOX-UPDATE"
        if [ ! -d $FolderPath ]; then
            export FolderPath="/data/trueDT/PackP2P"
            mkdir -p $FolderPath
            echo "FolderPath > $FolderPath"
        fi
        # Symlink
        rm /data/asusbox/.install > /dev/null 2>&1    
        /system/bin/busybox ln -sf $FolderPath /data/asusbox/.install
        InstallFolder="ENABLED"
}

function Check.installFolder () {
    Clink=`/system/bin/busybox readlink -v "/data/asusbox/.install"` > /dev/null 2>&1    
    # test if symlink is broken (by seeing if it links to an existing file)
    if [ ! -e "$Clink" ] ; then
        InstallFolder="DISABLED"
        echo "Symlink /data/.install esta desativado"
        if [ ! $InstallFolder == "ENABLED" ]; then
            echo "ADM DEBUG ########################################################"
            echo "ADM DEBUG ### verificando se existe storage ext4 AsusBOX-PC"    
            .installAsusBOX-PC
        fi
        # desativado pq esta dando problemas
        # if [ ! $InstallFolder == "ENABLED" ]; then
        #     echo "ADM DEBUG ########################################################"
        #     echo "ADM DEBUG ### verificando se existe espaço na /system/.install" 
        #     .installSystem
        # fi
        if [ ! $InstallFolder == "ENABLED" ]; then
            echo "ADM DEBUG ########################################################"
            echo "ADM DEBUG ### ativando a pasta install no SDCard" 
            .installSDcard
        fi
        Check.installFolder
    else
        InstallFolder="ENABLED"
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### $InstallFolder = $Clink" 
    fi    
}

### Precisa apagar o symlink sempre no boot pois se tiver um usb storage vai puxar do mesmo
# verifica sem um pendrive AsusBOX-PC esta conectado e o utiliza como .install
# verifica se tem espaço na system e seta o diretorio como .install
# instala no sdcard em ultimo caso > /storage/emulated/0/Download/AsusBOX-UPDATE (assim o cliente pode apagar no futuro)
rm -rf /data/asusbox/.install
Check.installFolder

if [ ! -d /storage/emulated/0/Download/naoApagueUpdate ]; then
    busybox mkdir -p /storage/emulated/0/Download/naoApagueUpdate
    echo "56asd476a5sf5467da" > /storage/emulated/0/Download/naoApagueUpdate/setup.txt
fi


