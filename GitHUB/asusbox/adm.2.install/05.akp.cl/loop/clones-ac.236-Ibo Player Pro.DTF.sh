####################### DTF Results >>> Fri Jan 23 18:10:01 UTC___ 2026
Senha7z="dnllyzajjcpXpnRzQYwbZDhGsQ3QzX4eXndrCLRZ7b3IIFWqxcxHFJ2kq9TOYCtHUC6swh"
apkName="ac.236"
app="com.flextv.livestore"
fakeName="Ibo Player Pro (3.5)"
versionNameOnline="Fri Jan 23 18:10:01 UTC___ 2026"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.236/DTF/ac.236.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.236"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.flextv.livestore/Fri Jan 23 18:10:01 UTC___ 2026" ] ; then
    pm disable com.flextv.livestore
    pm clear com.flextv.livestore
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.flextv.livestore-*/lib/arm /data/data/com.flextv.livestore/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.flextv.livestore/Fri Jan 23 18:10:01 UTC___ 2026"
    pm enable com.flextv.livestore
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.flextv.livestore" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

