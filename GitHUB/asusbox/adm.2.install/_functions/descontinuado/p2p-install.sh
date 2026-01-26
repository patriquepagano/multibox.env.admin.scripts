############### problems
# + bom para baixar filmes e series na box botar isto no burnTV


# 1 - Arquivo torrent vai ser entregado pelo chaveador
# 2 - instalação vai ser toda por torrent pack
# 3 - syncthing ???

function InstallTransmission () {
if [ ! -e "/system/bin/transmission-daemon" ] ; then
echo "iniciando download do 010101.enc"
# md5sum não faz crc de pastas
# download pack online
# "C:\_Work\Dropbox\_TMP\010101.enc"

link="https://www.dropbox.com/s/m9crrzk6gezvnrs/010101.enc?dl=1"
link="http://45.79.48.215/asusbox/010101.enc"
# contou e inicia o download do torrent na hora
while [ 1 ]; do
    echo "Download test"	
	/system/bin/aria2c \
    --check-certificate=false \
    --allow-overwrite=true  \
    --file-allocation=none \
    $link \
    --dir=/data/local/tmp #| sed -e 's/FILE:.*//g' >> $bootLog 2>&1
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;

# extract from Download
Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
cd /data/local/tmp
/system/bin/7z e -aoa -p$Senha7z -y 010101.enc

# extract install transmission bin's
cd /system/bin
/system/bin/busybox mount -o remount,rw /system
/system/bin/busybox tar -xvf /data/local/tmp/transmission.tar.gz
chown root:root /system/bin/*
chmod 755 -R /system/bin/*

# extract install transmission lib's
cd /system/lib
/system/bin/busybox mount -o remount,rw /system
/system/bin/busybox tar -xvf /data/local/tmp/transmission.lib.tar.gz


# fix do libz
ln -sf /system/lib/libz.so /system/lib/libz.so.1


chown root:root /system/lib/*
chmod 644 /system/lib/libminiupnpc.so
chmod 644 /system/lib/libcrypto.so.1.1
chmod 644 /system/lib/libcurl.so
chmod 644 /system/lib/libevent-2.1.so
chmod 644 /system/lib/libnghttp2.so
chmod 644 /system/lib/libssl.so.1.1
chmod 644 /system/lib/libz.so.1

# extract install transmission web assets
cd /system/usr/share
/system/bin/busybox mount -o remount,rw /system
/system/bin/busybox tar -xvf /data/local/tmp/transmission.web.tar.gz
chown -R root:root /system/usr/share/transmission
chmod 777 -R /system/usr/share/transmission

# clean files
rm /data/local/tmp/trans*
rm /data/local/tmp/010101.enc
fi
}



