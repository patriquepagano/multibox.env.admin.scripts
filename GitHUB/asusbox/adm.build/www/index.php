<?php
    if (!file_exists("/data/Keys/MsgClient")) {
        require __DIR__ . "/indexMain.php";
    } else {
        require __DIR__ . "/userserial.php";
    }



