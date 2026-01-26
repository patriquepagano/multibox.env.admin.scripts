#!/system/bin/sh

# digitar no cel   bash ./tb.sh
CPU=`getprop ro.product.cpu.abi`

pkg update -y
pkg install p7zip curl rsync lftp bash screen lighttpd php-fpm wget -y

cd /data/data/com.termux/files/usr/bin
files="
curl
rsync
lftp
lftpget
bash
screen
screen-4.6.2
lighttpd
php-fpm
"
tar -cvf $EXTERNAL_STORAGE/Download/PersonalTecnico.net/bins_$CPU.tar $files
gzip -9 -f $EXTERNAL_STORAGE/Download/PersonalTecnico.net/bins_$CPU.tar

cd /data/data/com.termux/files/usr/lib
files="
p7zip
libc++_shared.so
libcurl.so
libnghttp2.so
libssl.so.1.0.0
libcrypto.so.1.0.0
libpopt.so
libpopt.so.0
libpopt.so.0.0.0
libandroid-support.so
libandroid-glob.so
libiconv.so
libreadline.so
libreadline.so.7
libreadline.so.7.0
libutil.so
libncurses.so
libncurses.so.6
libncurses.so.6.1
libncursesw.so
libncursesw.so.6
libncursesw.so.6.1
libhistory.so
libhistory.so.7
libhistory.so.7.0
libcrypt.so
mod_access.so
mod_accesslog.so
mod_alias.so
mod_auth.so
mod_authn_file.so
mod_cgi.so
mod_compress.so
mod_deflate.so
mod_dirlisting.so
mod_evasive.so
mod_evhost.so
mod_expire.so
mod_extforward.so
mod_fastcgi.so
mod_flv_streaming.so
mod_indexfile.so
mod_openssl.so
mod_proxy.so
mod_redirect.so
mod_rewrite.so
mod_rrdtool.so
mod_scgi.so
mod_secdownload.so
mod_setenv.so
mod_simple_vhost.so
mod_ssi.so
mod_staticfile.so
mod_status.so
mod_uploadprogress.so
mod_userdir.so
mod_usertrack.so
mod_vhostdb.so
mod_webdav.so
mod_wstunnel.so
libgd.so
libfontconfig.so
libtiff.so
libfreetype.so
libbz2.so
libbz2.so.1.0
libbz2.so.1.0.6
libpng.so
libpng16.so
libpcre.so
libxml2.so
liblzma.so
"
tar -cvf $EXTERNAL_STORAGE/Download/PersonalTecnico.net/libs_$CPU.tar $files
gzip -9 -f $EXTERNAL_STORAGE/Download/PersonalTecnico.net/libs_$CPU.tar









