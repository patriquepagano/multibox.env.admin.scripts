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
                        <b>Responsabilidade dos revendedores:</b>
                        <ol>
                            <li>Atendimento cordial e humanizado</li>
                            <li>Suporte de utilização do TVBOX</li>
                            <li>Suporte de uso dos aplicativos</li>
                            <li>Problema eletrônico no TVBOX</li>
                            <li>Os Aplicativos são selecionados e instalados pelo revendedor</li>                           
                        </ol>                        
                        <hr>
                    </div>
                    <div class="col-md-6">
                        <b>Responsabilidade dos aplicativos:</b>
                        <ol>
                            <li>Youtube travou? = Aguarde resolução da empresa</li>
                            <li>Netflix travou? = Aguarde resolução da empresa</li>
                            <li>Amazon travou? = Aguarde resolução da empresa</li>
                            <li>O mesmo vale para todos aplicativos</li>
                            <li>Aguarde por atualização automática</li>
                        </ol>
                        <hr>
                    </div>
                    <div class="col-md-6">
                        <b>Responsabilidade do cliente:</b>
                        <ol>
                            <li>Trate o revendedor com carinho e empatia</li>
                            <li>Tenha paciência seu revendedor é humano e vai te ajudar</li>
                            <li>Calma, 95% dos problemas são corrigidos com atualização automática</li>
                            <li>Apps Travando pode ser internet ou manutenção<br>da empresa fornecedora do aplicativo. tenha paciência.</li>
                            <li>Evite enviar mensagems desnecessárias para seu revendedor<br>que atende muitas pessoas por dia e precisa <b>dormir e viver.</b></li>
                        </ol>
                        <button onclick="window.location.href='https://wa.me/447888753796/?text=Olá!%20Preciso%20de%20suporte%20técnico%20humanizado.'">Iniciar suporte pelo whatsapp com o revendedor</button>
                        <hr>
                    </div>                   
                    <div class="col-md-6">
                        <b>Responsabilidade do desenvolvedor do firmware:</b>
                        <ol>
                            <li>Sistema de manutenção remota das boxes</li>
                            <li>Remoção de vírus e obsolescência programada</li>
                            <li>Atualização vitalícia do sistema Android</li>
                            <li>Ativação de updates e seriais de suporte</li>
                            <li>Controle de qualidade e gestão de revendedores</li>
                            <li>Este painel de configuração local <b>http://<?php echo $LocationIPlocal; ?></b></li>
                            <li>Sempre em busca de novas tecnologias e melhorias do sistema</li>
                        </ol>
                        <hr>
                    </div>
                </div>                
                    <h2>Envie sua mensagem para o desenvolvedor:</h2>
            </div>
                <form action="/contato.enviado.php" method="post" style="max-width: 800px; margin: auto;">
                    <div class="row text-left" style="margin: auto;">
                        <label for="whats" style="min-width: 100px;">   WhatsApp:</label>
                        <input type="text" id="whats" name="whats" style="width: 250px; display: inline-block;" ><br>

                        <label for="email" style="min-width: 100px;">   E-mail:</label>
                        <input type="text" id="email" name="email" style="width: 250px; display: inline-block;" ><br>
                    </div>

                    <label for="assunto" style="min-width: 100px;">Assunto:</label><br>
                    <select id="assunto" name="assunto">
                        <option value="opcao0">Clique escolha um tema</option>
                        <option value="Ativação de Serial">Ativação de Serial</option>
                        <option value="Sobre o painel de configuração">Sobre o painel de configuração <b>http://<?php echo $LocationIPlocal; ?></b></option>
                        <option value="Sugestões para novas tecnologias">Sugestões para novas tecnologias</option>
                        <option value="Reclamar - Atendimento Revendedor">Reclamar - Atendimento Revendedor</option>
                        <option value="Reclamar - Problema sistema atualização">Reclamar - Problema sistema atualização</option>
                    </select>        
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
