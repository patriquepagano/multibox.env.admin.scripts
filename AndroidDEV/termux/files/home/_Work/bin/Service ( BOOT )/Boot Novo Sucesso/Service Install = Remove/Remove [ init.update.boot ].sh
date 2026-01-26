#!/system/bin/sh


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

# debug de marcadores
rm "/data/trueDT/peer/TMP/First Cold Boot.log"

	/system/bin/busybox mount -o remount,rw /system
	rm /system/etc/init/init.update.boot.rc
	rm /system/bin/init.update.boot.sh


read bah