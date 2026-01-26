####################### DTF Results >>> Thu Dec  4 21:48:00 UTC___ 2025
Senha7z="mlguxqDfoy9yWmONZMsfsYZP0fReNJ1JkzKtt7OrIu8WwiY7OenuUTGzgM11mKyxcUneOm"
apkName="ac.232"
app="com.wapp.ibo"
fakeName="Wapp IBO (3.9)"
versionNameOnline="Thu Dec  4 21:48:00 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.232/DTF/ac.232.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.232"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.wapp.ibo/Thu Dec  4 21:48:00 UTC___ 2025" ] ; then
    pm disable com.wapp.ibo
    pm clear com.wapp.ibo
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.wapp.ibo-*/lib/arm /data/data/com.wapp.ibo/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.wapp.ibo/Thu Dec  4 21:48:00 UTC___ 2025"
    pm enable com.wapp.ibo
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.wapp.ibo" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

