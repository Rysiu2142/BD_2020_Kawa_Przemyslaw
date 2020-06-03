<?php
	session_start();
	
	if(!isset($_POST['Tytul']))
	{
		header('Location: DodajF.php');
		echo "<script>alert('Error');</script>";
		exit();
	}
	$conn = oci_connect('HR','haslo','localhost:1521/KSIAZKIFILMY');
		if(!$conn) 
	{
		$m=oci_error();
		trigger_error(hymlentites($m['message']), E_USER_ERROR);
	}
	$k=0;
	if(!isset($_POST['IDKATEG']))
	{
		$k=1;
	}
	
	$idksiazka=0;
	$r=-1;
	if(isset($_POST['IDKSIAZKI'])
	{
		$idksiazka=$_POST['IDKSIAZKI'];
		$stid = oci_parse($conn,"begin :r = T_Film.Check_Book(:idks); end;");
		oci_bind_by_name($stid,":r",$r);
		oci_bind_by_name($stid,":idks",$idksiazka);
		oci_execute($stid);
	}
	else
	{
		$idksiazka=NULL
	}
	
	if($r == -1 or $r ==1)
	{
		$cursor1=oci_new_cursor($conn);
		$stid = oci_parse($conn,"begin T_Film.ST_Filmy(:tytul,:idks,:dane); end;");
		oci_bind_by_name($stid,":tytul",$_POST['Tytul']);
		oci_bind_by_name($stid,":idks",$_POST['IDKSIAZKI']);
		oci_bind_by_name($stid,":dane",$cursor1,-1,OCI_B_CURSOR);
        oci_execute($stid);
		oci_execute($cursor1);
		$row = oci_fetch_array($cursor1, OCI_ASSOC + OCI_RETURN_NULLS);
		$idk=$row['IDFILM'];
		oci_free_statement($stid);
		oci_free_statement($cursor1);
		if($k!=1)
		{
			$stid = oci_parse($conn,"begin T_Film.ST_FK(:kategoria,:idf)")
			oci_bind_by_name($stid,":idf",$idk);
			$autorzy= explode(",",$_POST['IDKATEG']);
			foreach($autorzy as $value)
			{
				oci_bind_by_name($stid,":kategoria",$value);
				oci_execute($stid);
			}
			oci_free_statement($stid);
		}
		
	}
	else
	{
		
	}
?>