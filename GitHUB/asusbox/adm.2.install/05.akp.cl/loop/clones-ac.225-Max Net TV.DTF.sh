####################### DTF Results >>> Fri Nov 21 23:24:24 UTC___ 2025
Senha7z="wQZFLXVNYFCamFHtrCR9arhB46BybXIE47tGOn3uUnXGDzQRRcRQA0kj3yAIH9vvx31Igy"
apkName="ac.225"
app="com.exploudapps.maxnettv"
fakeName="Max Net TV (12.3)"
versionNameOnline="Fri Nov 21 23:24:24 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.225/DTF/ac.225.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.225"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.exploudapps.maxnettv/Fri Nov 21 23:24:24 UTC___ 2025" ] ; then
    pm disable com.exploudapps.maxnettv
    pm clear com.exploudapps.maxnettv
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.exploudapps.maxnettv-*/lib/arm /data/data/com.exploudapps.maxnettv/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.exploudapps.maxnettv/Fri Nov 21 23:24:24 UTC___ 2025"
    pm enable com.exploudapps.maxnettv
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.exploudapps.maxnettv" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

