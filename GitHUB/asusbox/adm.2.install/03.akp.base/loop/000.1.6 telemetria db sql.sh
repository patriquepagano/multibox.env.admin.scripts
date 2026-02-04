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

#if [ -n "$UUIDBOX" ] && { [ "$wrote_ok" = "1" ] || [ -f "$UUIDPath" ]; }; then

UUIDPath="/system/UUID.Uniq.key.txt"
# Verifica se o arquivo existe e se a primeira linha tem exatamente 64 caracteres.
if [ -f "$UUIDPath" ] && [ "$(busybox head -n 1 "$UUIDPath" | busybox tr -d '[:space:]' | busybox wc -c)" -eq 64 ]; then
  Response=$(do_post 2>&1)
  echo "$Response"
else
  echo "UUID not available; skipping POST."
fi

