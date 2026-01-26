####################### DTF Results >>> Fri Sep 26 20:37:19 UTC___ 2025
Senha7z="d2hk4ObSxbXgMffjfyNzfziQK3lTFWlG9NjTRRQKoe5JDL1UfZne26vPazusKTdRRV5GQP"
apkName="ac.222"
app="com.integration.unitvsiptv"
fakeName="UniTV Free (5.3.1)"
versionNameOnline="Fri Sep 26 20:37:18 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.222/DTF/ac.222.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.222"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.integration.unitvsiptv/Fri Sep 26 20:37:18 UTC___ 2025" ] ; then
    pm disable com.integration.unitvsiptv
    pm clear com.integration.unitvsiptv
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
rm /storage/emulated/0/.config
rm /storage/emulated/0/.properties
echo -n '#personal info
#Sat Aug 30 22:49:36 GMT-03:00 2025
key_device_id_unitvfree=443141686b59376e573358313356714b66417a3573413d3d
key_sn_token_unitvfree=546e4753625874497347715162776969354c4f65626a6c3838746d794f514134
' > /storage/emulated/0/.config

    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.integration.unitvsiptv-*/lib/arm /data/data/com.integration.unitvsiptv/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.integration.unitvsiptv/Fri Sep 26 20:37:18 UTC___ 2025"
    pm enable com.integration.unitvsiptv
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.integration.unitvsiptv" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

