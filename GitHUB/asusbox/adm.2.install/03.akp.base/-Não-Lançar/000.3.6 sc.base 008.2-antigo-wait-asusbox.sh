# # vai chavear baseado na instalação da versão antiga

# se não botar um login válido que autentique o app não cria o arquivo loginPrefs.xml
# depois que passar daqui a configuração forçada vai aplicar sempre o arquivo

if [ ! -f /data/asusbox/fullInstall ]; then
#if [ ! -f /system/etc/init/initRc.adm.drv.rc ]; then
    if [ ! -e /data/asusbox/SenhaIPTV ]; then
        # chama a tela do app do asusbox
        am start --user 0 -a android.intent.action.MAIN com.asusbox.asusboxiptvbox/.view.activity.SplashActivity
        # aguarda pela criação do arquivo e entra em looping ate existir no path

echo -n "batata" > /data/asusbox/SenhaIPTV


        while [ 1 ]; do
			# chama a funçao pra ver se o user acertou o login no app
            CheckUser
            if [ ! "$UserPass" = "" ]; then break; fi;
            echo "aguardando arquivo"
            sleep 1;
        done;
        # cria o arquivo caso o app verificar o login como válido
        while [ 1 ]; do
            echo -n $UserPass > /data/asusbox/SenhaIPTV
            if [ $? = 0 ]; then break; fi;
            sleep 1;
        done;
        am force-stop com.asusbox.asusboxiptvbox
        # informa que user foi verificado
        echo "<h2>Autenticado com Sucesso</h2>" >> $bootLog 2>&1
        echo "<h1>Por favor aguarde a instalação</h1>" >> $bootLog 2>&1
    fi # fim do if se não existir o /data/asusbox/SenhaIPTV
fi




