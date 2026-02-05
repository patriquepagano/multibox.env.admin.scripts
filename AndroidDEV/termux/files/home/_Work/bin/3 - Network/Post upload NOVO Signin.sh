#!/system/bin/sh
# Menu switch DNS - BusyBox / root limitado
# Compatível com Android TV boxes com BusyBox
clear

path="$( cd "${0%/*}" && pwd -P )"


# UNIQ DEVICE IDENTIFICATION
Placa=$(getprop ro.product.board)
CpuSerial=`busybox cat /proc/cpuinfo | busybox grep Serial | busybox awk '{ print $3 }'`
MacLanReal=`/system/bin/busybox cat /data/macLan.hardware | busybox sed 's;:;;g'`
uuidDevice="123e4567-e89b-12d3-a456-426614174000"

# SIMULATED PAYLOAD (device-side fields)
MacWiFiReal="A1:B2:C3:D4:E5:F6"
ServiceGeoIP='{"ip":"203.0.113.10","country":"BR","region":"SP","city":"Sao Paulo"}'
IPExterno="203.0.113.10"
country="BR"
region="SP"
city="Sao Paulo"
Operadora="Vivo"
FirstsignupUnix="1700000000"
FirmwareInstallUnix="1700001234"
FirmwareHardResetUnix="1700009999"
UpdateSystemVersion="v1.2.3"
FirmwareFullSpecsID="build-2025-12-01"
AppInUse="Launcher"
FileSystemPartitionData="data:ext4:8GB:used=2GB"
FileSystemPartitionSystem="system:ext4:4GB:used=1.2GB"
ExternalDrivers="usb:keyboard;usb:mouse"
FileSystemSDCARD="sdcard:fat32:32GB:used=6GB"
FirmwareInstallLOG="install ok"
FirmwareHardResetLOG="hard reset ok"
AppInUseLOG="launcher opened"
FirmwareFullSpecs="board=RK3318;ram=2GB;android=9"
JsonCustom01='{"key":"value1"}'
JsonCustom02='{"key":"value2"}'
JsonCustom03='{"key":"value3"}'
JsonCustom04='{"key":"value4"}'
JsonCustom05='{"key":"value5"}'
JsonCustom06='{"key":"value6"}'
JsonCustom07='{"key":"value7"}'

BB=/system/bin/busybox

PostURL="https://painel.iaupdatecentral.com/telemetria.php"

curl -sS --cacert "/data/Curl_cacert.pem" --connect-timeout 8 --max-time 25 --retry 4 --retry-delay 2 --retry-max-time 25 --retry-connrefused \
    -w "\nHTTP_STATUS=%{http_code}\n" -X POST "$PostURL" \
    -H "X-Auth-Token: mbx_9f3a7d1b2c4e6f8a0b1c3d5e7f9a1b2c3d4e6f8a" \
    -d "uuidDevice=$uuidDevice" \
    -d "Placa=$Placa" \
    -d "CpuSerial=$CpuSerial" \
    -d "MacLanReal=$MacLanReal" \
    -d "MacWiFiReal=$MacWiFiReal" \
    -d "ServiceGeoIP=$ServiceGeoIP" \
    -d "IPExterno=$IPExterno" \
    -d "country=$country" \
    -d "region=$region" \
    -d "city=$city" \
    -d "Operadora=$Operadora" \
    -d "FirstsignupUnix=$FirstsignupUnix" \
    -d "FirmwareInstallUnix=$FirmwareInstallUnix" \
    -d "FirmwareHardResetUnix=$FirmwareHardResetUnix" \
    -d "UpdateSystemVersion=$UpdateSystemVersion" \
    -d "FirmwareFullSpecsID=$FirmwareFullSpecsID" \
    -d "AppInUse=$AppInUse" \
    -d "FileSystemPartitionData=$FileSystemPartitionData" \
    -d "FileSystemPartitionSystem=$FileSystemPartitionSystem" \
    -d "ExternalDrivers=$ExternalDrivers" \
    -d "FileSystemSDCARD=$FileSystemSDCARD" \
    -d "FirmwareInstallLOG=$FirmwareInstallLOG" \
    -d "FirmwareHardResetLOG=$FirmwareHardResetLOG" \
    -d "AppInUseLOG=$AppInUseLOG" \
    -d "FirmwareFullSpecs=$FirmwareFullSpecs" \
    -d "JsonCustom01=$JsonCustom01" \
    -d "JsonCustom02=$JsonCustom02" \
    -d "JsonCustom03=$JsonCustom03" \
    -d "JsonCustom04=$JsonCustom04" \
    -d "JsonCustom05=$JsonCustom05" \
    -d "JsonCustom06=$JsonCustom06" \
    -d "JsonCustom07=$JsonCustom07"



if [ ! "$1" = "skip" ]; then
    echo "Press any key to exit."
    read -r bah
fi






