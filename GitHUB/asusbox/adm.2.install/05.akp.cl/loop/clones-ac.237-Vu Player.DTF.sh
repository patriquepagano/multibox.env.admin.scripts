####################### DTF Results >>> Fri Jan 23 18:07:31 UTC___ 2026
Senha7z="QfxJcXCZYo0kxFOCDNky5288cRp30eyfWi1prU6hQe9fE2kH4vzVplBEw1hFh57Qu5vJzi"
apkName="ac.237"
app="com.super.tela"
fakeName="Vu Player (1.7)"
versionNameOnline="Fri Jan 23 18:07:31 UTC___ 2026"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.237/DTF/ac.237.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.237"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.super.tela/Fri Jan 23 18:07:31 UTC___ 2026" ] ; then
    pm disable com.super.tela
    pm clear com.super.tela
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.super.tela-*/lib/arm /data/data/com.super.tela/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.super.tela/Fri Jan 23 18:07:31 UTC___ 2026"
    pm enable com.super.tela
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.super.tela" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

