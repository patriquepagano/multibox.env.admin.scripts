#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear
TMP_DIR="/data/trueDT/peer/TMP"

BB=/system/bin/busybox


SyncID=$(< "$TMP_DIR/init.21027.ID")
CfgXML="/data/trueDT/peer/config/config.xml"
APIKEY=$($BB awk -F '[><]' '/<apikey>/ {print $3}' "$CfgXML")

APIURL="http://127.0.0.1:8384/rest"
FOLDERS_URL="$APIURL/config/folders"
DEVICES_URL="$APIURL/config/devices"
CONN_URL="$APIURL/system/connections"
cleaned=""

# pasta de log
LOG="$path/systemconnections.log"

date > "$LOG"

SyncthingServersMirrors='Z5ITMCU-XQD2YN4-3AWJ6IU-GHQ3CBH-LUUJSB7-EVIYGYK-KCBIRZZ-NS2KNA7;datacenter;free-mirror.1
XMGJDYA-5YEALCS-57T3BV5-R2TUX7L-GUZX3EK-T3VNZNC-OVJ2F6A-YLQDOAL;datacenter;free-mirror.2
GY2SB4F-3VBKXVP-CKIBMMS-7CZGZEZ-5IQUGBD-SIFHGWP-FHDVQAG-6F45YAA;datacenter;free-mirror.3
FV44NCY-BJLGYVF-MGMXJVT-VGQRWUC-PC557GO-U7VSXM4-4DIEJBZ-V44XOAX;datacenter;free-mirror.4
APH5XO4-ZTCRBIM-HONXXAG-7GWUSOL-DJE54OQ-OG4QOEZ-IZJC3UB-RVVFDAF;datacenter;free-mirror.5'


# captura 1 vez o JSON das conexões
conns=$(curl -s -H "X-API-Key:$APIKEY" "$CONN_URL")
#echo "$(date +'%F %T') DEBUG raw connections: $conns" >>"$LOG"
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
  # <<< COLOQUE AQUI A SUA AÇÃO DE “ALL OFFLINE” >>>
  # ex: reinicia serviço, envia alerta, etc.
  echo "TODOS os mirrors OFFLINE desconectando sistema update" >>"$LOG"
fi


