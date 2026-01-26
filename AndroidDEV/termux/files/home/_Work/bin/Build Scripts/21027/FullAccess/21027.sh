#!/system/bin/bash
clear
path=$( cd "${0%/*}" && pwd -P )

BB=/system/bin/busybox
ClientHardware="/data/trueDT/peer/data/client/ClientHardware"

Log="/data/trueDT/peer/data/client/LOG/services/init.21027.LOG"
DeviceName=$(< "$ClientHardware/UniqID")

CfgXML="/data/trueDT/peer/config/config.xml"
API=$($BB awk -F '[><]' '/<apikey>/ {print $3}' "$CfgXML")
Headers="Content-Type: application/json"

Lista="
# TVBOX 101
TVBox-59f2dea210831638f2d9e

# TVBOX 102
TVBox-bfa3f120fe0788927859a

# TVBOX IP rede / wifi 116 ( gamebox instalado )
TVBox-6987905daccc14fb0ece1

# TVBOX wifi 117 ( A7 com pendrive )
TVBox-d73be3aa530f09cc94b3d

"
if echo "$Lista" | $BB sed '/^\s*#/d;/^\s*$/d' | $BB grep -Fxq "$DeviceName"; then   
    # full access: limpa user/pass e ajusta endereço
    if $BB grep -q '<user>[^<]' "$CfgXML"; then
        echo "Device na lista full acesso"
        if curl -s -m 2 -H "X-API-Key: $API" "http://127.0.0.1:8384/rest/system/status" | grep -q '"myID"'; then
            GuiURL="http://127.0.0.1:8384/rest/config/gui"
            echo "USER INFO ########################################################" >> "$Log"
            echo "USER INFO ### $DeviceName full access" >> "$Log"
            echo "ADM DEBUG ### No password gui 0.0.0.0:8384" >> "$Log"
            DataClear='{"enabled":true,"user":"","password":"","address":"0.0.0.0:8384"}'
            curl -X PATCH -H "X-API-Key: $API" "$GuiURL" -H "$Headers" -d "$DataClear"
        fi
    fi
fi



read bah



        # ativa o serviço


# # para ligar serviço precisa dos marcadores

# # para ativar o serviço
# : > "$LogFolder/Start.update.System"
# rm /data/trueDT/peer/TMP/init.21027.cfg.done
# # so para testar e ver se vai gerar
# rm /data/trueDT/peer/TMP/TVBoxID.png

# # remove a destrava do init service
# rm /data/trueDT/peer/TMP/init.21027.DISABLED

# marcador do full access
DevSpec="/data/trueDT/peer/data/server/Dev.Spec"
mkdir -p "/data/trueDT/peer/data/server/Dev.Spec"
date > "$DevSpec/FullAccess.21027"