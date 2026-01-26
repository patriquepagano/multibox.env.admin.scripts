#!/system/bin/sh

echo ""

# alertas e notificações chatas desativa
settings put global heads_up_notifications_enabled 0

# data e hora
settings put global time_zone America/Sao_Paulo
setprop persist.sys.timezone "America/Sao_Paulo"

# How to stop "allow Google to regularly check device activity"
settings put global package_verifier_enable 0

# Allow “unknown sources” from Terminal without going to Settings App
settings put secure install_non_market_apps 1
settings put global install_non_market_apps 1

# força linguagem para Brasil
setprop persist.sys.language pt_BR
setprop persist.sys.country BR
# android 6
setprop ro.product.locale pt-BR
setprop persist.sys.locale pt-BR

echo "data e hora configurada"
echo "linguagem PT-BR"
echo ""