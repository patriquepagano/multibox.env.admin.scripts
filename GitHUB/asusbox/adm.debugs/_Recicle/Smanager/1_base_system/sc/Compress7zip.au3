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

FileDelete (@ScriptDir&"\.sc.7z")

RunWait ($7zip & ' a -mx=9 -p67asd5a7s6d57sd57 -mhe=on -t7z -y .sc.7z ' & '"' & @ScriptDir & '\*.sh"', @ScriptDir, @SW_HIDE)

ClipPut ("67asd5a7s6d57sd57")

; https://www.autoitscript.com/forum/topic/112932-get-parent-folder/
$dir = @ScriptDir
$dir_parent = StringLeft($dir,StringInStr($dir,"\",0,-1)-1)
;MsgBox(0,"",$dir_parent)

FileDelete ($dir_parent&"\.sc.7z")

FileMove ($dir&"\.sc.7z", $dir_parent&"\.sc.7z" ,1)

MsgBox(0,"sucesso.", "1_base_system pack atualizado")