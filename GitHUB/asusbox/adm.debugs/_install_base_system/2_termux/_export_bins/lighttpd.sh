#!/system/bin/sh
# pkg files lighttpd
clear
Dir=$(dirname $0)
source $Dir/_function.sh

export pack="lighttpd"
export cmd="/system/usr/bin/lighttpd --version"
cat << EOF > "$Dir/$pack.FileList"
/data/data/com.termux/files/usr/lib/mod_sockproxy.so
/data/data/com.termux/files/usr/lib/mod_cgi.so
/data/data/com.termux/files/usr/lib/mod_ssi.so
/data/data/com.termux/files/usr/lib/mod_auth.so
/data/data/com.termux/files/usr/lib/mod_fastcgi.so
/data/data/com.termux/files/usr/lib/mod_rewrite.so
/data/data/com.termux/files/usr/lib/mod_evasive.so
/data/data/com.termux/files/usr/lib/mod_dirlisting.so
/data/data/com.termux/files/usr/lib/mod_webdav.so
/data/data/com.termux/files/usr/lib/mod_rrdtool.so
/data/data/com.termux/files/usr/lib/mod_authn_file.so
/data/data/com.termux/files/usr/lib/mod_access.so
/data/data/com.termux/files/usr/lib/mod_proxy.so
/data/data/com.termux/files/usr/lib/mod_vhostdb.so
/data/data/com.termux/files/usr/lib/mod_wstunnel.so
/data/data/com.termux/files/usr/lib/mod_usertrack.so
/data/data/com.termux/files/usr/lib/mod_compress.so
/data/data/com.termux/files/usr/lib/mod_accesslog.so
/data/data/com.termux/files/usr/lib/mod_setenv.so
/data/data/com.termux/files/usr/lib/mod_status.so
/data/data/com.termux/files/usr/lib/mod_scgi.so
/data/data/com.termux/files/usr/lib/mod_simple_vhost.so
/data/data/com.termux/files/usr/lib/mod_secdownload.so
/data/data/com.termux/files/usr/lib/mod_openssl.so
/data/data/com.termux/files/usr/lib/mod_userdir.so
/data/data/com.termux/files/usr/lib/mod_extforward.so
/data/data/com.termux/files/usr/lib/mod_uploadprogress.so
/data/data/com.termux/files/usr/lib/mod_staticfile.so
/data/data/com.termux/files/usr/lib/mod_indexfile.so
/data/data/com.termux/files/usr/lib/mod_evhost.so
/data/data/com.termux/files/usr/lib/mod_redirect.so
/data/data/com.termux/files/usr/lib/mod_expire.so
/data/data/com.termux/files/usr/lib/mod_alias.so
/data/data/com.termux/files/usr/lib/mod_flv_streaming.so
/data/data/com.termux/files/usr/lib/mod_deflate.so
/data/data/com.termux/files/usr/bin
/data/data/com.termux/files/usr/bin/lighttpd
/data/data/com.termux/files/usr/share/doc/lighttpd
EOF

SyncGenerateList

DebugBINs

bkpBins

# clean
rm "$Dir/$pack.FileList" > /dev/null 2>&1



