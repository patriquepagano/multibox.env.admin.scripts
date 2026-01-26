####################### DTF Results >>> Thu Dec  4 21:40:44 UTC___ 2025
Senha7z="D4ZrHN0Iab2RbDgewMgAEZAJIoBLv455GRk68dqF9eAKc7PPEowYeGteTyXWpgxV7zO9fF"
apkName="ac.230"
app="com.vupurple.player"
fakeName="VU Player Pro (1.6)"
versionNameOnline="Thu Dec  4 21:40:44 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.230/DTF/ac.230.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.230"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.vupurple.player/Thu Dec  4 21:40:44 UTC___ 2025" ] ; then
    pm disable com.vupurple.player
    pm clear com.vupurple.player
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.vupurple.player-*/lib/arm /data/data/com.vupurple.player/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.vupurple.player/Thu Dec  4 21:40:44 UTC___ 2025"
    pm enable com.vupurple.player
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.vupurple.player" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

