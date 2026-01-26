<?php
include $_SERVER['DOCUMENT_ROOT'] . "php/00.code.php";
?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="google" content="notranslate">
    <meta http-equiv="Content-Language" content="pt-br">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="expires" content="-1">
    <meta http-equiv="cache-control" content="no-cache, must-revalidate, post-check=0, pre-check=0">
    <meta http-equiv="expires" content="Wed, 1 Jan 1111 00:00:00 GMT">
    <meta name="description" content="log de instalação">
    <meta name="keywords" content="log,install">
    <title>login</title>
    <?php include $_SERVER['DOCUMENT_ROOT'] . "php/00.head.css.php"; ?>
    <?php include $_SERVER['DOCUMENT_ROOT'] . "php/01.style.php"; ?>
    <style>
        .hidden-fb {
            opacity: 0;
            display: none;
        }

        .links>a {
            display: none;
        }

        .links>a:first-child {
            display: block;
        }

        .btn {
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <?php include $_SERVER['DOCUMENT_ROOT'] . "/index.navbar.php"; ?>
    <!-- Container Start -->
    <div class="container" style="margin-top: 1px;" align="center">
        <div class="row">
            <!--     <div class="thumbnail">
            <p><img class="img-responsive" src="" /></p>
            </div> -->
            <div class="container">
                <div class="row text-center">
                    <!-- console start -->
                    <pre style="text-align: left">
                        <?php
                        // Verifica se o formulário foi submetido
                        if ($_SERVER["REQUEST_METHOD"] == "POST") {
                            // Verifica se o campo SerialID foi enviado
                            if (isset($_POST["SerialID"])) {
                                // Obtém o valor do campo SerialID
                                $SerialID = $_POST["SerialID"];
                                // Separar partes do SerialID
                                $partes = explode("-", $SerialID);
                                // Atribuir valores a variáveis
                                $Product = $partes[0];
                                $Type = $partes[1];
                                // Pegar a parte específica após a segunda ocorrência de hífen
                                $UniqSerial = implode('-', array_slice($partes, 2, 4));
                                // Atribuir os 4 últimos dígitos como PinCode
                                $PinCode = end($partes);
                                // Condições baseadas no valor de $Product
                                // aqui é onde travo as opções de produtos a venda
                                if ($Product == "01") {
                                    $ProductTitle = "Multibox";
                                    $ProductDir = "/firmware";
                                } elseif ($Product == "02") {
                                    $ProductTitle = "RetroGamer";
                                    $ProductDir = "/firmware";
                                } elseif ($Product == "07") {
                                    $ProductTitle = "A7";
                                    $ProductDir = "/firmware";                                    
                                } elseif ($Product == "08") {
                                    $ProductTitle = "BitGamer";
                                    $ProductDir = "/firmware";
                                } else {
                                    $Product = "erro";
                                    //echo "<br> Product não existe";
                                }
                                // Condições baseadas no valor de $Type
                                if ($Type == "00") {
                                    $ProductType = "ChaveAcesso";
                                    $ProductDir = "/firmware";
                                } elseif ($Type == "69") {
                                    $ProductType = "SuporteRemoto";
                                    $ProductDir = "/firmware";
                                } elseif ($Type == "71") {
                                    $ProductType = "Addon BitGamer";
                                    $ProductDir = "/firmwareAddon/BitGamer";
                                } elseif ($Type == "72") {
                                    $ProductType = "Addon Kids";
                                    $ProductDir = "/firmwareAddon/Kids";
                                } else {
                                    $Type = "erro";
                                    //echo "<br> Type não existe";
                                }
                                // Verificação combinada para ambas as condições
                                if ($Product != "erro" && $Type != "erro") {
                                    // Caminho para o diretório onde você deseja armazenar os arquivos
                                    $caminhoDiretorio = "/data/Keys$ProductDir";
                                    // Cria o diretório se não existir
                                    if (!file_exists($caminhoDiretorio)) {
                                        mkdir($caminhoDiretorio, 0777, true); // 0777 concede permissões completas (somente para fins de exemplo, ajuste conforme necessário)
                                    }
                                    $caminhoArquivo = "$caminhoDiretorio/PinCodePost";
                                    file_put_contents("$caminhoArquivo", $PinCode);
                                    $caminhoArquivo = "$caminhoDiretorio/Product";
                                    file_put_contents("$caminhoArquivo", $ProductTitle);
                                    $caminhoArquivo = "$caminhoDiretorio/Type";
                                    file_put_contents("$caminhoArquivo", $ProductType);
                                    $caminhoArquivo = "$caminhoDiretorio/Serial";
                                    file_put_contents("$caminhoArquivo", $UniqSerial);
                                    $caminhoArquivo = "/data/Keys/Posted";
                                    file_put_contents("$caminhoArquivo", 'ok');
                                    echo "<h4>Produto: $ProductTitle<br>Ativação: $ProductType<br>Serial: $SerialID</h4>";
                                    //echo "<h4>Serial: $UniqSerial<br>Senha Mestre: $PinCode</h4>";
                                    echo "<h3>Por favor aguarde a verificação e ativação</h3>";
                                } else {
                                    // Dentro do bloco else
                                    echo '<br>';
                                    echo 'Serial inválido. <button onclick="window.location.href=\'/userserial.php\'">Tente Novamente</button>';
                                }
                            }
                        }
                        ?>
                    </pre>
                    <!-- Console end -->
                </div>
                <hr>
                <!-- Footer -->
                <footer>
                    <?php include $_SERVER['DOCUMENT_ROOT'] . "php/footer.php"; ?>
                </footer>
            </div>
            <!-- Container End -->
            <!-- Javascript Libraries -->
            <script src="/js/jquery.js"></script>
            <script>

            </script>
</body>
</html>

