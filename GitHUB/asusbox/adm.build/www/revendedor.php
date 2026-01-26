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
    <title>Contato</title>
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
            <div class="container">
                <div class="row text-left">

                    <div class="col-md-6">
                        <b>Requisitos para ser um revendedor:</b>
                        <ol>
                            <li>Atendimento cordial e humanizado com os clientes.</li>
                            <li>Conhecimentos para instalar firmware em TVBOX.</li>
                            <li>Comprar TVBOX compatíveis com sistema.</li>
                            <li>Saber utilizar IA e tradutor chines ou ingles para conversar.</li>
                            <li>Saber comprar bitcoins no MercadoPago e transferir.</li>
                            <li>Pedido minimo de 10 seriais código Ativação.</li>
                            <li>Seleção de aplicativos são responsabilidade sua.</li>
                        </ol>                        
                        <hr>
                    </div>
                    <div class="col-md-6">
                        <b>Regras para entrar em contato:</b>
                        <ol>
                            <li>Deixe seu email e whatsapp abaixo.</li>
                            <li>Fazer upload privado youtube mostrando sua loja ou banca.</li>
                            <li>Doe R$50 reais em bitcoin no endereço abaixo.</li>
                            <li>Digite informação do deposito no texto abaixo.</li>
                            <li>Não exportamos tvbox e eletronicos para Brazil.</li>
                            <li>Motivo: Remessa conforme e estravio nos correios.</li>
                            <li>Pedimos paciência estamos na china atendemos o mundo.</li>
                        </ol>
                        <hr>
                    </div>

                </div>
                <div class="row center">
                    <b>Minha carteira Bitcoin:</b><br>
                    <img src="bitcoin.png" alt="bitcoin" class="img-fluid w-100" style="max-width: 300px;">
                    <hr>               
                </div>
                    <h2>Quero ser um revendedor:</h2>
            </div>
                <form action="/revendedor.enviado.php" method="post" style="max-width: 800px; margin: auto;">
                    <div class="row text-left" style="margin: auto;">
                        <label for="whats" style="min-width: 100px;">   WhatsApp:</label>
                        <input type="text" id="whats" name="whats" style="width: 250px; display: inline-block;" ><br>

                        <label for="email" style="min-width: 100px;">   E-mail:</label>
                        <input type="text" id="email" name="email" style="width: 250px; display: inline-block;" ><br>
                    </div>
      
                        <hr>
                        <!-- Campo de entrada de texto grande -->
                        <label for="text">Digite seu texto abaixo:</label><br>
                        <textarea id="text" name="text" style="width: 100%; height: 200px;" required></textarea><br><br>
                        <!-- Botão de envio -->
                        <button type="submit" style="width: 100%;">Enviar</button>
                </form>
            
                <hr>
                <!-- Footer -->
                <footer>
                    <?php include $_SERVER['DOCUMENT_ROOT'] . "php/footer.php"; ?>
                </footer>
            </div>
        </div>
    </div>


    <!-- Container End -->
    <!-- Javascript Libraries -->
    <script src="/js/jquery.js"></script>
    <script>
        <?php include $_SERVER['DOCUMENT_ROOT'] . "php/scripts.php"; ?>
        function doGet(s) {
            $.get('index.php?oper=' + s, function(data) {});
        }
    </script>
</body>
</html>
