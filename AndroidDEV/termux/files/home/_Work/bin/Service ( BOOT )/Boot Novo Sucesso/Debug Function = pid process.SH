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


if [ ! -d "$TMP_DIR" ]; then
	mkdir -p "$TMP_DIR"
fi

echo "ADM DEBUG ##########################################################################################" >> "$Log"
echo "ADM DEBUG ### start init service $(date) [v6]" >> "$Log"
echo "ADM DEBUG ### [] tem que revisar o pid que não muda quando o processo é quebrado" >> "$Log"
echo "ADM DEBUG ### [] script service esta reinicando e nao parando no while das funções" >> "$Log"

# Inicio roda apenas uma vez no start do script
# espera que o serviço de armazenamento (vold) esteja em execução
until [ "$(getprop init.svc.vold)" = "running" ]; do sleep 1; done
# espera pelo daemon de rede
until [ "$(getprop init.svc.netd)" = "running" ]; do sleep 1; done
# para travar aguardar o boot
until getprop sys.boot_completed >/dev/null; do sleep 1; done


# # Mac address
# function CheckMacInUse () {
# MacLanClone=`/system/bin/busybox ifconfig \
# | /system/bin/busybox grep eth0 \
# | /system/bin/busybox grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' \
# | /system/bin/busybox tr 'A-F' 'a-f'`
# }
# CheckMacInUse
# if [ ! "$MacLanClone" == "d0:76:6c:31:00:40" ]; then
#     export MacLanReal=`/system/bin/busybox ifconfig | /system/bin/busybox grep eth0 | /system/bin/busybox awk '{ print $5 }'`
#     echo "ADM DEBUG ###########################################################"
#     echo "ADM DEBUG ### ativando mac oficial para emulação clone"
#     am force-stop com.valor.mfc.droid.tvapp.generic
#     #/data/asusbox/.sc/OnLine/mac.sh # descontinuado remover do pack local
#     /system/bin/busybox ifconfig eth0 down
#     /system/bin/busybox ifconfig eth0 hw ether d0:76:6c:31:00:40
#     /system/bin/busybox ifconfig eth0 up
#     while [ 1 ]; do
#         CheckMacInUse
#         echo "ADM DEBUG ###########################################################"
#         echo "ADM DEBUG ### aguardando receber novo mac na interface Lan"        
#         echo "Mac atual > $MacLanClone"
#         if [ "$MacLanClone" = "d0:76:6c:31:00:40" ]; then break; fi;        
#         sleep 1;
#     done;
# else
#     export MacLanReal=`/system/bin/busybox cat /data/macLan.hardware`
# fi


CheckMacInUse() {
  MacInUse=$($IFC | $BB grep -oE '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' | $BB tr 'A-F' 'a-f')
}

