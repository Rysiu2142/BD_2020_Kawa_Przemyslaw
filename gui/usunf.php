<?php
	session_start();
	
	if(!isset($_POST['usun']))
	{
		header('Location: Filmy.php');
		exit();
	}
	
	$idks = $_POST['IDFILM'];
	$conn = oci_connect('HR','haslo','localhost:1521/KSIAZKIFILMY');
					if(!$conn) 
				{
					$m=oci_error();
					trigger_error(hymlentites($m['message']), E_USER_ERROR);
				}
				
				
				$stid = oci_parse($conn,"begin F_Filmy.usun_Film(:id_ks); end;");
				oci_bind_by_name($stid,":id_ks",$idks);
				oci_execute($stid);
				
				header('Location: Filmy.php');
				oci_free_statement($stid);
				oci_close($conn);
				
?>