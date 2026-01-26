
# se a box tiver privilégios de BoxListBetaInstallers vai liberar o acesso ao Mixplorer
checkUserAcess=`echo "$BoxListBetaInstallers" | grep "$Placa=$CpuSerial=$MacLanReal"`
if [ "$checkUserAcess" == "" ]; then
    pm disable com.mixplorer
else
    pm enable com.mixplorer
fi


