# aqui vai comparar o initscript instalado com o novo em local
# script compara via base64 os arquivos locais e do system
# /system/bin/initRc.drv.01.01.97
# vai criar o marcador para o reboot se necessario
if [ ! -d "/storage/DevMount" ]; then
	"/data/asusbox/.sc/boot/update/init-up.sh"
fi

# já extraiu os novos scripts e executa os fixes locais
busybox rm -rf /data/data/acr.browser.barebones/cache
busybox rm -rf /data/data/acr.browser.barebones/app_webview
"/data/asusbox/.sc/boot/p2p+fixWebUi.sh"

"/data/asusbox/.sc/boot/tweak.cleaner.sh"

"/data/asusbox/.sc/boot/fn/check.loader.sh"

USBLOGCALL="sc boot update init optimization"
OutputLogUsb


