####################### DTF Results >>> Wed Dec 31 21:55:39 BRT 1969
Senha7z="zNNxizEiOkfX99z2ngbs7gETcvco50MUX6WTJk97Vtc5EJSghAakzFf5QIffwMj7WdmPEo"
apkName="005.0"
app="de.robv.android.xposed.installer"
versionNameOnline="Wed Dec 31 21:55:38 BRT 1969"
SourcePack="/data/asusbox/.install/01.sc.base/005.0/DTF/005.0.DTF"
excludeListPack "/data/asusbox/.install/01.sc.base/005.0"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/de.robv.android.xposed.installer/Wed Dec 31 21:55:38 BRT 1969" ] ; then
    pm clear de.robv.android.xposed.installer
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/de.robv.android.xposed.installer-*/lib/arm /data/data/de.robv.android.xposed.installer/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop=""
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/de.robv.android.xposed.installer/Wed Dec 31 21:55:38 BRT 1969"
fi
###################################################################################
# config forçada para rodar sempre no boot

