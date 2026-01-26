#!/data/data/com.termux/files/usr/bin/env /data/data/com.termux/files/usr/bin/bash
#

echo "Desligando transmission torrent downloader"
/system/bin/transmission-remote --exit
killall transmission-daemon

