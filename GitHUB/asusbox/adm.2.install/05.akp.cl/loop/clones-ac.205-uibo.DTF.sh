####################### DTF Results >>> Sat Aug  9 00:14:47 UTC___ 2025
Senha7z="izfLf7WHMiTzQr99NLmSpxZSYT2XuKXiBjnMU1vw1LhbGuS7dhmdysKOxycbBrP4l8Hope"
apkName="ac.205"
app="com.ibostore.meplayerib4k"
fakeName="MediaPlayerIbo (229.6)"
versionNameOnline="Sat Aug  9 00:14:47 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.205/DTF/ac.205.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.205"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.ibostore.meplayerib4k/Sat Aug  9 00:14:47 UTC___ 2025" ] ; then
    pm disable com.ibostore.meplayerib4k
    pm clear com.ibostore.meplayerib4k
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.ibostore.meplayerib4k-*/lib/arm /data/data/com.ibostore.meplayerib4k/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop=""
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.ibostore.meplayerib4k/Sat Aug  9 00:14:47 UTC___ 2025"
    pm enable com.ibostore.meplayerib4k
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.ibostore.meplayerib4k" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

