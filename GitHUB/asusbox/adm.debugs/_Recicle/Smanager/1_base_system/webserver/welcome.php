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


if (isset($_GET["oper"])) {
  $oper = $_GET["oper"];
  if ($oper == "startgame") {
    exec ("am start --user 0 -a android.intent.action.MAIN -c android.intent.category.HOME");
  }
  exit;
}


$my_current_ip=exec("busybox ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'");

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
    <meta name="description" content="Portal Gamer é um Frontend para organizar sua biblioteca de Jogos utilizando um celular como controle remoto.">
    <meta name="keywords" content="Frontend,Portal,Games,jogos,httpc,mediacenter,Emulators,emuladores,launcher,Playstation2,pcsx2">
    <title>Super APP</title>
 <!-- Bootstrap Core CSS -->
    <link href="/.code/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom CSS -->
    <link href="/.code/css/heroic-features.css" rel="stylesheet"> 
	<link href="/.code/css/catalogo.css" rel="stylesheet"> 
	<link href="/.code/css/utils.css" rel="stylesheet">
	<link href="/.code/css/blueimp-gallery.min.css" rel="stylesheet">
	<link href="/.code/css/blueimp-gallery-indicator.css" rel="stylesheet">	
	<link href="/.code/css/video-js.min.css" rel="stylesheet">
	<script src="/.code/js/videojs-ie8.min.js"></script>
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
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
<!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                 <button type="button" id="startgame" class="btn btn-danger">Fechar</button>
				 
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
			<h1 style="text-align:center">Sistema iniciado!</h1>
			
		Para ter acesso a este painel de controle<br>
		Abra o endereço abaixo em seu celular ou tablet		
		<h3><?php echo $my_current_ip; ?>:8080	</h3>	
			
			
         <!-- Console end -->
    </div>
	   <hr>
	   
	<h1 style="text-align:center">Espaço em Uso em :</h1> <?php echo $osPath; ?>
    <div class="progress">
      <div class="progress-bar" role="progressbar" aria-valuenow="<?php echo floor($dp); ?>" aria-valuemin="0" aria-valuemax="100" style="width: <?php echo floor($dp); ?>%;">
        <?php echo floor($dp); ?>%
      </div>
    </div>
	          <!-- Footer -->
        <footer>
            <div class="row" align="center">
                <div class="col-lg-12">
                    <a href="https://www.facebook.com/personaltecnico.page/" target="_blank" class="btn btn-primary">Curta a nossa página - Personal Técnico</a>
                </div>
            </div>
        </footer>	
  </div>
  <!-- Container End -->
  <!-- Javascript Libraries -->
<script src="/.code/js/jquery.js"></script>
<script>
$.get("updateDesativado.php");
</script>

<script>
  $('#startgame').on('click', function() {
    doGet("startgame");
  });
 
  function doGet(s) {
    $.get('index.php?oper=' + s, function(data) {
    });
  }
</script>  

</body>
</html>
