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
    <meta name="description" content="Painel Android">
    <meta name="keywords" content="android, tvbox, controle, remoto">
    <title>index</title>
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
    <?php include $_SERVER['DOCUMENT_ROOT'] . "index.navbar.php"; ?>
    <!-- Container Start -->
    <div class="container" style="margin-top: 1px;" align="center">
        <div class="row">
            <!--     <div class="thumbnail">
            <p><img class="img-responsive" src="" /></p>
            </div> -->
            <div class="container">
                <div class="row text-center">
                    <!-- console start -->
                    <pre style="text-align: center">
                        <h4>Muitas Novidades!!!</br>Abra o qrcode em seu celular</h4>
                    </pre>
                    <div class="rowa">
                        <div class="coluna">
                            <img src="qrIP.png">
                            <img src="/img/guide.qr.gif" width="130">
                        </div>
                        <div class="coluna">
                            <a href='/controleremoto.php' class='btn btn-primary'>Controle Remoto</a></br>
                            <a href='/apps.php' class='btn btn-primary'>Aplicativos</a></br>
                            <a href='/news.php' class='btn btn-primary'>Comunicados</a></br>
                            <a href='/hdd.php' class='btn btn-primary'>Configurar HDD</a></br></br>
                            Dica: <b>Não formate o SDCard,</br> Não remova o pacote de atualização</br>mantenha seu equipamento atualizado a 100%</b></br>
                        </div>
                    </div>
                    <!-- Console end -->                    
                    Nivel de atualização atual:
                    <div class="progress">
                        <div class="progress-bar" role="progressbar" aria-valuenow="<?php echo floor($UpdatePack); ?>" aria-valuemin="0" aria-valuemax="100" style="width: <?php echo floor($UpdatePack); ?>%;">
                            <?php echo floor($UpdatePack); ?>%
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
                    $.get('painel.php?oper=' + s, function(data) {});
                }
            </script>
</body>
</html>

