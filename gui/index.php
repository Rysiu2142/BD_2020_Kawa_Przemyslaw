<?php
session_start();

$conn = oci_connect('student', 'student', 'localhost:1521/KSIAZKIFILMY');
if (!$conn) {
    $m = oci_error();
    trigger_error(htmlentities($m['message']), E_USER_ERROR);
}
else{
    echo("MAMA MIJA!");
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TESTING</title>
</head>
<body>
   
</body>
</html>