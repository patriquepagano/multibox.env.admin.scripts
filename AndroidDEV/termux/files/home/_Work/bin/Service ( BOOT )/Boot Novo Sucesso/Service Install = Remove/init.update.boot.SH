#!/system/bin/sh

# shebang do service não funciona se botar bash. utilize o #!/system/bin/sh

export TZ=UTC−03:00
TMP_DIR="/data/trueDT/peer/TMP"

# conteudo gerado nos tvboxes
LogFolder="/data/trueDT/peer/data/client/LOG/services"
ClientHardware="/data/trueDT/peer/data/client/ClientHardware"
# conteudo gerado no servidor
DevSpec="/data/trueDT/peer/data/server/Dev.Spec"
# file marks
Log="$LogFolder/init.update.boot.LOG"
NO_NET=$LogFolder/NoInternetAccess
FIRST_SETUP="$LogFolder/FirstSetupWiFi.log"


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

# vars mac emulation
BB=/system/bin/busybox
IFC="$BB ifconfig eth0"

getHDateNow () {
$BB date +"%d/%m/%Y %H:%M:%S"
}



# Inicio roda apenas uma vez no start do script
# 1) espera o vold subir e montar o emulated storage
until [ "$(getprop init.svc.vold)" = "running" ] && [ -d /storage/emulated/0 ]; do
  sleep 1
done
# 2) espera o netd subir
until [ "$(getprop init.svc.netd)" = "running" ]; do
  sleep 1
done
# 3) espera o Android terminar de bootar de verdade
until [ "$(getprop sys.boot_completed)" = "1" ]; do
  sleep 1
done




# cria os diretorios
mkdir -p "/data/trueDT/peer/data/client/LOG/services"
mkdir -p "/data/trueDT/peer/data/client/chat"
mkdir -p "/data/trueDT/peer/data/client/ClientHardware"
mkdir -p "/data/trueDT/peer/TMP"




echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
echo "USER INFO @@@ $(getHDateNow) = starting init update service" > "$Log"



CheckMacInUse() {
	MacInUse=$($IFC | $BB grep -oE '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' | $BB tr 'A-F' 'a-f')
	echo "USER INFO @@@ $(getHDateNow) Mac in use now = $MacInUse " >> "$Log"
}

SetHardwareInfo() {
	while ! $BB ifconfig | grep -q "eth0"; do
		echo "USER INFO @@@ $(getHDateNow) = Waiting for network lan interface" >> "$Log"
		$BB sleep 1
	done
	CheckMacInUse
	echo -n "$(getprop ro.product.board)" > "$ClientHardware/MB"
	echo -n "$($BB awk -F ': ' '/Serial/ {print $2}' /proc/cpuinfo)" > "$ClientHardware/CPU"
	echo -n "$MacInUse" > "$ClientHardware/macLan"
	Placa=$(< "$ClientHardware/MB")
	CpuSerial=$(< "$ClientHardware/CPU")
	MacLanReal=$(< "$ClientHardware/macLan")
	raw="$Placa|$CpuSerial|$MacLanReal"
	DeviceName="TVBox-$(echo -n "$raw" | $BB md5sum | cut -c1-21)"
	echo -n "$DeviceName" > "$ClientHardware/UniqID"
	echo -n "${DeviceName#TVBox-}" > "$ClientHardware/UniqID.QR"
}

SetHardwareEmulation(){
if [ -f "$TMP_DIR/HE.macLan.Emulated.checkin" ] && [ -f "$TMP_DIR/HE.macLan.Emulated" ]; then
	# pega o mac emulado
	MacLanEmulated=$(< "$TMP_DIR/HE.macLan.Emulated")
	CheckMacInUse
	if [ "$MacInUse" != "$MacLanEmulated" ]; then
		echo "USER INFO @@@ $(getHDateNow) Enable MAC Emulation" >> "$Log"
		bash "$TMP_DIR/HE.macLan.app.reset"
		# espera até refletir
		while [ "$MacInUse" != "$MacLanEmulated" ]; do
			$BB ifconfig eth0 down
			$BB ifconfig eth0 hw ether "$MacLanEmulated"
			$BB ifconfig eth0 up
			echo "USER INFO @@@ $(getHDateNow) Mac LOG" >> "$Log"
			echo "USER INFO @@@ Mac in use : $MacInUse" >> "$Log"
			echo "USER INFO @@@ Mac emulation: $MacLanEmulated" >> "$Log"
			sleep 1
			CheckMacInUse
		done
		echo "USER INFO @@@ $(getHDateNow) MAC OK: $MacInUse" >> "$Log"
		$BB rm "$TMP_DIR/HE.macLan.Emulated.checkin"
	else
		echo "USER INFO @@@ $(getHDateNow) Mac LOG" >> "$Log"
		echo "USER INFO @@@ Mac in use : $MacInUse" >> "$Log"
		echo "USER INFO @@@ Mac emulation: $MacLanEmulated" >> "$Log"
		$BB rm "$TMP_DIR/HE.macLan.Emulated.checkin"
	fi
fi
IDNew=$(< "$TMP_DIR/HE.ID.Emulated.online")
ID=$(cat "$TMP_DIR/HE.ID.Emulated")
if [ "$IDNew" != "$ID" ]; then
    settings put --user 0 secure android_id "$IDNew"
    for i in $(seq 1 5); do
        $BB sleep 1
        GetID="$(settings get secure android_id)"
        [ "$GetID" = "$IDNew" ] && break
    done
    if [ "$GetID" = "$IDNew" ]; then
        echo -n "$IDNew" > "$TMP_DIR/HE.ID.Emulated"
        echo "USER INFO @@@ $(getHDateNow) Android ID changed: $IDNew" >> "$Log"
    else
        echo "USER INFO @@@ $(getHDateNow) Android ID error to apply $IDNew" >> "$Log"
    fi
fi
}

CheckUptime() {
  set -- $(</proc/uptime)
  checkUptime=${1%%.*}
}

