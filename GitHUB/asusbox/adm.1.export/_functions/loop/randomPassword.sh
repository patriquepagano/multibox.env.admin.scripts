function randomPassword () {
    # bash generate random 70 character alphanumeric string (upper and lowercase) and 
    export Senha7z=$(/system/bin/busybox cat /dev/urandom \
    | /system/bin/busybox tr -dc 'a-zA-Z0-9' \
    | /system/bin/busybox fold -w 70 \
    | /system/bin/busybox head -n 1)
    # alterando Senha7z da ficha técnica
    /system/bin/busybox sed -i -e "s/Senha7z=.*/Senha7z=\"$Senha7z\"/g" "$SCRIPT"
}



