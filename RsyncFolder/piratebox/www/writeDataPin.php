<?php
// para restringir o acesso a script ou bots online
if($secretAPI !== "65fads876f586a7sd5f867ads5f967a5sd876f5asd876f5as7d6f58a7sd65f7") {
    exit;
}


// grava novo pinCode no host
$fhandle = fopen("$PinCodePath", "w") or die("Unable to open file!");
fwrite($fhandle, "$PinCodeNEW");
fclose($fhandle);
// escreve arquivo de log
$date = date('d/m/Y');
$hora = date('H:i:s');


// // metodo antigo
// $LocationPath = __DIR__ . "/devices/$Product/$Type/$Serial/location.log";
// $fhandle = fopen($LocationPath, "a") or die("Unable to open file!");
// $fileContent = <<<EOT

// #Data="$date"#Hora="$hora"#Uptime="$checkUptime"#Geo="$LocationGeoIP"#CpuSerial="$CpuSerial"
// EOT;
// fwrite($fhandle, $fileContent);
// fclose($fhandle);



$LocationPath = __DIR__ . "/devices/$Product/$Type/$Serial/location.log";
$fileContent = <<<EOT
#Data="$date"#Hora="$hora"#Uptime="$checkUptime"#Geo="$LocationGeoIP"#CpuSerial="$CpuSerial"
EOT;
// Abre o arquivo para escrita, com o modo 'a' (append) e adiciona a flag FILE_APPEND
file_put_contents($LocationPath, $fileContent . PHP_EOL, FILE_APPEND | LOCK_EX);









// mantem as 400 linhas do log
shell_exec("tail -n 400 $LocationPath | sponge $LocationPath");

// Divide a string usando " | " como delimitador
$dados = explode(" | ", $LocationGeoIP);

// Atribui os valores a variáveis
$ip1 = $dados[0];
$ip2 = $dados[1];
$country = $dados[2];
$state = $dados[3];
$city = $dados[4];
// $provider = $dados[5];
// $hostname = $dados[6];

$LocationPath = __DIR__ . "/devices/$Product/$Type/$Serial/location";
$fhandle = fopen($LocationPath, "w") or die("Unable to open file!");

$fileContent = <<<EOT
<b>Último acesso:</b> $date | Hora $hora
<b>Tempo conectado ao servidor:</b> $checkUptime
<b>IPs:</b> $ip1 | $ip2
$country | $state | $city
EOT;

fwrite($fhandle, $fileContent);
fclose($fhandle);

echo "WriteDataPIN='Changed $PinCodeNEW $date $hora'\n";

?>
