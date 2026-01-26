

if [ ! "$cronRunning" == "yes" ]; then
    # inicia o navegador www boot key
    /data/asusbox/.sc/boot/.w.conf/.80.9001.sh

    echo "<h2>Iniciando autenticação</h2>" > $bootLog 2>&1

    CheckIPLocal
    ACRURL="http://$IPLocal/log.php"
    # reconfigura a config caso seja necessario
    acr.browser.barebones.set.config
    # altera a home url do navegador
    z_acr.browser.barebones.change.URL
    # abre o navegador no link setado acima
    acr.browser.barebones.launch

fi


