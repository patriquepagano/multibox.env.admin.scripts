
export bootLog="/data/data/jackpal.androidterm/app_HOME/log.txt"
if [ ! -f /data/asusbox/fullInstall ]; then
	echo "Aguarde atualizando Sistema" > $bootLog
	chmod 777 $bootLog

	am force-stop jackpal.androidterm
	am start --user 0 \
	-n jackpal.androidterm/.Term \
	-a android.intent.action.VIEW 
fi

