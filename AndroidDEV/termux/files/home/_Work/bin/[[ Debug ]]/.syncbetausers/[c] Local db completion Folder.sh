#!/system/bin/sh
# extraindo a config
path=$( cd "${0%/*}" && pwd -P )
ServerConfigPath="/data/trueDT/peer/config/config.xml"
API=$(cat "$ServerConfigPath" | grep "<apikey>" | cut -d ">" -f 2 | cut -d "<" -f 1)
WebPort=$(cat "$ServerConfigPath" | grep "<localAnnounceMCAddr>" | cut -d ":" -f 3 | cut -d "]" -f 1)

folderID="sdl5z-fujnz"

while [ 1 ]; do
	sleep 1
    data=`curl --silent -X GET -H "X-API-Key: $API" "http://127.0.0.1:$WebPort/rest/db/completion?folder=$folderID"`
    completion=`echo "$data" | grep "completion" | cut -d "," -f 1 | cut -d " " -f 4`
    echo "ADM DEBUG ######################################################################"
    echo "ADM DEBUG ### Aguardando a pasta sincronizar em 100% estado atual = $completion%"
	if [ "$completion" == "100" ]; then break; fi; # se for igual a 200 sai deste loop
done;

# pm uninstall ru.elron.gamepadtester
# pm uninstall com.chiarly.gamepad
# pm uninstall org.cosinus.launchertv


########################################################################################################################
# instalando para todos peers q compartilharam a pasta
# .com.retroarch.sh
# .termux0.103.sh
ScriptList=".ru.elron.gamepadtester.sh
.com.chiarly.gamepad.sh
.org.cosinus.launchertv.sh"
for script in $ScriptList; do
    # rodando os scripts definidos dentro da pasta dev
    Folder="/data/trueDT/peer/Sync.BetaUsers"
    # abaixo é a senha do script
    Senha7z="98ads59f78da5987f5a97d8s5f96ads85f968da78dsfynmd-9as0f-09ay8df876asd96ftadsb8f7an-sd809f"
    echo "$Folder/$script"
    Code=$(/system/bin/7z x -so -p$Senha7z "$Folder/$script") > /dev/null 2>&1
    eval "$Code"
done

########################################################################################################################
# instalando apenas para os da lista descomentada
ClientList="\
# DEVTEAM
###OEZPJ46-L5VS6EC-6WLRFDS-S444Z2H-2FJ2U5J-SF4XHNR-P256JL6-J7B5XQW;A dev team;Anibal box quarto
#2XU3LB6-IVFFSIA-SCICKAA-OBH6J54-ZFG4MNI-DUILG7Q-7O55S27-2JG6FQF;A dev team;DEVBOX 02
#J66LYFR-ZQN4IGE-OPH2VB4-2WMXRUU-DCFIURD-HLOSP3K-MR4QRCN-PRBLJQU;A dev team;DEVBOX 03

# AMIG@S
K4GMV7J-OO5FFU2-F77GHXW-TVRGLWU-2IJIIKS-NPVKBNC-LMY7CMU-OZSBMQV;amig@;Gil

# FAMILIA
###WUZNMWR-HXMOQDV-ZL52VUL-HX2EXWT-45OOF3E-BW22NMS-S7AOKZD-RJH5FAS;familia;rodrigo
###KK4DIUG-Z2OSE5J-4TCKE2M-ZNYSJYV-EYQ64AH-7TGSXVH-VDWYAX2-YUL3GAT;familia;tetezão

# end Loop\
"
clear
echo "$ClientList" | sed 's/\s*#.*$//' | sed '/^\s*$/d' | while read line; do 
    DeviceID=`echo $line | cut -d ";" -f 1`
    Category=`echo $line | cut -d ";" -f 2`
    UserName=`echo $line | cut -d ";" -f 3`    
    MySyncID=`busybox cat /data/trueDT/peer/Sync/serial.live`
    if [ "$DeviceID" == "$MySyncID" ]; then
        echo "$DeviceID > $Category > $UserName"
ScriptList=".termux0.103.sh
.com.retroarch.sh"
        for script in $ScriptList; do
            # rodando os scripts definidos dentro da pasta dev
            Folder="/data/trueDT/peer/Sync.BetaUsers"
            # abaixo é a senha do script
            Senha7z="98ads59f78da5987f5a97d8s5f96ads85f968da78dsfynmd-9as0f-09ay8df876asd96ftadsb8f7an-sd809f"
            echo "$Folder/$script"
            Code=$(/system/bin/7z x -so -p$Senha7z "$Folder/$script") > /dev/null 2>&1
            eval "$Code"
        done
    fi

done






read bah
cd "$path"
x
exit




