
function AtivaSeedBOX () {
#################################################################################################################
echo "####################  ativa o seedBOX #########################################"

rm -rf /data/transmission
mkdir -p /data/transmission

# 
InstallTransmission # verificar se o sistema novo de bins contempla toda esta função
killTransmission # como é o boot depois eu removo esta etapa
StartDaemonTransmission


# chama o navegador para frente da box mostrando o p2p
# verificar usando o comando uptime se a box estiver ligada mais que 3 minutos não chama o navegador para frente
# com isto consigo rodar este script via cron

am force-stop com.xyz.fullscreenbrowser
am start --user 0 \
-n com.xyz.fullscreenbrowser/.BrowserActivity \
-a android.intent.action.VIEW -d "http://127.0.0.1:9091" > /dev/null 2>&1 # abre a pagina inicial para atualizar a imagem qrcode

# Variaveis
/system/bin/busybox rm /data/transmission/$torFile
SeedBOXTransmission

}

