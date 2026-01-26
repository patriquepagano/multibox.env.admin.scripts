####################### DTF Results >>> Fri Jul 19 20:29:19 UTC___ 2024
Senha7z="FvdONx3132RvOEB2p9BCu3q1h4iW3728Why969f8hFyK7kcjOHxY6V4QEW3KhGLLKTRttX"
apkName="ac.090"
app="com.interactive.htviptv"
fakeName="HTV (4.9.0)"
versionNameOnline="Fri Jul 19 20:29:18 UTC___ 2024"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.090/DTF/ac.090.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.090"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.interactive.htviptv/Fri Jul 19 20:29:18 UTC___ 2024" ] ; then
    pm disable com.interactive.htviptv
    pm clear com.interactive.htviptv
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.interactive.htviptv-*/lib/arm /data/data/com.interactive.htviptv/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.interactive.htviptv/Fri Jul 19 20:29:18 UTC___ 2024"
    pm enable com.interactive.htviptv
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.interactive.htviptv" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

