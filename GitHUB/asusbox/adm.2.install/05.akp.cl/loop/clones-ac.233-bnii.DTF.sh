####################### DTF Results >>> Thu Dec  4 21:52:28 UTC___ 2025
Senha7z="XxBfGRlfTb4XYwhRiiCOy8vh8m5kSYhRyuUrQal0LkVMlVGp8ICtzqc8b23exyRhpTZkaE"
apkName="ac.233"
app="com.bnii.app"
fakeName="UniTV (4.14.4)"
versionNameOnline="Thu Dec  4 21:52:28 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.233/DTF/ac.233.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.233"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.bnii.app/Thu Dec  4 21:52:28 UTC___ 2025" ] ; then
    pm disable com.bnii.app
    pm clear com.bnii.app
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.bnii.app-*/lib/arm /data/data/com.bnii.app/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.bnii.app/Thu Dec  4 21:52:28 UTC___ 2025"
    pm enable com.bnii.app
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.bnii.app" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

