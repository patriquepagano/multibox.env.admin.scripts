
CACERT="/data/Curl_cacert.pem"
CACERT_URL="https://curl.se/ca/cacert.pem"
CACERT_MAX_AGE_DAYS=30


# exemplo como o aria2c foi usado em outro script 
#     aria2c --check-certificate=true --ca-certificate="/data/Curl_cacert.pem" --continue=true --max-connection-per-server=4 -x4 -s4 --dir="/data/local/tmp" -o "openssl" "$URL"
 
#leia apenas este script. isto vai rodar em um tvbox android limitado mas tem aria2c instalado entao no topo do 
#script leia o comentario como o aria2c baixa com sucesso um arquivo como seria a função curl_bootstrap_cacert para baixar usando 


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




