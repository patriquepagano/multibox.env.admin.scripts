#!/system/bin/sh

export APPFolder=/data/data/os.tools.scriptmanager
export TheAPP=os.tools.scriptmanager
export TMPDIR="$APPFolder"
export PATH=$APPFolder/bin/applets:$PATH
export busybox="$APPFolder/bin/busybox"
export aria2c="$APPFolder/bin/aria2c"
export wget="$APPFolder/bin/wget"
export Szip="$APPFolder/bin/7z"
# path removivel
$APPFolder/sc/0_support/Wpath.sh
export Wpath=`cat "$APPFolder/Wpath.TXT"`
export logao="$Wpath/debug.log"
# webserver
export baseapps="$Wpath/.0/1_base_system"
export CPU=`getprop ro.product.cpu.abi`
# sqlite
export sqlite="$APPFolder/bin/sqlite3"

if [ ! -e "$baseapps" ] ; then
mkdir -p $baseapps/apk
fi

echo "Iniciando base install" > $logao 2>&1

DownloadFiles="
https://www.dropbox.com/s/rbr7g69tx3mfisg/.base.sh
https://www.dropbox.com/s/4ce2lpntrlwx5q8/1.install_base.sh
https://www.dropbox.com/s/3fp089ipua9c8xf/.sc.7z
"
cd $baseapps
for link in $DownloadFiles; do
while [ 1 ]; do
    $wget --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue $link
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
done

# scripts
cd $APPFolder/sc/1_base_system
$Szip x -aoa -p67asd5a7s6d57sd57 -y $baseapps/.sc.7z  >> $logao 2>&1
chmod -R 755 $APPFolder/sc/1_base_system/*.sh >> $logao 2>&1
restorecon -FR $APPFolder/sc/1_base_system >> $logao 2>&1

echo "Download dos componentes webserver..."

DownloadFiles="
https://www.dropbox.com/s/7vxnvdmjnz5qmvh/.lighttpd-dir.css
https://www.dropbox.com/s/3hju1e4qzyup12x/webserver.7z
https://www.dropbox.com/s/tlg9jdultgf6wqb/www.7z.001
https://www.dropbox.com/s/d6pacbnqk45tr8v/www.7z.002
"
mkdir -p $baseapps/webserver
cd $baseapps/webserver
for link in $DownloadFiles; do
while [ 1 ]; do
    $wget --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue $link
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 1;
done;
done

echo "Aguarde descomprimindo binários..."
# binarios
cd $APPFolder/bin
$Szip x -aoa -p67asd5a7s6d57sd57 -y $baseapps/webserver/webserver.7z  >> $logao 2>&1
chmod 755 $APPFolder/bin/*
chmod 660 $APPFolder/bin/*.conf
chmod 660 $APPFolder/bin/*.ini
# paginas base
cd $Wpath
$Szip x -aoa -p67asd5a7s6d57sd57 -y $baseapps/webserver/www.7z.001  >> $logao 2>&1
cp $baseapps/webserver/.lighttpd-dir.css $EXTERNAL_STORAGE/Android/data/$TheAPP/files/www/


mkdir -p $EXTERNAL_STORAGE/Download/_A_Compartilhar
cp $baseapps/webserver/.lighttpd-dir.css $EXTERNAL_STORAGE/Download/_A_Compartilhar/
echo '<div style="margin:15px 20px;"><h3>Arquivos a Compartilhar</h3></div>' > $EXTERNAL_STORAGE/Download/_A_Compartilhar/HEADER.txt
echo "   Arquivos a Compartilhar" > $EXTERNAL_STORAGE/Download/_A_Compartilhar/README.txt


#### configs webserver
# PersonalTecnico.net
# PersonalGameBOX.top
# WiFi-Livre.net
# loop="
# _A_Compartilhar
# "
# for L in $loop; do
# mkdir -p $EXTERNAL_STORAGE/Download/$L
# cp $baseapps/webserver/.lighttpd-dir.css $EXTERNAL_STORAGE/Download/$L/
# echo "   $L" > $EXTERNAL_STORAGE/Download/$L/README.txt
# done

# echo '<div style="margin:15px 20px;"><h3>Aplicativos essenciais</h3></div>' > $EXTERNAL_STORAGE/Download/PersonalTecnico.net/HEADER.txt
# echo '<div style="margin:15px 20px;"><h3>Configurar GameBOX</h3></div>' > $EXTERNAL_STORAGE/Download/PersonalGameBOX.top/HEADER.txt
# echo '<div style="margin:15px 20px;"><h3>Configurar WiFi-Livre</h3></div>' > $EXTERNAL_STORAGE/Download/WiFi-Livre.net/HEADER.txt
#echo '<div style="margin:15px 20px;"><h3>Meus arquivos a compartilhar</h3></div>' > $EXTERNAL_STORAGE/Download/_A_Compartilhar/HEADER.txt

file="$APPFolder/bin/lighttpd.conf"
#cat $file | grep "server.document-root"
sed -i -e 's;.*/files/www";server.document-root = "'$EXTERNAL_STORAGE'/Android/data/'$TheAPP'/files/www";g' $file
# sed -i -e 's;.*/PersonalTecnico.net";server.document-root = "'$EXTERNAL_STORAGE'/Download/PersonalTecnico.net";g' $file
# sed -i -e 's;.*/PersonalGameBOX.top";server.document-root = "'$EXTERNAL_STORAGE'/Download/PersonalGameBOX.top";g' $file
# sed -i -e 's;.*/WiFi-Livre.net";server.document-root = "'$EXTERNAL_STORAGE'/Download/WiFi-Livre.net";g' $file
# sed -i -e 's;.*/_A_Compartilhar";server.document-root = "'$EXTERNAL_STORAGE'/Download/_A_Compartilhar";g' $file

cat <<EOF > $APPFolder/bin/fcgiserver
#!/system/bin/sh

echo "Iniciando php"
export PHP_FCGI_CHILDREN=3
export PHP_FCGI_MAX_REQUESTS=1000
#php -b 127.0.0.1:9001 -c /system/etc/php.ini 2>&1
$APPFolder/bin/php-cgi -b 127.0.0.1:9001 -c $APPFolder/bin/php.ini > $EXTERNAL_STORAGE/Download/phpserver.log 2>&1
EOF
chmod 755 $APPFolder/bin/fcgiserver

restorecon -FR $APPFolder/bin >> $logao 2>&1


$APPFolder/sc/1_base_system/webserver_on.sh










exit
# Update Smanager shortcuts
$APPFolder/sc/0_support/smanager_shortcuts.sh