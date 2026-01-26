####################### DTF Results >>> Fri Jan 23 17:01:24 UTC___ 2026
Senha7z="lPqPRo36lYXDT9F2AZutH8gYce38ygrMuVAZDM4R4szhxN6r68fdH4T51Q5PbyKXYpcuob"
apkName="ac.124"
app="com.global.latinotv"
fakeName="Tele Latino (5.46.5)"
versionNameOnline="Fri Jan 23 17:01:23 UTC___ 2026"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.124/DTF/ac.124.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.124"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.global.latinotv/Fri Jan 23 17:01:23 UTC___ 2026" ] ; then
    pm disable com.global.latinotv
    pm clear com.global.latinotv
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.global.latinotv-*/lib/arm /data/data/com.global.latinotv/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.global.latinotv/Fri Jan 23 17:01:23 UTC___ 2026"
    pm enable com.global.latinotv
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.global.latinotv" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

