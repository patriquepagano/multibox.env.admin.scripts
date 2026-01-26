<?php
// Dados POST
$secretAPI = $_POST['secretAPI'];
$WanIP = $_SERVER['REMOTE_ADDR'];
// Box unique identification
$Placa = $_POST['Placa'];
$MacLan = $_POST['MacLan'];
$CpuSerial = $_POST['CpuSerial'];
// wifi é facilmente modificado mac mas é interessante para saber que esta usando wifi
$MacWiFiReal = $_POST['MacWiFiReal'];
$FirmwareInstall = $_POST['FirmwareInstall'];
$FirmwareInstallUnix = $_POST['FirmwareInstallUnix'];
$FirmwareInstallLOG = $_POST['FirmwareInstallLOG'];
$FirmwareHardReset = $_POST['FirmwareHardReset'];
$FirmwareHardResetUnix = $_POST['FirmwareHardResetUnix'];
$FirmwareHardResetLOG = $_POST['FirmwareHardResetLOG'];
$LocationGeoIP = $_POST['LocationGeoIP'];
$FirmwareFullSpecs = $_POST['FirmwareFullSpecs'];
$FirmwareFullSpecsID = $_POST['FirmwareFullSpecsID'];
$AppInUse = $_POST['AppInUse'];
$AppInUseLOG = $_POST['AppInUseLOG'];
$ExternalDrivers = $_POST['ExternalDrivers'];
$FileSystemPartitionData = $_POST['FileSystemPartitionData'];
$FileSystemPartitionSystem = $_POST['FileSystemPartitionSystem'];
$FileSystemSDCARD = $_POST['FileSystemSDCARD'];
$checkUptime = $_POST['checkUptime'];
$UsingMountedDevices = $_POST['UsingMountedDevices'];
$UpdateSystemVersion = $_POST['UpdateSystemVersion'];
$Serial = $_POST['Serial'];
$Product = $_POST['Product'];
$Type = $_POST['Type'];
$PinCodePost = $_POST['PinCodePost'];
$WriteLogData = $_POST['WriteLogData'];
$chatContato = $_POST['chatContato'];
$chatRevendedor = $_POST['chatRevendedor'];
$PinCodeNEW = rand(1000, 9999);
?>
