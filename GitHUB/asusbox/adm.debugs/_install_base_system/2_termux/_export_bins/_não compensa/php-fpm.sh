#!/system/bin/sh
# pkg files php-fpm
clear
Dir=$(dirname $0)
source $Dir/_function.sh

export pack="php-fpm"
export cmd="/system/usr/bin/php-fpm -v"
cat << EOF > "$Dir/$pack.FileList"
/data/data/com.termux/files/usr/bin/php-fpm
/data/data/com.termux/files/usr/etc/php-fpm.d/www.conf
/data/data/com.termux/files/usr/etc/php-fpm.conf
/data/data/com.termux/files/usr/lib/libtidy.so
/data/data/com.termux/files/usr/lib/libgmp.so
/data/data/com.termux/files/usr/lib/libbz2.so
/data/data/com.termux/files/usr/lib/libbz2.so.1.0
/data/data/com.termux/files/usr/lib/libbz2.so.1.0.8
/data/data/com.termux/files/usr/lib/libxml2.so
/data/data/com.termux/files/usr/lib/libsqlite3.so
/data/data/com.termux/files/usr/lib/libffi.so
/data/data/com.termux/files/usr/lib/libgd.so
/data/data/com.termux/files/usr/lib/libicuio.so.67
/data/data/com.termux/files/usr/lib/libicuio.so.67.1
/data/data/com.termux/files/usr/lib/libicui18n.so.67
/data/data/com.termux/files/usr/lib/libicui18n.so.67.1
/data/data/com.termux/files/usr/lib/libicuuc.so.67
/data/data/com.termux/files/usr/lib/libicuuc.so.67.1
/data/data/com.termux/files/usr/lib/libonig.so
/data/data/com.termux/files/usr/lib/libxslt.so
/data/data/com.termux/files/usr/lib/libexslt.so
/data/data/com.termux/files/usr/lib/libzip.so
/data/data/com.termux/files/usr/lib/liblzma.so.5
/data/data/com.termux/files/usr/lib/liblzma.so.5.2.5
/data/data/com.termux/files/usr/lib/libpng16.so
/data/data/com.termux/files/usr/lib/libfontconfig.so
/data/data/com.termux/files/usr/lib/libfreetype.so
/data/data/com.termux/files/usr/lib/libtiff.so
/data/data/com.termux/files/usr/lib/libwebp.so
/data/data/com.termux/files/usr/lib/libicudata.so.67
/data/data/com.termux/files/usr/lib/libicudata.so.67.1
/data/data/com.termux/files/usr/lib/libcrypt.so
/data/data/com.termux/files/usr/lib/libgcrypt.so
/data/data/com.termux/files/usr/lib/libgpg-error.so
EOF

SyncGenerateList

DebugBINs

bkpBins

# clean
rm "$Dir/$pack.FileList" > /dev/null 2>&1


exit


# echo "###################################################################################"
# echo ""
# https://brasilcloud.com.br/duvidas/diferenca-fastcgi-suphp-cgi-mod_php-dso-fpm/
#                 	mod_php	CGI	    suPHP	FastCGI	PHP-FPM
# Uso de memória   	Baixo	Baixo	Baixo	Alto	Alto
# Utilização do CPU	Baixo	Alto	Alto	Baixo	Baixo
# Segurança	        Baixo	Baixo	Alto	Alto	Alto
# Executar como propr	Não	    Não	    Sim	    Sim	    Sim
# Desempenho Geral	Rápido	Lento	Lento	Rápido	Rápido
# php-fpm --version >> $log 2>&1
# 
/data/data/com.termux/files/usr/lib/libc++_shared.so
/data/data/com.termux/files/usr/lib/libpcre2-8.so
/data/data/com.termux/files/usr/lib/libpng.so
/data/data/com.termux/files/usr/lib/libuuid.so
/data/data/com.termux/files/usr/lib/libuuid.so.1
/data/data/com.termux/files/usr/lib/libuuid.so.1.0.0





