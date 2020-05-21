<?php
session_start();

$conn = oci_connect('HR','haslo','localhost:1521/KSIAZKIFILMY');
if(!$conn) 
{
	$m=oci_error();
	trigger_error(hymlentites($m['message']), E_USER_ERROR);
}


?>
<!DOCTYPE html>
<html lang="pl">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<title>BuldoRex</title>
		<meta name="description" content="Wypożyczalnia pojazdów budowlanych">
		<meta name="keywords" content="wypożyczalnia pojazdów budowlanych, budowa, koparka">
		<meta name="author" content="Przemek">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="css/bootstrap.min.css">
		<link rel="stylesheet" href="css/style.css">
	</head>
	
	<body>
	
	<section id="kontakt" class="bg-secondary">
		<div class="container">
		<h3 class="text-cenetr">Kontakt</h3>
			
		</div>
	</section>

	</body>
</html>