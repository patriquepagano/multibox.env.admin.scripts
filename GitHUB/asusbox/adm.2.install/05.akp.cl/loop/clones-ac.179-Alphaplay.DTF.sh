####################### DTF Results >>> Fri Jan 31 23:01:57 UTC___ 2025
Senha7z="UefYqIr2RmcpgnG79rSulwc1cH14t7INdsY4ilsvJYafvzZsadzt4899V1Q6My9pqAVBJF"
apkName="ac.179"
app="com.chsz.efile.alphaplay"
fakeName="Alphaplay (a5.2.1-20240619)"
versionNameOnline="Fri Jan 31 23:01:57 UTC___ 2025"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.179/DTF/ac.179.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.179"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.chsz.efile.alphaplay/Fri Jan 31 23:01:57 UTC___ 2025" ] ; then
    pm disable com.chsz.efile.alphaplay
    pm clear com.chsz.efile.alphaplay
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.chsz.efile.alphaplay-*/lib/arm /data/data/com.chsz.efile.alphaplay/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.chsz.efile.alphaplay/Fri Jan 31 23:01:57 UTC___ 2025"
    pm enable com.chsz.efile.alphaplay
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.chsz.efile.alphaplay" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

