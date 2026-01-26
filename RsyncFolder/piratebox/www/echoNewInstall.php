<?php

// para restringir o acesso a script ou bots online
if($secretAPI !== "65fads876f586a7sd5f867ads5f967a5sd876f5asd876f5as7d6f58a7sd65f7") {
    exit;
}

$FirstsignupSH = file_get_contents("$structureLOG/01Firstsignup.sh");
preg_match("/Firstsignup='(.*?)'/", $FirstsignupSH, $matches);
$Firstsignup="$matches[1]";

echo "Assinatura='NewInstall'\n";
echo "MsgClient='<div class=\"row text-center\">
<pre style=\"text-align: left\">
<h4>
<b>Box Registrada em: $Firstsignup <br>

Escaneie o QR Code fornecido pelo revendedor.
Em seu controle remoto, digite a sequência:
Três toques para baixo e digite os números e pressione enviar
Seu serial é a sua senha, não compartilhe seu serial!
Não é possivel alterar os números do serial.</b>
</h4>
</pre>
</div>'\n";


?>
