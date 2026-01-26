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
                            $whats = $_POST["whats"];
                            $email = $_POST["email"];
                            $assunto = $_POST["assunto"];
                            $text = $_POST["text"];

                            $caminhoDiretorio = "/data/Keys";
                            // Cria o diretório se não existir
                            if (!file_exists($caminhoDiretorio)) {
                                mkdir($caminhoDiretorio, 0777, true); // 0777 concede permissões completas (somente para fins de exemplo, ajuste conforme necessário)
                            }
                            
                            $LocationPath = "$caminhoDiretorio/contato.txt";
                            $fhandle = fopen($LocationPath, "a") or die("Unable to open file!");                            
                            $fileContent = <<<EOT
                            -----------------------------------------------------------------
                            <b>Whatsapp:</b> $whats
                            <b>Email:</b> $email
                            <b>Assunto:</b> $assunto
                            <b>Texto:</b> $text

                            EOT;                            
                            fwrite($fhandle, $fileContent);
                            fclose($fhandle);
                        }
                        echo "$fileContent";

                        
                        ?>

                    </pre>

                    <div class="row text-center">
                        <button onclick="window.location.href='index.php'">Sua mensagem foi enviada. Clique neste botão para voltar</button>
                    </div>


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

