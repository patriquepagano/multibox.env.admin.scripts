#!/system/bin/sh

#unset PATH
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin
#unset LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib


export Dir=$(dirname $0)


torDir="/data/asusbox/.install"
torDir="/storage/DevMount/asusbox/.install"
trackerList="/storage/DevMount/GitHUB/asusbox/adm.1.export/_functions/debug/transmission.trackers"
taskRun="/storage/DevMount/GitHUB/asusbox/adm.2.install/0-p2p-create-torrent.sh"

function killTransmission () {
    checkPort=`netstat -ntlup | /system/bin/busybox grep "9091" | /system/bin/busybox cut -d ":" -f 2 | /system/bin/busybox awk '{print $1}'`
    if [ "$checkPort" == "9091" ]; then
        echo "ADM DEBUG ### Desligando transmission torrent downloader"
        /system/bin/transmission-remote --exit
        killall transmission-daemon
    fi
}

function generateTorrent () {
# escreve o arquivo para rodar o comando
/system/bin/busybox cat <<EOF > "$taskRun"
#!/system/bin/sh
/system/bin/transmission-create \\
-o /storage/DevMount/GitHUB/asusbox/adm.2.install/.install.torrent \\
EOF
/system/bin/busybox cat "$trackerList" >> "$taskRun"
/system/bin/busybox cat <<EOF >> "$taskRun"

-s 512 \\
$torDir
EOF
chmod 700 "$taskRun"
"$taskRun"
du -hs "/storage/DevMount/GitHUB/asusbox/adm.2.install/.install.torrent"
rm "$taskRun"
}

killTransmission
generateTorrent

echo "copia o torrent para base local"
rm /data/asusbox/.install.torrent
cp "/storage/DevMount/GitHUB/asusbox/adm.2.install/.install.torrent" /data/asusbox/
echo  "copia para a pasta a ser atualizada no http server"
cp "/storage/DevMount/GitHUB/asusbox/adm.2.install/.install.torrent" $Dir/asusboxA1/


# gerando os marcadores para ficha tecnica
file="/storage/DevMount/GitHUB/asusbox/adm.3.Online/asusboxA1/.install.torrent"
TorrentFileMD5=`/system/bin/busybox md5sum $file | /system/bin/busybox awk '{print $1}'`


FileMark="/data/trueDT/peer/Sync/p2p.list.live"
TorrentFolder=`/system/bin/busybox readlink /data/asusbox/.install`
rm $FileMark > /dev/null 2>&1
/system/bin/busybox find "$TorrentFolder" -type f -name "*" | sort | while read file; do
    tmpVar=`/system/bin/busybox md5sum $file | /system/bin/busybox awk '{print $1}'`
    echo "$file | $tmpVar"
    echo "$tmpVar" >> $FileMark
done
TorrentFolderMD5=`/system/bin/busybox md5sum $FileMark | /system/bin/busybox awk '{print $1}'`
rm $FileMark


datebuild=`date`
# exportando 
echo "

TorrentPackVersion=\"$datebuild\"
TorrentFileMD5=\"$TorrentFileMD5\"
TorrentFolderMD5=\"$TorrentFolderMD5\"


" > "/storage/DevMount/GitHUB/asusbox/adm.2.install/00.boot/loop/005.1-TorrentSync-VersionPack.sh"




# TorrentPackVersion="Thu Mar 24 21:18:34 BRT 2022"
# TorrentFileMD5="995b92182750ca591c87c3c8a5b8d80a"
# TorrentFolderMD5="246d80a44c7c7dcf0d663942e02b5739"

# TorrentPackVersion="Sun May  8 02:01:06 BRT 2022"
# TorrentFileMD5="01c63a6a5029722538a68c2f5793d538"
# TorrentFolderMD5="a4b50c63464f937224cbb5f58d32f56e"


# echo "Gerando nova ficha tecnica dos arquivos oficiais"

# DEVFile="/storage/DevMount/GitHUB/asusbox/adm.2.install/00.boot/loop/000.2-P2PVARList.sh"
# echo 'busybox cat <<EOF > "/data/local/tmp/PackList"' > $DEVFile
# /system/bin/busybox find "/data/asusbox/.install/" -type f -name "*" \
# | sort \
# | while read fname; do
#     #Fileloop=`basename $fname`
#     echo "$fname" >> $DEVFile
# done
# echo  'EOF

# ' >> $DEVFile
# busybox chmod 700 $DEVFile


