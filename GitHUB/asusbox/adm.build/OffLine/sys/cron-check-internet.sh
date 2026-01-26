#!/system/bin/sh

logcat -c

#unset PATH
export PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin:/system/usr/bin
#unset LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/system/lib:/system/usr/lib


# FUNÇÕES #########################################################################################################
function CheckUptimeInternet () { # checa 3 vezes cada url e entrega a variavel InternetConection
CheckUptimeInternetlinks="
google.com
ipv4.icanhazip.com
"
for LinkUptimeInternetlinks in $CheckUptimeInternetlinks; do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### verificando o link se tem acesso > $LinkUptimeInternetlinks"
    InternetConection="OFFLINE" # seta todo loop como offline ate que se prove o contrario..
    echo "ADM DEBUG ### Tenta conectar ao link 7 vezes "    
    /system/bin/wget --timeout=1 --tries=7 --spider "$LinkUptimeInternetlinks" > /dev/null 2>&1
    # Se tiver acesso finaliza esta função
    if [ $? = 0 ] ; then
        echo "ADM DEBUG ### internet Uptime 100%"
        InternetConection="ONLINE"
        break # fecha a função por completo
    fi    
done ### DOWNLOAD COM SISTEMA MULTI-LINKS
}

function LoopWaitingNet () { # entra em looping infinito ate ter internet
while true
do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Entrando na função > LoopWaitingNet"
    CheckUptimeInternet
	if [ "$InternetConection" == "ONLINE" ]; then
        echo "ADM DEBUG ### Tem acesso a internet e o acesso esta > $InternetConection"
        logcat -c
        break
    fi
done
}



LoopWaitingNet

# executa o boot novamente quando retorna a internet
/system/bin/initRc.drv.01.01.97


