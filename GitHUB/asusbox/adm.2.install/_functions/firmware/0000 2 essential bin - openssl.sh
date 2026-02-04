
BB=/system/bin/busybox

# Verifica se o binário já existe e está funcional — se sim, pula o download
skip_download=0
if [ -x /data/bin/openssl ]; then
    version=$(/data/bin/openssl version 2>/dev/null | cut -d " " -f 2)
    if [ -n "$version" ]; then
        echo "OpenSSL já instalado — versão $version. Pulando download."
        skip_download=1
    else
        echo "OpenSSL encontrado mas não respondeu corretamente — atualizando..."
    fi
fi

# if [ "$skip_download" -eq 0 ]; then
#     URL="https://painel.iaupdatecentral.com/android/armeabi-v7a/openssl"
#     curl -sS --cacert "/data/Curl_cacert.pem" "$URL" -o "/data/local/tmp/openssl"
#     $BB du -hs "/data/local/tmp/openssl"
#     $BB mount -o remount,rw /system
#     $BB mv "/data/local/tmp/openssl" /system/usr/bin/openssl
#     $BB chmod 755 /system/usr/bin/openssl
# fi


# if [ "$skip_download" -eq 0 ]; then
#     URL="https://painel.iaupdatecentral.com/android/armeabi-v7a/openssl"
#     echo "Baixando OpenSSL com aria2c..."
#     $BB mkdir -p /data/local/tmp
#     aria2c --check-certificate=true --ca-certificate="/data/Curl_cacert.pem" --continue=true --max-connection-per-server=4 -x4 -s4 --dir="/data/local/tmp" -o "openssl" "$URL"
#     $BB du -hs "/data/local/tmp/openssl"
#     $BB chmod 755 /data/local/tmp/openssl
#     $BB mount -o remount,rw /system
#     $BB rm -f /system/usr/bin/openssl
#     $BB cp "/data/local/tmp/openssl" /system/usr/bin/openssl
# fi

if [ "$skip_download" -eq 0 ]; then
    URL="https://painel.iaupdatecentral.com/android/armeabi-v7a/openssl"
    echo "Baixando OpenSSL com aria2c..."
    $BB mkdir -p /data/bin
    aria2c --check-certificate=true --ca-certificate="/data/Curl_cacert.pem" --continue=true --max-connection-per-server=4 -x4 -s4 --dir="/data/bin" -o "openssl" "$URL"
    $BB du -hs "/data/bin/openssl"
    $BB chmod 755 /data/bin/openssl
fi



