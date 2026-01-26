####################### DTF Results >>> Mon Jun 23 21:25:30 UTC___ 2025
Senha7z="fvPVr6r5ljfy2cLjBPkCYVzEkkF91ujkNVqr5XDL4seZqmiAOuoDgdu4qmxv5NBEZb4Jn2"
apkName="ac.196"
app="iptv.vivo.player"
fakeName="Vivo Player (3.3.6)"
versionNameOnline="Mon Jun 23 21:25:30 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.196/DTF/ac.196.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.196"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/iptv.vivo.player/Mon Jun 23 21:25:30 UTC___ 2025" ] ; then
    pm disable iptv.vivo.player
    pm clear iptv.vivo.player
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/iptv.vivo.player-*/lib/arm /data/data/iptv.vivo.player/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop=""
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/iptv.vivo.player/Mon Jun 23 21:25:30 UTC___ 2025"
    pm enable iptv.vivo.player
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "iptv.vivo.player" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