SetHardwareEmulation(){
if [ -f /data/macLan.Emulated ]; then
	# # pega o emulado
	# MacLanEmulated=$(< /data/macLan.Emulated)
	# CheckMacInUse
	# if [ "$MacInUse" != "$MacLanEmulated" ]; then
	# 	echo "ADM DEBUG ### ativando MAC emulado" >> "$Log"
	# 	bash "/data/macLan.app.reset"
	# 	$BB ifconfig eth0 down
	# 	$BB ifconfig eth0 hw ether "$MacLanEmulated"
	# 	$BB ifconfig eth0 up
	# 	# espera até refletir
	# 	while [ "$MacInUse" != "$MacLanEmulated" ]; do
	# 		echo "ADM DEBUG ### Mac ainda não aplicado: $MacInUse" >> "$Log"
	# 		sleep 1
	# 		CheckMacInUse
	# 	done
	# 	echo "ADM DEBUG ### MAC OK: $MacInUse" >> "$Log"
	# fi


#     export MacLanReal=`/system/bin/busybox ifconfig | /system/bin/busybox grep eth0 | /system/bin/busybox awk '{ print $5 }'`
#     echo "ADM DEBUG ###########################################################" >> "$Log"
#     echo "ADM DEBUG ### ativando mac oficial para emulação clone" >> "$Log"
#     am force-stop com.valor.mfc.droid.tvapp.generic
#     #/data/asusbox/.sc/OnLine/mac.sh # descontinuado remover do pack local

#     while [ 1 ]; do

#     /system/bin/busybox ifconfig eth0 down
#     /system/bin/busybox ifconfig eth0 hw ether d0:76:6c:31:00:40
#     /system/bin/busybox ifconfig eth0 up

#         CheckMacInUse
#         echo "ADM DEBUG ###########################################################"
#         echo "ADM DEBUG ### aguardando receber novo mac na interface Lan"  >> "$Log"
#         echo "Mac atual >$MacInUse< | MACReal >$MacLanReal<" >> "$Log"
#         if [ "$MacInUse" = "d0:76:6c:31:00:40" ]; then break; fi;
#         sleep 1
#     done;
# else
#     export MacLanReal=`/system/bin/busybox cat /data/macLan.hardware`
# fi

# falta setar o mac real




IDNew=$(< /data/ID.Emulated.online)
ID=$(cat /data/ID.Emulated)
if [ ! "$IDNew" == "$ID" ]; then
    GetID=`settings get secure android_id`
    settings put --user 0 secure android_id $GetID
    echo -n "$GetID" > /data/ID.Emulated
	echo "ADM DEBUG ### Android ID $GetID" >> "$Log"
fi
}



# 3 serviços neste script
	# CheckUptimeInternet 
		# (pq se não tiver internet chama o wifi settings para frente uma unica vez apenas no firstboot)
		# deixa a box em loop infinito ate o sinal retornar
	# FORCEClockUpdateNow
		# forca update do time via url proxy
	# ClockUpdateNow
		# NTP update time

# -eq # Equal
# -ne # Not equal
# -lt # Less than
# -le # Less than or equal
# -gt # Greater than
# -ge # Greater than or equal

CheckUptime() {
  set -- $(</proc/uptime)
  checkUptime=${1%%.*}
}



###########################################################################################################################
# declarando as funções

