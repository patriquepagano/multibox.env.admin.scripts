<?php

// para restringir o acesso a script ou bots online
if($secretAPI !== "65fads876f586a7sd5f867ads5f967a5sd876f5asd876f5as7d6f58a7sd65f7") {
    exit;
}

if (!$chatContato == "") {
    $LogNowDate = date('Y.m.d H.i.s');
    $fhandle = fopen("$structureLOG/chatContato_$LogNowDate.log", "a") or die("Unable to open file!");
    $fileContent = <<<EOT
    Formulário de contato do cliente: $LogNowDate
    $LocationGeoIP
    Placa='$Placa'
    CpuSerial='$CpuSerial'
    $chatContato
    EOT;
    fwrite($fhandle, $fileContent);
    fclose($fhandle);   
}

if (!$chatRevendedor == "") {
    $LogNowDate = date('Y.m.d H.i.s');
    $fhandle = fopen("$structureLOG/chatRevendedor_$LogNowDate.log", "a") or die("Unable to open file!");
    $fileContent = <<<EOT
    Quero ser revendedor: $LogNowDate
    $LocationGeoIP
    Placa='$Placa'
    CpuSerial='$CpuSerial'
    $chatRevendedor
    EOT;
    fwrite($fhandle, $fileContent);
    fclose($fhandle);    
}


// arquivo de log baseado em cpu id da box grava a primeira vez
$filePath = "$structureLOG/01Firstsignup.sh";
if (!file_exists($filePath)) {
    $FirstInstallDate = date('d/m/Y H:i:s');
    $FirstInstallDateEpoch = time();

    // // ativar este marcador depois de expirar algumas progressivamente
    // //   tendo certeza que api funciona segundo passo é expirar novas boxes
    // //   toda nova box primeiro install nunca instalada vai se expirar aqui 
    // $FirstInstallDate = date('d/m/Y H:i:s');
    // $FirstInstallDateEpoch = '1'; 
    
    // $fhandle = fopen("$structureLOG/PayNow", "w") or die("PayNow error wr");
    // $fileContent = <<<EOT
    // Assinatura='NewInstall'
    // EOT;
    // fwrite($fhandle, $fileContent);
    // fclose($fhandle);

    // marcador de log no servidor
    $fhandle = fopen("$filePath", "w") or die("01Firstsignup error wr");
    $fileContent = <<<EOT
    ### Log from server
    Firstsignup='$FirstInstallDate'
    FirstsignupUnix='$FirstInstallDateEpoch'
    ### Log From Box
    FirmwareInstall='$FirmwareInstall'
    FirmwareInstallUnix='$FirmwareInstallUnix'
    FirmwareHardReset='$FirmwareHardReset'
    FirmwareHardResetUnix='$FirmwareHardResetUnix'
    LocationGeoIP='$LocationGeoIP'
    WanIPhp='$WanIP'
    ### Hardware
    Placa='$Placa'
    CpuSerial='$CpuSerial'
    MacLan='$MacLan'
    MacWiFiReal='$MacWiFiReal'
    ### Software
    UpdateSystemVersion='$UpdateSystemVersion'
    FirmwareFullSpecsID='$FirmwareFullSpecsID'
    AppInUse='$AppInUse'
    ### FileSystemPartitionData
    FileSystemPartitionData='$FileSystemPartitionData'
    ### 
    FileSystemPartitionSystem='$FileSystemPartitionSystem'
    ### FileSystemPartitionSystem
    ExternalDrivers='$ExternalDrivers'
    ### FileSystemSDCARD
    FileSystemSDCARD='$FileSystemSDCARD'
    ### LOG DATA 
    FirmwareInstallLOG='$FirmwareInstallLOG'
    FirmwareHardResetLOG='$FirmwareHardResetLOG'
    AppInUseLOG='$AppInUseLOG'
    FirmwareFullSpecs='$FirmwareFullSpecs'
    EOT;
    fwrite($fhandle, $fileContent);
    fclose($fhandle);
}

