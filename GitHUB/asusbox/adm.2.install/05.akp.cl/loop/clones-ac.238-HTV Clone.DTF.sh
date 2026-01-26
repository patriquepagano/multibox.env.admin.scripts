####################### DTF Results >>> Fri Jan 23 18:12:19 UTC___ 2026
Senha7z="AmxPoQHfBRrttx7smeZIdm4HjBSYI3Q3VQAMG7nzgqytIvcDcX9u0m7o15TgN5hZRexOin"
apkName="ac.238"
app="com.example.app"
fakeName="HTV (5.40.0)"
versionNameOnline="Fri Jan 23 18:12:19 UTC___ 2026"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.238/DTF/ac.238.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.238"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.example.app/Fri Jan 23 18:12:19 UTC___ 2026" ] ; then
    pm disable com.example.app
    pm clear com.example.app
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.example.app-*/lib/arm /data/data/com.example.app/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.example.app/Fri Jan 23 18:12:19 UTC___ 2026"
    pm enable com.example.app
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.example.app" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

