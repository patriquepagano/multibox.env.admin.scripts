#!/system/bin/sh

# http://asusbox.dyndns-office.com/get.php?username=f1020304050&password=f1020304050&type=m3u_plus&output=ts
# é muito simples baixar uma lista m3u dos servers!!!
# depois criar uma database atualizada para alimentar um sistema p2p


admExport=$(dirname $0)

clear
date



URL="http://asusbox.dyndns-office.com/get.php?username=Af1020304050&password=f1020304050&type=m3u_plus&output=ts"
#/system/bin/curl -iL --max-redirs 1 $URL # mostra os redirects e baixa toda a lista. demooora
/system/bin/curl -s -o /dev/null -w "%{http_code}" $URL
#/system/bin/curl -s -o /dev/null -I -w "%{http_code}" $URL # não baixa o response body
date



# Logar no painel xtream funciona! mas se clonarem uma box com este login vai funcionar em todas pois
# o xtream não bloqueia logins simultaneos











exit

echo "baixando o arquivo"
date

URL="http://asusbox.dyndns-office.com/get.php?username=f1020304050&password=f1020304050&type=m3u_plus&output=ts"
bootFile="/data/local/tmp/login.tmp"
/system/bin/wget --timeout=1 --tries=7 -O $bootFile --no-check-certificate $URL

date

exit


URL="http://asusbox.dyndns-office.com/get.php?username=f1020304050&password=f1020304050&type=m3u_plus&output=ts"
/system/bin/wget -q --spider $URL 
if [ $? -ne 0 ] ; then
  echo "do something"
fi








#/system/bin/aria2c -h  > $admExport/aria.log 2>&1

URL="http://asusbox.dyndns-office.com/get.php?username=AAf1020304050&password=f1020304050&type=m3u_plus&output=ts"
/system/bin/wget -S --spider $URL  2>&1




exit

function validate_url(){
  if [[ `wget -S --spider $1  2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then
    return 0
  else
    return 1
  fi
}


