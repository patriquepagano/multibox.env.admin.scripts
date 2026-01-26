#cs ----------------------------------------------------------------------------
$Szip -v5m a -mx=9 -pAdmger9pqt -mhe=on -t7z -y my_zip.7z $EXTERNAL_STORAGE/Download/homeLauncher.tar

echo 67asd5a7s6d57sd57| clip


#ce ----------------------------------------------------------------------------
#include <MsgBoxConstants.au3>
#include <File.au3>
#include <WinAPIFiles.au3>
#include <Array.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Include <GuiEdit.au3>

Local $7zip = ("C:\Program Files\7-Zip\7z.exe")

FileDelete (@ScriptDir&"\.sc.tar")

RunWait ($7zip & ' a -ttar -y .sc.tar ' & '"' & @ScriptDir & '\*.sh"', @ScriptDir, @SW_HIDE)

ClipPut ("67asd5a7s6d57sd57")


; https://www.autoitscript.com/forum/topic/112932-get-parent-folder/
$dir = @ScriptDir
$dir_parent = StringLeft($dir,StringInStr($dir,"\",0,-1)-1)
;MsgBox(0,"",$dir_parent)

FileDelete ($dir_parent&"\.sc.tar")

FileMove ($dir&"\.sc.tar", $dir_parent&"\.sc.tar" ,1)

MsgBox(0,"sucesso.", "0_support pack atualizado")