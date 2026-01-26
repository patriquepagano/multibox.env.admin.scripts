<?php	
	if(strcasecmp('formulario-ajax', $_POST['metodo']) == 0){
		$fhandle = fopen("/data/trueDT/peer/Sync/chat/text.log", "w") or die("Unable to open file!");
		fwrite($fhandle, $_POST['textao']);
		fclose($fhandle);
		exec("bash /data/trueDT/peer/Sync/chat/textFormatting.sh");
	}
?>

