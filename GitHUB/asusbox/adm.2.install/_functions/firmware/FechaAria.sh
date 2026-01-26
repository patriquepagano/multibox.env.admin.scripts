
#####################################################################################################
# Funções de download
function FechaAria () {
/system/bin/busybox kill -9 $(/system/bin/busybox pgrep aria2c) > /dev/null 2>&1
}

