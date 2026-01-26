#!/system/bin/sh
list="
$EXTERNAL_STORAGE/.Rxst/bluetv
"
for loop in $list; do
if [ ! -d "$loop" ] ; then
mkdir -p $loop
fi
done
rm -rf /data/data/com.mm.droid.livetv.bluetv/shared_prefs
/system/bin/busybox cat << 'EOF' > $EXTERNAL_STORAGE/.Rxst/bluetv/at
1592591987893
BSvmT8yxmw3b4C80onscNfSwTmNbPXDOEw+Ue3/1ltPeicaPamK+r3E1hwPLV7iwAlwDFZUyv0Dz5H5tagrNKbniCkBRVYnh2qvJUZouHXmXNnuJP94zBXBUwLahyGzrK4YWB6FVbeaIzAr88kW+FaheoXx9BxpxTJSjXFbZYmk9fjyws7PH0SDbTj2wwtPTurfWX6Migd2pdk5d9Q+0IyG08e40MVUS2Ywefc4NhxwgFUSRmY1be+0mZaptrR6YrM+5gfU2FC3wosogXqA1RFQf4cHcb/4VY8n6mA/8BpIOMdigvEYGN6UlXr0fvTAZ2w1IQ0g9glMfV7jEvCWcDyeO4Yg9+0EWIQTeODpzZHgLVdFF3schw7T/KouNo8MbthLrN2QpbpS5suAEYgiZx5lAZAUAQGk2SQiOi5tIQiZupvQ1SwzGVKObkhS5o3V2
EOF
/system/bin/busybox cat << 'EOF' > $EXTERNAL_STORAGE/.Rxst/bluetv/bluetv
afZp3WVl1xfWIkOXLN48z9Vi2Zy7oCn9eICPzPsqM9U5pQDmZ6yK9adBx32CtoLmKgCrJ25feMNjxAXAUIrWpQZiFYjZd8hfZmcZf6NGtC6ebl3mbdoef5cdO2gcHj+joySdZhh/rYI9ikAoMKuiDPqYy0CePlOKF5rH1DmtJ2ntzVw2zsh5VIr6p/goVdRhkHUGxdEnLPPXniufk4Td1GJZ3xWfT+D9IP0TptBSi1g=
EOF
