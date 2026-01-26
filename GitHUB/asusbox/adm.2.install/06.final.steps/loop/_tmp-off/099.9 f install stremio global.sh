
if ! ls /data/app/ | grep -q "com.stremio.one"; then
    echo "iniciando instalação stremio"
    /system/bin/wget \
        --no-check-certificate \
        --user-agent="Mozilla/5.0 (Linux; Android 7.1.2; AFTN) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Mobile Safari/537.36" \
        --timeout=11 --tries=11 \
        -O /data/local/tmp/base.apk \
        "https://dl.strem.io/android/v1.7.4-androidTV/com.stremio.one-1.7.4-11049200-armeabi-v7a.apk"
    pm install -r /data/local/tmp/base.apk
    du -hs /data/local/tmp/base.apk
    rm /data/local/tmp/base.apk
fi

USBLOGCALL="stremio global instalado"
OutputLogUsb
