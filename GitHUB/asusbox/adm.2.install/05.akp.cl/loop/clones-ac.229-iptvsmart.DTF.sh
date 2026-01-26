####################### DTF Results >>> Thu Dec  4 21:33:57 UTC___ 2025
Senha7z="6sW73WsTmDhvUbGSyQPbmRG3tA2p7s1M11p6cuh5hfN7dZ5dg2oMXkTDadXATIokZiZzJ9"
apkName="ac.229"
app="iptvsmart.iboxt"
fakeName="DUNA XTP (1.18)"
versionNameOnline="Thu Dec  4 21:33:57 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.229/DTF/ac.229.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.229"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/iptvsmart.iboxt/Thu Dec  4 21:33:57 UTC___ 2025" ] ; then
    pm disable iptvsmart.iboxt
    pm clear iptvsmart.iboxt
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/iptvsmart.iboxt-*/lib/arm /data/data/iptvsmart.iboxt/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/iptvsmart.iboxt/Thu Dec  4 21:33:57 UTC___ 2025"
    pm enable iptvsmart.iboxt
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "iptvsmart.iboxt" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