# quando o services chamar este script pode ser que o uptime chegue em media a 74secs. 
FNCheckColdBoot () {
CheckUptime
if [ "$checkUptime" -le 150 ]; then
	$BB rm "$LogFolder/init.update.boot.LOG"* > /dev/null 2>&1


	$BB rm -rf "$LogFolder/mLastSleepTime" > /dev/null 2>&1
	$BB rm "$LogFolder/NoInternetAccess" > /dev/null 2>&1
	# marcadores do serviço syncthing
	$BB rm "$LogFolder/Last.Update.Time" > /dev/null 2>&1
	$BB rm "$LogFolder/Start.update.System" > /dev/null 2>&1
	$BB rm "$LogFolder/init.21027.LOG"* > /dev/null 2>&1
	# apaga o marcador de config no boot a frio para forçar nova reconfiguração
	$BB rm $TMP_DIR/init.*cfg.done* > /dev/null 2>&1


	echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" > "$Log"
	echo "USER INFO @@@ $(getHDateNow) First Cold Boot Uptime: $checkUptime" >> "$Log"
	echo "USER INFO @@@ $($BB ps | $BB grep init.update.boot.sh | $BB grep -v grep)" >> "$Log"
	echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
	echo "USER INFO @@@ {function FNCheckColdBoot} " >> "$Log"
	echo "USER INFO @@@ $($BB ps | grep "init.update.boot.sh" | $BB grep -v grep)" >> "$Log"
	echo "USER INFO @@@ New coldboot one time only step" >> "$Log"
	echo "USER INFO @@@ TVBox uptime running $checkUptime" >> "$Log"

	checkPin="$($BB cat /system/.pin)"
	if [ ! "$checkPin" = "FSgfdgkjhç8790d5sdf85sd867f5gs876df5g876sdf5g78s6df5g78s6df5gs87df6g576sfd" ];then
		$BB mount -o remount,rw /system
		echo -n 'FSgfdgkjhç8790d5sdf85sd867f5gs876df5g876sdf5g78s6df5g78s6df5gs87df6g576sfd' > /system/.pin
		chmod 644 /system/.pin
	fi

	echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
	echo "USER INFO @@@ $(getHDateNow) setup android settings..." >> "$Log"
	settings put global heads_up_notifications_enabled 0
	settings put global package_verifier_enable 0
	settings put secure install_non_market_apps 1
	settings put global install_non_market_apps 1
	settings put global policy_control immersive.full=*
	echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
	echo "USER INFO @@@ $(getHDateNow) Cold Boot Finished" >> "$Log"
	# grava o marcador do coldboot
	echo "Cold Boot Finished! uptime:$($BB cut -d ' ' -f1 /proc/uptime | $BB cut -d '.' -f1) $($BB date +"%d/%m/%Y %H:%M:%S")" > "$TMP_DIR/First Cold Boot.log"
	# gravando a mac real
	SetHardwareInfo
	# emulando a mac global
	$BB date > "$TMP_DIR/HE.macLan.Emulated.checkin"
	SetHardwareEmulation
	# tempo suficiente para não entrar mais neste bloco e a internet conectar na box
	while :; do
		set -- $(</proc/uptime)
		uptime_sec=${1%%.*}
		if [ "$uptime_sec" -gt 250 ]; then
			break
		fi
		echo "USER INFO @@@ $(getHDateNow) Wainting internet conection: uptime ${uptime_sec}s" >> "$Log"
		$BB sleep 7
	done	
	# verifica internet apenas uma vez no coldboot e não fica mais chateando cliente
	CheckUptimeInternet
	# atualização da hora ocorre apenas no boot ou apos wake da hibernação
	ClockUpdateNow
fi
}

CheckUptimeInternet () {
# verifica se a box tem internet caso não tenha trava em looping aqui
echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
echo "USER INFO @@@ $(getHDateNow) Testing internet access" >> "$Log"
# debug inicial
echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
echo "USER INFO @@@ $(getHDateNow) {function CheckUptimeInternet} Loop Infinito " >> "$Log"
curl_opts="--head --silent -k --connect-timeout 5 --max-time 10"
if [ ! -f "$FIRST_SETUP" ]; then
  # primeira vez: bloqueia até qualquer link responder 2xx/3xx
  while :; do
    anyUp=0
    for link in "${sites[@]}"; do
      httpcode=$(/system/bin/curl $curl_opts --write-out '%{http_code}' -o /dev/null "$link")
      echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
	  echo "USER INFO @@@ $(getHDateNow)" >> "$Log"
	  echo "USER INFO @@@ link     = $link"       >> "$Log"
      echo "USER INFO @@@ httpcode = $httpcode"    >> "$Log"
      if [ "$httpcode" -ge 200 ] && [ "$httpcode" -lt 600 ]; then
        anyUp=1
        rm -f "$NO_NET"
        break
      fi
    done
    if [ "$anyUp" -eq 1 ]; then
      # internet OK: marca primeira configuração e sai
      ts="$($BB date +%s) => $($BB date '+%d/%m/%Y %H:%M:%S')"
      echo "[ FirstSetupWiFi ] $ts" > "$FIRST_SETUP"
      break
    fi
    # enquanto estiver sem internet o painel não vai sair da frente obrigando usuario a conectar a internet
    echo "USER INFO @@@ $(getHDateNow) Open wifi settings one time only" >> "$Log"
    am start -a com.android.settings -n com.android.settings/com.android.settings.wifi.WifiSettings
    echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
    echo "USER INFO @@@ $(getHDateNow) Check internet access: $($BB date '+%d/%m/%Y %H:%M:%S')" >> "$Log"
    # gera o marcador para os scripts não executarem sem internet
    if [ ! -f "$NO_NET" ]; then
        ts="$($BB date +%s) => $($BB date '+%d/%m/%Y %H:%M:%S')"
        echo "[ NoInternetAccess ] $ts" > "$NO_NET"
    fi
    $BB sleep 11
  done
else
  # não é primeira vez: checa uma vez e segue adiante
  anyUp=0
  for link in "${sites[@]}"; do
    httpcode=$(/system/bin/curl $curl_opts --write-out '%{http_code}' -o /dev/null "$link")
    echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
    echo "USER INFO @@@ $(getHDateNow)" >> "$Log"
	echo "USER INFO @@@ link     = $link"       >> "$Log"
    echo "USER INFO @@@ httpcode = $httpcode"    >> "$Log"
    if [ "$httpcode" -ge 200 ] && [ "$httpcode" -lt 600 ]; then
      anyUp=1
      rm -f "$NO_NET"
      break
    fi
  done
  # se todos falharam, registra NoInternetAccess e segue
  if [ "$anyUp" -ne 1 ]; then
    ts="$($BB date +%s) => $($BB date '+%d/%m/%Y %H:%M:%S')"
    echo "[ NoInternetAccess ] $ts" > "$NO_NET"
  fi
fi
}

