

if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then

    CheckIPLocal
    ACRURL="http://$IPLocal/log.php"
    # reconfigura a config caso seja necessario
    acr.browser.barebones.set.config
    # abre o navegador no link setado acima
    if [ ! -f /data/asusbox/fullInstall ]; then
        acr.browser.barebones.launch
    fi

fi
