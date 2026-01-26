#!/system/bin/sh

export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="M9rkBR4Et5Zh37gYyghXQE4p0AQtwW0PAm5Xshy4vufdV9qwb9QTSqgXn5UQcj4i092Yrj"
# Binário
app="lighttpd"
apkSection="bins"
CpuPack="armeabi-v7a"
FileName="B.005.0-$CpuPack"
apkName="$FileName"
FileExtension="7z"
path="/data/asusbox/.install/00.snib"
admExport=$(dirname "$0")

cmdCheck='/system/usr/bin/lighttpd -h > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'

eval $cmdCheck
versionBinOnline=$versionBinLocal
echo $versionBinLocal

FileList="/system/usr/lib/mod_sockproxy.so
/system/usr/lib/mod_cgi.so
/system/usr/lib/mod_ssi.so
/system/usr/lib/mod_auth.so
/system/usr/lib/mod_fastcgi.so
/system/usr/lib/mod_rewrite.so
/system/usr/lib/mod_evasive.so
/system/usr/lib/mod_dirlisting.so
/system/usr/lib/mod_webdav.so
/system/usr/lib/mod_rrdtool.so
/system/usr/lib/mod_authn_file.so
/system/usr/lib/mod_access.so
/system/usr/lib/mod_proxy.so
/system/usr/lib/mod_vhostdb.so
/system/usr/lib/mod_wstunnel.so
/system/usr/lib/mod_usertrack.so
/system/usr/lib/mod_accesslog.so
/system/usr/lib/mod_setenv.so
/system/usr/lib/mod_status.so
/system/usr/lib/mod_scgi.so
/system/usr/lib/mod_simple_vhost.so
/system/usr/lib/mod_secdownload.so
/system/usr/lib/mod_openssl.so
/system/usr/lib/mod_userdir.so
/system/usr/lib/mod_extforward.so
/system/usr/lib/mod_uploadprogress.so
/system/usr/lib/mod_staticfile.so
/system/usr/lib/mod_indexfile.so
/system/usr/lib/mod_evhost.so
/system/usr/lib/mod_redirect.so
/system/usr/lib/mod_expire.so
/system/usr/lib/mod_alias.so
/system/usr/lib/mod_flv_streaming.so
/system/usr/lib/mod_deflate.so
/system/usr/bin/lighttpd"

scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/lighttpd /system/bin/lighttpd
"

scriptAtBoot=''
SCRIPT=`realpath "$0"`
### Tasks ###############################################################################
compressTarget

exportVarsBINs









