

# Obrigatório setar isto SEMPRE quando a box liga pela primeira vez
# cmd > settings get global ntp_server = 1.7seconds to complete
echo "ADM DEBUG ##############################################################################"
echo "ADM DEBUG ### atenção ntp client usa porta udp bloqueada por algums net providers"
if [ ! -e /data/asusbox/crontab/LOCK_cron.updates ]; then
    settings put global ntp_server a.st1.ntp.br 
	settings put global auto_time 0
	settings put global auto_time 1
fi

function ClockUpdateNow () {
echo "ADM DEBUG ########################################################################################"
echo "ADM DEBUG ### Micro serviço worldtimeapi.org funciona sem garantias criar meu proprio self hosted"

# variaveis de data unix epoch
dateOld="1630436299" # dia que foi feito este script
dateNew=`date +%s` # data atual no momento do boot

# comparar a data local da box com unix if update via proxy time
# if [ "3" -gt "1" ];then
if [ ! -d /data/trueDT/peer/Sync ]; then
    mkdir -p /data/trueDT/peer/Sync
fi
if [ "$dateOld" -gt "$dateNew" ];then
FileMark="/data/trueDT/peer/Sync/udp.clock.blocked.by.isp.v2.live"
busybox cat <<EOF > $FileMark
date from local gateway = $(date +"%d/%m/%Y %H:%M:%S")
EOF
    echo "ADM DEBUG ##############################################################################"
    echo "ADM DEBUG ### atualizando horário a partir do clock server"
    echo "ADM DEBUG ### Microserviço funciona sem garantias o unico ate agora 21/03/2022"
    TZ=UTC−03:00
    export TZ
    echo "ADM DEBUG ##############################################################################"
    echo "ADM DEBUG ### abre url temporária do telegram informando sobre o bug do relógio"
    ACRURL="https://telegra.ph/Entre-em-contato-com-o-suporte-03-20"
    acr.browser.barebones.launch
    echo "ADM DEBUG ##############################################################################"
    echo "ADM DEBUG ### TRAVA EM LOOP ATE CONSEGUIR O HORARIO"
    echo "ADM DEBUG ### PODE DEIXAR AS BOX PARADAS"
	while [ 1 ]; do
		export CheckCurl=`/system/bin/curl "http://worldtimeapi.org/api/timezone/America/Sao_Paulo"`
		if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
		sleep 3;
	done;    
    datetime=`echo -n "$CheckCurl" | busybox cut -d ',' -f 3 | busybox cut -d '"' -f 4 | busybox cut -d '"' -f 1`
    timezone=`echo -n "$CheckCurl" | busybox cut -d ',' -f 11 | busybox cut -d '"' -f 4 | busybox cut -d '"' -f 1`
    unixtime=`echo -n "$CheckCurl" | busybox cut -d ',' -f 12 | busybox cut -d ':' -f 2`
    /system/bin/busybox date -s "@$unixtime"
busybox cat <<EOF >> $FileMark
date from world api = $datetime
$timezone
$unixtime
EOF
am force-stop acr.browser.barebones
fi

}


# -eq # equal
# -ne # not equal
# -lt # less than
# -le # less than or equal
# -gt # greater than
# -ge # greater than or equal



# desativado pq não funciona! aguardando novo metodo
# comparar a data local da box com unix if update via proxy time
#if [ "3" -gt "1" ];then
# if [ "$dateOld" -gt "$dateNew" ];then
#     echo "ADM DEBUG ##############################################################################"
#     echo "ADM DEBUG ### atualizando horário a partir do clock server"
#     TZ=UTC−03:00
#     export TZ
#     url="https://time.is/pt_br/Unix_time_converter"
#     curl -ko /data/local/tmp/getTime $url
#     epochDate=`/system/bin/busybox cat /data/local/tmp/getTime | /system/bin/busybox grep 'id="unix_time" value="' | /system/bin/busybox cut -d '"' -f 8`
#     /system/bin/busybox date -s "@$epochDate"
#     rm /data/local/tmp/getTime
# fi


# precisa deixar linhas em branco abaixo para a funçao


