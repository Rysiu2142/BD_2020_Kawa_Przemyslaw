<?php
	session_start();
	
	if(!isset($_POST['OCENA']))
	{
		header('Location: index.php');
		exit();
	}
	$ocena= $_POST['OCENA'];
	$idks = $_POST['IDFILM'];
	$conn = oci_connect('HR','haslo','localhost:1521/KSIAZKIFILMY');
					if(!$conn) 
				{
					$m=oci_error();
					trigger_error(hymlentites($m['message']), E_USER_ERROR);
				}
	$stid = oci_parse($conn,"begin T_OF.ST_OcenyFilmu(:ocena,:id); end;");
				oci_bind_by_name($stid,":id",$idks);
				oci_bind_by_name($stid,":ocena",$ocena);
				oci_execute($stid);
				
				header('Location: index.php');
				oci_free_statement($stid);
				oci_close($conn);
?>
