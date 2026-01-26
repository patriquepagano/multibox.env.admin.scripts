#!/system/bin/sh
source /data/.vars
    if [ ! -d /data/$Produto/crontab ];then
        $mkdir -p /data/$Produto/crontab
    fi
$cat <<EOF > /data/$Produto/crontab/root
0 */3 * * * /data/asusbox/.sc/OnLine/cron.updates.sh
0 */1 * * * /data/asusbox/.sc/OnLine/remove-apps.sh
0 */1 * * * /data/asusbox/.sc/OnLine/remove-files.sh
EOF

function killcron () {
    checkPort=`/system/bin/busybox ps | grep "/system/bin/busybox crond" | grep -v "grep" | /system/bin/busybox cut -d " " -f 2`
    if [ ! "$checkPort" == "" ]; then
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### Desligando serviço cron"
        echo "ADM DEBUG ### cron rodando na porta $checkPort"
        /system/bin/busybox kill -9 $checkPort
    fi
}

$chmod 755 /data/$Produto/crontab/root

killcron

logcat -c
/system/bin/busybox crond -fb -l 9 -c /data/$Produto/crontab

