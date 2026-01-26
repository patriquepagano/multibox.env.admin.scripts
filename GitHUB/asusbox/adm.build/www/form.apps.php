<?php

$Fabricante = $_GET['Fabricante'];
$Dispositivo = $_GET['Dispositivo'];
$Modelo = $_GET['Modelo'];
$rom_build = $_GET['rom_build'];
$senha = $_GET['senha'];

$folder_path =  __DIR__ . "/_clts/{$Fabricante}/{$Dispositivo}/{$Modelo}/{$rom_build}/{$senha}";

$required_get_fields = array('Fabricante', 'Dispositivo', 'Modelo', 'rom_build', 'senha');
$required_post_fields = array(
    'android_name',
    'selected_profile'
);

// data de instalação
$myfile = fopen("$folder_path/install_date", "r") or die("Unable to open file!");
$install_date = fgets($myfile);
fclose($myfile);
// cpu
$myfile = fopen("$folder_path/cpu", "r") or die("Unable to open file!");
$cpu = fgets($myfile);
fclose($myfile);
// nome cliente
$myfile = fopen("$folder_path/customer_name.txt", "r") or die("Unable to open file!");
$customer_name = fgets($myfile);
fclose($myfile);
// email
$myfile = fopen("$folder_path/user_email.txt", "r") or die("Unable to open file!");
$user_email = fgets($myfile);
fclose($myfile);

function validate_get_params() {
    global $required_get_fields;
    foreach ($required_get_fields as $field) {
        if (empty($_GET[$field])) {
            return false;
        }
    }
    return true;
}

function validate_post_params() {
    global $required_post_fields;
    foreach ($required_post_fields as $field) {
        if (empty($_POST[$field])) {
            return false;
        }
    }
    return true;
}

function android_folder_exists() {
    global $folder_path;
    return file_exists($folder_path);
}

function write_file($path, $content) {
    $fhandle = fopen($path, "w") or die("Unable to open file!");
    fwrite($fhandle, $content);
    fclose($fhandle);
}


switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        if (!(validate_get_params() && android_folder_exists())) {
            echo "error!";
            exit;
        }
        require(__DIR__ . '/apps_form.html');
        break;
    case 'POST':
        if (!(validate_get_params() && validate_post_params() && android_folder_exists())) {        
            require(__DIR__ . '/apps_form.html');
            exit;
        }
        
        foreach ($required_post_fields as $field) {
            $file_path = "{$folder_path}/{$field}.txt";
            write_file($file_path, $_POST[$field]);
        }
        // if arquivo de log user não existir ele posta
        if (!file_exists("{$folder_path}/wpPost.log")) {
shell_exec("wp post  create --post_author=4 --post_type=post --post_status=pending --post_title=\"Novo android Registrado {$user_email}\" --path=\"//build/www/personaltecnico\" --post_content=\"
Android Sem acesso Root
Sistema de painel com utilização termux (sem root)

Tvbox registrado em: {$install_date}

nome do cliente : {$customer_name} 
Email : {$user_email}

CPU : {$cpu}
Fabricante : {$Fabricante}
Dispositivo : {$Dispositivo}
Modelo : {$Modelo}
RomBuild : {$rom_build}
AndroidID : {$senha}


Path do user tvbox
<pre>{$folder_path}</pre>

Cliente aguardando Android ser ativado.

verificar pagamento e gerar o script para liberar o user.\" > {$folder_path}/wpPost.log 2>&1 ");    
        }
        // senha license
        $myfile = fopen("{$folder_path}/acesso.vip", "w") or die("Unable to open file!");
        $txt = "{$senha}\n";
        fwrite($myfile, $txt);
        $txt = "{$customer_name}\n";
        fwrite($myfile, $txt);
        $txt = "{$user_email}\n";
        fwrite($myfile, $txt);
        $txt = "{$install_date}\n";
        fwrite($myfile, $txt);
        fclose($myfile);
        // redirecionar
        header('Location: ' . "/Android/Roms/waiting_room.php?Fabricante={$Fabricante}&Dispositivo={$Dispositivo}&Modelo={$Modelo}&rom_build={$rom_build}&senha={$senha}", true, 301);
        break;
    default:
        echo "Error! Invalid request type.";
}
?>
