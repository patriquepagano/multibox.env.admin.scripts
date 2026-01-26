
cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"


# echo "ADM DEBUG ##############################################################################"
# echo "ADM DEBUG ### Desativando o pisca alerta"
# /data/asusbox/.sc/boot/led-on.sh

file=/data/asusbox/fullInstall
if [ ! -f $file ]; then
    echo "ok" > $file
fi


CheckIPLocal
ACRURL="http://$IPLocal"
# reconfigura a config caso seja necessario
acr.browser.barebones.set.config
# altera a home url do navegador
z_acr.browser.barebones.change.URL


# finaliza o lock do cron
rm /data/asusbox/crontab/LOCK_cron.updates

# monstra a contagem final de tempo 
duration=$SECONDS
#echo "<h3>$(($duration / 60)) minutos e $(($duration % 60)) segundos para concluir inicialização e atualização completa.</h3>" >> $bootLog 2>&1

echo "$(($duration / 60)) minutos e $(($duration % 60)) segundos para concluir." >> $bootLog 2>&1


# mostra na aba news.php a key da box
# antes de liberar a instalação para eu determinar um filtro de quais box quero limpar
mkdir -p /data/trueDT/peer/Sync/sh.all
echo "
KEY : $Placa=$CpuSerial=$MacLanReal

" > "/data/trueDT/peer/Sync/sh.all/news.log" 2>&1


echo "
Atualizado com sucesso!!!
KEY : $Placa=$CpuSerial

" > "$bootLog" 2>&1



USBLOGCALL="file mark final code boot"
OutputLogUsb

