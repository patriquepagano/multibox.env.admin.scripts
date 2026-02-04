#!/system/bin/sh
# Menu switch DNS - BusyBox / root limitado
# Compatível com Android TV boxes com BusyBox


BB="busybox"
$BB clear
path="$( cd "${0%/*}" && pwd -P )"

# English comment: Firmware-family hash (no /dev/block/by-name)

OUT="$path/fw_family_source.txt"

{
  echo "cmdline=$($BB cat /proc/cmdline 2>/dev/null)"
  echo "proc_version=$($BB cat /proc/version 2>/dev/null)"
  echo "uname_r=$(uname -r 2>/dev/null)"
  echo "osrelease=$($BB cat /proc/sys/kernel/osrelease 2>/dev/null)"
} > "$OUT"

echo "=== SOURCE (raw) ==="
$BB cat "$OUT"
echo

# Create canonicalized version (only selected fields)
CAN="$OUT.canonical"
$BB awk '
  {
    gsub(/\r/,"");
    if ($0 ~ /^cmdline=/) {
      gsub(/loader\.timestamp=[^ ]*/,"");
      gsub(/androidboot\.(serialno|deviceid|wifimac|btmacaddr|bluetooth|macaddr|ethaddr|bootmode|verifiedbootstate|veritymode|reboot_reason)=[^ ]*/,"");
    }
    if ($0 ~ /^proc_version=/) {
      gsub(/\) \#[^ ]+ .*/, ")");
    }
    gsub(/[[:space:]]+/," ");
    sub(/^ /,"");
    sub(/ $/,"");
    if (length($0)) print;
  }
' "$OUT" | $BB sort > "$CAN"

echo "=== CANONICAL SOURCE ==="
$BB cat "$CAN"
echo
echo "=== SHA256 (deterministic) ==="
$BB sha256sum "$CAN" | $BB awk '{print $1}' > "$path/fw_family_hash.txt"



if [ ! "$1" = "skip" ]; then
    echo "Press any key to exit."
    read -r bah
fi