WriteUpdateFMark () {
	# marca a hora certa
	echo -n "$($BB date +%s)" > "$LogFolder/Last.Update.Time"
	# Marcador para iniciar o update
	echo "$($BB date +"%d/%m/%Y %H:%M:%S")" >> "$LogFolder/Start.update.System"
}

ClockUpdateNow() {
	# update relogio precisa de um tempo para a box iniciar e chamar o ntp client
	# futuro chamar um script ou service separado para update do relogio
	echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
	echo "USER INFO @@@ $(getHDateNow)" >> "$Log"
	echo "USER INFO @@@ Update time and date" >> "$Log"
	echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
	echo "USER INFO @@@ {function ClockUpdateNow} [ SNTP ]" >> "$Log"
	settings put global ntp_server $NTP_SERVER
	settings put global auto_time 0
	settings put global auto_time 1
	#if ! $BB timeout $SNTP_TIMEOUT $BB ntpd -q -n -p $NTP_SERVER 2>&1 | tee -a "$Log"; then
	if $BB timeout $SNTP_TIMEOUT $BB ntpd -q -n -p $NTP_SERVER 2>&1 | tee -a "$Log"; then
		echo "USER INFO @@@ $(getHDateNow) ntpd OK" >> "$Log"
		# gera o marcador de update
		WriteUpdateFMark
	else
		echo "USER INFO @@@ $(getHDateNow) ntpd error, fallback HTTP-Date" >> "$Log"
		HTTPDateFallback
	fi
	setprop persist.sys.timezone $TIMEZONE
	echo "USER INFO @@@ $(getHDateNow) {function ClockUpdateNow} [ pós-sync ]" >> "$Log"
}

