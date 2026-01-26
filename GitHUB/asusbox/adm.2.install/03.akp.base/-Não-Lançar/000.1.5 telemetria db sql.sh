
# ------------------------------------------------------

# UNIQ DEVICE IDENTIFICATION
Placa=$(getprop ro.product.board)
CpuSerial=`busybox cat /proc/cpuinfo | busybox grep Serial | busybox awk '{ print $3 }'`
MacLanReal=`/system/bin/busybox cat /data/macLan.hardware | busybox sed 's;:;;g'`

# CurlData=`curl -s -w "HttpCode='%{http_code}'" -d  "secretAPI=$secretAPI&\

do_post() {
curl -sS --connect-timeout 8 --max-time 20 --retry 2 --retry-delay 2 --retry-max-time 20 \
    -w "\nHTTP_STATUS=%{http_code}\n" -X POST "$PostURL" \
    -H "X-Auth-Token: mbx_9f3a7d1b2c4e6f8a0b1c3d5e7f9a1b2c3d4e6f8a" \
    -d "hardware_hash=${hardware_hash:-}" \
    -d "Placa=${Placa:-}" \
    -d "CpuSerial=${CpuSerial:-}" \
    -d "MacLanReal=${MacLanReal:-}" \
    -d "MacWiFiReal=${MacWiFiReal:-}" \
    -d "FirstsignupUnix=${FirstsignupUnix:-}" \
    -d "FirmwareInstallUnix=${FirmwareInstallUnix:-}" \
    -d "FirmwareHardResetUnix=${FirmwareHardResetUnix:-}" \
    -d "LocationGeoIP=${LocationGeoIP:-}" \
    -d "WanIPhp=${WanIPhp:-}" \
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
if [ -f "$UUIDPath" ]; then
  RandUniq=`busybox cat "$UUIDPath" | busybox tr -d '\r\n'`
else
  RandUniq=`/system/usr/bin/openssl rand -hex 32`
  wrote_ok=0
  attempt=1
  while [ "$attempt" -le 11 ]; do
    echo "$RandUniq" > "$UUIDPath" 2>/dev/null
    if [ -f "$UUIDPath" ]; then
      check_value=`busybox cat "$UUIDPath" 2>/dev/null | busybox tr -d '\r\n'`
      if [ "$check_value" = "$RandUniq" ]; then
        wrote_ok=1
        break
      fi
    fi
    busybox mount -o remount,rw /system 2>/dev/null
    attempt=$((attempt + 1))
    busybox sleep 1
  done
  if [ "$wrote_ok" != "1" ]; then
    #echo "UUID write failed after 11 attempts; skipping POST."
    wrote_ok=0
  fi
fi
HardwareID="$Placa│$CpuSerial│$MacLanReal│"
hardware_hash="${HardwareID}${RandUniq}"
DeviceName="$HardwareID$RandUniq"

#echo "DeviceName=$DeviceName"

# Optional fields can be empty; keep them defined for the POST.
FirstsignupUnix="${FirstsignupUnix:-}"
FirmwareInstallUnix="${FirmwareInstallUnix:-}"
FirmwareHardResetUnix="${FirmwareHardResetUnix:-}"
LocationGeoIP="${LocationGeoIP:-}"
WanIPhp="${WanIPhp:-}"
UpdateSystemVersion="${UpdateSystemVersion:-}"
FirmwareFullSpecsID="${FirmwareFullSpecsID:-}"
AppInUse="${AppInUse:-}"
FileSystemPartitionData="${FileSystemPartitionData:-}"
FileSystemPartitionSystem="${FileSystemPartitionSystem:-}"
ExternalDrivers="${ExternalDrivers:-}"
FileSystemSDCARD="${FileSystemSDCARD:-}"
FirmwareInstallLOG="${FirmwareInstallLOG:-}"
FirmwareHardResetLOG="${FirmwareHardResetLOG:-}"
AppInUseLOG="${AppInUseLOG:-}"
FirmwareFullSpecs="${FirmwareFullSpecs:-}"


PostURL="https://painel.iaupdatecentral.com/telemetria.php"

if [ "$wrote_ok" = "1" ] || [ -f "$UUIDPath" ]; then
  Response=$(do_post)
  echo "$Response"
else
  echo "UUID not available; skipping POST."
fi




