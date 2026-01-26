#!/system/bin/sh
clear
path="$( cd "${0%/*}" && pwd -P )"
parent_path="$(dirname "$path")"



CACERT="/data/Curl_cacert.pem"
CACERT_URL="https://curl.se/ca/cacert.pem"
CACERT_MAX_AGE_DAYS=30

# Bootstrap CA bundle: first download with -k, then refresh with verification.
curl_bootstrap_cacert() {
  if [ ! -f "$CACERT" ]; then
    /system/bin/curl -sS -k --connect-timeout 8 --max-time 25 \
      -o "$CACERT" "$CACERT_URL"
    return
  fi

  if /system/bin/busybox stat -c %Y "$CACERT" >/dev/null 2>&1; then
    now_ts=$(date +%s)
    file_ts=$(/system/bin/busybox stat -c %Y "$CACERT")
    age_days=$(( (now_ts - file_ts) / 86400 ))
    if [ "$age_days" -ge "$CACERT_MAX_AGE_DAYS" ]; then
      /system/bin/curl -sS --cacert "$CACERT" --connect-timeout 8 --max-time 25 \
        -o "$CACERT" "$CACERT_URL"
    fi
  fi
}

curl_bootstrap_cacert



if [ ! "$1" == "skip" ]; then
    echo "Press any key to exit."
    read bah
fi
