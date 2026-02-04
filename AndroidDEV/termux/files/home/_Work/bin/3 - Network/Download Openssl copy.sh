#!/system/bin/sh
# Menu switch DNS - BusyBox / root limitado
# Compatível com Android TV boxes com BusyBox
clear

BB=/system/bin/busybox


# Verifica se o binário já existe e está funcional — se sim, pula o download
skip_download=0
if [ -x /system/usr/bin/openssl ]; then
    version=$(/system/usr/bin/openssl version 2>/dev/null | cut -d " " -f 2)
    if [ -n "$version" ]; then
        echo "OpenSSL já instalado — versão $version. Pulando download."
        skip_download=1
    else
        echo "OpenSSL encontrado mas não respondeu corretamente — atualizando..."
    fi
fi

if [ "$skip_download" -eq 0 ]; then
    URL="https://painel.iaupdatecentral.com/android/armeabi-v7a/openssl"
    curl -sS --cacert "/data/Curl_cacert.pem" "$URL" -o "/data/local/tmp/openssl"
    $BB du -hs "/data/local/tmp/openssl"
    $BB mount -o remount,rw /system
    $BB mv "/data/local/tmp/openssl" /system/usr/bin/openssl
    $BB chmod 755 /system/usr/bin/openssl
fi






if [ ! "$1" = "skip" ]; then
    echo "Press any key to exit."
    read -r bah
fi






