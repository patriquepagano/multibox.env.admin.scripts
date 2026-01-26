#!/system/bin/sh
path="$( cd "${0%/*}" && pwd -P )"

BB="/system/bin/busybox"
UUID_PATH="$path/UUIDUniq.txt"
OUT_JSON="$path/telemetry.json"

read_file() {
  [ -r "$1" ] && "$BB" tr -d '\000\r\n' < "$1"
}

first_match_cmdline() {
  key="$1"
  "$BB" cat /proc/cmdline 2>/dev/null | "$BB" tr ' ' '\n' | "$BB" awk -F= -v k="$key" '$1==k{print $2; exit}'
}

ensure_uuid() {
  if [ -r "$UUID_PATH" ]; then
    UUID_VAL="$(read_file "$UUID_PATH")"
  else
    # tenta gerar uuid; fallback se uuidgen nao existir
    if "$BB" uuidgen >/dev/null 2>&1; then
      UUID_VAL="$("$BB" uuidgen)"
    elif [ -r /proc/sys/kernel/random/uuid ]; then
      UUID_VAL="$(read_file /proc/sys/kernel/random/uuid)"
    else
      UUID_VAL="$("$BB" date +%s)-$RANDOM-$RANDOM"
    fi
    # grava no path local do script
    echo "$UUID_VAL" > "$UUID_PATH" 2>/dev/null
    sync
  fi
  echo "$UUID_VAL"
}

# Coletas
CPUINFO_HW="$("$BB" grep -m1 -E '^Hardware' /proc/cpuinfo 2>/dev/null | "$BB" cut -d: -f2- | "$BB" sed 's/^ *//')"
CPUINFO_SERIAL="$("$BB" grep -m1 -E '^Serial' /proc/cpuinfo 2>/dev/null | "$BB" cut -d: -f2- | "$BB" sed 's/^ *//')"

DT_MODEL="$(read_file /proc/device-tree/model)"
DT_COMPAT="$(read_file /proc/device-tree/compatible)"

CMD_SERIAL="$(first_match_cmdline androidboot.serialno)"
CMD_HW="$(first_match_cmdline androidboot.hardware)"
CMD_BRAND="$(first_match_cmdline androidboot.brand)"

ETH_MAC="$(read_file /sys/class/net/eth0/address)"
MMC_CID="$(read_file /sys/block/mmcblk0/device/cid)"
MMC_SERIAL="$(read_file /sys/block/mmcblk0/device/serial)"
MMC_NAME="$(read_file /sys/block/mmcblk0/device/name)"

UUID_UNIQ="$(ensure_uuid)"

# Normaliza strings vazias
norm() { [ -n "$1" ] && echo "$1" || echo ""; }

# Fingerprint (pode ajustar a concat)
FINGERPRINT_SRC="$(norm "$CPUINFO_HW")|$(norm "$CPUINFO_SERIAL")|$(norm "$ETH_MAC")|$(norm "$MMC_CID")|$(norm "$UUID_UNIQ")"
if "$BB" sha256sum >/dev/null 2>&1; then
  FINGERPRINT="$(echo -n "$FINGERPRINT_SRC" | "$BB" sha256sum | "$BB" awk '{print $1}')"
elif "$BB" md5sum >/dev/null 2>&1; then
  FINGERPRINT="$(echo -n "$FINGERPRINT_SRC" | "$BB" md5sum | "$BB" awk '{print $1}')"
else
  FINGERPRINT="$FINGERPRINT_SRC"
fi

cat > "$OUT_JSON" <<EOF
{
  "uuid_uniq": "$(norm "$UUID_UNIQ")",
  "cpuinfo_hardware": "$(norm "$CPUINFO_HW")",
  "cpuinfo_serial": "$(norm "$CPUINFO_SERIAL")",
  "dt_model": "$(norm "$DT_MODEL")",
  "dt_compatible": "$(norm "$DT_COMPAT")",
  "cmd_serial": "$(norm "$CMD_SERIAL")",
  "cmd_hardware": "$(norm "$CMD_HW")",
  "cmd_brand": "$(norm "$CMD_BRAND")",
  "eth_mac": "$(norm "$ETH_MAC")",
  "mmc_cid": "$(norm "$MMC_CID")",
  "mmc_serial": "$(norm "$MMC_SERIAL")",
  "mmc_name": "$(norm "$MMC_NAME")",
  "fingerprint": "$(norm "$FINGERPRINT")"
}
EOF

echo "JSON salvo em $OUT_JSON"
cat "$OUT_JSON"



# sem pausa interativa para nao travar no launcher
