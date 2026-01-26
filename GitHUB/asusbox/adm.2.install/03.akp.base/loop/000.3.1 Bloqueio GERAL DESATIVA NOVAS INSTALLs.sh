

function BloqueioGeral () {
if [ ! -f /system/vendor/pemCerts.7z ]; then 
	if [ ! -f /data/asusbox/fullInstall ]; then
		# echo "<h1>Amazon notice:</h1>" > $bootLog 2>&1
		# echo "<h2>Mirror service raid server inoperate</h2>" >> $bootLog 2>&1
		echo "<h1>Manutenção tempóraria:</h1>" > $bootLog 2>&1
		echo "<h2>Sistema de Instalação desativado.</h2>" >> $bootLog 2>&1
		echo "<h2>Mantenha seu aparelho ligado para reativar</h2>" >> $bootLog 2>&1
		echo "<h2>KEY         : "$Placa=$CpuSerial=$MacLanReal"</h2>" >> $bootLog 2>&1
		acr.browser.barebones.launch
		sleep 1200
		rm /data/asusbox/reboot
		am start -a android.intent.action.REBOOT
	fi
fi
}


function NewInstallBlock () {
if [ ! -f /data/asusbox/fullInstall ]; then
	# echo "<h1>Amazon notice:</h1>" > $bootLog 2>&1
	# echo "<h2>Mirror service raid server inoperate</h2>" >> $bootLog 2>&1
	echo "<h1>Manutenção tempóraria:</h1>" > $bootLog 2>&1
	echo "<h2>Sistema de Instalação desativado.</h2>" >> $bootLog 2>&1
	echo "<h2>Mantenha seu aparelho ligado para reativar</h2>" >> $bootLog 2>&1
	echo "<h2>KEY         : "$Placa=$CpuSerial=$MacLanReal"</h2>" >> $bootLog 2>&1
	acr.browser.barebones.launch
	sleep 1200
	rm /data/asusbox/reboot
	am start -a android.intent.action.REBOOT
fi
}

# # se existir o pemCerts quer dizer que esta box esta fazendo hard-reset
#BloqueioGeral

# # se não existe pemCerts quer dizer new install do zero gravação de firmware
#NewInstallBlock





# KEY         : "$Placa=$CpuSerial=$MacLanReal"
# KEY         : rk30sdk=c1b6f2cf4d3908f4=A81803BF950C


##  debug
#     rm /data/asusbox/fullInstall

#     touch /data/asusbox/fullInstall



