
BB=/system/bin/busybox
NTP_SERVER=a.st1.ntp.br
SNTP_TIMEOUT=11
TIMEZONE=America/Sao_Paulo

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

HTTPDateFallback() {
  date_hdr=""
  for site in "${sites[@]}"; do
    date_hdr=$($BB timeout 11 /system/bin/wget --no-check-certificate -T2 --spider -S "$site" 2>&1 | $BB grep -i '^ *Date:' | $BB head -1 | tr -d '\r')
    date_hdr=${date_hdr#*: }
    date_hdr=${date_hdr#*, }
    date_hdr=${date_hdr% GMT}
    [ -n "$date_hdr" ] && break
  done

  if [ -n "$date_hdr" ]; then
    set -- $date_hdr
    day=$1; mon=$2; year=$3; time=$4
    hh=${time%%:*}
    mm=${time#*:}; mm=${mm%:*}
    ss=${time##*:}
    case $mon in
      Jan) m=01;; Feb) m=02;; Mar) m=03;; Apr) m=04;;
      May) m=05;; Jun) m=06;; Jul) m=07;; Aug) m=08;;
      Sep) m=09;; Oct) m=10;; Nov) m=11;; Dec) m=12;;
    esac
    offset=-3
    hh_dec=$((10#$hh + offset))
    [ $hh_dec -lt 0 ] && hh_dec=$((hh_dec + 24))
    if [ $hh_dec -lt 10 ]; then
      hh_local="0$hh_dec"
    else
      hh_local="$hh_dec"
    fi
    iso_local="${year}-${m}-${day} ${hh_local}:${mm}:${ss}"
    $BB date -s "$iso_local"
    return 0
  fi

  return 1
}

settings put global ntp_server $NTP_SERVER
settings put global auto_time 0
settings put global auto_time 1

if $BB timeout $SNTP_TIMEOUT $BB ntpd -q -n -p $NTP_SERVER >/dev/null 2>&1; then
  :
else
  HTTPDateFallback >/dev/null 2>&1
fi

setprop persist.sys.timezone $TIMEZONE

