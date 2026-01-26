#!/system/bin/sh

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### Verificação final se esta tudo bem com o p2p pack"
echo "ADM DEBUG ### wip= ao gerar novo pack torrent gera esta lista"
echo "ADM DEBUG ### wip= integra o resultado do md5sum em var no boot"

FileMark="/data/trueDT/peer/Sync/p2p.list.live"
TorrentFolder=`busybox readlink /data/asusbox/.install`
rm $FileMark
/system/bin/busybox find "$TorrentFolder" -type f -name "*" \
| sort \
| while read file; do
busybox md5sum $file | busybox awk '{print $1}' >> $FileMark
done

busybox cat <<EOF > "/data/trueDT/peer/Sync/p2p.md5.live"
$(busybox md5sum /data/trueDT/peer/Sync/p2p.list.live)
EOF

busybox cat <<EOF > "/data/trueDT/peer/Sync/p2p.status.live"
log date        = $(date +"%d/%m/%Y %H:%M:%S")
torrent date    = $(/system/bin/busybox stat -c '%y' /data/asusbox/.install.torrent | /system/bin/busybox cut -d "." -f 1)
md5sum torrent  = $(/system/bin/busybox md5sum /data/asusbox/.install.torrent)
RealFolder      = $TorrentFolder
md5sum folder   = $(busybox md5sum /data/trueDT/peer/Sync/p2p.list.live)
$(/system/bin/transmission-remote --list)
EOF










