#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear


while :; do
  # acha PIDs
  PIDS=$(busybox ps \
    | busybox grep init.update.boot.sh \
    | busybox grep -v grep \
    | busybox awk '{print $1}')
  [ -z "$PIDS" ] && break      # sai se não achar nada
  busybox kill $PIDS           # mata os processos
  sleep 1                      # evita loop frenético
done


echo "Verifica se processo ainda esta rodando"
busybox ps \
    | busybox grep init.update.boot.sh \
    | busybox grep -v grep \
    | busybox awk '{print $1}'


read bah