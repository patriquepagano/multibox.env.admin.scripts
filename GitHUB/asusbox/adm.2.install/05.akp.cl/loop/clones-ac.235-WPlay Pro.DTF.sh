####################### DTF Results >>> Fri Jan 23 17:40:26 UTC___ 2026
Senha7z="g8idd83cNu4jnMzJZm83eVPAjr1FJ8dhxd1ZX8n9Jyb49mSQ1QiMSU1MmiBnXiiBSIE7ck"
apkName="ac.235"
app="io.wareztv.android.pro"
fakeName="WPlay Pro (4.2.8)"
versionNameOnline="Fri Jan 23 17:40:26 UTC___ 2026"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.235/DTF/ac.235.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.235"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/io.wareztv.android.pro/Fri Jan 23 17:40:26 UTC___ 2026" ] ; then
    pm disable io.wareztv.android.pro
    pm clear io.wareztv.android.pro
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/io.wareztv.android.pro-*/lib/arm /data/data/io.wareztv.android.pro/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/io.wareztv.android.pro/Fri Jan 23 17:40:26 UTC___ 2026"
    pm enable io.wareztv.android.pro
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "io.wareztv.android.pro" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

