$('#simples-formulario-ajax').submit(function(e){
    e.preventDefault();
    
    if($('#enviar').val() == 'Enviando...'){
        return(false);
    }
    
    $('#enviar').val('Enviando...');
    
    $.ajax({
        url: 'messageToAdmin.exec.php',
        type: 'post',
        dataType: 'html',
        data: {
            'metodo': $('#metodo').val(),
            'textao': $('#textao').val()
        }
    }).done(function(data){
        
        $('#enviar').val('Enviar dados');
        $('#metodo').val('formulario-ajax');
        $('#textao').val('');
        
        window.location.replace("/messageToAdmin.php");

    });
    
});