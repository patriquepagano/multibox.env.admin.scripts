#!/system/bin/sh

function .installAsusBOX-PC () {
    FolderPath="/storage/AsusBOX-PC"
    UUID=`blkid | /system/bin/busybox grep "AsusBOX-PC" | /system/bin/busybox head -n 1 | cut -d "=" -f 3`
    if [ ! $UUID == "" ]; then    
        if [ ! -d $FolderPath ] ; then
            mkdir /storage/AsusBOX-PC
            chmod 700 /storage/AsusBOX-PC
        fi
        # montando o device
        /system/bin/busybox umount $FolderPath > /dev/null 2>&1  
        /system/bin/busybox mount -t ext4 LABEL="AsusBOX-PC" $FolderPath
        # Symlink
        rm /data/asusbox/.install > /dev/null 2>&1    
        /system/bin/busybox ln -sf $FolderPath/asusbox/.install /data/asusbox/
        InstallFolder="ENABLED"
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### $FolderPath ativado como pasta .install" 
    fi
}

function .installSystem () {
    FolderPath="/system/.install"
    ### tamanho atual da pasta .install = 697512
    #/system/bin/busybox du -s /storage/AsusBOX-PC/asusbox/.install | /system/bin/busybox cut -f1
    SystemSpace=`/system/bin/busybox df | grep "/system" | /system/bin/busybox awk '/[0-9]%/{print $(NF-2)}'`
    #if [ "$SystemSpace" -ge "75000000000000000000000" ];then # debug para não utilizar a system
    if [ "$SystemSpace" -ge "750000" ];then        
        if [ ! -d $FolderPath ] ; then
            /system/bin/busybox mount -o remount,rw /system
            # montando o device
            mkdir $FolderPath
            chmod 700 $FolderPath
        fi
        # Symlink
        rm /data/asusbox/.install > /dev/null 2>&1    
        /system/bin/busybox ln -sf $FolderPath /data/asusbox/
        InstallFolder="ENABLED"
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### $FolderPath ativado como pasta .install"   
    fi
}

function .installSDcard () {
        FolderPath="/storage/emulated/0/Download/AsusBOX-UPDATE"
        if [ ! -d $FolderPath ] ; then
            mkdir $FolderPath
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
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### Symlink /data/.install esta desativado"
        logcat -c
        if [ ! $InstallFolder == "ENABLED" ]; then
            echo "ADM DEBUG ########################################################"
            echo "ADM DEBUG ### verificando se existe storage ext4 AsusBOX-PC"    
            .installAsusBOX-PC
        fi 
        if [ ! $InstallFolder == "ENABLED" ]; then
            echo "ADM DEBUG ########################################################"
            echo "ADM DEBUG ### verificando se existe espaço na /system/.install" 
            .installSystem
        fi
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
rm /data/asusbox/.install
Check.installFolder





