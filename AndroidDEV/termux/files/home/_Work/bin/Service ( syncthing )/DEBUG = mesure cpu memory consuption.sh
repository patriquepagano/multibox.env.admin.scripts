#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )


#!/system/bin/sh
# syncthing_usage_busybox.sh – mede RAM e CPU do Syncthing (1min, 12 amostras)

# acha PID
PID=$(busybox pgrep initRc.drv.05 | busybox head -n1)
[ -z "$PID" ] && echo "syncthing não rodando" && exit 1

OUT="$path/syncthing_usage.log"
echo "timestamp vmrss_kB cpu_percent" > "$OUT"

# iniciais
prev_total=$(busybox awk '/^cpu /{for(i=2;i<=NF;i++)s+=$i;print s}' /proc/stat)
prev_proc=$(busybox awk -v pid="$PID" '{ getline < "/proc/"pid"/stat"; split($0,a," "); print a[14]+a[15] }')

i=0
while [ "$i" -lt 12 ]; do
  sleep 5

  total=$(busybox awk '/^cpu /{for(i=2;i<=NF;i++)s+=$i;print s}' /proc/stat)
  proc=$(busybox awk -v pid="$PID" '{ getline < "/proc/"pid"/stat"; split($0,a," "); print a[14]+a[15] }')
  cpu=$(busybox awk -v pt="$prev_total" -v t="$total" -v pp="$prev_proc" -v p="$proc" \
        'BEGIN{ printf "%.2f", 100*(p-pp)/(t-pt) }')

  prev_total=$total
  prev_proc=$proc

  vmrss=$(busybox awk '/VmRSS/{print $2}' /proc/"$PID"/status)

  echo "$(busybox date '+%Y-%m-%d %H:%M:%S') $vmrss $cpu" >> "$OUT"
  i=$((i+1))
done

echo "Resultados em $OUT"


echo "Dados gravados em $OUT"

read bah
exit




