#!/system/bin/sh
export TZ=UTC−03:00
TMP_DIR=/data/trueDT/peer/TMP
NO_NET=$TMP_DIR/NoInternetAccess
FIRST_SETUP=$TMP_DIR/FirstSetupWiFi.log
PidProcessFile="/data/trueDT/peer/TMP/init.update.boot.PID"
Log="/data/trueDT/peer/TMP/init.update.boot.LOG"


CheckUptime() {
  set -- $(</proc/uptime)
  checkUptime=${1%%.*}
}

echo "
este script tem que rodar direto no service para testar em uso mesmo a logica"





echo "Done!"
read bah


