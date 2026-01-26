#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
BB="/system/bin/busybox"
clear

setprop ctl.stop init21027

echo "apaga todas as pastas sync"
rm -rf /data/trueDT/peer/config
rm -rf /data/trueDT/peer/data/client/BKP
rm -rf /data/trueDT/peer/data/client/LOG/services
rm -rf /data/trueDT/peer/data/server

servicesupdate