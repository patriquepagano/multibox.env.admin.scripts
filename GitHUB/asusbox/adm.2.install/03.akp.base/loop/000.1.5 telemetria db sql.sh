# ------------------------------------------------------

# UNIQ DEVICE IDENTIFICATION
Placa=$(getprop ro.product.board)
CpuSerial=`busybox cat /proc/cpuinfo | busybox grep Serial | busybox awk '{ print $3 }'`
MacLanReal=`/system/bin/busybox cat /data/macLan.hardware | busybox sed 's;:;;g'`

do_post() {
  curl -sS --cacert "/data/Curl_cacert.pem" --connect-timeout 8 --max-time 25 --retry 4 --retry-delay 2 --retry-max-time 25 --retry-connrefused \
    -w "\nHTTP_STATUS=%{http_code}\n" -X POST "$PostURL" \
    -H "X-Auth-Token: mbx_9f3a7d1b2c4e6f8a0b1c3d5e7f9a1b2c3d4e6f8a" \
    -d "UUIDBOX=${UUIDBOX:-}" \
    -d "Placa=${Placa:-}" \
    -d "CpuSerial=${CpuSerial:-}" \
    -d "MacLanReal=${MacLanReal:-}" \
    -d "MacWiFiReal=${MacWiFiReal:-}" \
    -d "ServiceGeoIP=${ServiceGeoIP:-}" \
    -d "IPExterno=${IPExterno:-}" \
    -d "country=${country:-}" \
    -d "region=${region:-}" \
    -d "city=${city:-}" \
    -d "Operadora=${Operadora:-}" \
    -d "FirstsignupUnix=${FirstsignupUnix:-}" \
    -d "FirmwareInstallUnix=${FirmwareInstallUnix:-}" \
    -d "FirmwareHardResetUnix=${FirmwareHardResetUnix:-}" \
    -d "UpdateSystemVersion=${UpdateSystemVersion:-}" \
    -d "FirmwareFullSpecsID=${FirmwareFullSpecsID:-}" \
    -d "AppInUse=${AppInUse:-}" \
    -d "FileSystemPartitionData=${FileSystemPartitionData:-}" \
    -d "FileSystemPartitionSystem=${FileSystemPartitionSystem:-}" \
    -d "ExternalDrivers=${ExternalDrivers:-}" \
    -d "FileSystemSDCARD=${FileSystemSDCARD:-}" \
    -d "FirmwareInstallLOG=${FirmwareInstallLOG:-}" \
    -d "FirmwareHardResetLOG=${FirmwareHardResetLOG:-}" \
    -d "AppInUseLOG=${AppInUseLOG:-}" \
    -d "FirmwareFullSpecs=${FirmwareFullSpecs:-}"
}

UUIDPath="/system/UUID.Uniq.key.txt"
wrote_ok=0
# 1) Se o arquivo existe, tenta ler o UUID atual (sem sobrescrever).
if [ -f "$UUIDPath" ]; then
  UUIDBOX=`busybox cat "$UUIDPath" | busybox tr -d '\r\n'`
fi
# 2) Se o UUID estiver vazio, gera um novo e tenta gravar.
if [ -z "$UUIDBOX" ]; then
  UUIDBOX=`/system/usr/bin/openssl rand -hex 32`
  attempt=1
  # 3) Tenta gravar e validar o UUID por ate 11 tentativas.
  while [ "$attempt" -le 11 ]; do
    # 3.1) Remonta /system como RW antes de tentar gravar.
    if [ ! -f "$UUIDPath" ] || [ ! -s "$UUIDPath" ]; then
      busybox mount -o remount,rw /system 2>/dev/null
      busybox sleep 1
      # 3.2) Grava o UUID gerado quando arquivo nao existe ou esta vazio.
      echo "$UUIDBOX" > "$UUIDPath" 2>/dev/null
    fi
    if [ -f "$UUIDPath" ]; then
      check_value=`busybox cat "$UUIDPath" 2>/dev/null | busybox tr -d '\r\n'`
      # 3.3) Se o arquivo tem o UUID gerado, confirma a gravacao.
      if [ "$check_value" = "$UUIDBOX" ]; then
        wrote_ok=1
        break
      fi
      # 3.4) Se o arquivo tem outro valor nao vazio, usa ele e sai.
      if [ -n "$check_value" ]; then
        UUIDBOX="$check_value"
        break
      fi
    fi
    # 3.5) Espera um pouco antes de tentar novamente.
    attempt=$((attempt + 1))
    busybox sleep 1
  done
  # 4) Se falhar, segue sem travar o fluxo (POST sera bloqueado).
  if [ "$wrote_ok" != "1" ]; then
    #echo "UUID write failed after 11 attempts; skipping POST."
    wrote_ok=0
  fi
fi

TokenHardwareID="$Placa│$CpuSerial│$MacLanReal│$UUIDBOX"
echo "$TokenHardwareID"

# # Optional fields can be empty; keep them defined for the POST.
# FirstsignupUnix="${FirstsignupUnix:-}"
# FirmwareInstallUnix="${FirmwareInstallUnix:-}"
# FirmwareHardResetUnix="${FirmwareHardResetUnix:-}"
# LocationGeoIP="${LocationGeoIP:-}"
# WanIPhp="${WanIPhp:-}"
# UpdateSystemVersion="${UpdateSystemVersion:-}"
# FirmwareFullSpecsID="${FirmwareFullSpecsID:-}"
# AppInUse="${AppInUse:-}"
# FileSystemPartitionData="${FileSystemPartitionData:-}"
# FileSystemPartitionSystem="${FileSystemPartitionSystem:-}"
# ExternalDrivers="${ExternalDrivers:-}"
# FileSystemSDCARD="${FileSystemSDCARD:-}"
# FirmwareInstallLOG="${FirmwareInstallLOG:-}"
# FirmwareHardResetLOG="${FirmwareHardResetLOG:-}"
# AppInUseLOG="${AppInUseLOG:-}"
# FirmwareFullSpecs="${FirmwareFullSpecs:-}"


PostURL="https://painel.iaupdatecentral.com/telemetria.php"

if [ -n "$UUIDBOX" ] && { [ "$wrote_ok" = "1" ] || [ -f "$UUIDPath" ]; }; then
  Response=$(do_post 2>&1)
  echo "$Response"
else
  echo "UUID not available; skipping POST."
fi
