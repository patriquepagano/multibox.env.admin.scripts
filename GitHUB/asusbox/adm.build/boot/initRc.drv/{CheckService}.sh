#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )


#netstat -ntlup | grep "4442"

# a diferença de dar o start no syncthing por aqui é que o script só finaliza quando o serviço estiver funcional
# não utilizar isto no boot pois pode parar o processo
# utilizar este script via cron no futuro

while [ 1 ]; do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Start service watch dog"
    checkPort=`netstat -ntlup | grep 4442 | cut -d ":" -f 2 | cut -d " " -f 1`
    if [ "$checkPort" == "4442" ]; then
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### service is online at port = $checkPort"    
        break
    else
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### start screen | syncthing instance"
        #chmod 755 "$path/{START}.sh"
        "$path/{START}.sh"
        sleep 30
    fi
done;

