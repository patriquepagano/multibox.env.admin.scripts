####################### DTF Results >>> Fri Jan 23 16:57:47 UTC___ 2026
Senha7z="7uXfwfCjTheIecYJQFl2bTAYfhgYhD9jAH7uT06IDaTPOgzUaVAyDtgTQAOc8r9a9C7IDb"
apkName="ac.228"
app="com.newone.p2p1"
fakeName="NEW ONE P2P (1.0.7)"
versionNameOnline="Fri Jan 23 16:57:47 UTC___ 2026"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.228/DTF/ac.228.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.228"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.newone.p2p1/Fri Jan 23 16:57:47 UTC___ 2026" ] ; then
    pm disable com.newone.p2p1
    pm clear com.newone.p2p1
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.newone.p2p1-*/lib/arm /data/data/com.newone.p2p1/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.newone.p2p1/Fri Jan 23 16:57:47 UTC___ 2026"
    pm enable com.newone.p2p1
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.newone.p2p1" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

