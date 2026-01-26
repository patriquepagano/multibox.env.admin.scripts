<?php
// para restringir o acesso a script ou bots online
if($secretAPI !== "65fads876f586a7sd5f867ads5f967a5sd876f5asd876f5as7d6f58a7sd65f7") {
    exit;
}

// antes de soltar o chaveamento forçando os clientes a adicionar o serial para todos preciso alimentar esta variavel
// limpar esta variavel força [TODAS AS BOXES] 
// a irem para o sistema de chaveamento expirado em serial
$Product = "A7";

// se a box não tiver identificação de modelo aparece o 
// chaveamento de nova instalação do zero ou boxes antigas q estiver rodando
if ($Product == "") {
    require __DIR__ . "/echoNewInstall.php";
    exit;
}

// Diretório de destino das pastas de LOG baseado em Placa fabricante e serial de CPU
$structureLOG = __DIR__ . "/devices/$Product/LOG/$Placa=$CpuSerial";
// variaveis product e type e cpuID não podem estar em branco
if (!is_dir($structureLOG)) {
    // Verifica se $structureLOG não é um diretório existente
    if (shell_exec("mkdir -p $structureLOG") === null) {
        // A criação do diretório falhou
    }

}
// gera os arquivos de log e marcadores do funil de venda
require __DIR__ . "/writeDataXlogCPU.php";


// verificação para expirar as boxes antigas para transição do sistema de serial
// se o user não for premium vai fazer esta verificação
if (!file_exists("$structureLOG/KeyLocked")) {
    // Lê a data da instalação da box
    $FirstsignupSH = file_get_contents("$structureLOG/01Firstsignup.sh");
    preg_match("/FirstsignupUnix='(.*?)'/", $FirstsignupSH, $matches);
    $FirstsignupUnix="$matches[1]";
    preg_match("/FirmwareInstallUnix='(.*?)'/", $FirstsignupSH, $matches);
    $FirmwareInstallUnix="$matches[1]";
    // Comparar as datas em epoch para ver qual é a mais antiga
    if ($FirstsignupUnix < $FirmwareInstallUnix) {
        //FirstsignupUnix é mais antigo
        $REALFirstInstallDate = "$FirstsignupUnix";
        //echo "FirstInstallDate='$FirstsignupUnix'\n";
    } elseif ($FirstsignupUnix > $FirmwareInstallUnix) {
        //FirmwareInstallUnix é mais antigo
        $REALFirstInstallDate = "$FirmwareInstallUnix";
        //echo "FirstInstallDate='$FirmwareInstallUnix'\n";
    } else {
        //Ambas as datas são iguais
        $REALFirstInstallDate = "$FirstsignupUnix";
        //echo "FirstInstallDate='$FirstsignupUnix'\n";
    }

    echo "logA='Data First signup no vps > $FirstsignupUnix'\n";
    echo "logB='Data install firmware bancada > $FirmwareInstallUnix'\n";
    echo "logC='Data mais antiga > $REALFirstInstallDate'\n";

    // nesta ideia sabendo a data de expiração das box baseadas em log
    // consigo expira-las por aqui chamando o echo das expiradas
    // box em questao esta na data epoch 1681258669

    //$DataFunil = "1681258670";
    $DataFunil = "1";
    if ($REALFirstInstallDate > $DataFunil) {
        echo "logD='REALFirstInstallDate é menor que o filtro vendas.'\n";
        echo "Assinatura='PasseLivre'\n";
    } elseif ($REALFirstInstallDate < $DataFunil) {
        echo "logE='DataFunil de vendas é maior que a box $REALFirstInstallDate.'\n";
        echo "logF='Expirando box e jogando para funil de vendas'\n";
        // definindo qual mensagem enviar
        $FPayNow = "$structureLOG/PayNow";
        if (file_exists($FPayNow)) {
            require __DIR__ . "/echoNewInstall.php";
        } else {
            require __DIR__ . "/echoAssinaturaExpirada.php";
        }        
        //echo "SkipCheck='YES'\n";
    } else {
        echo "logG='As duas variáveis têm o mesmo valor. levando box para funil de vendas'\n";
        // definindo qual mensagem enviar
        $FPayNow = "$structureLOG/PayNow";
        if (file_exists($FPayNow)) {
            require __DIR__ . "/echoNewInstall.php";
        } else {
            require __DIR__ . "/echoAssinaturaExpirada.php";
        }
        //echo "SkipCheck='YES'\n";
    }
}






// caso não atualize o codigo no cliente reinicie o fpm
//    sudo systemctl restart php8.1-fpm
// mesmo reiniciando o nginx server e o fpm ainda não atualizou o código. isto pode ser bug grave