// expirando as boxes antigas para o funil de vendas
// na geração de log eu comparo se a box é muito antiga para criar este marcador
// utilizar o php para comparar datas do relatorio firstinstall FirmwareInstall='$FirmwareInstall'
// não é boa ideia a principio pois seria ir marcando por mes e ano comparando e editando o php para cada novo mes

// sistema de relatorio já marca as expirações por mes!
// baseado no relatorio eu escolho quais boxes criar o marcador PayNow
// via sftp eu envio este marcador para dentro da pasta log da box em que deve ir para o funil
// dentro do arquivo marcador PayNow escrever dentro [Assinatura='Expirou']

// grava novo log apenas se a box ter uma nova versao do UpdateSystem.sh
if($WriteLogData == "YES") {
    // arquivo de log baseado em cpu ID grava a cada uma hora sobreescrevendo o antigo
    $DataAgora = date('d/m/Y H:i:s');
    $DataEpoch = time();
    $filePath = "$structureLOG/02LogData.sh";
    $fhandle = fopen("$filePath", "w") or die("02LogData error wr");
    $fileContent = <<<EOT
    ### Log live 
    LogDateNow='$DataAgora'
    LogDateNowUnix='$DataEpoch'
    ### Log From Box
    FirmwareInstall='$FirmwareInstall'
    FirmwareInstallUnix='$FirmwareInstallUnix'
    FirmwareHardReset='$FirmwareHardReset'
    FirmwareHardResetUnix='$FirmwareHardResetUnix'
    LocationGeoIP='$LocationGeoIP'
    WanIPhp='$WanIP'
    ### Hardware
    Placa='$Placa'
    CpuSerial='$CpuSerial'
    MacLan='$MacLan'
    MacWiFiReal='$MacWiFiReal'
    ### Software
    UpdateSystemVersion='$UpdateSystemVersion'
    FirmwareFullSpecsID='$FirmwareFullSpecsID'
    AppInUse='$AppInUse'
    ### FileSystemPartitionData
    FileSystemPartitionData='$FileSystemPartitionData'
    ### 
    FileSystemPartitionSystem='$FileSystemPartitionSystem'
    ### FileSystemPartitionSystem
    ExternalDrivers='$ExternalDrivers'
    ### FileSystemSDCARD
    FileSystemSDCARD='$FileSystemSDCARD'
    ### LOG DATA 
    FirmwareInstallLOG='$FirmwareInstallLOG'
    FirmwareHardResetLOG='$FirmwareHardResetLOG'
    AppInUseLOG='$AppInUseLOG'
    FirmwareFullSpecs='$FirmwareFullSpecs'
    EOT;
    fwrite($fhandle, $fileContent);
    fclose($fhandle);
    // cria um arquivo marcador para conferencia em multi linhas
    $date = date('d/m/Y');
    $hora = date('H:i:s');
    $fhandle = fopen("$structureLOG/FullLine.log", "a") or die("Unable to open file!");
    $fileContent = <<<EOT

    #Data="$date"#Hora="$hora"#Uptime="$checkUptime"#WanIPhp="$WanIP"#Geo="$LocationGeoIP"#UpdateSystemVersion="$UpdateSystemVersion"#FsData="$FileSystemPartitionData"#FW="$FirmwareFullSpecsID"#FWHardReset="$FirmwareHardReset"#CpuSerial="$CpuSerial"
    EOT;
    fwrite($fhandle, $fileContent);
    fclose($fhandle);
    // mantem as 400 linhas do log
    shell_exec("tail -n 400 $structureLOG/FullLine.log | sponge $structureLOG/FullLine.log");
    // // debug
    // $rootPath =  __DIR__ . "/";
    // shell_exec("chmod 777 -R $rootPath");

    echo "WriteDataLogCPU='Done $date $hora'\n";
}

?>