# quando o services chamar este script pode ser que o uptime chegue em media a 74secs. 
# apos entrar dentro deste loop fica parado para não chamar duas vezes
FNCheckColdBoot () {
CheckUptime
if [ "$checkUptime" -le 150 ]; then
	echo "ADM DEBUG ##########################################################################################" > "$Log"
	echo "ADM DEBUG ### First Cold Boot Uptime: $checkUptime" >> "$Log"
	echo "ADM DEBUG ### $(busybox ps | busybox grep init.update.boot.sh | busybox grep -v grep)" >> "$Log"
	rm "$PidProcessFile" > /dev/null 2>&1
	rm "/data/trueDT/peer/TMP/NoInternetAccess" > /dev/null 2>&1
	echo "ADM DEBUG ##########################################################################################" >> "$Log"
	echo "ADM DEBUG ### {function FNCheckColdBoot} " >> "$Log"
	echo "ADM DEBUG ### $(busybox ps | grep "init.update.boot.sh" | busybox grep -v grep)" >> "$Log"
	echo "ADM DEBUG ### novo boot a frio" >> "$Log"
	echo "ADM DEBUG ### Tasks one time only" >> "$Log"
	echo "ADM DEBUG ### Box ligada a $checkUptime segundos atras" >> "$Log"
	echo "ADM DEBUG ### BLOQUEANDO O ACESSO ROOT" >> "$Log"
	checkPin=`/system/bin/busybox cat /system/.pin`
	if [ ! "$checkPin" = "FSgfdgkjhç8790d5sdf85sd867f5gs876df5g876sdf5g78s6df5g78s6df5gs87df6g576sfd" ];then
		/system/bin/busybox mount -o remount,rw /system
		echo -n 'FSgfdgkjhç8790d5sdf85sd867f5gs876df5g876sdf5g78s6df5g78s6df5gs87df6g576sfd' > /system/.pin
		chmod 644 /system/.pin
	fi
	# # obrigado a dar este pause no first boot para aguardar as interfaces de rede lan e wlan
	# Em resumo: o until roda menos processos e é mais rápido/compatível num shell limitado.
	#until getprop sys.boot_completed >/dev/null; do sleep 1; done
	echo "ADM DEBUG ##########################################################################################" >> "$Log"
	echo "ADM DEBUG ### configurando android settings..." >> "$Log"
	settings put global heads_up_notifications_enabled 0
	settings put global package_verifier_enable 0
	settings put secure install_non_market_apps 1
	settings put global install_non_market_apps 1
	settings put global policy_control immersive.full=*
	echo "ADM DEBUG ##########################################################################################" >> "$Log"
	echo "ADM DEBUG ### Cold Boot Finished" >> "$Log"
	echo "Cold Boot Finished! uptime:$(busybox cut -d ' ' -f1 /proc/uptime | busybox cut -d '.' -f1) $(busybox date +"%d/%m/%Y %H:%M:%S")" > "/data/trueDT/peer/TMP/First Cold Boot.log"
	# verifica internet apenas uma vez no coldboot e não fica mais chateando cliente
	CheckUptimeInternet
	# atualização da hora ocorre apenas no boot ou apos wake da hibernação
	ClockUpdateNow
	echo "aaaaaaaa" > "$Log-$(date)"
	# gravando a mac real
	SetHardwareEmulation
	echo -n $MacLanReal > /data/macLan.hardware
	# segura para não entra novamente neste looping
	sleep 300
fi
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


# como a box vai saber que esta ligando a partir de um wakeup?
# se aguardar uma hora baseado no time deste script apos retornar do sleep a box vai ficar quase uma hora com horario errado!
# se ficar dando ping no horario a cada um minuto vai estourar a banda do serviço update time
# preciso descobrir qual script que rodar apos o wakeup da box
FNCheckifSleep () {
CheckifSleep=`dumpsys power | grep "mLastSleepTime=" | cut -d "=" -f 2 | cut -d " " -f 1`
if [ ! "$CheckifSleep" == "0" ]; then
	if [ ! -f "/data/trueDT/peer/TMP/mLastSleepTime/$CheckifSleep" ]; then
		echo "ADM DEBUG ##########################################################################################" >> "$Log"
		echo "ADM DEBUG ### {function FNCheckifSleep} " >> "$Log"
		echo "ADM DEBUG ### Tvbox retornou do mLastSleepTime" >> "$Log"
		echo "ADM DEBUG ### Sincronizar o horario via url" >> "$Log"
		# verifica internet apenas uma vez no coldboot e não fica mais chateando cliente
		CheckUptimeInternet
		# atualização da hora ocorre apenas no boot ou apos wake da hibernação
		ClockUpdateNow
		# bem provavel que a box com a hora certa detecte o arquivo PidProcess como antigo
		# assim a box chamaria o Boot Oficial UpdateSystem.sh apos um wakeup
		echo "ADM DEBUG ##########################################################################################" >> "$Log"
		echo "ADM DEBUG ### mensagem de alerta para usuário após o wakeup" >> "$Log"
		# * carregar um url do telegram e jogar na tela ?

		mkdir -p "/data/trueDT/peer/TMP/mLastSleepTime"
		echo "Wake from sleep $(busybox date +%s) => $(busybox date +"%d/%m/%Y %H:%M:%S")" > "/data/trueDT/peer/TMP/mLastSleepTime/$CheckifSleep"
	fi
else
	if [ -d "/data/trueDT/peer/TMP/mLastSleepTime" ]; then
		busybox rm -rf "/data/trueDT/peer/TMP/mLastSleepTime"
	fi
fi
}


checkPidTime () {
	# se a box fizer reboot o arquivo pid do ultimo uso sera mais novo que a data do boot frio fazendo o boot demorar o tempo estipulado no -mmin
	# se o arquivo pid exist e tem uma vida util X tempo então apaga para o gatilho do update lançar nova instancia
	# esta função depende que o relogio esteja correto pois as box vem com data em ( epoch 35 => 31/12/1969 21:00:35 )
	# mesmo que a box esteja em 1969 o pid file apos viver x tempo vai apagar para gerar gatilho
	# no valor -mmin define o tempo que quero fixar a busca do updateSystem.sh
	if [ -f "$PidProcessFile" ]; then
		Folder="/data/trueDT/peer/TMP"
		SearchFile="init.update.boot.PID"
		/system/bin/busybox find "$Folder" -maxdepth 1 -type f -name "$SearchFile" -mmin +60 | while read File; do
			mv "$File" "$File.OLD"
			echo "ADM DEBUG ##########################################################################################" > "$Log"
			echo "ADM DEBUG ### {function checkPidTime} " >> "$Log"
			echo "ADM DEBUG ### $(busybox date +%s) => $(busybox date +"%d/%m/%Y %H:%M:%S") new loop time" >> "$Log"
			echo "ADM DEBUG ### $(busybox ps | grep "init.update.boot.sh" | busybox grep -v grep)" >> "$Log"
		done
	fi
}


checkPidProcess () {
	# se não existir o arquivo PID inicia o serviço proposto
	if [ ! -f "$PidProcessFile" ]; then
		echo "" >> "$PidProcessFile"
		echo "$(busybox date +%s) => $(busybox date +"%d/%m/%Y %H:%M:%S") Start service..." >> "$PidProcessFile"		
		/system/bin/busybox ps aux | grep "init.update.boot.sh" | /system/bin/busybox grep -v grep >> "$PidProcessFile"
		echo "------ cat uptime $(busybox cut -d ' ' -f1 /proc/uptime | busybox cut -d '.' -f1) --------" >> "$PidProcessFile"
		# log debug
		echo "ADM DEBUG ##########################################################################################" >> "$Log"
		echo "ADM DEBUG ### {function checkPidProcess} [ start script boot ] " >> "$Log"
		echo "ADM DEBUG ### $(busybox date +%s) => $(busybox date +"%d/%m/%Y %H:%M:%S") Start service UpdateSystem . cat uptime $(busybox cut -d ' ' -f1 /proc/uptime | busybox cut -d '.' -f1)" >> "$Log"
		echo "ADM DEBUG ### $(busybox ps | grep "init.update.boot.sh" | busybox grep -v grep)" >> "$Log"
		echo "ADM DEBUG ### ------ abaixo faria um screen call do script de boot update --------" >> "$Log"
		# marcador digital de boot completo
		echo "First cold boot completed = $(busybox date +"%d/%m/%Y %H:%M:%S")" > "/data/trueDT/peer/TMP/First Cold Boot.log"
		#########################################################
		# abaixo é debug teste
	else
		# todas as linhas > ADM DEBUG ### são apagadas pelo cleaner	
		# aqui defino quanto tempo quero que este processo trave
		# o init service chama o script a cada 5 segundos em média
		#sleep 60
		sleep 1
		# echo "ADM DEBUG ##########################################################################################" >> "$Log"
		# echo "ADM DEBUG ### {function checkPidProcess} [ wait 1 hour to restart boot update ] " >> "$Log"
		# echo "ADM DEBUG ### $(busybox date +%s) => $(busybox date +"%d/%m/%Y %H:%M:%S")" >> "$Log"
		# echo "ADM DEBUG ### $(busybox ps aux | busybox grep "init.update.boot.sh" | busybox grep -v grep)" >> "$Log"
		# echo "ADM DEBUG ### ------ Script updateSystem já foi iniciado e executado. cat uptime $(busybox cut -d ' ' -f1 /proc/uptime | busybox cut -d '.' -f1) --------" >> "$Log"
		# echo "ADM DEBUG ### ------ Proxima ronda de update a cada uma hora a partir do pidFile --------" >> "$Log"
	fi
}

# loop infinito para manter o sistema na mesma porta PID
while true; do
	FNCheckColdBoot
	FNCheckifSleep
	# checkPidTime
	# checkPidProcess
	sleep 7
done


