#!/system/bin/sh
/system/bin/transmission-create \
-o //data/asusbox/adm.1.export/04.akp.oem/04.akp.oem.torrent \
-t http://tracker.yoshi210.com:6969/announce \
-t udp://tracker.yoshi210.com:6969/announce \
-t http://secure.pow7.com/announce \
-t http://atrack.pow7.com/announce \
-t http://t1.pow7.com/announce \
-t http://pow7.com:80/announce \
-t http://t2.pow7.com/announce \
-t http://p4p.arenabg.com:1337/announce \
-t http://open.acgtracker.com:1096/announce \
-t udp://tracker.openbittorrent.com:80/announce \
-t udp://tracker.tiny-vps.com:6969/announce \
-t udp://tracker.coppersurfer.tk:6969/announce \
-t udp://tracker.leechers-paradise.org:6969/announce \
-t udp://tracker.opentrackr.org:1337/announce \
-t udp://62.138.0.158:6969/announce \
-t udp://explodie.org:6969/announce \
-t udp://open.stealth.si:80/announce \
-s 512 \
/data/asusbox/.install/04.akp.oem
