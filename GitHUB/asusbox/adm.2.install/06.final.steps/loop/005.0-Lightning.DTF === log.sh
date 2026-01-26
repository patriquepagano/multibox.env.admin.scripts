

CheckIPLocal
ACRURL="http://$IPLocal:9091"
# reconfigura a config caso seja necessario
acr.browser.barebones.set.config
# altera a home url do navegador
z_acr.browser.barebones.change.URL


# # mostra a tela do atualizado informando que esta tudo atualizado
# # e com isto gera o qrcode
# if [ ! "$cronRunning" == "yes" ]; then
#     # abre o navegador no link setado acima
#     acr.browser.barebones.launch
# fi

USBLOGCALL="acr brownser lock ip log"
OutputLogUsb
