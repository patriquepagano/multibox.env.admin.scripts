
echo "$(date +"%d/%m/%Y %H:%M:%S") Logs " > $LogRealtime

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### get.geoIP load results to var"
"/data/asusbox/.sc/boot/log/Log.get.geoIP.sh"

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### generate log firmware install"
"/data/asusbox/.sc/boot/log/Log.DFI.sh"

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### iniciando logs"
"/data/asusbox/.sc/boot/log/Log.final.sh"


# precisa rodar o filesystem depois do update do p2p pack para fazer sentido
echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### call log FileSystems"
"/data/asusbox/.sc/boot/log/Log.FileSystem.sh"




settings get secure android_id >> $bootLog 2>&1
