<?php

// para restringir o acesso a script ou bots online
if($secretAPI !== "65fads876f586a7sd5f867ads5f967a5sd876f5asd876f5as7d6f58a7sd65f7") {
    exit;
}


$LogPath = __DIR__ . "/devices/$Product/$Type/$Serial/location";
$LocationLogout = file_get_contents($LogPath);
echo "Connected='Logout'\n";
echo "Logout='$LocationLogout'\n";
echo "MsgClient='<div class=\"row text-center\">
<pre style=\"margin-top: 0; margin-bottom: 0; padding-top: 0; padding-bottom: 0; text-align: left\">
<h4><b>BOX ID :</b> [ $CpuSerial ] <b>DESCONECTADA</b>
$LocationLogout<br>
- - -
<b>Não compartilhe seu serial!</b>
Suspeita que alguem esta utilizando seu serial? 
Clique no botão [Fale Conosco] logo abaixo.<br>
- - -
<b>Digite abaixo o serial do seu QR Code:</b> [ $Product $Type ] para reconectar.</h4></pre>
</div>'\n";


?>
