
# # este código é necessário para limpar as notificações do firmware antigo 2.4ghz asusbox
# if [ -d "/data/data/com.hal9k.notify4scripts.Notify" ]; then
#     # # Recolhe o dropdown menu
#     # service call statusbar 2
#     # # apk de notificação de tela que esta no android firmware antigo
#     # pm disable com.hal9k.notify4scripts.Notify
# fi

if [ ! -f "/data/asusbox/fullInstall" ]; then
    Titulo="Acesso $DeviceName"
    Mensagem="Por favor aguarde."
    am startservice --user 0 -n com.hal9k.notify4scripts/.NotifyServiceCV -e int_id 1 -e b_noicon "1" -e b_notime "1" -e float_tsize 27 -e str_title "$Titulo" -e hex_tcolor "FF0000" -e float_csize 16 -e str_content "$Mensagem"
    cmd statusbar expand-notifications
fi

USBLOGCALL="Block notifications boring spam"
OutputLogUsb

