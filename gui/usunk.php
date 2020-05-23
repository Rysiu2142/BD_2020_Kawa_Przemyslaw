<?php
	session_start();
	
	if(!isset($_POST['usun']))
	{
		header('Location: index.php');
		exit();
	}
	
	$idks = $_POST['IDKSIAZKA'];
	$conn = oci_connect('HR','haslo','localhost:1521/KSIAZKIFILMY');
					if(!$conn) 
				{
					$m=oci_error();
					trigger_error(hymlentites($m['message']), E_USER_ERROR);
				}
				
				
				$stid = oci_parse($conn,"begin F_Ksiazki.usun_Ksiazke(:id_ks); end;");
				oci_bind_by_name($stid,":id_ks",$idks);
				oci_execute($stid);
				
				header('Location: index.php');
				oci_free_statement($stid);
				oci_close($conn);
				
?>