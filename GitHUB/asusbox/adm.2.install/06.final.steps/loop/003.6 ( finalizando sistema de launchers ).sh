
echo "ADM DEBUG ### ativando a launcher Official para deixar por padrão" 
pm enable dxidev.toptvlauncher2
cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"

OnScreenNow=`dumpsys window windows | busybox grep mCurrentFocus | busybox cut -d " " -f 5 | busybox cut -d "/" -f 1`
if [ "$OnScreenNow" == "android" ]; then
    echo "ADM DEBUG ### tela de escolha detectada." 
    echo "ADM DEBUG ### Fechando a launcher para ler a config em caso de novos apps ou apps reativados" 
    am force-stop dxidev.toptvlauncher2
    echo "ADM DEBUG ### trazendo a launcher para a frente"
    am start --user 0 -a android.intent.action.MAIN dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity 
fi


USBLOGCALL="launcher final step lock"
OutputLogUsb

