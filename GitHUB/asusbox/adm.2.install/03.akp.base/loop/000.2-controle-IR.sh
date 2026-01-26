# desativar o sleep na box isto deve rodar sempre
svc power stayon true

# inicia verificação se o controle esta ativado o botão power
file="/system/usr/keylayout/110b0030_pwm.kl"
check=`busybox cat "$file" | busybox grep "POWER"`
if [ "$check" == "" ]; then
echo "<h3>Comunicado Importante: Sobre o botão de desligar no controle remoto</h3>
<h4>+ O botão foi desativado temporariamente para que seu aparelho continue recebendo atualizações.</br>
+ Novo sistema de atualização mesmo com seu MultiBOX em espera. (sleep ou standby)</br>
+ O funcionamento do botão desligar do seu MultiBOX foi reativado agora.</br>
<h3>Seu MultiBOX vai reiniciar automaticamente para efetivar esta atualização.</h3>
Por favor aguarde 2 minutos.
</h4>
" > $bootLog 2>&1
echo "ADM DEBUG ### write power button"
/system/bin/busybox mount -o remount,rw /system
busybox sed -i -e 's/key 116.*/key 116   POWER/g' $"$file"

echo "ADM DEBUG ### ativando a mensagem na tela sobre power button"
    CheckIPLocal
    ACRURL="http://$IPLocal/log.php"
    # reconfigura a config caso seja necessario
    acr.browser.barebones.set.config
    # altera a home url do navegador
    z_acr.browser.barebones.change.URL
    # abre o navegador no link setado acima

    # temporario para testar os clientes tem que entender oque esta acontecendo
    acr.browser.barebones.launch
    # pausa para o cliente ler e reinicia a box
    sleep 60
    am start -a android.intent.action.REBOOT
    sleep 200
fi

USBLOGCALL="if IR controller setup"
OutputLogUsb
