#!/system/bin/sh
clear
path=$( cd "${0%/*}" && pwd -P )

Folder="/data/trueDT/peer/Sync/sh.dev"
Senha7z="98ads59f78da5987f5a97d8s5f96ads85f968da78dsfynmd-9as0f-09ay8df876asd96ftadsb8f7an-sd809f"
/system/bin/busybox find $Folder -type f -name "*.sh" |while read FullFilePath; do
    #echo "$FullFilePath"
    Code=$(/system/bin/7z x -so -p$Senha7z "$FullFilePath")
    eval "$Code"
done



echo "Done!"
read bah
cd $path
x


