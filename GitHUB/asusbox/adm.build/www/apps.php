<?php
if (isset($_GET["oper"])) {
    $oper = $_GET["oper"];
    if ($oper == "tvplutoandroid") {
        exec("am start --user 0 -n tv.pluto.android/.leanback.controller.LeanbackSplashActivity -a android.intent.action.MAIN");
    }
    if ($oper == "acrbrowserbarebones") {
        exec("monkey -p acr.browser.barebones -c android.intent.category.LAUNCHER 1");
    }
    if ($oper == "amazonTV") {
        exec("monkey -p com.amazon.avod.thirdpartyclient -c android.intent.category.LAUNCHER 1");
    }
    if ($oper == "vix") {
        exec("monkey -p com.batanga.vix -c android.intent.category.LAUNCHER 1");
    }
    if ($oper == "disneyplus") {
        exec("monkey -p com.disney.disneyplus -c android.intent.category.LAUNCHER 1");
    }
    if ($oper == "netflix") {
        exec("monkey -p com.netflix.mediaclient -c android.intent.category.LAUNCHER 1");
    }
    if ($oper == "youtubemusic") {
        exec("monkey -p com.google.android.apps.youtube.music -c android.intent.category.LAUNCHER 1");
    }
    if ($oper == "youtubetv") {
        exec("monkey -p com.google.android.youtube.tv -c android.intent.category.LAUNCHER 1");
    }
    if ($oper == "aa_image_viewer") {
        exec("monkey -p com.not.aa_image_viewer -c android.intent.category.LAUNCHER 1");
    }
    if ($oper == "libreflix") {
        exec("monkey -p org.libreflix.android -c android.intent.category.LAUNCHER 1");
    }
    if ($oper == "appsClose") {
        exec("/data/asusbox/.sc/boot/CloseApps.sh");
    }
    if ($oper == "CloseAppOnScreen") {
        exec("/data/asusbox/.sc/boot/CloseAppOnScreen.sh");
    }       
    exit;
}
$LocationIPlocal = exec("/system/bin/busybox ifconfig | /system/bin/busybox grep -v 'P-t-P' | /system/bin/busybox grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | /system/bin/busybox grep -Eo '([0-9]*\.){3}[0-9]*' | /system/bin/busybox grep -v '127.0.0.1'");
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
    <title>apps</title>
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
<pre style="text-align: center">
<b>Aplicativos recomendados pelo
desenvolvedor deste firmware.</b>
</pre>
                    <hr>
                    <button type="button" id="netflix" class="btn btn-default glyphicon glyphicon-th"> <b>Netflix</b></button>&nbsp;
                    <button type="button" id="amazonTV" class="btn btn-default glyphicon glyphicon-th"> <b>Amazon TV</b></button>&nbsp;
                    <button type="button" id="disneyplus" class="btn btn-default glyphicon glyphicon-th"> <b>Disney +</b></button>&nbsp;
                    <hr>
                    <button type="button" id="youtubetv" class="btn btn-default glyphicon glyphicon-th"> <b>Youtube TV</b></button>&nbsp;
                    <button type="button" id="youtubemusic" class="btn btn-default glyphicon glyphicon-th"> <b>Youtube Music</b></button>&nbsp;
                    <hr>
                    <button type="button" id="tvplutoandroid" class="btn btn-default glyphicon glyphicon-th"> <b>Pluto TV</b></button>&nbsp;
                    <button type="button" id="vix" class="btn btn-default glyphicon glyphicon-th"> <b>VIX</b></button>&nbsp;
                    <button type="button" id="libreflix" class="btn btn-default glyphicon glyphicon-th"> <b>LibreFlix</b></button>&nbsp;
                    <hr>
                    <button type="button" id="acrbrowserbarebones" class="btn btn-default glyphicon glyphicon-th"> <b>Navegador Internet</b></button>&nbsp;
                    <button type="button" id="aa_image_viewer" class="btn btn-default glyphicon glyphicon-th"> <b>Visualizador de Fotos</b></button>&nbsp;
                    <hr>

                    <button type="button" id="CloseAppOnScreen" class="btn btn-primary"> <b>Fechar App em execução na tela</b></button>&nbsp;
                    <button type="button" id="appsClose" class="btn btn-primary"> <b>Fechar todos aplicativos em execução</b></button>&nbsp;

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
                $('#tvplutoandroid').on('click', function() {
                    doGet("tvplutoandroid");
                });
                $('#acrbrowserbarebones').on('click', function() {
                    doGet("acrbrowserbarebones");
                });
                $('#amazonTV').on('click', function() {
                    doGet("amazonTV");
                });
                $('#vix').on('click', function() {
                    doGet("vix");
                });
                $('#disneyplus').on('click', function() {
                    doGet("disneyplus");
                });
                $('#netflix').on('click', function() {
                    doGet("netflix");
                });
                $('#youtubemusic').on('click', function() {
                    doGet("youtubemusic");
                });
                $('#youtubetv').on('click', function() {
                    doGet("youtubetv");
                });
                $('#aa_image_viewer').on('click', function() {
                    doGet("aa_image_viewer");
                });
                $('#libreflix').on('click', function() {
                    doGet("libreflix");
                });
                $('#appsClose').on('click', function() {
                    doGet("appsClose");
                });
                $('#CloseAppOnScreen').on('click', function() {
                    doGet("CloseAppOnScreen");
                });                                      
                        function doGet(s) {
                    $.get('apps.php?oper=' + s, function(data) {});
                }
            </script>
</body>
</html>

