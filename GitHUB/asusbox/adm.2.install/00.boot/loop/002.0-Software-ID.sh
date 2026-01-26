
if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then
    # adicionar o secure android_id no hostname da box
    setprop net.hostname "A7-$CpuSerial"
    #(this should display the current network name)
    #getprop net.hostname >> $SupportLOG
    # identificar a versao do firmware aqui
    # marcar espaços e definir qual é a placa ou software instalado
fi


USBLOGCALL="set safe androidID"
OutputLogUsb


