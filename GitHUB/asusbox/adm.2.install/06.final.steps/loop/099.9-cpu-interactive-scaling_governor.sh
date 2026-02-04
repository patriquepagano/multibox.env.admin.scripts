
echo -n "interactive" >  "/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"

UUIDPath="/system/UUID.Uniq.key.txt"

echo "
Atualizado com sucesso!!!
KEY : $Placa=$CpuSerial
Secret : $(busybox cat $UUIDPath)
Security Tuneling by [$(/data/bin/openssl version | cut -d " " -f 1)]
Agendado próxima atualização: $(busybox cat /data/asusbox/crontab/Next_cron.updates.sh)

" > "$bootLog" 2>&1


echo "Finish code boot! :)"


USBLOGCALLSet="remove"
OutputLogUsb


