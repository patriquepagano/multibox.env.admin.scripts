#!/system/bin/sh
source /data/.vars 

# para gerar o id_rsa é necessario fixar o path home em vez do asusbox
#HOME=/data/data/com.termux/files/home

$kill -9 $($pgrep lighttpd) > /dev/null 2>&1
$kill -9 $($pgrep php-cgi) > /dev/null 2>&1
mv /data/asusbox /data/asusboxOLD

# need for download from git
export GIT_SSH_COMMAND="/data/data/com.termux/files/usr/bin/ssh"


# falta um cmd aqui para aceitar as chaves automaticamente
# Warning: Permanently added the RSA host key for IP address '140.82.113.3' to the list of known hosts.

cd /data
git clone git@github.com:patriquepagano/asusbox.git # por enquanto tem que aceitar com yes e aguardar, depois cola cmds a seguir

# migrando os arquivos antigos
mv /data/asusboxOLD/* /data/asusbox/
mv /data/asusboxOLD/.* /data/asusbox/


# arquivos que começam com . 
# são ocultos e não movem
# arquivos de config gerada (my policy)
# arquivos de scripts q baixam (my policy)


