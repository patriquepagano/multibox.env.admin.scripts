# só alterna para esta launcher se for o primeiro instal
# por padrao o initscript sempre vai deixar nesta launcher

if [ ! -f /data/asusbox/fullInstall ]; then
    if [ ! -f /data/asusbox/crontab/LOCK_cron.updates ]; then
        echo "ADM DEBUG #####################################################################"
        echo "ADM DEBUG ### Alterna para a launcher dos apps base enquanto atualiza"
        ### para quem ja tiver a launcher só força o setting
        cmd package set-home-activity "launcher.offline/dxidev.toptvlauncher2.HomeActivity"
        /data/asusbox/.sc/boot/launcher-02-update.sh
    fi
fi

