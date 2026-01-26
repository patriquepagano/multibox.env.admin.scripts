####################### DTF Results >>> Fri Nov 21 23:18:31 UTC___ 2025
Senha7z="TMSBaOtRjWNAHPktr7RDdt38kcxMmNfDT20WcbIIG2ztSwnUp2VPw0GCEIhbl387kDzGtu"
apkName="ac.114"
app="com.world.youcinetv"
fakeName="YouCine (1.15.1)"
versionNameOnline="Fri Nov 21 23:18:31 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.114/DTF/ac.114.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.114"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.world.youcinetv/Fri Nov 21 23:18:31 UTC___ 2025" ] ; then
    pm disable com.world.youcinetv
    pm clear com.world.youcinetv
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.world.youcinetv-*/lib/arm /data/data/com.world.youcinetv/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.world.youcinetv/Fri Nov 21 23:18:31 UTC___ 2025"
    pm enable com.world.youcinetv
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.world.youcinetv" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

