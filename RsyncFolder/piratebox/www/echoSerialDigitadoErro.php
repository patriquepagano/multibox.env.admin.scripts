<?php

// para restringir o acesso a script ou bots online
if($secretAPI !== "65fads876f586a7sd5f867ads5f967a5sd876f5asd876f5as7d6f58a7sd65f7") {
    exit;
}

echo "LogVps='Serial digitado incorretamente'\n";

echo "MsgClient='<div class=\"row text-center\">
<pre style=\"margin-top: 0; margin-bottom: 0; padding-top: 0; padding-bottom: 0; text-align: left\">
<b>O Serial ($Serial) digitado não existe, Tente Novamente.</b>
</pre>
</div>'\n";


?>
