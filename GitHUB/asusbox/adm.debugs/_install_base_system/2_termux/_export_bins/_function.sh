#!/system/bin/sh
# precisa rodar via sshdroid
clear
export CPU=`getprop ro.product.cpu.abi`
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib

bkpFiles="/storage/DevMount/AndroidDEV/bins"


function SyncGenerateList () {

FileList="$Dir/$pack.FileList"
log="$Dir/$pack.FileList.log"
echo $pack
rm $FileList.New > /dev/null 2>&1
file=`cat "$FileList"`
echo "$file" | while IFS= read -r line ; do
#for line in $list; do
    if [[ -f $line ]]; then 
        #echo "$line is the File"
        FileChange=`echo $line | /system/bin/busybox sed 's;/data/data/com.termux/files;/system;g'`
        echo $FileChange
        DIRTarget=`dirname $FileChange`
        /system/bin/busybox mount -o remount,rw /system
        mkdir -p $DIRTarget
        /system/bin/rsync -ah --progress -rptv $line $FileChange
        chown root:root $FileChange > /dev/null 2>&1
        # gerando o fileList para o export
        echo $FileChange >> $FileList.New
    fi
done
rm $FileList
}

function DebugBINs () {
mv /data/data/com.termux /data/data/com.termuxAAAAAAAA

echo "###################################################################################"
echo "$pack"
eval "$cmd"

mv /data/data/com.termuxAAAAAAAA /data/data/com.termux
}


function bkpBins () {
    echo "ADM DEBUG ################### compress #####################################"
    FileList="$Dir/$pack.FileList"
    # clean
    rm -rf "$bkpFiles/$pack.tar.gz"
    # dir
    mkdir -p "$bkpFiles/$CPU"
    Listaarquivos=`cat $FileList.New`
    # tar file compactando arquivos e diretórios com permissões unix
    /system/bin/busybox tar -czvf "$bkpFiles/$CPU/$pack.tar.gz" $Listaarquivos
}