HTTPDateFallback() {
	for site in "${sites[@]}"; do
		echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
		echo "USER INFO @@@ $(getHDateNow) get header date $site" >> "$Log"
		date_hdr=$($BB timeout 11 /system/bin/wget --no-check-certificate -T2 --spider -S "$site" 2>&1 | $BB grep -i '^ *Date:' | $BB head -1 | tr -d '\r')
		# strip “Date: ”, dia da semana e “ GMT”
		# -> "Sun, 22 Jun 2025 01:10:53 GMT"
		date_hdr=${date_hdr#*: }
		# -> "22 Jun 2025 01:10:53 GMT"
		date_hdr=${date_hdr#*, }
		# -> "22 Jun 2025 01:10:53"
		date_hdr=${date_hdr% GMT}
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
		echo "USER INFO @@@ setup iso $iso_local (Brazil)" >> "$Log"
		$BB date -s "$iso_local"
		echo "USER INFO @@@ $(getHDateNow) time adjusted:')" >> "$Log"
		$BB rm "$NO_NET"
		# gera o marcador de update
		WriteUpdateFMark
		else
		# sem internet nem fallback → marca e segue
		ts="$($BB date +%s) => $($BB date '+%d/%m/%Y %H:%M:%S')"
		echo "[ NoInternetAccess ] $ts" >> "$NO_NET"
		echo "USER INFO @@@ $(getHDateNow) NoInternetAccess: " >> "$Log"
	fi
}

FNCheckifSleep() {
    local CheckifSleep WakeUpTime
    CheckifSleep=$(dumpsys power | $BB awk -F'[= ]+' '/mLastSleepTime/ {print $3; exit}')
    if [ "$CheckifSleep" != "0" ]; then
        if [ ! -f "$LogFolder/mLastSleepTime/$CheckifSleep" ]; then
            mkdir -p "$LogFolder/mLastSleepTime"
            WakeUpTime="Wake from sleep $($BB date +%s) => $($BB date +"%d/%m/%Y %H:%M:%S")"
            echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
            echo "USER INFO @@@ $(getHDateNow)" >> "$Log"
			echo "USER INFO @@@ {function FNCheckifSleep} " >> "$Log"
            echo "USER INFO @@@ Tvbox come back mLastSleepTime" >> "$Log"
            echo "USER INFO @@@ Sync time by url" >> "$Log"
            # espera rede local (qualquer iface IPv4 não-loopback)
            while [ -z "$(ip -o -4 addr show scope global)" ]; do
                echo "USER INFO @@@ $(getHDateNow) waiting network connection" >> "$Log"
                $BB sleep 1
            done
            CheckUptimeInternet
            ClockUpdateNow
            echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
            echo "$WakeUpTime" > "$LogFolder/mLastSleepTime/$CheckifSleep"
            echo "Braziliam Time $($BB date +%s) => $($BB date +"%d/%m/%Y %H:%M:%S")" >> "$LogFolder/mLastSleepTime/$CheckifSleep"
        fi
    fi
}

loadSyncthingVars (){
	IP=`$BB ifconfig | $BB grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | $BB grep -Eo '([0-9]*\.){3}[0-9]*' | $BB grep -v '127.0.0.1' | $BB head -1`
	Placa=$(< "$ClientHardware/MB")
	CpuSerial=$(< "$ClientHardware/CPU")
	MacLanReal=$(< "$ClientHardware/macLan")
	DeviceName=$(< "$ClientHardware/UniqID")
	DeviceNameQR=$(< "$ClientHardware/UniqID.QR")
	SyncID=$(< "$TMP_DIR/init.21027.ID")
	CfgXML="/data/trueDT/peer/config/config.xml"
	APIKEY=$($BB awk -F '[><]' '/<apikey>/ {print $3}' "$CfgXML")
	Headers="Content-Type: application/json"
SyncthingServersMirrors='Z5ITMCU-XQD2YN4-3AWJ6IU-GHQ3CBH-LUUJSB7-EVIYGYK-KCBIRZZ-NS2KNA7;datacenter;free-mirror.1
XMGJDYA-5YEALCS-57T3BV5-R2TUX7L-GUZX3EK-T3VNZNC-OVJ2F6A-YLQDOAL;datacenter;free-mirror.2
GY2SB4F-3VBKXVP-CKIBMMS-7CZGZEZ-5IQUGBD-SIFHGWP-FHDVQAG-6F45YAA;datacenter;free-mirror.3
FV44NCY-BJLGYVF-MGMXJVT-VGQRWUC-PC557GO-U7VSXM4-4DIEJBZ-V44XOAX;datacenter;free-mirror.4
APH5XO4-ZTCRBIM-HONXXAG-7GWUSOL-DJE54OQ-OG4QOEZ-IZJC3UB-RVVFDAF;datacenter;free-mirror.5'
}


SyncthingRemoveServers () {
	DevURL="http://127.0.0.1:8384/rest/config/folders"
	Headers='Content-Type: application/json'

	# pega todos os folder IDs configurados localmente
	Folders=$(curl -s -H "X-API-Key: $APIKEY" "$DevURL" | $BB awk -F'"' '/"id":/ { print $4 }')
	for folder in $Folders; do
		# remove se o ID contiver Client|Server|SyncOK
		if echo "$folder" | $BB grep -Eq '^TVBox-.*-(Client|Server|SyncOK)$'; then
			#echo "REMOVENDO compartilhamento: $folder"
			curl -s -X DELETE -H "X-API-Key: $APIKEY" "$DevURL/$folder"
			$BB sleep 3
		fi
	done

	IDs=$(echo "$SyncthingServersMirrors" | $BB awk -F';' '{print $1}')
	DeviceURL="http://127.0.0.1:8384/rest/config/devices"
	# para cada device do SyncthingServersMirrors
	for id in $IDs; do
		[ "$id" = "$SyncID" ] && continue
		#echo "REMOVENDO device $id"
		curl -s -X DELETE -H "X-API-Key: $APIKEY" "$DeviceURL/$id"
		$BB sleep 2
	done



}

SyncthingAddServers () {
	DevURL="http://127.0.0.1:8384/rest/config/devices"
	Headers='Content-Type: application/json'
	while IFS=';' read -r DeviceID Category UserName; do
	[ -z "$DeviceID" ] && continue
	if ! $BB grep -q "$DeviceID" "$CfgXML"; then
		#echo "ADM DEBUG ### Adicionando device: $DeviceID"
		Data="{\"deviceID\":\"$DeviceID\",\"name\":\"$Category $UserName\",\"autoAcceptFolders\":false,\"paused\":false}"
		curl -s -X POST -H "X-API-Key: $APIKEY" -H "$Headers" "$DevURL" -d "$Data"
	# else
	# 	echo "ADM DEBUG ### server já existe: $DeviceID"
	fi
	done <<< "$SyncthingServersMirrors"
}

SyncthingProfileClient () {
mkdir -p "/data/trueDT/peer/data/client"
touch "/data/trueDT/peer/data/client/.stfolder"
date > "/data/trueDT/peer/data/client/Z_post-Update.log"

DevURL="http://127.0.0.1:8384/rest/config/folders"

if ! $BB grep -q "id=\"$DeviceName-Client\"" "$CfgXML"; then
echo "ADM DEBUG ### Importando profile sendonly Client ($DeviceName-Client)"

# monta entries sem vírgula final
DeviceEntries=$(
echo "$SyncthingServersMirrors" | $BB sed '/^\s*$/d' | while IFS=';' read -r id cat name; do
	printf '    {"deviceID":"%s","introducedBy":"","encryptionPassword":""},\n' "$id"
done | $BB sed '$s/,$//'
)

# envia JSON direto ao curl, sem arquivo temporário
curl -X POST -H "X-API-Key: $APIKEY" -H "Content-Type: application/json" "$DevURL" -d @- <<EOF
{
  "id": "$DeviceName-Client",
  "label": "$DeviceName-Client",
  "filesystemType": "basic",
  "path": "/data/trueDT/peer/data/client",
  "type": "sendonly",
  "devices": [
$DeviceEntries
  ],
  "rescanIntervalS": 3600,
  "fsWatcherEnabled": true,
  "fsWatcherDelayS": 10,
  "ignorePerms": false,
  "autoNormalize": true,
  "minDiskFree": { "value": 0, "unit": "" },
  "versioning": { "type": "", "params": {}, "cleanupIntervalS": 0, "fsPath": "", "fsType": "basic" },
  "copiers": 1,
  "pullerMaxPendingKiB": 0,
  "hashers": 0,
  "order": "random",
  "ignoreDelete": false,
  "scanProgressIntervalS": 0,
  "pullerPauseS": 0,
  "maxConflicts": 0,
  "disableSparseFiles": false,
  "disableTempIndexes": false,
  "paused": false,
  "weakHashThresholdPct": 25,
  "markerName": ".stfolder",
  "copyOwnershipFromParent": false,
  "modTimeWindowS": 0,
  "maxConcurrentWrites": 2,
  "disableFsync": false,
  "blockPullOrder": "standard",
  "copyRangeMethod": "standard",
  "caseSensitiveFS": false,
  "junctionsAsDirs": false
}
EOF
fi
}

SyncthingProfileServer () {
mkdir -p "/data/trueDT/peer/data/server"
touch "/data/trueDT/peer/data/server/.stfolder"
FolderURL="http://127.0.0.1:8384/rest/config/folders"
Headers='Content-Type: application/json'

if ! $BB grep -q "id=\"$DeviceName-Server\"" "$CfgXML"; then
  echo "ADM DEBUG ### Importando profile receiveonly Server ($DeviceName-Server)"

# monta entries sem vírgula final
DeviceEntries=$(
  echo "$SyncthingServersMirrors" | $BB sed '/^\s*$/d' | while IFS=';' read -r id cat name; do
    printf '    {"deviceID":"%s","introducedBy":"","encryptionPassword":""},\n' "$id"
  done | $BB sed '$s/,$//'
)

# envia JSON direto ao curl
curl -X POST -H "X-API-Key: $APIKEY" -H "$Headers" "$FolderURL" -d @- <<EOF
{
  "id":"$DeviceName-Server",
  "label":"$DeviceName-Server",
  "filesystemType":"basic",
  "path":"/data/trueDT/peer/data/server",
  "type":"receiveonly",
  "devices":[
$DeviceEntries
  ],
  "rescanIntervalS":3600,
  "fsWatcherEnabled":true,
  "fsWatcherDelayS":10,
  "ignorePerms":false,
  "autoNormalize":true,
  "minDiskFree":{"value":0,"unit":""},
  "versioning":{"type":"","params":{},"cleanupIntervalS":0,"fsPath":"","fsType":"basic"},
  "copiers":1,
  "pullerMaxPendingKiB":0,
  "hashers":0,
  "order":"oldestFirst",
  "ignoreDelete":false,
  "scanProgressIntervalS":0,
  "pullerPauseS":0,
  "maxConflicts":0,
  "disableSparseFiles":false,
  "disableTempIndexes":false,
  "paused":false,
  "weakHashThresholdPct":25,
  "markerName":".stfolder",
  "copyOwnershipFromParent":false,
  "modTimeWindowS":0,
  "maxConcurrentWrites":2,
  "disableFsync":false,
  "blockPullOrder":"standard",
  "copyRangeMethod":"standard",
  "caseSensitiveFS":false,
  "junctionsAsDirs":false
}
EOF
fi
}

SyncthingProfileSyncOK () {
mkdir -p "/data/trueDT/peer/data/SyncOK"
date > "/data/trueDT/peer/data/SyncOK/Z_post-Update.log"

DevURL="http://127.0.0.1:8384/rest/config/folders"

if ! $BB grep -q "id=\"$DeviceName-SyncOK\"" "$CfgXML"; then
echo "ADM DEBUG ### Importando profile sendonly SyncOK ($DeviceName-SyncOK)"

# monta entries sem vírgula final
DeviceEntries=$(
echo "$SyncthingServersMirrors" | $BB sed '/^\s*$/d' | while IFS=';' read -r id cat name; do
	printf '    {"deviceID":"%s","introducedBy":"","encryptionPassword":""},\n' "$id"
done | $BB sed '$s/,$//'
)

# envia JSON direto ao curl, sem arquivo temporário
curl -X POST -H "X-API-Key: $APIKEY" -H "Content-Type: application/json" "$DevURL" -d @- <<EOF
{
  "id": "$DeviceName-SyncOK",
  "label": "$DeviceName-SyncOK",
  "filesystemType": "basic",
  "path": "/data/trueDT/peer/data/SyncOK",
  "type": "sendonly",
  "devices": [
$DeviceEntries
  ],
  "rescanIntervalS": 3600,
  "fsWatcherEnabled": true,
  "fsWatcherDelayS": 10,
  "ignorePerms": false,
  "autoNormalize": true,
  "minDiskFree": { "value": 0, "unit": "" },
  "versioning": { "type": "", "params": {}, "cleanupIntervalS": 0, "fsPath": "", "fsType": "basic" },
  "copiers": 1,
  "pullerMaxPendingKiB": 0,
  "hashers": 0,
  "order": "random",
  "ignoreDelete": false,
  "scanProgressIntervalS": 0,
  "pullerPauseS": 0,
  "maxConflicts": 0,
  "disableSparseFiles": false,
  "disableTempIndexes": false,
  "paused": false,
  "weakHashThresholdPct": 25,
  "markerName": ".stfolder",
  "copyOwnershipFromParent": false,
  "modTimeWindowS": 0,
  "maxConcurrentWrites": 2,
  "disableFsync": false,
  "blockPullOrder": "standard",
  "copyRangeMethod": "standard",
  "caseSensitiveFS": false,
  "junctionsAsDirs": false
}
EOF
fi
}


SyncthingCheckSyncState () {
APIURL="http://127.0.0.1:8384/rest"
FOLDERS_URL="$APIURL/config/folders"
DEVICES_URL="$APIURL/config/devices"
CONN_URL="$APIURL/system/connections"
cleaned=""
# loop nas pastas Client
curl -s -H "X-API-Key: $APIKEY" "$FOLDERS_URL" \
  | $BB awk -F '"' '/"id":/ {print $4}' \
  | $BB grep -E "^TVBox-.*$SearchFolder" \
  | while read -r folder; do
    # remotes (exclui self)
    devs=$(curl -s -H "X-API-Key: $APIKEY" "$FOLDERS_URL/$folder" | $BB awk -F '"' '/"deviceID":/ {print $4}')
    remotes=$(echo "$devs" | $BB grep -v -x "$SyncID")
    [ -z "$remotes" ] && continue
    remove_now=0
    for remote in $remotes; do
      # valor na box local
      DBCompletionBox="$(curl -s -H "X-API-Key: $APIKEY" "http://127.0.0.1:8384/rest/db/completion?folder=$folder&device=$SyncID")"
      # extrai só o número (100)
      completionTVBOX=$($BB awk -F '[:, ]+' '/"completion"/{print $3}' <<<"$DBCompletionBox")
      # valores no remoto
      DBCompletionServer="$(curl -s -H "X-API-Key: $APIKEY" "http://127.0.0.1:8384/rest/db/completion?folder=$folder&device=$remote")"
      # extrai só o número (100)
      completionServer=$($BB awk -F '[:, ]+' '/"completion"/{print $3}' <<<"$DBCompletionServer")
      # extrai só a string (valid)
      remoteState=$($BB awk -F '[":, ]+' '/"remoteState"/{print $3}' <<<"$DBCompletionServer")
      # se qualquer remote sincronizado e conectado, marca remoção
      if [ "$completionTVBOX" = "100" ] && [ "$completionServer" = "100" ] && [ "$remoteState" = "valid" ]; then
		echo "#########################################################################" >>  "$Log"
		echo "DEBUG Folder  = $folder" >> "$Log"
		echo "#########################################################################" >>  "$Log"
		echo "DEBUG TVBOXID = $SyncID" >> "$Log"
		echo "DEBUG sync em $completionTVBOX% " >>  "$Log"
		echo "$DBCompletionBox" >>  "$Log"
		echo "#########################################################################" >>  "$Log"
		echo "DEBUG remote  = $remote" >> "$Log"
		echo "DEBUG sync em $completionServer% remote state = $remoteState" >>  "$Log"
		echo "$DBCompletionServer" >>  "$Log"
        remove_now=1
        break
      fi
    done
    # remove se marcado
    if [ "$remove_now" -eq 1 ]; then
	  date > "$TMP_DIR/init.21027.sync100%-$SearchFolder"
    fi
  done

}

SyncthingCheckSystemConnection () {
CONN_URL="$APIURL/system/connections"
# captura 1 vez o JSON das conexões
conns=$(curl -s -H "X-API-Key:$APIKEY" "$CONN_URL")
#echo "$(date +'%F %T') DEBUG raw connections: $conns" >> "$Log"
all_offline=1
# itera os mirrors no mesmo shell
for line in $($BB printf '%s\n' "$SyncthingServersMirrors"); do
  # quebra "DeviceID;location;mirror" em três variáveis
  set -- $($BB printf '%s' "$line" | tr ';' ' ')
  deviceID=$1
  location=$2
  mirror=$3
  # extrai bloco que contém até o campo connected
  block=$(
    $BB printf '%s\n' "$conns" \
    | $BB grep -F -A 6 "\"$deviceID\":"
  )
  # se encontrar connected:true, temos online → sai do loop
  if $BB printf '%s\n' "$block" | $BB grep -q '"connected":[[:space:]]*true'; then
    # algum mirror esta online
    all_offline=0
    break
  fi
done
# aqui dispara apenas quando **todos** os mirrors estiverem offline
if [ "$all_offline" -eq 1 ]; then
	echo "TODOS os mirrors OFFLINE desconectando sistema update" >> "$Log"
	if [ ! -f "$DevSpec/21027/FullAccess" ] ; then
		SyncthingShutdown
	else
		SyncthingFullAccess
	fi
fi
}


SyncthingForceOverride () {
BaseURL="http://127.0.0.1:8384"
Headers="Content-Type: application/json"

# pega todos os folder IDs
Folders=$(curl -s -H "X-API-Key: $APIKEY" "$BaseURL/rest/config/folders" \
  | $BB awk -F'"' '/"id":/ { print $4 }')

for folder in $Folders; do
  # busca config da pasta
  FolderInfo=$(curl -s -H "X-API-Key: $APIKEY" \
    "$BaseURL/rest/config/folders/$folder")
  Label=$(echo "$FolderInfo" | $BB awk -F'"' '/"label":/ { print $4 }')
  Type=$(echo "$FolderInfo" | $BB awk -F'"' '/"type":/ { print $4 }')
  StatusURL="$BaseURL/rest/db/status?folder=$folder"
  StatusJSON=$(curl -s -H "X-API-Key:$API" "$StatusURL")

  # filtro para sendonly (TVBox-*-Client)
  if echo "$Label" | $BB grep -Eq '^TVBox-.*-Client$' && [ "$Type" = "sendonly" ]; then
    sendFiles=$($BB awk -F': ' '/needFiles/ {gsub(/,/, ""); print $2}' <<<"$StatusJSON")
    if [ "${sendFiles:-0}" -gt 0 ]; then
        echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
        echo "USER INFO @@@ $(getHDateNow) [service 21017] OVERRIDE sendonly: " >> "$Log"
        echo "USER INFO @@@ $folder ($sendFiles waiting files)" >> "$Log"
        curl -s -X POST -H "X-API-Key:$API" \
            "$BaseURL/rest/db/override?folder=$folder"
    fi
  fi

  # filtro para receiveonly (TVBox-*-Server)
  if echo "$Label" | $BB grep -Eq '^TVBox-.*-Server$' && [ "$Type" = "receiveonly" ]; then
    recvFiles=$($BB awk -F': ' '/receiveOnlyChangedFiles/ {gsub(/,/, ""); print $2}' <<<"$StatusJSON")
    if [ "${recvFiles:-0}" -gt 0 ]; then
        echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
        echo "USER INFO @@@ $(getHDateNow) [service 21017] REVERT receiveonly: " >> "$Log"
        echo "USER INFO @@@ $folder ($recvFiles local changes)" >> "$Log"
        curl -s -X POST -H "X-API-Key:$API" \
            "$BaseURL/rest/db/revert?folder=$folder"
    fi
  fi
done
}

SyncthingShutdown () {
	SyncthingRemoveServers
	setprop ctl.stop init21027
	$BB rm "$TMP_DIR/init.21027.started.service"
	# elimina o marcador de update
	$BB rm "$LogFolder/Start.update.System"
	$BB rm "$TMP_DIR/init.21027.sync100%"*
	$BB rm /data/trueDT/peer/config/.syncthing.tmp.*
}

SyncthingFullAccess () {
	SyncthingRemoveServers
	$BB rm "$TMP_DIR/init.21027.started.service"
	# elimina o marcador de update
	$BB rm "$LogFolder/Start.update.System"
	$BB rm "$TMP_DIR/init.21027.sync100%"*
	$BB rm /data/trueDT/peer/config/.syncthing.tmp.*
}


FNSetup21027() {
# se existir o marcador do update inicia o syncthing
if [ -f "$LogFolder/Start.update.System" ]; then
	# ativa o serviço
	setprop ctl.start init21027
	# se não existir o cfg.done entao configura e inicia
	if [ ! -f "$TMP_DIR/init.21027.cfg.done" ]; then
		loadSyncthingVars
		if curl -s -m 2 -H "X-API-Key: $APIKEY" "http://127.0.0.1:8384/rest/system/status" | grep -q '"myID"'; then
			# opções básicas
			OptionsURL="http://127.0.0.1:8384/rest/config/options"
			OptionsData='{"startBrowser":false,"urAccepted":-1,"urSeen":3,"crashReportingEnabled":false,"RawListenAddresses":["default"],"maxRecvKbps":0,"maxSendKbps":0,"natEnabled":true,"globalAnnounceEnabled":true,"localAnnounceEnabled":true,"relaysEnabled":true,"globalAnnounceServer":["default"]}'
			if ! $BB grep -q "<startBrowser>false</startBrowser>" "$CfgXML" || \
				! $BB grep -q "<urAccepted>-1</urAccepted>" "$CfgXML" || \
				! $BB grep -q "<urSeen>3</urSeen>" "$CfgXML" || \
				! $BB grep -q "<crashReportingEnabled>false</crashReportingEnabled>" "$CfgXML" || \
				! $BB grep -q "<listenAddress>default</listenAddress>" "$CfgXML" || \
				! $BB grep -q "<maxRecvKbps>0</maxRecvKbps>" "$CfgXML" || \
				! $BB grep -q "<maxSendKbps>0</maxSendKbps>" "$CfgXML" || \
				! $BB grep -q "<natEnabled>true</natEnabled>" "$CfgXML" || \
				! $BB grep -q "<globalAnnounceEnabled>true</globalAnnounceEnabled>" "$CfgXML" || \
				! $BB grep -q "<localAnnounceEnabled>true</localAnnounceEnabled>" "$CfgXML" || \
				! $BB grep -q "<relaysEnabled>true</relaysEnabled>" "$CfgXML" || \
				! $BB grep -q "<globalAnnounceServer>default</globalAnnounceServer>" "$CfgXML"; then
				echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
				echo "USER INFO @@@ Setup oficial options" >> "$Log"
				curl -X PATCH -H "X-API-Key: $APIKEY" "$OptionsURL" -H "$Headers" -d "$OptionsData"
				$BB sleep 2
			fi
			# devicename e desativar auto aceitar folders
			DevURL="http://127.0.0.1:8384/rest/config/devices"
			DevData="{\"deviceID\":\"$SyncID\",\"name\":\"$IP $(getHDateNow) $DeviceName\",\"autoAcceptFolders\":false,\"paused\":false}"
			if ! $BB grep -q "name=\"$IP $(getHDateNow) $DeviceName\"" "$CfgXML" || \
				! $BB grep -q "<autoAcceptFolders>false</autoAcceptFolders>" "$CfgXML" || \
				! $BB grep -q "<paused>false</paused>" "$CfgXML"; then
				echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
				echo "USER INFO @@@ setup device name $DeviceName" >> "$Log"
				echo "USER INFO @@@ disable auto folders" >> "$Log"
				curl -X POST -H "X-API-Key: $APIKEY" "$DevURL" -H "$Headers" -d "$DevData"
				$BB sleep 2
			fi
			# Qrcode do hardware ID para contato
			QRUrl="http://127.0.0.1:8384/qr/"
			DeviceNamePNG=$(tail -n1 "$TMP_DIR/TVBoxID.png" 2>/dev/null)
			if [ "$DeviceNameQR" != "$DeviceNamePNG" ]; then
				curl -s -H "X-API-Key: $APIKEY" \
					-G --data-urlencode "text=$DeviceNameQR" \
					"$QRUrl" > "$TMP_DIR/TVBoxID.png"
				{
					echo ""
					echo "$DeviceNameQR"
				} >> "$TMP_DIR/TVBoxID.png"
			fi
			GuiURL="http://127.0.0.1:8384/rest/config/gui"
			# sem full access: define senha e ajusta endereço
			if ! $BB grep -q '<user>' "$CfgXML"; then
				UserSync="$RANDOM"
				Pass="$RANDOM-$RANDOM-$RANDOM-$RANDOM"
				echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
				echo "USER INFO @@@ $(getHDateNow) $DeviceName no full access" >> "$Log"
				echo "ADM DEBUG ### GUI = User=$UserSync senha=$Pass" >> "$Log"
				DataPass="{\"enabled\":true,\"user\":\"$UserSync\",\"password\":\"$Pass\",\"address\":\"127.0.0.1:8384\"}"
				curl -X PATCH -H "X-API-Key: $APIKEY" "$GuiURL" -H "$Headers" -d "$DataPass"
				$BB sleep 2
			fi
			# carrega as variaveis uma vez dentro deste looping
			loadSyncthingVars
			# no first setup remove e limpa os servers
			SyncthingRemoveServers

			# Marcador que determina quando serviço iniciou e esta configurado
			# o tempo é mensurado a partir deste marcador
			# este marcador vale apenas para usuarios limitados
			echo "$($BB date +%s)" > "$TMP_DIR/init.21027.started.service"
			echo "$(getHDateNow)" >> "$TMP_DIR/init.21027.started.service"

			# Tempo para deixar o syncthing restruturar sua config e gerar um pouco de log para analize posterior
			#$BB sleep 120

			# fazer backup da config
			mkdir -p /data/trueDT/peer/data/client/BKP/21027
			rsync -a --exclude='index-v0.14.0.db/' /data/trueDT/peer/config/ /data/trueDT/peer/data/client/BKP/21027/
			# copia do log do first boot syncthing
			$BB cp "$TMP_DIR/init.21027.fullReport.log" "$LogFolder/"

			# marcador que em sua inexistencia é gatilho para configurar o syncthing
			echo "$($BB date +"%d/%m/%Y %H:%M:%S")" >> "$TMP_DIR/init.21027.cfg.done"
		fi
	fi
	# comandos aqui que rodam sempre no looping enquanto existir o marcador "$LogFolder/Start.update.System"
	if [ -f "$TMP_DIR/init.21027.cfg.done" ]; then
		if curl -s -m 2 -H "X-API-Key: $APIKEY" "http://127.0.0.1:8384/rest/system/status" | grep -q '"myID"'; then
			loadSyncthingVars
			$BB sleep 3
			if [ ! -f "$TMP_DIR/init.21027.sync100%-Client" ]; then
				if $BB grep -q "${DeviceName}-Client" "$CfgXML"; then
					# busca por atualização na pasta client
					SyncthingForceOverride
					$BB sleep 3
					SearchFolder="Client"
					SyncthingCheckSyncState
					$BB sleep 3
				else
					SyncthingAddServers
					SyncthingProfileClient
					$BB sleep 3
				fi
			fi
			if [ -f "$TMP_DIR/init.21027.sync100%-Client" ]; then
				if [ ! -f "$TMP_DIR/init.21027.sync100%-Server" ]; then
					if $BB grep -q "${DeviceName}-Server" "$CfgXML"; then
						# busca por atualização na pasta Server
						SyncthingForceOverride
						$BB sleep 3
						SearchFolder="Server"
						SyncthingCheckSyncState
						$BB sleep 3
					else
						SyncthingProfileServer
						$BB sleep 3
					fi
				fi
			fi
			if [ -f "$TMP_DIR/init.21027.sync100%-Server" ]; then
				if [ ! -f "$TMP_DIR/init.21027.sync100%-SyncOK" ]; then
					if ! $BB grep -q "${DeviceName}-SyncOK" "$CfgXML"; then
						SyncthingProfileSyncOK
						$BB sleep 3
						$BB date > "$TMP_DIR/init.21027.sync100%-SyncOK"
					fi
				fi
			fi
			# desliga por race condition na box
			if [ -f "$TMP_DIR/init.21027.sync100%-SyncOK" ]; then
				SyncthingCheckSystemConnection
			fi

			# desligamento do serviço dentro de 10 minutos para users globais e limitados
			if [ -f "$TMP_DIR/init.21027.started.service" ]; then
					# pega o epoch salvo
					last_update=$($BB head -n1 "$TMP_DIR/init.21027.started.service")
					# pega o epoch agora
					now=$($BB date +%s)
					# diferença em segundos
					delta=$(( now - last_update ))
					# se já passou tempo x segundos fecha o serviço syncthing
					# 10 minutos para sincronizar = 600
					StopSyncTime="300"
				if [ ! -f "$DevSpec/21027/FullAccess" ] ; then
					if [ "$delta" -ge "$StopSyncTime" ]; then
						SyncthingShutdown
					fi
				else
					if [ "$delta" -ge "$StopSyncTime" ]; then
						SyncthingFullAccess
						echo "USER INFO @@@ $(getHDateNow) init 21027 Waiting to stop in $delta seconds" >> "$Log"
					fi
				fi
			fi
			# users admin e devs
			if [ -f "$DevSpec/21027/FullAccess" ] ; then
				# carrega profiles especificos
				if [ ! -f "$TMP_DIR/init.21027.FullAccess.cfg.done" ]; then
					if $BB grep -q '<user>[^<]' "$CfgXML"; then
						echo "USER INFO @@@ $(getHDateNow) init 21027 FullAccess Device load profiles" >> "$Log"
						"$DevSpec/21027/FullAccess"
						echo "$($BB date +"%d/%m/%Y %H:%M:%S")" > "$TMP_DIR/init.21027.FullAccess.cfg.done"
						$BB sleep 3
					fi
				fi
			fi
		fi
	fi
# final do if se existir o marcador do update inicia o syncthing
fi

}


# mesmo conceito do setup syncthing para o transmission




### posso criar um gatilho apos uma hora que reativa o syncthing
# apos o update ele desativa o syncthing novamente
FNCron() {
  # só continua se houver o arquivo com o último update
  if [ -f "$LogFolder/Last.Update.Time" ]; then
    # pega o epoch salvo
    last_update=$($BB head -n1 "$LogFolder/Last.Update.Time")
    # pega o epoch agora
    now=$($BB date +%s)
    # diferença em segundos
    delta=$(( now - last_update ))
	# echo "USER INFO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> "$Log"
	# echo "USER INFO @@@ $(getHDateNow) FNCron 4update" >> "$Log"
    # echo "USER INFO @@@ Last update epoch: $last_update" >> "$Log"
    # echo "USER INFO @@@ Current epoch    : $now"        >> "$Log"
    # echo "USER INFO @@@ Delta (s)       : $delta"      >> "$Log"
    # se já passou 3600s (1h), cria o marcador
	CronCicle="1200"
	CronCicle="3600"
    if [ "$delta" -ge "$CronCicle" ]; then
		echo "USER INFO @@@ New update time > $(getHDateNow)" >> "$Log"
		# atualiza o Last.Update.Time pro próximo ciclo
		ClockUpdateNow
    fi
  fi
}

while true; do
	FNCheckColdBoot
	FNCheckifSleep
	SetHardwareEmulation
	FNSetup21027
	#echo "USER INFO @@@ [$(getHDateNow)] = loop while call functions" >> "$Log"
	FNCron
	sleep 7
done

# boxes estao ligando do boot a frio e ficam travadas tentando sincar e não desligam apos os 10 minutos
# mesmo a box sendo privilegiada ela chama o SyncthingRemoveServers

# requisições de dispositivos "" sem nome fica chegando no server e nao sei oque é



# conceituar a ideia do marcador estatico para alivicar o syncthing
# marcadore de versoes em multimirrors sites: codeshare, github, txtonline, telegraph etc..
# fazer a soma do arquivo torrent e binario de boot offline
# se o user tiver a mesma versão roda novamente em local tudo em looping mantendo a config exata de tudo




# [] falta tratar a situação da box offline se vale a pena forçar o user ou não precisa ?
#    - se for usar o syncthing para update realmente não precisa mais forçar estar online


# adicionar este rescan no fluxo da criação dos profiles

# # 3) força reindex via API
# curl -s -X POST -H "X-API-Key:$APIKEY" \
#   "$APIURL/system/rescan?folder=$folder" \
#   && echo "DEBUG: rescan iniciado para $folder"

# # 4) dispara o override no lado send-only
# curl -s -X POST -H "X-API-Key:$APIKEY" \
#   "$APIURL/db/override?folder=$folder" \
#   && echo "DEBUG: override executado em $folder"
