#!/system/bin/sh
rm $www/fcgiserver.log
echo "Sistema iniciado" > $bootLog 2>&1
date >> $bootLog 2>&1
$cat << 'EOF' > $www/index.php
<?php include $_SERVER['DOCUMENT_ROOT'] . "/.index.static/index.php" ?>
EOF
$cat << 'EOF' > $www/log.php
<?php include $_SERVER['DOCUMENT_ROOT'] . "/.index.static/log.php" ?>
EOF
$cat << 'EOF' > $www/off.php
<?php include $_SERVER['DOCUMENT_ROOT'] . "/.index.static/off.php" ?>
EOF
$cat << 'EOF' > $www/painel.php
<?php include $_SERVER['DOCUMENT_ROOT'] . "/.index.static/painel.php" ?>
EOF
$cat << 'EOF' > $www/api.php
<?php include $_SERVER['DOCUMENT_ROOT'] . "/.index.static/api.php" ?>
EOF
$cat << EOF > $www/version
$senha
EOF
$cat << EOF > $conf/fcgiserver
$shellBin
echo "Iniciando php"
export PHP_FCGI_CHILDREN=3
export PHP_FCGI_MAX_REQUESTS=1000
/system/bin/php-cgi -b 127.0.0.1:9001 -c $conf/php.ini > $www/fcgiserver.log 2>&1
EOF
$chmod 755 $conf/fcgiserver
if [ ! -e "$conf/php.ini" ] ; then
echo "gravando config php"
$cat << 'EOF' > $conf/php.ini
[PHP]
engine = On
short_open_tag = On
asp_tags = Off
precision = 14
y2k_compliance = On
output_buffering = 4096
zlib.output_compression = Off
implicit_flush = Off
unserialize_callback_func =
serialize_precision = 17
allow_call_time_pass_reference = Off
safe_mode = Off
safe_mode_gid = Off
safe_mode_include_dir =
safe_mode_exec_dir =
safe_mode_allowed_env_vars = PHP_
safe_mode_protected_env_vars = LD_LIBRARY_PATH
disable_functions =
disable_classes =
expose_php = On
max_execution_time = 30
max_input_time = 60
memory_limit = 128M
error_reporting = E_ALL & ~E_NOTICE
display_errors = On
display_startup_errors = On
log_errors = On
log_errors_max_len = 1024
ignore_repeated_errors = Off
ignore_repeated_source = Off
report_memleaks = On
track_errors = On
html_errors = On
variables_order = "GPCS"
request_order = "GP"
register_globals = Off
register_long_arrays = Off
register_argc_argv = Off
auto_globals_jit = On
post_max_size = 8M
magic_quotes_gpc = Off
magic_quotes_runtime = Off
magic_quotes_sybase = Off
auto_prepend_file =
auto_append_file =
default_mimetype = "text/html"
doc_root =
user_dir =
enable_dl = Off
cgi.force_redirect = 0
cgi.fix_pathinfo=1
cgi.check_shebang_line = 1
file_uploads = On
upload_tmp_dir = /sdcard
upload_max_filesize = 20M
max_file_uploads = 20
allow_url_fopen = On
allow_url_include = Off
default_socket_timeout = 60
[Date]
date.timezone = "America/Sao_Paulo"
[filter]
[iconv]
[intl]
[sqlite]
[sqlite3]
[Pcre]
[Pdo]
[Pdo_mysql]
pdo_mysql.cache_size = 2000
pdo_mysql.default_socket=
[Phar]
[Syslog]
define_syslog_variables  = Off
[mail function]
SMTP = localhost
smtp_port = 25
mail.add_x_header = On
[SQL]
sql.safe_mode = Off
[ODBC]
odbc.allow_persistent = On
odbc.check_persistent = On
odbc.max_persistent = -1
odbc.max_links = -1
odbc.defaultlrl = 4096
odbc.defaultbinmode = 1
[Interbase]
ibase.allow_persistent = 1
ibase.max_persistent = -1
ibase.max_links = -1
ibase.timestampformat = "%Y-%m-%d %H:%M:%S"
ibase.dateformat = "%Y-%m-%d"
ibase.timeformat = "%H:%M:%S"
[MySQL]
mysql.allow_local_infile = On
mysql.allow_persistent = On
mysql.cache_size = 2000
mysql.max_persistent = -1
mysql.max_links = -1
mysql.default_port =
mysql.default_socket =
mysql.default_host =
mysql.default_user =
mysql.default_password =
mysql.connect_timeout = 60
mysql.trace_mode = Off
[MySQLi]
mysqli.max_persistent = -1
mysqli.max_links = -1
mysqli.cache_size = 2000
mysqli.default_port = 3306
mysqli.default_socket =
mysqli.default_host =
mysqli.default_user =
mysqli.default_pw =
mysqli.reconnect = Off
[mysqlnd]
mysqlnd.collect_statistics = On
mysqlnd.collect_memory_statistics = On
[OCI8]
[PostgresSQL]
pgsql.allow_persistent = On
pgsql.auto_reset_persistent = Off
pgsql.max_persistent = -1
pgsql.max_links = -1
pgsql.ignore_notice = 0
pgsql.log_notice = 0
[Sybase-CT]
sybct.allow_persistent = On
sybct.max_persistent = -1
sybct.max_links = -1
sybct.min_server_severity = 10
sybct.min_client_severity = 10
[bcmath]
bcmath.scale = 0
[browscap]
[Session]
session.save_handler = files
session.save_path = "/sdcard"
session.use_cookies = 1
session.use_only_cookies = 1
session.name = PHPSESSID
session.auto_start = 0
session.cookie_lifetime = 0
session.cookie_path = /
session.cookie_domain =
session.cookie_httponly =
session.serialize_handler = php
session.gc_probability = 1
session.gc_divisor = 1000
session.gc_maxlifetime = 1440
session.bug_compat_42 = On
session.bug_compat_warn = On
session.referer_check =
session.entropy_length = 0
session.entropy_file =
session.cache_limiter = nocache
session.cache_expire = 180
session.use_trans_sid = 0
session.hash_function = 0
session.hash_bits_per_character = 5
url_rewriter.tags = "a=href,area=href,frame=src,input=src,form=fakeentry"
[MSSQL]
mssql.allow_persistent = On
mssql.max_persistent = -1
mssql.max_links = -1
mssql.min_error_severity = 10
mssql.min_message_severity = 10
mssql.compatability_mode = Off
mssql.secure_connection = Off
[Assertion]
[COM]
[mbstring]
[gd]
[exif]
[Tidy]
tidy.clean_output = Off
[soap]
soap.wsdl_cache_enabled=1
soap.wsdl_cache_dir="/sdcard"
soap.wsdl_cache_ttl=86400
soap.wsdl_cache_limit = 5
[sysvshm]
[ldap]
ldap.max_links = -1
[mcrypt]
[dba]
EOF
fi
$cat << EOF > $conf/.80.9001.sh
$shellBin
source /data/.vars
EOF
$cat << 'BAH' >> $conf/.80.9001.sh
$cat << EOF > $conf/lighttpd.conf
server.modules = (
"mod_fastcgi",
)
fastcgi.server = (
".php" =>
(( "host" => "127.0.0.1",
"port" => 9001,
))
)
server.document-root = "$www"
server.errorlog = "$www/lighttpd.log"
alias.url += ( "/share" => "/system/asusbox/share" )
EOF
devices=`$ls /storage | $grep -v self | $grep -v emulated | $grep -v sdcard`
if [ "$devices" == "" ] ; then
cat <<EOF >> $conf/lighttpd.conf
alias.url += ( "/SDCard" => "/storage/emulated/0" )
EOF
echo "<h2>Memória interna localizada. rótulo: > SDCard </h2>" >> $bootLog 2>&1
else
echo "<h1>Escaneando Memória externa:</h1>" >> $bootLog 2>&1
for loop in $devices; do
cat <<EOF >> $conf/lighttpd.conf
alias.url += ( "/$loop" => "/storage/$loop/" )
EOF
echo "<h2>Memória externa localizada. rótulo: > $loop </h2>" >> $bootLog 2>&1
done
cat <<EOF >> $conf/lighttpd.conf
alias.url += ( "/SDCard" => "/storage/emulated/0" )
EOF
echo "<h2>Memória interna localizada. rótulo: > SDCard </h2>" >> $bootLog 2>&1
fi
$cat << EOF >> $conf/lighttpd.conf
server.port = 80
index-file.names = ("index.php", "index.html")
dir-listing.activate = "enable"
dir-listing.hide-dotfiles = "enable"
dir-listing.external-css    = "/.index.static/.lighttpd-dir.css?version=10"
dir-listing.encoding = "utf-8"
dir-listing.show-readme ="enable"
dir-listing.hide-readme-file ="enable"
dir-listing.show-header     ="enable"
dir-listing.hide-header-file ="enable"
dir-listing.encode-header ="disable"
mimetype.use-xattr        = "disable"
mimetype.assign             = (
".pdf"          =>      "application/pdf",
".sig"          =>      "application/pgp-signature",
".spl"          =>      "application/futuresplash",
".class"        =>      "application/octet-stream",
".ps"           =>      "application/postscript",
".torrent"      =>      "application/x-bittorrent",
".dvi"          =>      "application/x-dvi",
".gz"           =>      "application/x-gzip",
".pac"          =>      "application/x-ns-proxy-autoconfig",
".swf"          =>      "application/x-shockwave-flash",
".tar.gz"       =>      "application/x-tgz",
".tgz"          =>      "application/x-tgz",
".tar"          =>      "application/x-tar",
".zip"          =>      "application/zip",
".mp3"          =>      "audio/mpeg",
".m3u"          =>      "audio/x-mpegurl",
".wma"          =>      "audio/x-ms-wma",
".wax"          =>      "audio/x-ms-wax",
".ogg"          =>      "application/ogg",
".wav"          =>      "audio/x-wav",
".gif"          =>      "image/gif",
".jpg"          =>      "image/jpeg",
".jpeg"         =>      "image/jpeg",
".png"          =>      "image/png",
".xbm"          =>      "image/x-xbitmap",
".xpm"          =>      "image/x-xpixmap",
".xwd"          =>      "image/x-xwindowdump",
".css"          =>      "text/css",
".html"         =>      "text/html",
".htm"          =>      "text/html",
".js"           =>      "text/javascript",
".asc"          =>      "text/plain",
".c"            =>      "text/plain",
".cpp"          =>      "text/plain",
".log"          =>      "text/plain",
".conf"         =>      "text/plain",
".text"         =>      "text/plain",
".txt"          =>      "text/plain",
".spec"         =>      "text/plain",
".dtd"          =>      "text/xml",
".xml"          =>      "text/xml",
".mpeg"         =>      "video/mpeg",
".mpg"          =>      "video/mpeg",
".mov"          =>      "video/quicktime",
".qt"           =>      "video/quicktime",
".avi"          =>      "video/x-msvideo",
".asf"          =>      "video/x-ms-asf",
".asx"          =>      "video/x-ms-asf",
".wmv"          =>      "video/x-ms-wmv",
".bz2"          =>      "application/x-bzip",
".tbz"          =>      "application/x-bzip-compressed-tar",
".tar.bz2"      =>      "application/x-bzip-compressed-tar",
".odt"          =>      "application/vnd.oasis.opendocument.text",
".ods"          =>
"application/vnd.oasis.opendocument.spreadsheet",
".odp"          =>
"application/vnd.oasis.opendocument.presentation",
".odg"          =>      "application/vnd.oasis.opendocument.graphics",
".odc"          =>      "application/vnd.oasis.opendocument.chart",
".odf"          =>      "application/vnd.oasis.opendocument.formula",
".odi"          =>      "application/vnd.oasis.opendocument.image",
".odm"          =>
"application/vnd.oasis.opendocument.text-master",
".ott"          =>
"application/vnd.oasis.opendocument.text-template",
".ots"          =>
"application/vnd.oasis.opendocument.spreadsheet-template",
".otp"          =>
"application/vnd.oasis.opendocument.presentation-template",
".otg"          =>
"application/vnd.oasis.opendocument.graphics-template",
".otc"          =>
"application/vnd.oasis.opendocument.chart-template",
".otf"          =>
"application/vnd.oasis.opendocument.formula-template",
".oti"          =>
"application/vnd.oasis.opendocument.image-template",
".oth"          =>      "application/vnd.oasis.opendocument.text-web",
""              =>      "application/octet-stream",
)
EOF
$cat << EOF > $www/index.navbar.php
<div id="top"><a href="top"></a></div>
<nav id="navigation-bar" class="navbar navbar-inverse navbar-fixed-top" role="navigation">
<div class="container">
<div class="navbar-header">
<img src="/.index.static/img/asusbox.top.png">
<button type="button" id="androidhome" class="btn btn-default glyphicon glyphicon-th"></button>&nbsp;
<a href="/" id="navbar-brand"><span class="btn btn-default glyphicon glyphicon-home"></span></a>&nbsp;
<a href="/painel.php" id="navbar-brand" ><span class="btn btn-default glyphicon glyphicon-wrench"></span></a>&nbsp;
<a href="/log.php" id="opt-fit-width" ><span class="btn btn-default glyphicon glyphicon-comment"></span></a>&nbsp;
<a href="/off.php" id="opt-fit-width" ><span class="btn btn-default glyphicon glyphicon-off"></span></a>&nbsp;
EOF
devices=`$ls /storage | $grep -v self | $grep -v emulated`
for loop in $devices; do
$cat << EOF >> $www/index.navbar.php
<a href="/$loop/" target="_blank" ><span class="btn btn-default glyphicon glyphicon-hdd"> <b>$loop</b></span></a>&nbsp;
EOF
done
$cat << EOF >> $www/index.navbar.php
<a href="/SDCard/" target="_blank" ><span class="btn btn-default glyphicon glyphicon-hdd"> <b>SDCard</b></span></a>&nbsp;
EOF
$cat << EOF >> $www/index.navbar.php
</div>
</div>
</nav>
EOF
$chmod 660 $conf/*.conf
$chmod 660 $conf/*.ini
$kill -9 $($pgrep lighttpd) > /dev/null 2>&1
$kill -9 $($pgrep php-cgi) > /dev/null 2>&1
$php &
while [ ! -f $www/fcgiserver.log ]
do
echo "Aguardando o log ser criado"
sleep 1
done
$lighttpd -f $conf/lighttpd.conf
BAH
$dos2unix $conf/.80.9001.sh
$chmod 755 $conf/.80.9001.sh
$conf/.80.9001.sh >> $systemLog
