#!/system/bin/sh

function killcron () {
checkPort=`/system/bin/busybox ps \
| /system/bin/busybox grep "/system/bin/busybox crond" \
| /system/bin/busybox grep -v "grep" \
| /system/bin/busybox awk '{print $1}' \
| /system/bin/busybox sed -e 's/[^0-9]*//g'`
    if [ ! "$checkPort" == "" ]; then
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### Desligando serviço cron"
        echo "ADM DEBUG ### cron rodando na porta $checkPort"
        /system/bin/busybox kill -9 $checkPort
    fi
}


if [ ! -d /data/asusbox/crontab ];then
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### criando a pasta crontab"
    mkdir -p /data/asusbox/crontab
fi

### ARQUIVO ###########################################################################
# /data/asusbox/crontab/root # arquivo que o cron le para executar os agendamentos
# /data/asusbox/crontab/root # escrito no boot if tiver gamebox sera add novas linhas

# +--------- Minute (0-59)                    | Output Dumper: >/dev/null 2>&1
# | +------- Hour (0-23)                      | Multiple Values Use Commas: 3,12,47
# | | +----- Day Of Month (1-31)              | Do every X intervals: */X  -> Example: */15 * * * *  Is every 15 minutes
# | | | +--- Month (1 -12)                    | Aliases: @reboot -> Run once at startup; @hourly -> 0 * * * *;
# | | | | +- Day Of Week (0-6) (Sunday = 0)   | @daily -> 0 0 * * *; @weekly -> 0 0 * * 0; @monthly ->0 0 1 * *;
# | | | | |                                   | @yearly -> 0 0 1 1 *;

TZ=UTC−03:00
export TZ
clear


hora=`/system/bin/busybox date +"%H"`
minutos=`/system/bin/busybox date +"%M"`

if [ "$hora" = "23" ]; then	
    hora="00"
else
    #echo "$hora real"
    ((hora=hora+1))
    #echo "$hora futuro"
fi


/system/bin/busybox date +"%T"


cat <<EOF > /data/asusbox/crontab/root
#*/$Minutos * * * * /data/asusbox/.sc/boot/cron.updates.sh
$minutos $hora * * * "/storage/DevMount/GitHUB/asusbox/adm.debugs/Features-tests/cron/debug-task.sh"
EOF
chmod 755 /data/asusbox/crontab/root


echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### Call function stop cron"
killcron

logcat -c
echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### iniciando serviço cron"
/system/bin/busybox crond -fb -l 9 -c /data/asusbox/crontab # sistema com log desativado ( -l 9 ) não mostra no catlog



cat /data/asusbox/crontab/root
