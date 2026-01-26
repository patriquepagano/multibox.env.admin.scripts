####################### DTF Results >>> Fri Aug  8 23:25:09 UTC___ 2025
Senha7z="UNsHNp8HzuN0wcSgiU9oBM3usYtBAFA9vtNz3cDQ1pmkXdErexsX0lwdig7crquYFjM1dI"
apkName="ac.201"
app="br.com.kerhkhd"
fakeName="P2Mais v5.9.1 (5.9.1)"
versionNameOnline="Fri Aug  8 23:25:09 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.201/DTF/ac.201.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.201"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/br.com.kerhkhd/Fri Aug  8 23:25:09 UTC___ 2025" ] ; then
    pm disable br.com.kerhkhd
    pm clear br.com.kerhkhd
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/br.com.kerhkhd-*/lib/arm /data/data/br.com.kerhkhd/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/br.com.kerhkhd/Fri Aug  8 23:25:09 UTC___ 2025"
    pm enable br.com.kerhkhd
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "br.com.kerhkhd" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

