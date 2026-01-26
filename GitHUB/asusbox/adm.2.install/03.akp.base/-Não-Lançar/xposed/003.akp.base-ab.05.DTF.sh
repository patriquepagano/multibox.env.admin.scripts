####################### DTF Results >>> Fri Oct 16 11:05:50 BRT 2020
DataBankTMP="
/data/asusbox/.install/03.akp.base/ab.05/DTF/;ab.05.DTF.001;3bb819e9d50113f3999446b64d96417c;1YjhxotFPkiaTXuqiF8rbmXlBNct9phwK;1nIlTav1Cp2OXBFmPZh8cRakgBMFkJGhm;1d6Jiy5nxiRZ3f-lxou2109SZrhElNud3;1dW0ZuBPjjVmwRDqGEaqCm2n53TgV65O7;1S208ES0TQnyIjJEYI6riAVfhrfsN_NBE;1D1sATspwsW4yFOYT5mkUgiSnrNFQt6zf;1yWrJdKToLYpdYhBj5d19t6T_0mh8RMPT
"
# Check e download Files, if o torrent já não tiver feito
CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f /data/data/de.robv.android.xposed.installer/1.0.0 ] ; then
pm clear de.robv.android.xposed.installer
extractDTFSplitted
# manual config nos arquivos

# seta as permissões de user da pasta
FixPerms
# atualiza o symlink das libs em caso de atualização de apk
ln -sf /data/app/de.robv.android.xposed.installer-*/lib/arm /data/data/de.robv.android.xposed.installer/lib
# permissoes do app
AppGrantLoop=""
AppGrant
# cria o marcador para não rodar isto sempre
date > /data/data/de.robv.android.xposed.installer/1.0.0
fi
# config forçada para rodar sempre no boot

