# ------------------------------------------------------

# UNIQ DEVICE IDENTIFICATION
Placa=$(getprop ro.product.board)
CpuSerial=`busybox cat /proc/cpuinfo | busybox grep Serial | busybox awk '{ print $3 }'`
MacLanReal=`/system/bin/busybox cat /data/macLan.hardware | busybox sed 's;:;;g'`

JsonCustom01='{"key":"value1"}'
JsonCustom02='{"key":"value2"}'
JsonCustom03='{"key":"value3"}'
JsonCustom04='{"key":"value4"}'
JsonCustom05='{"key":"value5"}'
JsonCustom06='{"key":"value6"}'
JsonCustom07='{"key":"value7"}'

UUIDPath="/system/UUID.Signin.key"
uuidDevice="$(busybox cat "$UUIDPath" 2>/dev/null | busybox tr -d '\r\n')"

do_post() {
curl -sS --cacert "/data/Curl_cacert.pem" --connect-timeout 8 --max-time 25 --retry 4 --retry-delay 2 --retry-max-time 25 --retry-connrefused \
    -w "\nHTTP_STATUS=%{http_code}\n" -X POST "$PostURL" \
    -H "X-Auth-Token: mbx_9f3a7d1b2c4e6f8a0b1c3d5e7f9a1b2c3d4e6f8a" \
    -d "uuidDevice=${uuidDevice:-}" \
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
    -d "FirmwareFullSpecs=${FirmwareFullSpecs:-}" \
    -d "JsonCustom01=${JsonCustom01:-}" \
    -d "JsonCustom02=${JsonCustom02:-}" \
    -d "JsonCustom03=${JsonCustom03:-}" \
    -d "JsonCustom04=${JsonCustom04:-}" \
    -d "JsonCustom05=${JsonCustom05:-}" \
    -d "JsonCustom06=${JsonCustom06:-}" \
    -d "JsonCustom07=${JsonCustom07:-}"
}


PostURL="https://painel.iaupdatecentral.com/telemetria.php"

# # Check if all variables are non-empty
# if [ -n "$Placa" ] && [ -n "$CpuSerial" ] && [ -n "$MacLanReal" ]; then
#     # All identifiers are present
#     uuidDevice="{\"Placa\":\"$Placa\",\"CpuSerial\":\"$CpuSerial\",\"MacLanReal\":\"$MacLanReal\"}"


if [ -n "$uuidDevice" ]; then
    echo "$uuidDevice"
    Response=$(do_post 2>&1)
    echo "$Response"
fi






