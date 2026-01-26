
echo "ADM DEBUG ##############################################################################"
echo "ADM DEBUG ### Led ativa informando que não esta mais se atualizando"
echo "ADM DEBUG ### if tiver o arquivo second boot"
filesc="/data/asusbox/.sc/boot/led-on.sh"
if [  -f $filesc ];then
    $filesc &
fi

sleep 1 # precisa deste tempo para não fechar o script a seguir

# fica no initscript
echo "ADM DEBUG ##############################################################################"
echo "ADM DEBUG ### ativando o pisca alerta ate atualizar tudo"
echo "ADM DEBUG ### if tiver o arquivo second boot"
filesc="/data/asusbox/.sc/boot/led-blink-infinity.sh"
if [  -f $filesc ];then
    $filesc &
fi


