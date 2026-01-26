#!/system/bin/sh

pm list packages -3 | sed -e 's/.*://' | sort

echo "cole o nome do app em questão"
read app


dumpsys package | grep -Eo "^[[:space:]]+[0-9a-f]+[[:space:]]+$app/[^[:space:]]+" | grep -oE "[^[:space:]]+$"

echo "try 2"

dumpsys package | grep $app | grep Activity



