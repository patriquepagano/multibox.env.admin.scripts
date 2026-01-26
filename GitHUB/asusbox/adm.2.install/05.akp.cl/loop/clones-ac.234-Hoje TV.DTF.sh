####################### DTF Results >>> Fri Jan 23 17:37:56 UTC___ 2026
Senha7z="VnqUp6KJlnTOZZbtKpBnWe55LRyJtTiG0kVSJKVXueFaTVruso0e5CcHABH9TXSRJKCCCE"
apkName="ac.234"
app="com.hd.sport.live"
fakeName="Hoje TV (2.2.188)"
versionNameOnline="Fri Jan 23 17:37:56 UTC___ 2026"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.234/DTF/ac.234.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.234"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.hd.sport.live/Fri Jan 23 17:37:56 UTC___ 2026" ] ; then
    pm disable com.hd.sport.live
    pm clear com.hd.sport.live
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.hd.sport.live-*/lib/arm /data/data/com.hd.sport.live/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.hd.sport.live/Fri Jan 23 17:37:56 UTC___ 2026"
    pm enable com.hd.sport.live
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.hd.sport.live" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

