
if ! ls /data/app/ | grep -q "org.xbmc.kodi"; then
    /system/bin/wget \
        --no-check-certificate \
        --user-agent="Mozilla/5.0 (Linux; Android 7.1.2; AFTN) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Mobile Safari/537.36" \
        --timeout=11 --tries=11 \
        -O /data/local/tmp/base.apk \
        "https://mirrors.kodi.tv/releases/android/arm/kodi-21.2-Omega-armeabi-v7a.apk"
    pm install -r /data/local/tmp/base.apk
    du -hs /data/local/tmp/base.apk
    rm /data/local/tmp/base.apk
    # permissoes
    pm grant org.xbmc.kodi android.permission.READ_EXTERNAL_STORAGE
    pm grant org.xbmc.kodi android.permission.WRITE_EXTERNAL_STORAGE
    pm grant org.xbmc.kodi android.permission.RECORD_AUDIO
fi

USBLOGCALL="Kodi global instalado"
OutputLogUsb




