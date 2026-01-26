
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



# CACERT="/data/Curl_cacert.pem"
# CACERT_URL="https://curl.se/ca/cacert.pem"
# CACERT_MAX_AGE_DAYS=30
# DEBUG_LOG="/data/trueDT/peer/Sync/Debug-collect-data.sh"

# log_debug() {
#   printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" >> "$DEBUG_LOG"
# }

# # Bootstrap CA bundle: first download with -k, then refresh with verification.
# curl_bootstrap_cacert() {
#   if [ ! -f "$CACERT" ]; then
#     log_debug "cacert missing; downloading with -k from $CACERT_URL"
#     /system/bin/curl -sS -k -v --connect-timeout 8 --max-time 25 \
#       -o "$CACERT" "$CACERT_URL" >> "$DEBUG_LOG" 2>&1
#     log_debug "curl exit code: $?"
#     return
#   fi

#   if /system/bin/busybox stat -c %Y "$CACERT" >/dev/null 2>&1; then
#     now_ts=$(date +%s)
#     file_ts=$(/system/bin/busybox stat -c %Y "$CACERT")
#     age_days=$(( (now_ts - file_ts) / 86400 ))
#     if [ "$age_days" -ge "$CACERT_MAX_AGE_DAYS" ]; then
#       log_debug "cacert age ${age_days}d; refreshing from $CACERT_URL"
#       /system/bin/curl -sS -v --cacert "$CACERT" --connect-timeout 8 --max-time 25 \
#         -o "$CACERT" "$CACERT_URL" >> "$DEBUG_LOG" 2>&1
#       log_debug "curl exit code: $?"
#     else
#       log_debug "cacert age ${age_days}d; no refresh needed"
#     fi
#   else
#     log_debug "busybox stat failed for $CACERT"
#   fi
# }

# curl_bootstrap_cacert
