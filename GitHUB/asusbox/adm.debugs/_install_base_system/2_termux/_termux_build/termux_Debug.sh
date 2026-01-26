# Simular o Smanager
if [ -e /data/data/os.tools.scriptmanagerpro ] ; then
		export APPFolder=/data/data/os.tools.scriptmanagerpro
		export TheAPP=os.tools.scriptmanagerpro
	else
		export APPFolder=/data/data/os.tools.scriptmanager
		export TheAPP=os.tools.scriptmanager
fi
unset PATH
PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:$APPFolder/bin/
export PATH=$APPFolder/bin/applets:$PATH

unset LD_LIBRARY_PATH
LD_LIBRARY_PATH=/vendor/lib:/system/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$APPFolder/files






#------------ script ao rodar apos atualizar no termux os apps
# 7 zip 
cp -r /data/data/com.termux/files/usr/lib/p7zip /data/data/os.tools.scriptmanager/files/
cp /data/data/com.termux/files/usr/lib/libc++_shared.so /data/data/os.tools.scriptmanager/files/
ln -s /data/data/os.tools.scriptmanager/files/p7zip/7z /data/data/os.tools.scriptmanager/bin/7z

# curl
cp /data/data/com.termux/files/usr/bin/curl /data/data/os.tools.scriptmanager/bin/
files="
/data/data/com.termux/files/usr/lib/libcurl.so
/data/data/com.termux/files/usr/lib/libnghttp2.so
/data/data/com.termux/files/usr/lib/libssl.so.1.0.0
/data/data/com.termux/files/usr/lib/libcrypto.so.1.0.0
"
for lib in $files; do
	cp -r $lib /data/data/os.tools.scriptmanager/files/
done

# rsync
cp /data/data/com.termux/files/usr/bin/rsync /data/data/os.tools.scriptmanager/bin/
files="
/data/data/com.termux/files/usr/lib/libpopt.so
/data/data/com.termux/files/usr/lib/libpopt.so.0
/data/data/com.termux/files/usr/lib/libpopt.so.0.0.0
/data/data/com.termux/files/usr/lib/libandroid-support.so
/data/data/com.termux/files/usr/lib/libandroid-glob.so
/data/data/com.termux/files/usr/lib/libiconv.so
"
for lib in $files; do
	cp -r $lib /data/data/os.tools.scriptmanager/files/
done

# lftp
cp /data/data/com.termux/files/usr/bin/lftp /data/data/os.tools.scriptmanager/files/
cp /data/data/com.termux/files/usr/bin/lftpget /data/data/os.tools.scriptmanager/files/
files="
/data/data/com.termux/files/usr/lib/libreadline.so
/data/data/com.termux/files/usr/lib/libreadline.so.7
/data/data/com.termux/files/usr/lib/libreadline.so.7.0
/data/data/com.termux/files/usr/lib/libutil.so
/data/data/com.termux/files/usr/lib/libncurses.so
/data/data/com.termux/files/usr/lib/libncurses.so.6
/data/data/com.termux/files/usr/lib/libncurses.so.6.1
/data/data/com.termux/files/usr/lib/libncursesw.so
/data/data/com.termux/files/usr/lib/libncursesw.so.6
/data/data/com.termux/files/usr/lib/libncursesw.so.6.1
/data/data/com.termux/files/usr/lib/libssl.so.1.0.0
/data/data/com.termux/files/usr/lib/libcrypto.so.1.0.0
/data/data/com.termux/files/usr/lib/libiconv.so
/data/data/com.termux/files/usr/lib/libandroid-support.so
/data/data/com.termux/files/usr/lib/libc++_shared.so
/data/data/com.termux/files/usr/etc/lftp.conf
"
for lib in $files; do
	cp -r $lib /data/data/os.tools.scriptmanager/files/
