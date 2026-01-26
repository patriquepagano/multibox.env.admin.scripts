<?php
include $_SERVER['DOCUMENT_ROOT'] . "php/00.code.php";
$filename = "/data/Keys/MsgClient";
if (file_exists($filename)) {
    $handle = fopen ($filename, "r");
    $MsgClient = fread ($handle, filesize ($filename));
    fclose ($handle);
} else {
    $MsgClient = "";
}
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
    <title>serial</title>
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
                <?php echo "$MsgClient"; ?>
                <br>
                <form action="/userlogin.php" method="post" id="myForm">
                    <!-- Campo de entrada com função JavaScript -->
                    <input type="text" id="SerialID" name="SerialID" oninput="formatarNumeros(this)" pattern="[0-9\-]*" maxlength="24" style="width: 199px;" required autofocus>
                    <!-- Botão de envio -->
                    <button type="submit">Enviar código serial</button>
                    <!-- Botão de reset para limpar o campo -->
                    </br></br>
                    <button onclick="window.location.href='contato.php'">Fale Conosco<br>SAC</button>
                    <button onclick="window.location.href='revendedor.php'">Quero ser um revendedor<br>Trabalhe Conosco</button>
                </form>
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
                function formatarNumeros(input) {
                    // Remove caracteres não numéricos
                    let numeros = input.value.replace(/\D/g, '');
                    // Adiciona hífens após cada dois dígitos nos dois primeiros blocos
                    numeros = numeros.replace(/(\d{2})(\d{2})?(\d{4})?(\d{4})?(\d{4})?(\d{4})?(\d{4})?/, function(match, p1, p2, p3, p4, p5, p6, p7) {
                        // Adiciona hífens apenas nos grupos não nulos
                        return [p1, p2, p3, p4, p5, p6, p7].filter(Boolean).join('-');
                    });
                    // Atualiza o valor do campo de entrada
                    input.value = numeros;
                }
            </script>
</body>
</html>

