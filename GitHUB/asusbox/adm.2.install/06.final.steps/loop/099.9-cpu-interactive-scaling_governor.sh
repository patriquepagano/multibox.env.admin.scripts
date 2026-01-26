
echo -n "interactive" >  "/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"

echo "
Atualizado com sucesso!!!
KEY : $Placa=$CpuSerial
Agendado próxima atualização: $(busybox cat /data/asusbox/crontab/Next_cron.updates.sh)

" > "$bootLog" 2>&1


echo "Finish code boot! :)"


USBLOGCALLSet="remove"
OutputLogUsb


