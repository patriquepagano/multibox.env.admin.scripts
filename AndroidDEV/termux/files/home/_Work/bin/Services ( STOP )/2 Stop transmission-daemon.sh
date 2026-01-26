#!/system/bin/sh

echo "Desligando transmission torrent downloader"
/system/bin/transmission-remote --exit
killall transmission-daemon

