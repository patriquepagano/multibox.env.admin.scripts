echo "Agendando proxima atualização" > $bootLog 2>&1

# Ativando o sistema cron para as atualizações

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
# | | | | |                                   | @yearly -> 0 0 1 1 *;wip

# fixa a data time para BR SP
TZ=UTC−03:00
export TZ

hora=`/system/bin/busybox date +"%H"`
minutos=`/system/bin/busybox date +"%M"`

if [ "$hora" = "23" ]; then	
    hora="00"
else
    #echo "$hora real"
    ((hora=hora+1))
    #echo "$hora futuro"
fi

echo -n "$hora:$minutos" > /data/asusbox/crontab/Next_cron.updates.sh

# FileExec="/data/local/tmp/cronTask.v2.sh"
# if [ ! -e $FileExec ]; then
# cat <<'EOF' > $FileExec
# /system/bin/busybox kill -9 `/system/bin/busybox ps aux | /system/bin/busybox grep uniqCode.sh | /system/bin/busybox grep -v grep | /system/bin/busybox awk '{print $1}'`
# sh "/data/trueDT/peer/BOOT/sh.uniq/uniqCode.sh"
# EOF
# fi

cat <<EOF > /data/asusbox/crontab/root
# futuro rodar tarefas de limpeza a cada 30 minutos o cron faz baseado na hora corrente
$minutos $hora * * * /data/asusbox/.sc/boot/cron.updates.sh
*/5 * * * * /data/asusbox/.sc/boot/anti-virus.sh
EOF
chmod 755 /data/asusbox/crontab/root

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### Call function stop cron"
killcron

# se a box for de um user BoxListBetaInstallers não sera iniciado o serviço CRON
checkUserAcess=`echo "$BoxListBetaInstallers" | grep "$Placa=$CpuSerial=$MacLanReal"`
if [ "$checkUserAcess" == "" ]; then
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### iniciando serviço cron"
    echo "ADM DEBUG ### Update a cada $Minutos minutos"
    /system/bin/busybox crond -fb -l 9 -c /data/asusbox/crontab # sistema com log desativado ( -l 9 ) não mostra no catlog
fi


USBLOGCALL="setup service next update time"
OutputLogUsb


