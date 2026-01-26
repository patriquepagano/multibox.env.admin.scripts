####################### DTF Results >>> Fri Sep 26 20:46:59 UTC___ 2025
Senha7z="lgCIglqBw75gJzYxFMLcJHIkZsd4MEHUskmNZJgJcRh7MGSfJ7HXM8u3R6plGrgaGsMtxy"
apkName="ac.223"
app="com.new2tourosat.app"
fakeName="Tourolive T1 (2.4.4)"
versionNameOnline="Fri Sep 26 20:46:59 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.223/DTF/ac.223.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.223"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.new2tourosat.app/Fri Sep 26 20:46:59 UTC___ 2025" ] ; then
    pm disable com.new2tourosat.app
    pm clear com.new2tourosat.app
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.new2tourosat.app-*/lib/arm /data/data/com.new2tourosat.app/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop=""
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.new2tourosat.app/Fri Sep 26 20:46:59 UTC___ 2025"
    pm enable com.new2tourosat.app
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.new2tourosat.app" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