done
chmod 755 /data/data/os.tools.scriptmanager/files/*
#/data/data/os.tools.scriptmanager/files/lftp

# FTP server
files="
/data/data/com.termux/files/usr/bin/pure-uploadscript
/data/data/com.termux/files/usr/bin/pure-statsdecode
/data/data/com.termux/files/usr/bin/pure-quotacheck
/data/data/com.termux/files/usr/bin/pure-pwconvert
/data/data/com.termux/files/usr/bin/pure-pw
/data/data/com.termux/files/usr/bin/pure-mrtginfo
/data/data/com.termux/files/usr/bin/pure-ftpwho
/data/data/com.termux/files/usr/bin/pure-ftpd
/data/data/com.termux/files/usr/bin/pure-authd
/data/data/com.termux/files/usr/etc/pure-ftpd.conf
"
for loop in $files; do
	cp -r $loop /data/data/os.tools.scriptmanager/files/
done

files="
/data/data/com.termux/files/usr/lib/libcrypt.so
"
for lib in $files; do
	cp -r $lib /data/data/os.tools.scriptmanager/files/
done
chmod 755 /data/data/os.tools.scriptmanager/files/*
#/data/data/os.tools.scriptmanager/files/pure-ftpd



# iMagick magic
files="
/data/data/com.termux/files/usr/bin/magick
/data/data/com.termux/files/usr/bin/compare
/data/data/com.termux/files/usr/bin/composite
/data/data/com.termux/files/usr/bin/conjure
/data/data/com.termux/files/usr/bin/convert
/data/data/com.termux/files/usr/bin/magick-script
/data/data/com.termux/files/usr/bin/mogrify
/data/data/com.termux/files/usr/bin/montage
"
for loop in $files; do
	cp -r $loop /data/data/os.tools.scriptmanager/files/
done

files="
/data/data/com.termux/files/usr/lib/libMagickCore-7.Q16HDRI.so
/data/data/com.termux/files/usr/lib/libMagickWand-7.Q16HDRI.so
/data/data/com.termux/files/usr/lib/liblcms2.so
/data/data/com.termux/files/usr/lib/liblcms2.so.2
/data/data/com.termux/files/usr/lib/liblcms2.so.2.0.8
/data/data/com.termux/files/usr/lib/libtiff.so
/data/data/com.termux/files/usr/lib/libtiffxx.so
/data/data/com.termux/files/usr/lib/libfftw3.so
/data/data/com.termux/files/usr/lib/libfftw3_threads.so
/data/data/com.termux/files/usr/lib/libfftw3f.so
/data/data/com.termux/files/usr/lib/libfftw3f_threads.so
/data/data/com.termux/files/usr/lib/libfftw3l.so
/data/data/com.termux/files/usr/lib/libfftw3l_threads.so
/data/data/com.termux/files/usr/lib/libopenjp2.so
/data/data/com.termux/files/usr/lib/libpango-1.0.so
/data/data/com.termux/files/usr/lib/libpangocairo-1.0.so
/data/data/com.termux/files/usr/lib/libpangoft2-1.0.so
/data/data/com.termux/files/usr/lib/libharfbuzz.so
/data/data/com.termux/files/usr/lib/libharfbuzz-subset.so
/data/data/com.termux/files/usr/lib/libgraphite2.so
/data/data/com.termux/files/usr/lib/libgthread-2.0.so
/data/data/com.termux/files/usr/lib/libgobject-2.0.so
/data/data/com.termux/files/usr/lib/libffi.so
/data/data/com.termux/files/usr/lib/libffi.so.6
/data/data/com.termux/files/usr/lib/libffi.so.6.0.4
/data/data/com.termux/files/usr/lib/libglib-2.0.so
/data/data/com.termux/files/usr/lib/libfribidi.so
/data/data/com.termux/files/usr/lib/libcairo.so
/data/data/com.termux/files/usr/lib/libcairo-script-interpreter.so
/data/data/com.termux/files/usr/lib/libpixman-1.so
/data/data/com.termux/files/usr/lib/libpng.so
/data/data/com.termux/files/usr/lib/libpng16.so
/data/data/com.termux/files/usr/lib/libfontconfig.so
/data/data/com.termux/files/usr/lib/libfreetype.so
/data/data/com.termux/files/usr/lib/libuuid.so
/data/data/com.termux/files/usr/lib/libuuid.so.1
/data/data/com.termux/files/usr/lib/libuuid.so.1.0.0
/data/data/com.termux/files/usr/lib/libbz2.so
/data/data/com.termux/files/usr/lib/libbz2.so.1.0
/data/data/com.termux/files/usr/lib/libbz2.so.1.0.6
/data/data/com.termux/files/usr/lib/libxml2.so
/data/data/com.termux/files/usr/lib/liblzma.so
/data/data/com.termux/files/usr/lib/libandroid-support.so
/data/data/com.termux/files/usr/lib/libapt-pkg.so
/data/data/com.termux/files/usr/lib/libapt-private.so
/data/data/com.termux/files/usr/lib/libbz2.so
/data/data/com.termux/files/usr/lib/libbz2.so.1.0
/data/data/com.termux/files/usr/lib/libbz2.so.1.0.6
/data/data/com.termux/files/usr/lib/libc++_shared.so
/data/data/com.termux/files/usr/lib/libcairo.so
/data/data/com.termux/files/usr/lib/libcairo-script-interpreter.so
/data/data/com.termux/files/usr/lib/libcrypt.so
/data/data/com.termux/files/usr/lib/libcrypto.so
/data/data/com.termux/files/usr/lib/libcrypto.so.1.0.0
/data/data/com.termux/files/usr/lib/libcurl.so
/data/data/com.termux/files/usr/lib/libcurses.so
/data/data/com.termux/files/usr/lib/libexpat.so
/data/data/com.termux/files/usr/lib/libffi.so
/data/data/com.termux/files/usr/lib/libffi.so.6
/data/data/com.termux/files/usr/lib/libffi.so.6.0.4
/data/data/com.termux/files/usr/lib/libfftw3.so
/data/data/com.termux/files/usr/lib/libfftw3_threads.so
/data/data/com.termux/files/usr/lib/libfftw3f.so
/data/data/com.termux/files/usr/lib/libfftw3f_threads.so
/data/data/com.termux/files/usr/lib/libfftw3l.so
/data/data/com.termux/files/usr/lib/libfftw3l_threads.so
/data/data/com.termux/files/usr/lib/libfontconfig.so
/data/data/com.termux/files/usr/lib/libfreetype.so
/data/data/com.termux/files/usr/lib/libfribidi.so
/data/data/com.termux/files/usr/lib/libgio-2.0.so
/data/data/com.termux/files/usr/lib/libglib-2.0.so
/data/data/com.termux/files/usr/lib/libgmodule-2.0.so
/data/data/com.termux/files/usr/lib/libgobject-2.0.so
/data/data/com.termux/files/usr/lib/libgraphite2.so
/data/data/com.termux/files/usr/lib/libgthread-2.0.so
/data/data/com.termux/files/usr/lib/libharfbuzz.so
/data/data/com.termux/files/usr/lib/libharfbuzz-subset.so
/data/data/com.termux/files/usr/lib/libhistory.so
/data/data/com.termux/files/usr/lib/libhistory.so.7
/data/data/com.termux/files/usr/lib/libhistory.so.7.0
/data/data/com.termux/files/usr/lib/libiconv.so
/data/data/com.termux/files/usr/lib/libidn.so
/data/data/com.termux/files/usr/lib/libjpeg.so
/data/data/com.termux/files/usr/lib/liblcms2.so
/data/data/com.termux/files/usr/lib/liblcms2.so.2
/data/data/com.termux/files/usr/lib/liblcms2.so.2.0.8
/data/data/com.termux/files/usr/lib/liblzma.so
/data/data/com.termux/files/usr/lib/libMagickCore-7.Q16HDRI.so
/data/data/com.termux/files/usr/lib/libMagickWand-7.Q16HDRI.so
/data/data/com.termux/files/usr/lib/libncurses.so
/data/data/com.termux/files/usr/lib/libncurses.so.6
/data/data/com.termux/files/usr/lib/libncurses.so.6.0
/data/data/com.termux/files/usr/lib/libncurses.so.6.1
/data/data/com.termux/files/usr/lib/libncursesw.so
/data/data/com.termux/files/usr/lib/libncursesw.so.6
/data/data/com.termux/files/usr/lib/libncursesw.so.6.1
/data/data/com.termux/files/usr/lib/libnghttp2.so
/data/data/com.termux/files/usr/lib/libopenjp2.so
/data/data/com.termux/files/usr/lib/libpango-1.0.so
/data/data/com.termux/files/usr/lib/libpangocairo-1.0.so
/data/data/com.termux/files/usr/lib/libpangoft2-1.0.so
/data/data/com.termux/files/usr/lib/libpcre.so
/data/data/com.termux/files/usr/lib/libpixman-1.so
/data/data/com.termux/files/usr/lib/libpng.so
/data/data/com.termux/files/usr/lib/libpng16.so
/data/data/com.termux/files/usr/lib/libreadline.so
/data/data/com.termux/files/usr/lib/libreadline.so.7
/data/data/com.termux/files/usr/lib/libreadline.so.7.0
/data/data/com.termux/files/usr/lib/libssl.so
/data/data/com.termux/files/usr/lib/libssl.so.1.0.0
/data/data/com.termux/files/usr/lib/libtermux-exec.so
/data/data/com.termux/files/usr/lib/libtiff.so
/data/data/com.termux/files/usr/lib/libtiffxx.so
/data/data/com.termux/files/usr/lib/libturbojpeg.so
/data/data/com.termux/files/usr/lib/libutil.so
/data/data/com.termux/files/usr/lib/libuuid.so
/data/data/com.termux/files/usr/lib/libuuid.so.1
/data/data/com.termux/files/usr/lib/libuuid.so.1.0.0
/data/data/com.termux/files/usr/lib/libxml2.so

"
for lib in $files; do
	cp $lib /data/data/os.tools.scriptmanager/files/
done
chmod 755 /data/data/os.tools.scriptmanager/files/*
/data/data/os.tools.scriptmanager/files/convert


# screen
cp /data/data/com.termux/files/usr/bin/screen /data/data/os.tools.scriptmanager/bin/
cp /data/data/com.termux/files/usr/bin/screen-4.6.2 /data/data/os.tools.scriptmanager/bin/
files="
/data/data/com.termux/files/usr/lib/libcrypt.so
"
for lib in $files; do
	cp -r $lib /data/data/os.tools.scriptmanager/files/
done








# bash
cp /data/data/com.termux/files/usr/bin/bash /data/data/os.tools.scriptmanager/bin/
files="
/data/data/com.termux/files/usr/lib/libhistory.so
/data/data/com.termux/files/usr/lib/libhistory.so.7
/data/data/com.termux/files/usr/lib/libhistory.so.7.0
"
for lib in $files; do
	cp -r $lib /data/data/os.tools.scriptmanager/files/
done



# lighttpd
cp /data/data/com.termux/files/usr/bin/lighttpd /data/data/os.tools.scriptmanager/bin/
files="
/data/data/com.termux/files/usr/lib/mod_access.so
/data/data/com.termux/files/usr/lib/mod_accesslog.so
/data/data/com.termux/files/usr/lib/mod_alias.so
/data/data/com.termux/files/usr/lib/mod_auth.so
/data/data/com.termux/files/usr/lib/mod_authn_file.so
/data/data/com.termux/files/usr/lib/mod_cgi.so
/data/data/com.termux/files/usr/lib/mod_compress.so
/data/data/com.termux/files/usr/lib/mod_deflate.so
/data/data/com.termux/files/usr/lib/mod_dirlisting.so
/data/data/com.termux/files/usr/lib/mod_evasive.so
/data/data/com.termux/files/usr/lib/mod_evhost.so
/data/data/com.termux/files/usr/lib/mod_expire.so
/data/data/com.termux/files/usr/lib/mod_extforward.so
/data/data/com.termux/files/usr/lib/mod_fastcgi.so
/data/data/com.termux/files/usr/lib/mod_flv_streaming.so
/data/data/com.termux/files/usr/lib/mod_indexfile.so
/data/data/com.termux/files/usr/lib/mod_openssl.so
/data/data/com.termux/files/usr/lib/mod_proxy.so
/data/data/com.termux/files/usr/lib/mod_redirect.so
/data/data/com.termux/files/usr/lib/mod_rewrite.so
/data/data/com.termux/files/usr/lib/mod_rrdtool.so
/data/data/com.termux/files/usr/lib/mod_scgi.so
/data/data/com.termux/files/usr/lib/mod_secdownload.so
/data/data/com.termux/files/usr/lib/mod_setenv.so
/data/data/com.termux/files/usr/lib/mod_simple_vhost.so
/data/data/com.termux/files/usr/lib/mod_ssi.so
/data/data/com.termux/files/usr/lib/mod_staticfile.so
/data/data/com.termux/files/usr/lib/mod_status.so
/data/data/com.termux/files/usr/lib/mod_uploadprogress.so
/data/data/com.termux/files/usr/lib/mod_userdir.so
/data/data/com.termux/files/usr/lib/mod_usertrack.so
/data/data/com.termux/files/usr/lib/mod_vhostdb.so
/data/data/com.termux/files/usr/lib/mod_webdav.so
/data/data/com.termux/files/usr/lib/mod_wstunnel.so
"
for lib in $files; do
	cp -r $lib /data/data/os.tools.scriptmanager/files/
done

# php
# /data/data/com.termux/files/usr/bin/php
# /data/data/com.termux/files/usr/bin/php-cgi
# /data/data/com.termux/files/usr/bin/php-config
# /data/data/com.termux/files/usr/bin/phpdbg
# /data/data/com.termux/files/usr/bin/php-fpm
# /data/data/com.termux/files/usr/bin/phpize
cp /data/data/com.termux/files/usr/bin/php-fpm /data/data/os.tools.scriptmanager/bin/
files="
/data/data/com.termux/files/usr/lib/libgd.so
/data/data/com.termux/files/usr/lib/libfontconfig.so
/data/data/com.termux/files/usr/lib/libtiff.so
/data/data/com.termux/files/usr/lib/libfreetype.so
/data/data/com.termux/files/usr/lib/libbz2.so
/data/data/com.termux/files/usr/lib/libbz2.so.1.0
/data/data/com.termux/files/usr/lib/libbz2.so.1.0.6
/data/data/com.termux/files/usr/lib/libpng.so
/data/data/com.termux/files/usr/lib/libpng16.so
/data/data/com.termux/files/usr/lib/libpcre.so
/data/data/com.termux/files/usr/lib/libxml2.so
/data/data/com.termux/files/usr/lib/liblzma.so
"
for lib in $files; do
	cp -r $lib /data/data/os.tools.scriptmanager/files/
done



# ANOTAR IMPORTANTE. A CADA UPDATE DO PACK DO TERMUX ANALISAR SE TODOS OS BINARIOS VAO RODAR ANTES DE ENVIAR DROPBOX.
# wget solicita um modulo que fica dentro da pasta do termux..


#rodar os comandos no sshdroid para simular como se fosse o smanager rodando


DUser=`stat -c "%u" /data/data/os.tools.scriptmanager`
chown -R $DUser:$DUser /data/data/os.tools.scriptmanager/bin/
chown -R $DUser:$DUser /data/data/os.tools.scriptmanager/files/

restorecon -FR /data/data/os.tools.scriptmanager/bin
restorecon -FR /data/data/os.tools.scriptmanager/files




if [ "$CPU" == "x86" ] ; then
		echo "Lib x86 detectado"
		export LD_LIBRARY_PATH=/data/app/os.tools.scriptmanager-1/lib/$CPU:/data/user/0/os.tools.scriptmanager/files	
	else
		echo "Lib arm detectado"
		export LD_LIBRARY_PATH=/data/app/os.tools.scriptmanager-1/lib/arm:/data/user/0/os.tools.scriptmanager/files
fi
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/data/data/os.tools.scriptmanager/bin
export PATH=/data/data/os.tools.scriptmanager/bin:/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin





set LD_LIBRARY_PATH=/data/data/os.tools.scriptmanager/files 
./data/data/os.tools.scriptmanager/bin/wget --help



/lib/ld-linux.so.2 --library-path PATH EXECUTABLE


/data/data/os.tools.scriptmanager/files/libiconv.so /data/data/os.tools.scriptmanager/bin/wget --help








cp /data/data/os.tools.scriptmanager/files/libandroid-support.so /data/data/os.tools.scriptmanager/files/libiconv.so


Szip="/data/data/os.tools.scriptmanager/files/p7zip/7z"

# bins
cd /data/data/os.tools.scriptmanager
tar -cvf $EXTERNAL_STORAGE/Download/PersonalTecnico.net/bins.tar bin files
gzip -9 -f $EXTERNAL_STORAGE/Download/PersonalTecnico.net/bins.tar

# web server
cd $EXTERNAL_STORAGE/Download/PersonalTecnico.net/
$Szip -v14m a -mx=9 -p67asd5a7s6d57sd57 -mhe=on -t7z -y www.7z $EXTERNAL_STORAGE/Android/data/os.tools.scriptmanager/files/www

























# -----------------------------------------------------------------------------------------------------------
nao prestou muito complicado melhor usar sshdroid nos clientes para acesso remoto

# ssh server
files="
/data/data/com.termux/files/usr/bin/ssh
/data/data/com.termux/files/usr/bin/ssha
/data/data/com.termux/files/usr/bin/ssh-add
/data/data/com.termux/files/usr/bin/ssh-agent
/data/data/com.termux/files/usr/bin/ssh-copy-id
/data/data/com.termux/files/usr/bin/sshd
/data/data/com.termux/files/usr/bin/ssh-keygen
/data/data/com.termux/files/usr/bin/ssh-keyscan
/data/data/com.termux/files/usr/libexec/ssh-pkcs11-helper
/data/data/com.termux/files/usr/libexec/ssh-keysign
/data/data/com.termux/files/usr/libexec/sftp-server
"
for bin in $files; do
	cp -r $bin /data/data/os.tools.scriptmanager/bin/
done
chmod 755 /data/data/os.tools.scriptmanager/bin/ssh*
chmod 755 /data/data/os.tools.scriptmanager/bin/sftp-server

files="
/data/data/com.termux/files/usr/lib/libldns.so
"
for lib in $files; do
	cp -r $lib /data/data/os.tools.scriptmanager/files/
done









app="/data/data/os.tools.scriptmanager"
mkdir -p $app/home/.ssh
# Make sure the folder .ssh folder has the correct permissions
chmod -R 700 $app/home
touch $app/home/.ssh/authorized_keys
# Set Permissions to the file
chmod 600 $app/home/.ssh/authorized_keys

cat <<EOF > $app/home/.ssh/environment
SHELL=/data/data/os.tools.scriptmanager/bin/bash
EOF



# config
mkdir -p $app/etc/ssh

cat <<EOF > $app/etc/ssh/sshd_config
PrintMotd no
PasswordAuthentication no
PubkeyAcceptedKeyTypes +ssh-dss
Subsystem sftp /data/data/os.tools.scriptmanager/bin/sftp-server
HostKey $app/etc/ssh/ssh_host_rsa_key
HostKey $app/etc/ssh/ssh_host_dsa_key
authorizedkeysfile $app/home/.ssh/authorized_keys
PermitRootLogin yes
EOF

cat <<EOF > $app/etc/ssh/ssh_config
PubkeyAcceptedKeyTypes +ssh-dss
EOF








# keys do server
ssh-keygen -f $app/etc/ssh/ssh_host_rsa_key -N '' -t rsa
ssh-keygen -f $app/etc/ssh/ssh_host_dsa_key -N '' -t dsa




-h host_key_file Specifies a file from which to read a host key. The default is to use /etc/ssh/ssh_host_<algorithm>_key files. Only one host key can be specified for each algorithm.

/data/data/os.tools.scriptmanager/bin/sshd -d -p 8122 -f $app/etc/ssh/sshd_config



pidfile /data/data/com.termux/files/usr/var/run/sshd.pid
xauthlocation /data/data/com.termux/files/usr/bin/xauth
authorizedkeysfile .ssh/authorized_keys .ssh/authorized_keys2



ssh_host_rsa_key.pub
ssh_host_rsa_key
ssh_host_ed25519_key.pub
ssh_host_ed25519_key
ssh_host_ecdsa_key.pub
ssh_host_ecdsa_key
ssh_host_dsa_key.pub
ssh_host_dsa_key
moduli


# client keys

echo -e  'y' | ssh-keygen -t rsa -b 4096 -f $app/home/.ssh/id_rsa -C "my remote key" -P ""
cat $app/home/.ssh/id_rsa.pub >> $app/home/.ssh/authorized_keys
chmod 600 $app/home/.ssh/authorized_keys



DUser=`stat -c "%u" /data/data/os.tools.scriptmanager`
chown -R $DUser:$DUser /data/data/os.tools.scriptmanager
restorecon -FR /data/data/os.tools.scriptmanager




#script no cliente para startar
export SHELL=/data/data/os.tools.scriptmanager/bin/bash
export TERM=xterm-256color
CPU="arm"
export LD_LIBRARY_PATH=/data/app/os.tools.scriptmanager-1/lib/$CPU:/data/user/0/os.tools.scriptmanager/files
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/data/data/os.tools.scriptmanager/bin/
export LD_LIBRARY_PATH
export PATH

export OLDPWD=/data/data/os.tools.scriptmanager/home
export HOME=/data/data/os.tools.scriptmanager/home
export TMPDIR=/data/data/os.tools.scriptmanager
export TERM=xterm-256color
export SHLVL=2

env > /sdcard/Download/termuxCrack.sh

app="/data/data/os.tools.scriptmanager"
/data/data/os.tools.scriptmanager/bin/sshd -d -p 8122 -f $app/etc/ssh/sshd_config