// se as variaveis não estiverem em branco executa
if (!empty($Product) && !empty($Type) && !empty($Serial)) {
    //echo "debugLoop='loop das variaveis todas com dados'\n";
    // se o diretório do serial existir executa
    $diretorio = __DIR__ . "/devices/$Product/$Type/$Serial";
    if (file_exists($diretorio)) {
        // verifica se o serial esta a venda
        $filePath = __DIR__ . "/devices/$Product/$Type/$Serial/KeyLog";
            if (!file_exists($filePath)) {
                $SignInDate = date('d/m/Y H:i:s');
                $SignInDateUnix = time();
                // Adiciona um ano ao timestamp atual
                $SignOutDateUnix = strtotime('+1 year', $SignInDateUnix);
                //$SignOutDateUnix = strtotime('+1 minutes', $SignInDateUnix);

                // expira em um ano full date
                $SignOutDate = date('d/m/Y H:i:s', $SignOutDateUnix);
                // arquivo marcador primeira ativação
                $fhandle = fopen("$filePath", "w") or die("error write enabled!\n");
                $fileContent = <<<EOT
                $SignInDate
                $SignInDateUnix
                $LocationGeoIP
                $SignOutDate
                $SignOutDateUnix
                EOT;
                fwrite($fhandle, $fileContent);
                fclose($fhandle);
                // apaga o arquivo marcado de serial a venda
                unlink(__DIR__ . "/devices/$Product/$Type/$Serial/forSell");
                // apaga o arquivo expirador de boxes novas
                unlink( "$structureLOG/PayNow");
                // cria o arquivo marcador de user premium na pasta log da box
                $fhandle = fopen("$structureLOG/KeyLocked", "w") or die("error wr Premium\n");
                $fileContent = <<<EOT
                $Serial
                EOT;
                fwrite($fhandle, $fileContent);
                fclose($fhandle);
            }
            // lendo o arquivo marcador de box ativada via serial
            $filePath = __DIR__ . "/devices/$Product/$Type/$Serial/KeyLog";
            // Lê todas as linhas do arquivo em um array
            $linhas = file($filePath, FILE_IGNORE_NEW_LINES);    
            // Atribui cada linha a uma variável
            list($SignInDate, $SignInDateUnix, $LocationGeoIPLog, $SignOutDate, $SignOutDateUnix) = $linhas;
            // Data atual
            $CurrentDateUnix = time();
            if ($SignOutDateUnix < $CurrentDateUnix) {
                require __DIR__ . "/echoAssinaturaExpirada.php";              
                shell_exec("touch $diretorio/SerialExpirado");
                exit;
            } else {
                echo "Assinatura='Ativo'\n";
                echo "VPSDate='$CurrentDateUnix'\n";
                echo "expiraUnix='$SignOutDateUnix'\n";
                echo "expiraDate='$SignOutDate'\n";
                $PinCodeMaster = substr($Serial, -4);
                $PinCodePath = __DIR__ . "/devices/$Product/$Type/$Serial/PinCode";
                $PinCodeAtual = file_get_contents($PinCodePath);
                if ($PinCodePost == $PinCodeAtual) {
                    require __DIR__ . "/writeDataPin.php";
                    echo "PinCodeVPS='$PinCodeNEW'\n";
                    echo "Connected='YES'\n";
                } elseif ($PinCodePost == $PinCodeMaster) {
                    require __DIR__ . "/writeDataPin.php";
                    echo "PinCodeVPS='$PinCodeNEW'\n";
                    echo "Connected='YES'\n";
                    echo "LogVps='Nova troca de senha iniciada'\n";
                    $date = date('d/m/Y');
                    $hora = date('H:i:s');
                    $LocationPath = __DIR__ . "/devices/$Product/$Type/$Serial/Pareamento.log";
                    $fhandle = fopen( $LocationPath, "a") or die("Unable to open file!");
                    $fileContent = <<<EOT
        
                    #Data="$date"#Hora="$hora"#Uptime="$checkUptime"#WanIPhp="$WanIP"#Geo="$LocationGeoIP"#UpdateSystemVersion="$UpdateSystemVersion"#FsData="$FileSystemPartitionData"#FW="$FirmwareFullSpecsID"#FWHardReset="$FirmwareHardReset"#CpuSerial="$CpuSerial"
                    EOT;
                    fwrite($fhandle, $fileContent);
                    fclose($fhandle);
                    // mantem as 400 linhas do log
                    shell_exec("tail -n 400 $LocationPath | sponge $LocationPath");
                } else {
                    // box desconectada logout
                    require __DIR__ . "/echoBoxDesconectada.php";
                }
            }
    } else {
        echo "Assinatura='serialIncorreto'\n";        
        require __DIR__ . "/echoSerialDigitadoErro.php";
        }
} else {
    $FPremiumU = "$structureLOG/KeyLocked";
    if (file_exists($FPremiumU)) {
        // box desconectada via hardreset ou bug
        echo "Assinatura='NewInstall'\n"; 
        require __DIR__ . "/echoNewInstall.php";
    }
} 


?>
