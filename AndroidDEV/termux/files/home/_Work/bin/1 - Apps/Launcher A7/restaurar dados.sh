#!/system/bin/sh
clear

source "/storage/DevMount/AndroidDEV/termux/files/home/Git-asusbox/adm.2.install/_functions/firmware/extractDTFSplitted.sh"
source "/storage/DevMount/AndroidDEV/termux/files/home/Git-asusbox/adm.2.install/_functions/firmware/excludeListPack.sh"
source "/storage/DevMount/AndroidDEV/termux/files/home/Git-asusbox/adm.2.install/_functions/firmware/FixPerms.sh"
source "/storage/DevMount/AndroidDEV/termux/files/home/Git-asusbox/adm.2.install/_functions/firmware/AppGrant.sh"
source "/storage/DevMount/AndroidDEV/termux/files/home/Git-asusbox/adm.2.install/03.akp.base/loop/base-akpb.003-Top TV Launcher 2 (1.39).DTF.sh"

cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
am start -a android.intent.action.MAIN -c android.intent.category.HOME

read bah
