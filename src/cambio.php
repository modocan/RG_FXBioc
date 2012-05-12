<?php
/**
 * Created by IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 27/04/12
 * Time: 19:28
 * To change this template use File | Settings | File Templates.



 */


mysql_connect( "localhost", "eromhsurapps", "v7UH9bAYxazb" );
mysql_select_db( "tourflex" );
mysql_query("SET NAMES 'utf8'");


$sql = "UPDATE preguntas SET pregunta = ".pregunta." WHERE id_pregunta = 43";

if(mysql_query($sql))
{
    print_r('OK');
} else {
    print_r('KO');
}


?>