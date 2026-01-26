#!/system/bin/sh
export TZ=UTC−03:00
TMP_DIR=/data/trueDT/peer/TMP
NO_NET=$TMP_DIR/NoInternetAccess
FIRST_SETUP=$TMP_DIR/FirstSetupWiFi.log
PidProcessFile="/data/trueDT/peer/TMP/init.update.boot.PID"
Log="/data/trueDT/peer/TMP/init.update.boot.LOG"

NTP_SERVER=a.st1.ntp.br
SNTP_TIMEOUT=11
HTTP_TIMEOUT=5
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


CheckUptime() {
  set -- $(</proc/uptime)
  checkUptime=${1%%.*}
}


ClockUpdateNow() {
	# update relogio precisa de um tempo para a box iniciar e chamar o ntp client
	# futuro chamar um script ou service separado para update do relogio
	echo "ADM DEBUG ##########################################################################################" >> "$Log"
	echo "ADM DEBUG ### atualizando relogio" >> "$Log"
	echo "ADM DEBUG ##########################################################################################" >> "$Log"
	echo "ADM DEBUG ### {function ClockUpdateNow} [ SNTP ] $(busybox date '+%d/%m/%Y %H:%M:%S')" >> "$Log"
	settings put global ntp_server $NTP_SERVER
	settings put global auto_time 0
	settings put global auto_time 1
	if ! busybox timeout $SNTP_TIMEOUT busybox ntpd -q -n -p $NTP_SERVER 2>&1 | tee -a "$Log"; then
		echo "ADM DEBUG ### ntpd OK" >> "$Log"
		# manter o sleep por causa do script de limpeza de codigo e obfuscação
		busybox sleep 1
	else
		echo "ADM DEBUG ### ntpd falhou, fallback HTTP-Date" >> "$Log"
		HTTPDateFallback
	fi
	setprop persist.sys.timezone $TIMEZONE
	echo "ADM DEBUG ### {function ClockUpdateNow} [ pós-sync ] $(busybox date '+%d/%m/%Y %H:%M:%S')" >> "$Log"
}

HTTPDateFallback() {
	for site in "${sites[@]}"; do
		echo "ADM DEBUG ##########################################################################################" >> "$Log"
		echo "ADM DEBUG ### get header date $site" >> "$Log"
		date_hdr=$(busybox timeout 11 /system/bin/wget --no-check-certificate -T2 --spider -S "$site" 2>&1 | busybox grep -i '^ *Date:' | busybox head -1 | tr -d '\r')
		# strip “Date: ”, dia da semana e “ GMT”
		date_hdr=${date_hdr#*: }    # -> "Sun, 22 Jun 2025 01:10:53 GMT"
		date_hdr=${date_hdr#*, }    # -> "22 Jun 2025 01:10:53 GMT"
		date_hdr=${date_hdr% GMT}   # -> "22 Jun 2025 01:10:53"
		[ -n "$date_hdr" ] && break
	done
	if [ -n "$date_hdr" ]; then
		# explode em campos
		set -- $date_hdr
		day=$1; mon=$2; year=$3; time=$4
		# extrai hh/mm/ss
		hh=${time%%:*}
		mm=${time#*:}; mm=${mm%:*}
		ss=${time##*:}
		# mapeia mês pra número
		case $mon in
			Jan) m=01;; Feb) m=02;; Mar) m=03;; Apr) m=04;;
			May) m=05;; Jun) m=06;; Jul) m=07;; Aug) m=08;;
			Sep) m=09;; Oct) m=10;; Nov) m=11;; Dec) m=12;;
		esac
		# converte hora GMT para hora local (UTC−3)
		offset=-3
		hh_dec=$((10#$hh + offset))
		[ $hh_dec -lt 0 ] && hh_dec=$((hh_dec + 24))
		# zero-pad manual
		if [ $hh_dec -lt 10 ]; then
		hh_local="0$hh_dec"
		else
		hh_local="$hh_dec"
		fi
		iso_local="${year}-${m}-${day} ${hh_local}:${mm}:${ss}"
		echo "ADM DEBUG ### ajustando para $iso_local (Hora de Brasília)" >> "$Log"
		busybox date -s "$iso_local"
		echo "ADM DEBUG ### data ajustada: $(busybox date '+%d/%m/%Y %H:%M:%S')" >> "$Log"
		busybox rm "$NO_NET"
		else
		# sem internet nem fallback → marca e segue
		ts="$(busybox date +%s) => $(busybox date '+%d/%m/%Y %H:%M:%S')"
		echo "[ NoInternetAccess ] $ts" >> "$NO_NET"
		echo "ADM DEBUG ### sem internet: $(date)" >> "$Log"
	fi
}



# 1) Ajusta pra uma data antiga pra testar
busybox date 010100002020.00


ClockUpdateNow


date


echo "Done!"
read bah



