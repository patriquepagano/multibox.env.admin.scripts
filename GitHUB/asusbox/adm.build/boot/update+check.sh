#!/system/bin/sh

export cronRunning=yes # necessário para passar a instrução para o boot updatesystem
date > /data/asusbox/crontab/LOCK_cron.updates

export CPU=`getprop ro.product.cpu.abi`
export bootFile="/data/asusbox/UpdateSystem.sh"

### PARA DESATIVAR O DEBUG COMENTE A LINHA ABAIXO
# echo "debug ForceUpdate" >> $bootFile

checkPin=`/system/bin/busybox cat /system/.pin`
if [ ! "$checkPin" = "FSgfdgkjhç8790d5sdf85sd867f5gs876df5g876sdf5g78s6df5g78s6df5gs87df6g576sfd" ];then
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### BLOQUEANDO O ACESSO ROOT"
    /system/bin/busybox mount -o remount,rw /system
    echo -n 'FSgfdgkjhç8790d5sdf85sd867f5gs876df5g876sdf5g78s6df5g78s6df5gs87df6g576sfd' > /system/.pin
    chmod 644 /system/.pin
fi


###################################################################################################################
# FUNÇÕES #########################################################################################################
function DownloadBOOT () { # tenta baixar 7 vezes por url o $bootFile entrega o resultado para o script
# rm $bootFile > /dev/null 2>&1 ### para fims de debug

# erro 301 esta baixando o link
# 1 - nosso linode oficial
# 2 - site do asusbox ( que nem é mais nosso ta doido cara )
# 3 - linode do elton
# http://45.79.133.216/asusboxA1/boot/$CPU/UpdateSystem.sh
# http://asusbox.com.br/asusboxA1/boot/$CPU/UpdateSystem.sh
# http://45.79.48.215/asusboxA1/boot/$CPU/UpdateSystem.sh
multilinks="
http://45.79.133.216/asusboxA1/boot/$CPU/UpdateSystem.sh
https://asusbox.com.br/asusboxA1/boot/$CPU/UpdateSystem.sh
http://45.79.48.215/asusboxA1/boot/$CPU/UpdateSystem.sh
"
    ### DOWNLOAD COM SISTEMA MULTI-LINKS
    for LinkUpdate in $multilinks; do 
        echo "ADM DEBUG ########################################################"
        echo "ADM DEBUG ### Entrando na função > DownloadBOOT"
        echo "ADM DEBUG ### tentando o link > $LinkUpdate"
        BootFileInstall="false" # ate que se prove o contrario não baixou o arquivo
        # Tenta conectar ao link 7 vezes 
        #/system/bin/wget --timeout=1 --tries=7 -O $bootFile --no-check-certificate $LinkUpdate
        /system/bin/wget -N --no-check-certificate --timeout=1 --tries=7 -P /data/asusbox/ $LinkUpdate > "/data/asusbox/wget.log" 2>&1
        CheckWgetCode=`/system/bin/busybox cat "/data/asusbox/wget.log" | /system/bin/busybox grep "HTTP request sent, awaiting response..."`
        #rm "/data/asusbox/wget.log"
            # Se tiver acesso finaliza esta função
            if [ "$CheckWgetCode" == "HTTP request sent, awaiting response... 200 OK" ] ; then
                echo "ADM DEBUG ### Wget :) $CheckWgetCode"
                echo "ADM DEBUG ### [202] Online update boot"
                BootFileInstall="true"
                UpdateAction="updateNow"
                break # fecha a função por completo
            fi
            if [ "$CheckWgetCode" == "HTTP request sent, awaiting response... 304 Not Modified" ] ; then
                echo "ADM DEBUG ### Wget :) $CheckWgetCode"
                echo "ADM DEBUG ### [304] boot local esta atualizado, rodando arquivo local"
                BootFileInstall="true"
                UpdateAction="updateNow"
                break # fecha a função por completo
            fi            
    done ### DOWNLOAD COM SISTEMA MULTI-LINKS
    echo "ADM DEBUG ### fim da função DownloadBOOT > BootFileInstall=$BootFileInstall"
}


function LoopForceDownloadBoot () { # entra em looping até baixar o arquivo de boot
while true
do
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Entrando na função > LoopForceDownloadBoot"
    DownloadBOOT 
	if [ "$BootFileInstall" == "false" ]; then
        echo "ADM DEBUG ### Nova tentativa em loop para baixar"
        logcat -c
    else
        break
    fi
done
}

#######################################################################################################################
# AQUI COMEÇA O PRIMEIRO ATO DO SCRIPT

LoopForceDownloadBoot # tenta baixar 7 vezes por url o $bootFile entrega o resultado para o script

# o /data/asusbox/UpdateSystem.sh roda SEMPRE a cada 1 hora para refazer confis e limpeza de arquivos e virus etc..
# deixando este code online consigo distribuir um patch mais rapido que criar pacotes p2p
# loop se for necessário o update
if [ "$UpdateAction" == "updateNow" ]; then
    # executa o script
    /system/bin/busybox chmod 700 $bootFile
    echo "ADM DEBUG ########################################################"
    echo "ADM DEBUG ### Iniciando boot"
    $bootFile
fi # END loop se for necessário o update



