####################### DTF Results >>> Fri Sep 26 21:45:05 UTC___ 2025
Senha7z="W3bzfo8LNliD3hA6JBhCmzGb49V3MSCO7QuMmfKs4TXeggr17egF1Z8SqPC8FwGQ3tmQk7"
apkName="ac.216"
app="com.bx.livf"
fakeName="STV (20250701)"
versionNameOnline="Fri Sep 26 21:45:05 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.216/DTF/ac.216.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.216"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.bx.livf/Fri Sep 26 21:45:05 UTC___ 2025" ] ; then
    pm disable com.bx.livf
    pm clear com.bx.livf
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.bx.livf-*/lib/arm /data/data/com.bx.livf/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.bx.livf/Fri Sep 26 21:45:05 UTC___ 2025"
    pm enable com.bx.livf
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.bx.livf" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

