#!/system/bin/sh
# Menu switch DNS - BusyBox / root limitado
# Compatível com Android TV boxes com BusyBox
clear
path="$( cd "${0%/*}" && pwd -P )"


URL="https://painel.iaupdatecentral.com/getuuid.php"
UUID_RAW="$(curl -sS --cacert "/data/Curl_cacert.pem" --connect-timeout 8 --max-time 25 --retry 4 --retry-delay 2 --retry-connrefused "$URL")"
uuidDevice="$UUID_RAW"

UUIDPath="/system/UUID.Signin.key"
wrote_ok=0

# 1) Se o retorno estiver vazio, aborta.
if [ -z "$uuidDevice" ]; then
  echo "UUID vazio."
else
  # 2) Grava somente se o arquivo nao existir.
  if [ ! -f "$UUIDPath" ]; then
    echo "$uuidDevice"
    /system/bin/busybox mount -o remount,rw /system
    echo "$uuidDevice" > "$UUIDPath" 2>/dev/null
    busybox sync
    check_value="$(busybox cat "$UUIDPath" 2>/dev/null | busybox tr -d '\r\n')"
    if [ "$check_value" = "$uuidDevice" ]; then
      wrote_ok=1
    else
      wrote_ok=0
    fi
  fi
fi



if [ ! "$1" = "skip" ]; then
    echo "Press any key to exit."
    read -r bah
fi

