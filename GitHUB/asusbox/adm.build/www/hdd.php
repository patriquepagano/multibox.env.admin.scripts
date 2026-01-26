<?php
include $_SERVER['DOCUMENT_ROOT'] . "php/00.code.php";

$UpdatePack = exec("/system/bin/transmission-remote --list | grep '.install' | busybox awk '{print $2}' | busybox sed 's;%;;g'");

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
    <title>hdd</title>
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
<h4>Em breve sera possível utilizar um pendrive ou HDD externo para os seguintes benefícios;</h4>
<h5>1 - Expandir a memória total do seu dispositivo
2 - Mais velocidade de leitura (recomendo hdd usb c/ alimentação externa)
3 - Loja de aplicativos (mantidos pelo desenvolvedor deste firmware)
4 - Loja de aplicativos (do seu revendedor) *
5 - instalação de jogos e apps o limite sera determinado pelo seu HDD

obs:
Adquira um pendrive ou hdd externo ( com alimentação externa ) quanto maior melhor.
Recomendo o uso de um <b>iClamper DPS</b> para a proteção de todos seus equipamentos. ( dica de ouro! vc merece. )
Ao formatar o pendrive ou hdd externo sera de exclusividade TOTAL a este dispositivo.
A formatação ocorrera com a sua permissão e vai <b>apagar tudo</b> no drive destino.

nota:
* Os apps compartilhados pelo revendedor são de <b>responsabilidade e suporte</b> do revendedor credenciado.
</h5>
</pre>
                    <!-- Console end -->
                    Dica: <b>Não formate o SDCard, Não remova o pacote de atualização</b> para manter seu equipamento atualizado a 100%</br>
                    Nivel de atualização atual:
                    <div class="progress">
                        <div class="progress-bar" role="progressbar" aria-valuenow="<?php echo floor($UpdatePack); ?>" aria-valuemin="0" aria-valuemax="100" style="width: <?php echo floor($UpdatePack); ?>%;">
                            <?php echo floor($UpdatePack); ?>%
                        </div>
                    </div>
                </div>
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
                    $.get('hdd.php?oper=' + s, function(data) {});
                }
            </script>
</body>
</html>