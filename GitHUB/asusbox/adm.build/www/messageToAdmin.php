<?php
include $_SERVER['DOCUMENT_ROOT'] . "php/00.code.php";

$filename = "/data/trueDT/peer/Sync/chat/text.private";
if (file_exists($filename)) {
    $handle = fopen ($filename, "r");
    $textLog = fread ($handle, filesize ($filename));
    fclose ($handle);
} else {
    $textLog = "";
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
    <title>user</title>
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

                    <!-- <button onclick="scrollToBottom()">Rolar pagina para baixo</button> -->

                    <div style="margin-left: 10px;margin-right: 10px;text-align: left">
                        <?php echo $textLog; ?>
                    </div>


                    <div style="margin-left: 10px;margin-right: 10px;text-align: left">
                        <form id="simples-formulario-ajax">
                            <fieldset>
                                <label for="textao">Mensagem direta para o desenvolvedor do sistema.</label><br />
                                <textarea id="textao" name="textao" rows="7" cols="20" placeholder="Digite aqui dentro sua dúvida, sugestão ou crítica. Por enquanto só conseguirei ler as mensagems. Estamos trabalhando no módulo de resposta :)"></textarea><br />
                                    <div class="container" align="center">
                                        <input type="submit" class='btn btn-primary' id="enviar" value="Enviar mensagem"><br />
                                    </div>
                                <input type="hidden" id="metodo" value="formulario-ajax" />
                            </fieldset>
                        </form>



<!-- <button type="submit" form="simples-formulario-ajax" value="Submit">asdasfasdf</button> -->
                    </div>



                    <!-- <button onclick="scrollToTop()">Rolar pagina para o topo</button> -->



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
                <?php include $_SERVER['DOCUMENT_ROOT'] . "php/scripts.php"; ?>

                function doGet(s) {
                    $.get('user.php?oper=' + s, function(data) {});
                }
            </script>
            <script src="/js/messageToAdmin.js"></script>

            <script>
                function scrollToBottom() {
                    window.scrollTo(0, document.body.scrollHeight);
                }
                history.scrollRestoration = "manual";
                window.onload = scrollToBottom;
            </script>


            <script>
                function scrollToTop() {
                    window.scrollTo(0, 0);
                }
            </script>
</body>

</html>