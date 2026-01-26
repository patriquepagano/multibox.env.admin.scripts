<?php
$filename = $_SERVER['DOCUMENT_ROOT'] . "/boot.log";
$handle = fopen ($filename, "r");
$debug = fread ($handle, filesize ($filename));
fclose ($handle);
$myfile = fopen($_SERVER['DOCUMENT_ROOT'] . "/version", "r") or die("Unable to open file!");
$ver = fgets($myfile);
fclose($myfile);

if (isset($_GET["oper"])) {
$oper = $_GET["oper"];
if ($oper == "androidhome") {
exec ("am start --user 0 -a android.intent.action.MAIN -c android.intent.category.HOME");
}
exit;
}


header( "refresh:5;" );
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
<meta name="description" content="log de instalação">
<meta name="keywords" content="log,install">
<title>log</title>
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
<body onload="goDown()">
<!-- Navigation -->
<?php include $_SERVER['DOCUMENT_ROOT']."/index.navbar.php";?>
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
<?php echo $debug ; ?>
</pre>
<?php echo $ver ; ?>
<!-- Console end -->
</div>
<hr>
<!-- Footer -->
<footer>
<?php include $_SERVER['DOCUMENT_ROOT']."/php/footer.php";?>
</footer>
</div>
<!-- Container End -->
<!-- Javascript Libraries -->
<script src="js/jquery.js"></script>
<script>
function goDown(id) {
var div = document.getElementById(id);
$('body').animate({
scrollTop: document.body.scrollHeight
}, 800);
}
</script>
<script>
$('#androidhome').on('click', function() {
doGet("androidhome");
});
function doGet(s) {
$.get('index.php?oper=' + s, function(data) {
});
}
</script>
</body>
</html>
