<?php
    $filename = "/sdcard";
    if (file_exists($filename)) {
    $osPath = "/sdcard";
    } else {
    $osPath = "/";
    }
    /* get disk space free (in bytes) */
    $df = disk_free_space("$osPath");
    /* and get disk space total (in bytes)  */
    $dt = disk_total_space("$osPath");
    /* now we calculate the disk space used (in bytes) */
    $du = $dt - $df;
    /* percentage of disk used - this will be used to also set the width % of the progress bar */
    $dp = sprintf('%.2f', ($du / $dt) * 100);
    /* and we formate the size from bytes to MB, GB, etc. */
    $df = formatSize($df);
    $du = formatSize($du);
    $dt = formatSize($dt);
    function formatSize($bytes)
    {
    $types = array('B', 'KB', 'MB', 'GB', 'TB');
    for ($i = 0; $bytes >= 1024 && $i < (count($types) - 1); $bytes /= 1024, $i++);
    return (round($bytes, 2) . " " . $types[$i]);
    }


    $my_current_ip=exec("/system/bin/busybox ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'");
?>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="google" content="notranslate">
<meta http-equiv="Content-Language" content="pt-br">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="expires" content="-1">
<meta http-equiv="cache-control" content="no-cache, must-revalidate, post-check=0, pre-check=0">
<meta http-equiv="expires" content="Tue, 10 May 1977 00:00:00 GMT">
<meta name="description" content="Painel Android">
<meta name="keywords" content="android, tvbox, controle, remoto">
<title>Painel de controle</title>
<?php include $_SERVER['DOCUMENT_ROOT']."/php/00.head.css.php";?>
<?php include $_SERVER['DOCUMENT_ROOT']."/php/01.style.php";?>
<style>
.hidden-fb {
opacity: 0;
display: none;
}
.links > a {
display: none;
}
.links > a:first-child {
display: block;
}
.btn {
margin-top: 5px;
}
</style>
</head>
<body>
<!-- Navigation -->


<div id="top"><a href="top"></a></div>	
    <nav id="navigation-bar" class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
            <a href="/index.php" id="navbar-brand" ><img src="/img/asusbox.top.png"></a>&nbsp;
            </div>
        </div>
    </nav>





<!-- Container Start -->
<div class="container" style="margin-top: 1px;"   align="center">
<div class="row">
<!--     <div class="thumbnail">
<p><img class="img-responsive" src="" /></p>
</div> -->
<div class="container">
<div class="row text-center">
<!-- console start -->

<!-- <img src="/img/anonovo.png" width="400"> -->



<h4>
Acesse este menu no site abaixo:</br>
<?php echo "http://$my_current_ip"; ?>
<br>
</h4>

Conectando usuário: <?php echo $_GET["name"]; ?><br>

<?php
$name = $_GET['name'];
$fhandle = fopen("/data/asusbox/user.serial", "w") or die("Unable to open file!");
fwrite($fhandle, $name);
fclose($fhandle);

$senha = $_GET['senha'];
$fhandle = fopen("/data/asusbox/user.senha", "w") or die("Unable to open file!");
fwrite($fhandle, $senha);
fclose($fhandle);
?>





<!-- Console end -->
</div>
<hr>
<h3 style="text-align:center">Dicas:</h3>
<h4>
Por favor não utilize o controle remoto
<br>
Aguarde ativação
<br>
</h4>

</div>
<!-- Footer -->
<footer>
<?php include $_SERVER['DOCUMENT_ROOT']."/php/footer.php";?>
</footer>
</div>
<!-- Container End -->
<!-- Javascript Libraries -->
<script src="/js/jquery.js"></script>


</body>
</html>
