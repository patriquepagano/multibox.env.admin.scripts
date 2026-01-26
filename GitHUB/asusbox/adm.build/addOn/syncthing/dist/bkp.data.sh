#!/system/bin/sh

# criei este teste para clonar o data em outra box e ver se duas box com data iguais sincronizam?
# as clonadas não syncam ao mesmo tempo.. mas ficam travadas e geram bugs etc..

# conseguir o numero do pid
pidClose=`netstat -ntlup | grep "libsyncthing" | cut -d '/' -f 1 | head -1 | tail -c 5`
kill $pidClose
netstat -ntlup | grep libsyncthing

sleep 3


cd /data/asusbox/sync
/system/bin/busybox tar -czvf /sdcard/Download/syncthing.data.orig.tar.gz *




