#!/system/bin/sh
export TZ=UTC−03:00
TMP_DIR=/data/trueDT/peer/TMP
NO_NET=$TMP_DIR/NoInternetAccess
FIRST_SETUP=$TMP_DIR/FirstSetupWiFi.log
PidProcessFile="/data/trueDT/peer/TMP/init.update.boot.PID"
Log="/data/trueDT/peer/TMP/init.update.boot.LOG"

sites=(
https://www.coinbase.com
https://www.kraken.com
https://www.coinmarketcap.com
https://www.coindesk.com
https://etherscan.io
https://www.facebook.com
https://www.github.com
https://www.binance.com
https://www.google.com
https://www.cloudflare.com
https://www.reddit.com
https://stackoverflow.com
https://ipv4.icanhazip.com
https://www.youtube.com
https://steamcommunity.com
)

NTP_SERVER=a.st1.ntp.br
SNTP_TIMEOUT=11
HTTP_TIMEOUT=5
TIMEZONE=America/Sao_Paulo


# [] a data ainda não esta ajustada corretamente do lance do http header



CheckUptime() {
  set -- $(</proc/uptime)
  checkUptime=${1%%.*}
}


CheckUptimeInternet () {
# verifica se a box tem internet caso não tenha trava em looping aqui
echo "ADM DEBUG ##########################################################################################" >> "$Log"
echo "ADM DEBUG ### Checando acesso a internet" >> "$Log"
# debug inicial
echo "ADM DEBUG ##########################################################################################" >> "$Log"
echo "ADM DEBUG ### {function CheckUptimeInternet} Loop Infinito " >> "$Log"
curl_opts="--head --silent -k --connect-timeout 5 --max-time 10"
if [ ! -f "$FIRST_SETUP" ]; then
  # primeira vez: bloqueia até qualquer link responder 2xx/3xx
  while :; do
    anyUp=0
    for link in "${sites[@]}"; do
      httpcode=$(/system/bin/curl $curl_opts --write-out '%{http_code}' -o /dev/null "$link")
      echo "ADM DEBUG ##########################################################################################" >> "$Log"
      echo "ADM DEBUG ### link     = $link"       >> "$Log"
      echo "ADM DEBUG ### httpcode = $httpcode"    >> "$Log"
      if [ "$httpcode" -ge 200 ] && [ "$httpcode" -lt 600 ]; then
        anyUp=1
        rm -f "$NO_NET"
        break
      fi
    done
    if [ "$anyUp" -eq 1 ]; then
      # internet OK: marca primeira configuração e sai
      ts="$(busybox date +%s) => $(busybox date '+%d/%m/%Y %H:%M:%S')"
      echo "[ FirstSetupWiFi ] $ts" > "$FIRST_SETUP"
      break
    fi
    # enquanto estiver sem internet o painel não vai sair da frente obrigando usuario a conectar a internet
    echo "ADM DEBUG ### ativando wifi settings one time only" >> "$Log"
    am start -a com.android.settings -n com.android.settings/com.android.settings.wifi.WifiSettings
    echo "ADM DEBUG ##########################################################################################" >> "$Log"
    echo "ADM DEBUG ### Check internet access: $(busybox date '+%d/%m/%Y %H:%M:%S')" >> "$Log"
    # gera o marcador para os scripts não executarem sem internet
    if [ ! -f "$NO_NET" ]; then
        ts="$(busybox date +%s) => $(busybox date '+%d/%m/%Y %H:%M:%S')"
        echo "[ NoInternetAccess ] $ts" > "$NO_NET"
    fi
    busybox sleep 11
  done
else
  # não é primeira vez: checa uma vez e segue adiante
  anyUp=0
  for link in "${sites[@]}"; do
    httpcode=$(/system/bin/curl $curl_opts --write-out '%{http_code}' -o /dev/null "$link")
    echo "ADM DEBUG ##########################################################################################" >> "$Log"
    echo "ADM DEBUG ### link     = $link"       >> "$Log"
    echo "ADM DEBUG ### httpcode = $httpcode"    >> "$Log"
    if [ "$httpcode" -ge 200 ] && [ "$httpcode" -lt 600 ]; then
      anyUp=1
      rm -f "$NO_NET"
      break
    fi
  done
  # se todos falharam, registra NoInternetAccess e segue
  if [ "$anyUp" -ne 1 ]; then
    ts="$(busybox date +%s) => $(busybox date '+%d/%m/%Y %H:%M:%S')"
    echo "[ NoInternetAccess ] $ts" > "$NO_NET"
  fi
fi
}


CheckUptimeInternet



echo "Done!"
read bah

