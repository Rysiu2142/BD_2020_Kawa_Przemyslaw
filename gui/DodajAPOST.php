<?php
	session_start();
	header('Location: DodajA.php');
	$imie=$_POST['Imie'];
	$Nazw=$_POST['Nazwisko'];
	$Urodz=$_POST['Urodzony'];
	$Zmar=$_POST['Zmarly'];
	$r=0;
	if($Urodz=='Y-m-d') $Urodz=Null;
	if($Zmar=='Y-m-d') $Zmar=Null;
	
	$conn = oci_connect('HR','haslo','localhost:1521/KSIAZKIFILMY');
					if(!$conn) 
				{
					$m=oci_error();
					trigger_error(hymlentites($m['message']), E_USER_ERROR);
				}
	$stid = oci_parse($conn,"begin :r := T_Autor.autor_pow(:imie,:naz); end;");
	oci_bind_by_name($stid,":imie",$imie);
	oci_bind_by_name($stid,":naz",$Nazw);
	oci_bind_by_name($stid,":r",$r);
	
	oci_execute($stid);

	if($r == 0)
	{
		$stid = oci_parse($conn, "begin T_Autor.ST_Autorzy(:imie,:naz,:urodz,:zmarl); end;");
		
		oci_bind_by_name($stid, ":imie",$imie);
		oci_bind_by_name($stid,":naz",$Nazw);
		oci_bind_by_name($stid,":urodz",$Urodz);
		oci_bind_by_name($stid,"zmarl",$Zmar);
		oci_execute($stid);
	}
	else
	{
		$_SESSION['istneje'] ='<span style="color:red"> Autor Istnieje</span>';
	}
	oci_free_statement($stid);
	oci_close($conn);
	
?>