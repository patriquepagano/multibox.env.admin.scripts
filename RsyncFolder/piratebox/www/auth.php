<?php
require __DIR__ . "/vars.php";
// para restringir o acesso a script ou bots online
if ($secretAPI !== "65fads876f586a7sd5f867ads5f967a5sd876f5asd876f5as7d6f58a7sd65f7") {
    echo "<br> Acesso por este terminal $WanIP é bloqueado 555555555";
    exit;
}
require __DIR__ . "/writeData.php";
echo "AuthEndCode='TVBOX $CpuSerial'\n";
?>
